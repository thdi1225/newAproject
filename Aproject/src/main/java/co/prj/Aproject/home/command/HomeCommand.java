package co.prj.Aproject.home.command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import co.prj.Aproject.comm.Command;

public class HomeCommand implements Command {
	
	@Override
	public String exec(HttpServletRequest request, HttpServletResponse response) {
		return "home/home";
	}

}
