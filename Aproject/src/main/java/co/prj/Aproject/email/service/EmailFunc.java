package co.prj.Aproject.email.service;


import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import co.prj.Aproject.email.serviceImpl.EmailServiceImpl;
import co.prj.Aproject.email.vo.EmailVO;

public class EmailFunc {
	// String user, password 있을 자리
	String user = "";
	String password = "";

	EmailService dao = new EmailServiceImpl();
	EmailImapRecieve eir = new EmailImapRecieve();
	int memNum = 0;

	// 메일 전송 method
	public boolean gmailSend(String to, String title, String subject) {
		Properties prop = new Properties();
		prop.put("mail.smtp.host", "smtp.gmail.com"); // 이메일 발송을 처리해줄 STMP 서버
		prop.put("mail.smtp.port", 465);
		prop.put("mail.smtp.auth", "true");
		prop.put("mail.smtp.ssl.enable", "true");
		prop.put("mail.smtp.ssl.trust", "smtp.gmail.com");

//		prop.put("mail.smtp.socketFactory.port", "465");
//		prop.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
//		prop.put("mail.smtp.socketFactory.fallback", "false");

		Session sessionSend = Session.getDefaultInstance(prop, new javax.mail.Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(user, password);
			}
		});

		try {
			MimeMessage message = new MimeMessage(sessionSend);
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

	// 기존 db랑
	public void saveEmailsInDB(int memberNum) {
		List<EmailVO> dbEmails = dao.emailSelectListAll(memberNum); // db에서 가져오기
		memNum = memberNum;
		List<EmailVO> newEmails;
		if (dbEmails.size() == 0) { // 처음 로그인할 때
			newEmails = eir.getMailAll(1,null,memberNum);
			for (int i = 0; i < newEmails.size(); i++) {
				System.out.println(i + "번째 삽입");
				dao.emailInsert(newEmails.get(i));
			}
			System.out.println("메일을 db에 저장 완료");
		} else { // 기존에 데이터가 있을 때
			newEmails = eir.getMailAll(0,null,memberNum); //id값 다 받아오기
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
				if (de.getEmailId() == ne.getEmailId()) {
					dFlag = false;
					break;
				}
			}
			if (dFlag) {
				System.out.println("값 삭제/ uid : "+de.getEmailId());
				dao.emailDelete(de);
				//파일도 삭제
				deleteFile(de);
			}
		}

		// new이메일을 검사
		List<Integer> idList = new ArrayList<Integer>();
		for (EmailVO ne : newEmails) {
			boolean nFlag = true;
			for (EmailVO de : dbEmails) {
				if (ne.getEmailId()==de.getEmailId()) { //id가 db랑 같은게 있으면 
					nFlag = false;
					break;
				}
			}
			if (nFlag) {
				idList.add(ne.getEmailId());
			}
		}
		List<EmailVO> neList = eir.getMailAll(1, idList,memNum);
		if(neList != null) {
			for(EmailVO ne : neList) {
				dao.emailInsert(ne);
			}
		}
	}
	
	//파일 삭제 메소드
	private void deleteFile(EmailVO vo) {
		String[] fileType = {".txt",".html",".png"};
		for(String ft : fileType) {
			System.out.println(vo.getEmailFile());
			File file = new File("c:/Temp/mail/"+vo.getEmailFile()+ft);
			if(file.exists() ){
	    		if(file.delete()){
	    			System.out.println(ft+" : 파일삭제 성공");
	    		}else{
	    			System.out.println("파일삭제 실패");
	    		}
	    	}else{
	    		System.out.println(ft+"파일이 존재하지 않습니다.");
	    	}
		}
	}
		        
}
