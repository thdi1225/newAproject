package co.prj.Aproject.email.service;

import java.util.Properties;

import javax.mail.Folder;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.NoSuchProviderException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Store;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class EmailService {
	//String user, password 있을 자리
	String user = "";
	String password = "";
	

	public boolean gmailSend(String to, String title, String subject) {
		//mail user와 password 보안용 코드
//		Properties mailProp = new Properties();
//		InputStream inputStream = getClass().getClassLoader().getResourceAsStream("mail.properties");
//		try {
//			mailProp.load(inputStream);
//			user = mailProp.getProperty("emailUser");
//			password = mailProp.getProperty("emailPassword");
//		} catch (FileNotFoundException e1) {
//			e1.printStackTrace();
//		} catch (IOException e1) {
//			e1.printStackTrace();
//		}
				
		Properties prop = new Properties();
		prop.put("mail.smtp.host","smtp.gmail.com"); //이메일 발송을 처리해줄 STMP 서버
		prop.put("mail.smtp.port",465);
		prop.put("mail.smtp.auth", "true");
		prop.put("mail.smtp.ssl.enable", "true");
		prop.put("mail.smtp.ssl.trust", "smtp.gmail.com");
		
		
		Session session = Session.getDefaultInstance(prop, new javax.mail.Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(user,password);
			}
		});
		
		try {
			MimeMessage message = new MimeMessage(session);
			message.setFrom(new InternetAddress(user));
			//수신자 메일 주소
			message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
			
			//Subject (제목)
			message.setSubject(title);
			
			//Text (내용)
			message.setText(subject);
			
			//send the message
			Transport.send(message);
			return true;
		} catch (AddressException e) {
			e.printStackTrace();
		} catch (MessagingException e) {
			e.printStackTrace();
		}
		return false;
	}
	
	public void gmailRecieve() {
		Properties prop = System.getProperties();
		prop.put("mail.smtp.host","smtp.gmail.com"); //이메일 발송을 처리해줄 STMP 서버
		prop.put("mail.smtp.port",995);
		prop.put("mail.smtp.auth", "true");
		prop.put("mail.smtp.ssl.enable", "true");
		prop.put("mail.smtp.ssl.trust", "pop.gmail.com");
		
		Session session = Session.getDefaultInstance(prop, new javax.mail.Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(user,password);
			}
		});
		
		session.setDebug(false);
		
		Store store;
		try {
			store = session.getStore("pop3");
			store.connect();
			Folder folder = store.getFolder("INBOX");
			folder.open(Folder.READ_ONLY);
			
			Message[] messages = folder.getMessages();
			
			for(Message message : messages) {
				System.out.println("===================");
				System.out.println(message.getSubject()); //제목 출력
			}
			
		} catch (NoSuchProviderException e1) {
			e1.printStackTrace();
		} catch ( MessagingException e2) {
			e2.printStackTrace();
		}
		
		
		
		
		
	}

}
