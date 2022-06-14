package co.prj.Aproject.email.service;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import javax.mail.Address;
import javax.mail.Flags;
import javax.mail.Folder;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.NoSuchProviderException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Store;
import javax.mail.Transport;
import javax.mail.UIDFolder;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.mail.search.FlagTerm;

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

		prop.put("mail.smtp.socketFactory.port", "465");
		prop.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
		prop.put("mail.smtp.socketFactory.fallback", "false");

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

	private List<EmailVO> gmailIMAPRecieve() {
		List<EmailVO> newEmails = new ArrayList<EmailVO>();
		Folder folder = null;
		Store store = null;
//	        String filePath = "c:/temp/mail/";
		try {
			Properties props = System.getProperties();
			props.setProperty("mail.store.protocol", "imaps");

			Session session = Session.getDefaultInstance(props, null);
			store = session.getStore("imaps");
			store.connect("imap.gmail.com", user, password);
			folder = store.getFolder("Inbox"); // inbox : 받은 메일함 폴더
			folder.open(Folder.READ_WRITE);
			UIDFolder uf = (UIDFolder) folder; // uid 얻기 위한 용도

			// 안 읽은 것만 가져오기
//            Message messages[] = folder.search(new FlagTerm(new Flags(Flags.Flag.SEEN), false));
			// 읽은 것도 가져오기
			Message messages[] = folder.getMessages();

			for (Message msg : messages) {
				EmailVO vo = new EmailVO();
				vo.setEmailFrom(getSender(msg)); // 주소
				vo.setEmailDate(msg.getReceivedDate()); // 날짜
				vo.setEmailTitle(msg.getSubject()); // 제목
				// 내용 가져오기
//				try {
//					String body = ((MimeMultipart) msg.getContent()).getBodyPart(0).getContent().toString();
//					System.out.println(body);
//				} catch (IOException e) {
//					e.printStackTrace();
//				}
				
				// uid
				vo.setEmailUid(uf.getUID(msg));

				System.out.println("Saving : " + msg.getSubject());
				newEmails.add(vo);
			}
		} catch (MessagingException e) {
			e.printStackTrace();
		} finally {
			if (folder != null) {
				try {
					folder.close(true);
				} catch (MessagingException e) {
					e.printStackTrace();
				}
			}
			if (store != null) {
				try {
					store.close();
				} catch (MessagingException e) {
					e.printStackTrace();
				}
			}
		}
		return newEmails;
	}

	private String getSender(Message msg) {
		String from = "unknown";
		try {
			if (msg.getReplyTo().length >= 1) {
				from = msg.getReplyTo()[0].toString();
			} else if (msg.getFrom().length >= 1) {
				from = msg.getFrom()[0].toString();
			}
		} catch (MessagingException e) {
			e.printStackTrace();
		}
		return from;
	}

	private void saveParts(long uId, Object content) {
		if (content instanceof Multipart) {
			Multipart multi = ((Multipart) content);
			int parts = multi.getCount();
			System.out.println("parts:" + parts);
			for (int j = 0; j < parts; ++j) {
				MimeBodyPart part = (MimeBodyPart) multi.getBodyPart(j);
				if (part.getContent() instanceof Multipart) {
					saveParts(uId, part.getContent(), fileName, filePath);
				}
			}
		}
	}

	// Gmail의 메일을 전부 불러오는 메소드
	private List<EmailVO> gmailPOPRecieve() {
		Properties prop = System.getProperties();
		prop.put("mail.pop3.host", "pop.gmail.com");
		prop.put("mail.pop3.port", 995);
		prop.put("mail.pop3.auth", "true");
		prop.put("mail.pop3.starttls.enable", "true");
		prop.put("mail.pop3.socketFactory.class", "javax.net.ssl.SSLSocketFactory");

		prop.put("mail.pop3.socketFactory.fallback", "false");
		prop.put("mail.pop3.socketFactory.port", "995");

		Session session = Session.getDefaultInstance(prop, new javax.mail.Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(user, password);
			}
		});

		Store store;
		Folder folder;
		List<EmailVO> emails = new ArrayList<EmailVO>();

		try {
			store = session.getStore("pop3");
			store.connect("pop.gmail.com", user, password);

			folder = store.getFolder("INBOX");
			folder.open(Folder.READ_ONLY);

			Message[] messages = folder.getMessages();
			for (Message message : messages) {
				EmailVO vo = new EmailVO();
				vo.setEmailDate(message.getSentDate());

				// 내용 넣는 부분
//				String subject = recieveSubject(message);

				// from 주소 인코딩
				Address sendAddr[] = message.getFrom();
				InternetAddress addr = null;
				if ((sendAddr != null) && (sendAddr.length > 0)) {
					addr = (InternetAddress) sendAddr[0];
				}
				vo.setEmailFrom(addr.getAddress()); // 주소

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
		gmailIMAPRecieve();
//		List<EmailVO> newEmails = gmailPOPRecieve(); // (POP) origin 메일에서 가져오기
		List<EmailVO> newEmails = gmailIMAPRecieve(); // (IMAP) origin 메일에서 가져오기
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
