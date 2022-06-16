package co.prj.Aproject.email.vo;

import java.util.Date;

//import java.util.Date;

import lombok.Data;

@Data
public class EmailVO { //emailVO
	private int emailId;
	private String emailTo;
	private String emailFrom;
	private String emailTitle;
	private String emailSubject;
	private Date emailDate;
	private int memberNum;
}
