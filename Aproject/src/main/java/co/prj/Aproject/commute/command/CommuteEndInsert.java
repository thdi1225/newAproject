package co.prj.Aproject.commute.command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import co.prj.Aproject.comm.Command;
import co.prj.Aproject.commute.Impl.CommuteImpl;
import co.prj.Aproject.commute.service.CommuteService;

public class CommuteEndInsert implements Command {

	@Override
	public String exec(HttpServletRequest request, HttpServletResponse response) {
		
		CommuteService dao = new CommuteImpl();
		dao.commuteEndInsert();
		
		return  "commute/commute";
	}

}
