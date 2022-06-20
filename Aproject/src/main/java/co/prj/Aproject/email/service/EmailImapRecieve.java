package co.prj.Aproject.email.service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import javax.mail.Flags;
import javax.mail.Folder;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.Session;
import javax.mail.Store;
import javax.mail.UIDFolder;

import co.prj.Aproject.email.vo.EmailVO;

public class EmailImapRecieve {
	public EmailImapRecieve() {
	}

	public List<EmailVO> getMailAll(int flag, List<Integer> idList, int memberNum,String user, String password) {
		// flag가 0이면 uid만 전부 받아오기
		// flag가 1이면 파일까지 // idList가 null이 아니라면 특정 uid의 값을 불러와서 파일까지 받아오기
		// flag가 2면 읽지 않은 메일 가져오기
		// flag가 3이고 idList가 null이 아니면 특정 uid값을 불러와서 지우기
		List<EmailVO> newEmails = new ArrayList<EmailVO>();
		
		Folder folder = null;
		Store store = null;
		try {
			Properties props = System.getProperties();
			props.setProperty("mail.store.protocol", "imaps");

			Session sessionGet = Session.getInstance(props, null);
			store = sessionGet.getStore("imaps");
			store.connect("imap.gmail.com", user, password);
			folder = store.getFolder("Inbox");
			
			folder.open(Folder.READ_WRITE);
			UIDFolder uf = (UIDFolder) folder;

			Message messages[]; // 전부 받아오기

			if (flag == 1 && idList != null || flag == 3) {
				messages = new Message[idList.size()];
				for (int i = 0; i < messages.length; i++) {
					Message msg = uf.getMessageByUID(idList.get(i));
					if(msg != null) {
						if(flag==3) {
							msg.setFlag(Flags.Flag.DELETED, true);
							System.out.println(idList.get(i)+"번 메세지 삭제 완료");
						}else {
							messages[i] = msg;
						}
					}else {
						System.out.println("메세지가 존재하지 않습니다.");
					}
				}
				if(flag==3) {
					return null;
				}
			}else {
				messages = folder.getMessages();
			}
			for (Message msg : messages) {
				EmailVO vo = new EmailVO();
				int uId = (int) uf.getUID(msg); // message의 고유 id
				if (flag == 1) { // 파일까지 다 받아오기
					vo.setEmailFrom(getSender(msg));
					vo.setEmailDate(msg.getReceivedDate());
					vo.setEmailTitle(msg.getSubject());
					vo.setEmailId(uId);
					
					System.out.println("진행중...");
					
					msg.setFlag(Flags.Flag.SEEN, false); // 이건 안 읽었다는 표시를 안한다는건지?
					Object content = msg.getContent();
					String sub="";
					if (content instanceof String)  
					{  
					    sub = (String)content;  
					}  
					else if (content instanceof Multipart)  
					{  
					    Multipart mp = (Multipart)content;
					    sub = mp.getBodyPart(0).getContent().toString();
					}
					
					vo.setEmailSubject(sub);
				} else if (flag == 0) { // uid만 받아오기
					vo.setEmailId(uId);
					vo.setEmailDate(msg.getReceivedDate());
				}
				vo.setMemberNum(memberNum);
				newEmails.add(vo);
			}
		} catch (MessagingException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (folder != null) {
					folder.close(true);
				}
				if (store != null) {
					store.close();
				}
			} catch (MessagingException e) {
				e.printStackTrace();
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



}
