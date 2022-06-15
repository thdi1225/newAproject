package co.prj.Aproject.email.service;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
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
import javax.mail.internet.MimeBodyPart;

import co.prj.Aproject.email.vo.EmailVO;

public class EmailImapRecieve {
	String user = "";
	String password = "";

	public EmailImapRecieve() {
	}

	public List<EmailVO> getMailAll(int flag, List<Integer> idList, int memberNum) {
		// flag가 0이면 uid만 전부 받아오기
		// flag가 1이면 파일까지 // idList가 null이 아니라면 특정 uid의 값을 불러와서 파일까지 받아오기
		// flag가 2면 읽지 않은 메일 가져오기
		// flag가 3이고 idList가 null이 아니면 특정 uid값을 불러와서 지우기
		Folder folder = null;
		Store store = null;
		String filePath = "c:/Temp/mail/";
		List<EmailVO> newEmails = new ArrayList<EmailVO>();
		try {
			Properties props = System.getProperties();
			props.setProperty("mail.store.protocol", "imaps");

			Session sessionGet = Session.getDefaultInstance(props, null);
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
					if(flag==3) {
						msg.setFlag(Flags.Flag.DELETED, true);
					}else {
						messages[i] = msg;
					}
				}
				if(flag==3) {
					System.out.println("성공적으로 삭제했습니다.");
					return null;
				}
			} else {
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
					String fileName = "" + System.currentTimeMillis(); // fileName = 현재시간
					vo.setEmailFile(fileName);
					saveParts(uId, msg.getContent(), fileName, filePath);
					msg.setFlag(Flags.Flag.SEEN, false); // 이건 안 읽었다는 표시를 안한다는건지?
				} else if (flag == 0) { // uid만 받아오기
					vo.setEmailId(uId);
					vo.setEmailDate(msg.getReceivedDate());
					
				}
				vo.setMemeberNum(memberNum);
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

	private void saveParts(long uId, Object content, String fileName, String filePath) {
		// uId : 메일 id, content : msg.getContent(), fileName : 저장 시간, filePath : 파일 저장
		// 경로
		String tmpFileName = fileName;
		try {
			if (content instanceof Multipart) { // 만약 content가 멀티파일이면
				Multipart multi = ((Multipart) content); // 멀티파일로 업캐스팅하기
				int parts = multi.getCount(); // 멀티파일 갯수 세기

				for (int j = 0; j < parts; ++j) {
					MimeBodyPart part = (MimeBodyPart) multi.getBodyPart(j);

					if (part.getContent() instanceof Multipart) { // 파트의 getContent가 또 멀티파트면 같은거 실행
						saveParts(uId, part.getContent(), fileName, filePath);
					} else { // 멀티 파트가 아니면
						try {
							saveSinglePart(uId, part, fileName, filePath);
						} catch (Exception e) {
							e.printStackTrace();
							try {
								saveSinglePart(uId, part, fileName, filePath);
							} catch (Exception ex) {
								ex.printStackTrace();
								saveSinglePart(uId, part, fileName, filePath);
							}
						}
					}
					fileName = tmpFileName;
				}
			} else {
				FileOutputStream output;
				output = new FileOutputStream(filePath + fileName + ".html");
				output.write(content.toString().getBytes());
				output.close();
			}
		} catch (MessagingException e) {
			e.printStackTrace();
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}

	}

	private void saveSinglePart(long uId, MimeBodyPart part, String fileName, String filePath) {
		BufferedOutputStream out = null;
		BufferedInputStream in = null;
		String fileFullPath = "";
		try {
			if (part.isMimeType("text/html")) { // part의 MimeType이 html이라면
				fileName = fileName + ".html"; // 시간 뒤에 .html
				fileFullPath = filePath + fileName;
			}
			else {
				if (part.isMimeType("text/plain")) {
					fileName = fileName + ".txt";
				}
				 else {
					fileName = fileName + "_" + part.getDataHandler().getName();
				}
				fileFullPath = filePath + fileName;
			}

			String result = String.format("[%d]: fileName:%s \tfilePath:%s", uId, fileName, fileFullPath);
			System.out.println("... " + result);

			try {
				Thread.sleep(300);
			} catch (Exception e) {
				e.printStackTrace();
			}
			if(fileFullPath.endsWith(".html")) {//html만 저장되게
				out = new BufferedOutputStream(new FileOutputStream(new File(fileFullPath)));
				in = new BufferedInputStream(part.getInputStream());
				int k;
				while ((k = in.read()) != -1) {
					out.write(k);
				}
				try {
					Thread.sleep(300);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			
		} catch (MessagingException e) {
			e.printStackTrace();
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			try {
				if (in != null) {
					in.close();
				}
				if (out != null) {
					out.flush();
					out.close();
				}
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}

}
