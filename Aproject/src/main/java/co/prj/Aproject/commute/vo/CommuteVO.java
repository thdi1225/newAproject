package co.prj.Aproject.commute.vo;


import java.sql.Date;
import java.sql.Timestamp;


import lombok.Data;
@Data
public class CommuteVO {
	
	
	private int commute_id;
	private Date commute_date;
	private Timestamp commute_start_time;
	private Timestamp commute_end_time;
	private int member_num;
	private int commute_num;
	

	
}
