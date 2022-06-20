package co.prj.Aproject.member.vo;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class MemberVO {
	private int member_num;
	private int section_id;
	private String member_email;
	private String member_pw;
	private String member_name;
	private String member_phone;
	private Date member_date;
	private String member_job;
	private String member_yn;
	private int member_auth;
	private String member_mail_email;
	private String member_mail_pw;
}
