package co.prj.Aproject.section.command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import co.prj.Aproject.comm.Command;
import co.prj.Aproject.section.service.SectionService;
import co.prj.Aproject.section.serviceImpl.SectionServiceImpl;
import co.prj.Aproject.section.vo.SectionVO;

public class SectionSelect implements Command {

	@Override
	public String exec(HttpServletRequest request, HttpServletResponse response) {
		SectionService service = new SectionServiceImpl();
		
		SectionVO vo = new SectionVO();
		
		vo.setSection_id(Integer.parseInt(request.getParameter("section_id")));
		
		Gson gson = new GsonBuilder().create();
		vo = service.sectionSelect(vo);
		
		return "ajax:" + gson.toJson(vo);
	}

}
