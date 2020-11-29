package com.smartbill.common.util;

import java.io.IOException;
import java.util.Date;
import java.util.Properties;

import javax.activation.DataHandler;
import javax.activation.DataSource;
import javax.activation.FileDataSource;
import javax.mail.BodyPart;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;


public class SendMail
{
	
	public SendMail(String rsvEmail, String subject, String bodyMsg, String imgPath ) throws AddressException, MessagingException {
		
		// 메일 관련 정보
        String host = ExXMLConfiguration.getInstance().getString("mail.host");
        final String username = ExXMLConfiguration.getInstance().getString("mail.username");
        final String password = ExXMLConfiguration.getInstance().getString("mail.password");
        int port=Integer.parseInt(ExXMLConfiguration.getInstance().getString("mail.port"));
		
		
        // 메일 내용
        String recipient = rsvEmail;
        String body = bodyMsg;
         
        Properties props = System.getProperties();
         
         
        props.put("mail.smtp.host", host);
        props.put("mail.smtp.port", port);
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.ssl.enable", "true");
        props.put("mail.smtp.ssl.trust", host);
          
        Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator() {
            String un=username;
            String pw=password;
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(un, pw);
            }
        });
        
        session.setDebug(true); //for debug
          
        Message msg = new MimeMessage(session);
        msg.setFrom(new InternetAddress(ExXMLConfiguration.getInstance().getString("mail.sendemail")));
        msg.setRecipient(Message.RecipientType.TO, new InternetAddress(recipient));
        msg.setSubject(subject);
        msg.setSentDate(new Date());
        msg.setText(body);
         
        
        // 파일첨부를 위한 Multipart
        Multipart multipart = new MimeMultipart("related");
        
        //third part for displaying image in the email body
        BodyPart bodyPart = new MimeBodyPart();
        String htmlText = body + "<br><img src=\"cid:image\">";
        bodyPart.setContent(htmlText, "text/html;charset=utf-8");
        bodyPart.setDisposition(MimeBodyPart.INLINE);
        multipart.addBodyPart(bodyPart);
         
        // 2. 이미지를 첨부한다.
        bodyPart = new MimeBodyPart();
        String filename = imgPath;
        DataSource source = new FileDataSource(filename);
        bodyPart.setDataHandler(new DataHandler(source));
        bodyPart.setFileName("contract.png");
        bodyPart.setHeader("Content-ID","<image>");
        multipart.addBodyPart(bodyPart);
      
         
        // 이메일 메시지의 내용에 Multipart를 붙인다.
        msg.setContent(multipart);
        Transport.send(msg);
        
     
	}
	
}