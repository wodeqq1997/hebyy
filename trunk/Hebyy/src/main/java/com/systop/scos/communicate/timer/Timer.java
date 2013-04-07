package com.systop.scos.communicate.timer;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.mail.internet.MimeMessage;

import org.apache.commons.lang.xwork.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.MailException;
import org.springframework.mail.javamail.MimeMessageHelper;

import com.systop.common.modules.mail.MailSender;
import com.systop.common.modules.security.user.model.User;
import com.systop.common.modules.security.user.service.UserManager;
import com.systop.scos.communicate.smsg.MsgConstants;
import com.systop.scos.communicate.smsg.model.Message;
import com.systop.scos.communicate.smsg.service.MessageManager;
import com.systop.zjimis.flow.model.FlowNode;
import com.systop.zjimis.flow.service.FlowNodeManager;

/**
 * Created with IntelliJ IDEA.
 * User: slimx
 * Date: 12-8-13
 * Time: 下午3:22
 * To change this template use File | Settings | File Templates.
 */
public class Timer {
    @Autowired
    private MailSender mailSender;
    @Autowired
    private UserManager userManager;
    @Autowired
    private FlowNodeManager flowNodeManager;
    @Autowired
    private MessageManager messageManager;

    protected Logger logger = LoggerFactory.getLogger(getClass());

    List<MimeMessage> messages;
    private String from;

    public void execute() {
        //短信
        try {
            List<User> users = userManager.getNotifiedSmsUser();
            for (User user : users) {
                String mobile = user.getMobile();
                if (!StringUtils.isNumeric(mobile)) continue;

                //待办
/*                List<FlowNode> todoList = flowNodeManager.getAllPendingNodes(user);
                for (FlowNode todo : todoList) {
                    messageManager.buildSms(mobile,todo.getFlow().getTitle());
                    todo.setNotified("true");
                    flowNodeManager.save(todo);
                }*/
                //系统消息
                List<Message> allUnSms = messageManager.getAllUnSms(user);
                for(Message msg:allUnSms){
                    if(msg.getNotified().equals("3"))
                        messageManager.buildSms(mobile,msg.getContent());
                    else
                        messageManager.buildSms(mobile,msg.getTitle());
                    msg.setNotified(MsgConstants.NOTIFIED);
                    messageManager.save(msg);
                }

            }
            } catch (Exception e) {
            logger.debug(e.getMessage());
        }

        //邮件
        try {
            List<User> users = userManager.getNotifiedUsers();
            messages = new ArrayList<MimeMessage>();
            from = userManager.getAdmin().getEmail();

            for (User user : users) {
                List<FlowNode> todoList = flowNodeManager.getAllPendingNodes(user);
                String to = user.getEmail();
                if (StringUtils.isBlank(to)) continue;
                for (FlowNode todo : todoList) {
                    buildEmail(to, todo);
                    todo.setNotified("true");
                    flowNodeManager.save(todo);
                }
            }
            mailSender.send(messages.toArray(new MimeMessage[messages.size()]));
        } catch (MailException e) {
            logger.debug(e.getMessage());
        }
    }

    /**
     * 根据待办信息构建邮件
     *
     * @param to
     * @param todo
     */
    private void buildEmail(String to, FlowNode todo) {
        try {
            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, "UTF-8");
            helper.setTo(to);
            helper.setFrom(from);
            helper.setSubject(todo.getFlow().getTitle());
            String content = "<a href='http://zjoa.meibu.net/zjimis/flow/node/view.do?model.id=" + todo.getId() + "'>查看详情</a>";
            helper.setText(content, true);
            helper.setSentDate(new Date());
            messages.add(message);

        } catch (Exception e) {
            logger.debug(e.getMessage());
        }
    }
}
