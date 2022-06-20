package co.prj.Aproject.board.vo;

import java.sql.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class BoardVO {
	private int board_id;
	private String board_writer;
	private String board_title;
	private String board_subject;
	
	
	private int member_num;
	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "Asia/Seoul")
	private Date board_date;
	private int hit;
	private String fileName;
	private String dirFileName;
	
}
