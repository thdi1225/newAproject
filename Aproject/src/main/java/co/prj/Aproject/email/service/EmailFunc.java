package co.prj.Aproject.email.service;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import javax.mail.Address;
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
import javax.mail.internet.MimeMultipart;

import co.prj.Aproject.email.serviceImpl.EmailServiceImpl;
import co.prj.Aproject.email.vo.EmailVO;

public class EmailFunc {
	// String user, password 있을 자리
	String user = "mplv261@gmail.com";
	String password = "mooecsnjsxbnubfg";

	EmailService dao = new EmailServiceImpl();

	// 메일 전송 method
	public boolean gmailSend(String to, String title, String subject) {
		// mail user와 password 보안용 코드
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
		prop.put("mail.smtp.host", "smtp.gmail.com"); // 이메일 발송을 처리해줄 STMP 서버
		prop.put("mail.smtp.port", 465);
		prop.put("mail.smtp.auth", "true");
		prop.put("mail.smtp.ssl.enable", "true");
		prop.put("mail.smtp.ssl.trust", "smtp.gmail.com");

		Session session = Session.getDefaultInstance(prop, new javax.mail.Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(user, password);
			}
		});

		try {
			MimeMessage message = new MimeMessage(session);
			message.setFrom(new InternetAddress(user));
			// 수신자 메일 주소
			message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));

			// Subject (제목)
			message.setSubject(title);

			// Text (내용)
			message.setText(subject);

			// send the message
			Transport.send(message);
			return true;
		} catch (AddressException e) {
			e.printStackTrace();
		} catch (MessagingException e) {
			e.printStackTrace();
		}
		return false;
	}

	// Gmail의 메일을 전부 불러오는 메소드
	private List<EmailVO> gmailTitleRecieve() {
		Properties prop = System.getProperties();
		prop.put("mail.pop3.host", "pop.gmail.com"); // 이메일 발송을 처리해줄 STMP 서버
		prop.put("mail.pop3.port", 995);
		prop.put("mail.pop3.auth", "true");
		prop.put("mail.pop3.starttls.enable", "true");
		prop.put("mail.pop3.socketFactory.class", "javax.net.ssl.SSLSocketFactory");

		Session session = Session.getDefaultInstance(prop, new javax.mail.Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(user, password);
			}
		});

		Store store;
		Folder folder;
		List<EmailVO> emails = new ArrayList<EmailVO>();
		SimpleDateFormat date = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");

		try {
			store = session.getStore("pop3");
			store.connect("pop.gmail.com", user, password);

			folder = store.getFolder("INBOX");
			folder.open(Folder.READ_ONLY);

			Message[] messages = folder.getMessages();
			for (Message message : messages) {
				EmailVO vo = new EmailVO();
				vo.setEmailDate(message.getSentDate());
				
				//내용 넣는 부분
				String subject = recieveSubject(message);

				Address sendAddr[] = message.getFrom();
				InternetAddress addr = null;
				if ((sendAddr != null) && (sendAddr.length > 0)) {
					addr = (InternetAddress) sendAddr[0];
				}
				vo.setEmailFrom(addr.getAddress()); // 어디서 온 메일인지

				vo.setEmailTitle(message.getSubject()); // 제목
				emails.add(vo);
			}
			System.out.println("불러오기 완료");

			// 다 끝나면
			folder.close(false);
			store.close();

		} catch (NoSuchProviderException e1) {
			e1.printStackTrace();
		} catch (MessagingException e2) {
			e2.printStackTrace();
		}
		return emails;

	}

	private String recieveSubject(Message message) {
		String subject = null;
		try {
			if (message.getContent() instanceof MimeMultipart) {
				MimeMultipart mimeMultipart = (MimeMultipart) message.getContent();
				for (int j = 0; j < mimeMultipart.getCount(); j++) {
					if (mimeMultipart.getBodyPart(j).getDisposition() == null) {
						System.out.println("내용 = " + mimeMultipart.getBodyPart(j).getContent());
					}
				}
			}
		} catch (MessagingException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return subject;

	}

	// 기존 db랑
	public void saveEmailsInDB() {
		// origin 이메일함 가져오기
		List<EmailVO> newEmails = gmailTitleRecieve(); // origin 메일에서 가져오기
		List<EmailVO> dbEmails = dao.emailSelectListAll(); // db에서 가져오기

		if (dbEmails.size() == 0) { // 처음 로그인할 때
			for (int i = 0; i < newEmails.size(); i++) {
				System.out.println(i + "번째 삽입");
				dao.emailInsert(newEmails.get(i));
			}
			System.out.println("메일을 db에 저장 완료");
		} else { // 기존에 데이터가 있을 때
			compareEmails(dbEmails, newEmails);
			System.out.println("업데이트 된 메일 db에 수정 완료");
		}
	}

	// 이메일 비교하기
	private void compareEmails(List<EmailVO> dbEmails, List<EmailVO> newEmails) {

		// db를 검사
		for (EmailVO de : dbEmails) {
			boolean dFlag = true;
			for (EmailVO ne : newEmails) {
				if (ne.getEmailDate().equals(de.getEmailDate()) && ne.getEmailTitle().equals(de.getEmailTitle())) {
					// 같은 값이 존재하면 break;
					dFlag = false;
					break;
				}
			}
			// 무사히 통과하면 db에 덜 지워진 값이 있다는거 -> db에서 해당값 삭제
			if (dFlag) {
				System.out.println("값 삭제");
				dao.emailDelete(de);
			}
		}

		// new이메일을 검사
		for (EmailVO ne : newEmails) {
			boolean nFlag = true;
			for (EmailVO de : dbEmails) {
				if (ne.getEmailDate().equals(de.getEmailDate()) && ne.getEmailTitle().equals(de.getEmailTitle())) {
					// 같은 값이 존재하면 break;
					nFlag = false;
					break;
				}
			}
			if (nFlag) {
				System.out.println("값 삽입");
				dao.emailInsert(ne);
			}
		}
	}

}
