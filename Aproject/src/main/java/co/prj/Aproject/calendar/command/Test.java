package co.prj.Aproject.calendar.command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import co.prj.Aproject.comm.Command;

public class Test implements Command {

	@Override
	public String exec(HttpServletRequest request, HttpServletResponse response) {
		
		return "calendar/test";
	}

}
