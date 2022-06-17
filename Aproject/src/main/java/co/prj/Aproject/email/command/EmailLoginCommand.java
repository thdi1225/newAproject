package co.prj.Aproject.email.command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import co.prj.Aproject.comm.Command;

public class EmailLoginCommand implements Command {

	@Override
	public String exec(HttpServletRequest request, HttpServletResponse response) {
		return "email/emailLogin";
	}

}
