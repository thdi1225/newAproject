package co.prj.Aproject.board.command;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import co.prj.Aproject.board.service.BoardService;
import co.prj.Aproject.board.serviceImpl.BoardServiceImpl;
import co.prj.Aproject.board.vo.BoardVO;
import co.prj.Aproject.comm.Command;

public class BoardInput implements Command {
	@Override
	public String exec(HttpServletRequest request, HttpServletResponse response) {
			
		// 게시글 저장
			BoardService dao = new BoardServiceImpl();
			BoardVO vo = new BoardVO();
			String saveDir = "c:\\temp\\";  //실제 저장할 공간
			int size = 1024*1024*1024;  //파일 최대 사이즈
			String dirFile="";
			String originalFile="";
			
			try {
				MultipartRequest multi = new MultipartRequest(
												request, 
												saveDir, 
												size,
												"utf-8",
												new DefaultFileRenamePolicy());
				dirFile = (multi).getFilesystemName("file"); //물리공간에 저장될 파일명
				originalFile = multi.getOriginalFileName("file"); //실제 파일명
				vo.setMember_num(Integer.parseInt(multi.getParameter("member_num")));
				vo.setBoard_writer(multi.getParameter("writer"));
				vo.setBoard_title(multi.getParameter("title"));
				vo.setBoard_subject(multi.getParameter("subject"));
				vo.setFileName(originalFile);
				vo.setDirFileName(dirFile);
			} catch (IOException e) {
				e.printStackTrace();
			}
			
			System.out.println(vo.toString());
			int n = dao.boardInsert(vo);
			
			List<BoardVO> list = new ArrayList<BoardVO>();
			
			list = dao.boardSelectList(null);
			
			request.setAttribute("list", list);
			request.setAttribute("message", "등록되었습니다.");
			
			return "boardList.do";
		}

	}