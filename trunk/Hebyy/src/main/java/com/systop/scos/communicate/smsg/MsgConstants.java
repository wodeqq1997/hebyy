package com.systop.scos.communicate.smsg;
/**
 * 站内短信常量类
 * @author 
 *
 */
public class MsgConstants {

	/** 移除标识*/
	public static final String DELETE = "1";
	
	/** 正常标识*/
	public static final String NOMAL = "0";
	
	/** 系统消息*/
	public static final String IS_SYS = "sys";
	
	/** 个人消息*/
	public static final String IS_PERSONAL = "personal";

    /**
     * 需要发短信通知
     */
    public static final String NOTIFY = "1";
    /**
     * 已经通知过了
     */
    public static final String NOTIFIED = "2";

    /**
     * 需要全文通知的
     */
    public static final String NOTIFY_FULL = "3";



}
