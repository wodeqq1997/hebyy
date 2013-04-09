package com.systop.scos.communicate.smsg.service;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.text.MessageFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.systop.common.modules.security.user.model.User;
import com.systop.core.ApplicationException;
import com.systop.core.Constants;
import com.systop.core.service.BaseGenericsManager;
import com.systop.scos.communicate.mail.model.MailBox;
import com.systop.scos.communicate.mail.service.MailBoxManager;
import com.systop.scos.communicate.smsg.MsgConstants;
import com.systop.scos.communicate.smsg.model.Message;
import com.systop.scos.info.notice.model.Notice;
import com.systop.zjimis.flow.model.FlowNode;
import com.systop.zjimis.flow.service.FlowNodeManager;

/**
 * 短消息管理
 * 
 * @author Nice
 */
@Service
public class MessageManager extends BaseGenericsManager<Message> {

    @Autowired
    private FlowNodeManager flowNodeManager;

    @Autowired
    private MailBoxManager mailMessage;

    /**
	 * 发送系统消息
	 * 
	 * @param pattern
	 * @param args
	 * @param user
	 */
	@Transactional
	public void saveSysMsg(String title, String pattern, Object[] args,
			User user,String...extra) {
		Message msg = new Message();
		msg.setTitle(title);
		msg.setMsgType(MsgConstants.IS_SYS);
		msg.setContent(MessageFormat.format(pattern, args));
		msg.setReceiver(user);
		msg.setCreateTime(new Date());
        //通知的标志
        if(extra.length>0)
            msg.setNotified(extra[0]);
        save(msg);

        if (args.length == 4 && args[3].getClass().equals(FlowNode.class)) {
            FlowNode flowNode = (FlowNode) args[3];
            flowNode.setMessage(msg);
            flowNodeManager.save(flowNode);
        } else if (args.length == 3 && args[2].getClass().equals(MailBox.class)) {
            MailBox mailBox = (MailBox) args[2];
            mailBox.setMsg(msg);
            mailMessage.save(mailBox);
        }

    }

	/**
	 * 发送邮件通知短信，格式化字符串"{0}/mail/view.do?mailId={1}"对照传递参数
	 *
	 * @param args
	 * @param user
	 */
	@Transactional
	public void saveMailMsg(Object[] args, User user) {
		if (args == null || args.length != 3) {
			throw new ApplicationException("发送邮件通知短信错误，参数为空或长度错误");
		}
		String pattern = "您有一封新邮件,请查收。&nbsp;<a href=\"{0}/mail/view.do?mailId={1}\">点击查看</a>";
        MailBox mailBox = (MailBox) args[2];
		saveSysMsg("新邮件："+mailBox.getMail().getSubject(), pattern, args, user);
	}

	/**
	 * 通知公告短信，格式化字符串"{0}/mail/view.do?mailId={1}"对照传递参数
	 * 
	 * @param args
	 * @param user
	 */
	@Transactional
	public void saveNoticeMsg(String path,Notice notice, User user) {
		String pattern = "通知公告,请查收。&nbsp;<a href=\"{0}/notice/view.do?model.id={1}\" target=\"_blank\">点击查看</a>";
        String[] args = new String[]{path,notice.getId().toString()};
		saveSysMsg("通知公告："+notice.getTitle(), pattern, args, user);
	}

	/**
	 * 待办事项通知短信，格式化字符串[新增待办事项\"{0}\"。&nbsp;<a
	 * href=\"{1}/flow/node/view.do?model.id={2}\">]
	 *
	 * @param args
	 * @param user
	 */
	@Transactional
	public void saveNodeMsg(Object[] args, User user) {
		if (args == null || args.length !=4) {
			throw new ApplicationException("发送待办事项通知短信错误，参数为空或长度错误");
		}
		String pattern = "待办事项:\"{0}\"。&nbsp;<a href=\"{1}/flow/node/view.do?model.id={2}\">点击查看</a>";
        FlowNode flowNode = (FlowNode) args[3];
		saveSysMsg("待办事项：" + flowNode.getFlow().getTitle(), pattern, args, user, "1");
	}

	/**
	 * 待办事项反馈通知短信或一个参数的短消息。<br>
	 * 格式化字符串[新的短息内容：\"{0}\"。] 审批通过或不通过反馈给审批人。
	 * 
	 * @param args
	 * @param user
	 */
	@Transactional
	public void saveNodeFeedbackMsg(Object[] args, User user) {
		if (args == null || args.length != 1) {
			throw new ApplicationException("审批反馈通知短信错误，参数为空或长度错误");
		}
		String pattern = "审批反馈消息：\"{0}\"。";
		saveSysMsg("审批反馈消息！", pattern, args, user,"3");
	}
	


