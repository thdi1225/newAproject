package co.prj.Aproject.board.vo;

import java.sql.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
@Getter
@Setter
@ToString
public class ReplyVO {
	private int board_reply_id;
	private String board_reply_subject;
	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "Asia/Seoul")
	private Date board_reply_date;
	private int board_id;
	private int page;
}
