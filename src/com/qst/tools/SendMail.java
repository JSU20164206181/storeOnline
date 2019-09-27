package com.qst.tools;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Properties;
import java.util.Random;

import javax.mail.Message;
import javax.mail.Message.RecipientType;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import com.qst.action.FinalConst;

public class SendMail implements FinalConst {
	/**
	 * 生成随机密码
	 * @return
	 */
	public static String RandomPws() { 
		Random random = new Random();
		String sRand = "";
		for (int i = 0; i < 6; i++) {
		String rand = null;
	
		if ( i<3) {
			rand = String.valueOf((char) (random.nextInt(26) + 65));
			
		} else {
			rand = String.valueOf((char) (random.nextInt(10) + 48));
		}
		sRand += rand;
		}
		return sRand;
		}


/**
 * 发送邮件
 * @param recipient 接收者邮箱
 * @param uCount 用户名字
 * @param pws 用户密码
 */
	public static void sendMails(String recipient,String uCount, String pws) {
		

		/*
		 * //发件人的邮箱地址（要完整），会显示在收件人的邮件中setSender("*********@163.com");
		 * //发件人登录邮箱的账号（@符合前面的部分） setUserName("*************");
		 * //下面填的是邮箱客户端授权码，切忌：邮箱务必要开启（POP3/SMTP服务）
		 * 
		 */
		try {
			// 创建邮件对象
			Session session = null;
			Properties props = new Properties();
			// 此处为发送方邮件服务器地址，要根据邮箱的不同需要自行设置
			props.put("mail.smtp.host", "smtp.163.com");
			props.setProperty("mail.transport.protocol", "smtp");
			// SMTP端口号
			props.put("mail.smtp.port", "25");
			// 设置成需要邮件服务器认证
			props.put("mail.smtp.auth", "true");
			props.put("mail.debug", "true"); 
			session = Session.getInstance(props);
			session.setDebug(true);
			Message message = new MimeMessage(session);
			// 设置发件人
			message.setFrom(new InternetAddress(SEND_EMAUL_COUNT));
			// 设置收件人
			message.addRecipient(RecipientType.TO, new InternetAddress(recipient));
			// 设置标题
			message.setSubject("你的密码为");
			// 邮件内容，根据自己需要自行制作模板 
			String name=uCount.substring(0, (uCount.length()/2)+1);   
			String time=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()).toString();
			message.setContent("<p>尊敬的用户"+name+"**："
					+ "</p><p>您好!您的密码已重置！</p><p>" + 
					"您的新密码为："+pws+"，登录后请修改此密码。</p>" 
					+ "<p>发件人：瓜子二手交易网</p><p>时间："+time+"</p><p></br></br> ..........（该数据仅用于测试）..........</p>" 
					, "text/html;charset=utf-8");
			// 发送邮件 
			Transport transport = session.getTransport("smtp");
			transport.connect("smtp.163.com", SEND_EMAUL_COUNT, SEND_EMAUL_PASSWORD);// 以smtp方式登录邮箱
			// 发送邮件,其中第二个参数是所有已设好的收件人地址
			transport.sendMessage(message, message.getAllRecipients());
			System.out.println("发送邮件-----------------》" + recipient);
			transport.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}