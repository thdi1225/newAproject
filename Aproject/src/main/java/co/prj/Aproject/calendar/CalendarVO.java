package co.prj.Aproject.calendar;

import java.sql.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class CalendarVO {
	private int calendar_id;
	private String calendar_title;
	private String calendar_subject;
	
	@JsonFormat(pattern = "yyyy-MM-dd",timezone = "Asia/Seoul")	
	private Date calendar_start_date;
	@JsonFormat(pattern = "yyyy-MM-dd",timezone = "Asia/Seoul")	
	private Date calendar_end_date;
	
	
	private int member_num; 
	private int section_id;
	
}