	/**
	 * 将所有未读信息设置为已读（根据当前登陆用户）
	 */
	@Transactional
	public void readAllMsgs(User user, String msgType) {
        List<Message> list;
        if(msgType==null){
            String hql = "from Message m where m.isRead = ? and m.receiver.id = ?";
            list = query(hql,MsgConstants.NOMAL, user.getId());
        }
        else{
            String hql = "from Message m where m.isRead = ? and m.receiver.id = ? and msgType = ?";
            list = query(hql,MsgConstants.NOMAL, user.getId(),msgType);

        }
		for (Message msg : list) {
			msg.setIsRead(MsgConstants.DELETE);
			update(msg);
		}
	}

    public List<Message> getAllUnSms(User user) {
        String hql = "from Message m where m.receiver.id = ? and m.isRead = ? and (m.notified = ?  or m.notified = ?)  order by m.createTime desc";
        List<Message> list = getDao().limitQurey(hql,999, new Object[]{user.getId()
               ,MsgConstants.NOMAL,MsgConstants.NOTIFY,MsgConstants.NOTIFY_FULL});
        return list;
    }


    /**
     * 触发
     * @param to
     * @param content
     */
    public void buildSms(String to, String content) {
        try {
            String postUrl = Constants.SMS_URL;
            String postData = Constants.SMS_DATA+to+"&smsg="+java.net.URLEncoder.encode(content+"【河北演艺集团通知】","utf-8");

            URL url = new URL(postUrl);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
            conn.setRequestProperty("Connection", "Keep-Alive");
            conn.setUseCaches(false);
            conn.setDoOutput(true);

            conn.setRequestProperty("Content-Length", "" + postData.length());
            OutputStreamWriter out = new OutputStreamWriter(conn.getOutputStream(), "UTF-8");
            out.write(postData);
            out.flush();
            out.close();

            //获取响应状态
            if (conn.getResponseCode() != HttpURLConnection.HTTP_OK) {
                System.out.println("connect failed!");
                //failed
            }
            //获取响应内容体
            String line, result = "";
            BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream(), "utf-8"));
            while ((line = in.readLine()) != null) {
                result += line + "\n";
            }
            in.close();
            logger.debug("result:" + result);
            System.out.println(result);
            //success
        } catch (Exception e) {
            logger.debug(e.getMessage());
            System.out.println(e.getMessage());
        }
    }

    /**
     * 群发,最好用触发的
     * @param to
     * @param content
     */
    public void buildSms2(String to,String content){
        try {
            String postUrl = "http://10658.com.cn/api/sendsms/";
            String postData = "uid=zjkc&pwd=609acbfb702ad495451db7485252499b&pid=2&mobile="+to+"&content="+java.net.URLEncoder.encode(content+"【河北演艺集团通知】","utf-8");

            URL url = new URL(postUrl);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
            conn.setRequestProperty("Connection", "Keep-Alive");
            conn.setUseCaches(false);
            conn.setDoOutput(true);

            conn.setRequestProperty("Content-Length", "" + postData.length());
            OutputStreamWriter out = new OutputStreamWriter(conn.getOutputStream(), "UTF-8");
            out.write(postData);
            out.flush();
            out.close();

            //获取响应状态
            if (conn.getResponseCode() != HttpURLConnection.HTTP_OK) {
                System.out.println("connect failed!");
                //failed
            }
            //获取响应内容体
            String line, result = "";
            BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream(), "utf-8"));
            while ((line = in.readLine()) != null) {
                result += line + "\n";
            }
            in.close();
            logger.debug("result:" + result);
            System.out.println(result);
            //success
        } catch (Exception e) {
            logger.debug(e.getMessage());
            System.out.println(e.getMessage());
        }

    }

    /**
	 * 下属关系确认消息提示
	 * 
	 * @param args
	 * @param user
	 */
	@Transactional
	public void saveSubUserMsg(Object[] args, User user) {
		if (args == null || args.length != 3) {
			throw new ApplicationException("参数为空或长度错误");
		}
		String pattern = "下属关系待确认，【{0}】将你设置为其下属。&nbsp;<a href=\"{1}/subuser/view.do?model.id={2}\">点击查看</a>";
		saveSysMsg("下属关系待确认", pattern, args, user);
	}

}
