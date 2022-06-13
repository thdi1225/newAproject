package co.prj.Aproject.board.vo;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class BoardVO {
	private int boardid;
	private String boardtitle;
	private String boardsubject;
	private Date boarddate;
	
}
