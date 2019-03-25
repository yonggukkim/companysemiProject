package semi.project.com.controller;

import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import semi.project.com.service.BoardService;

@Controller
public class BoardController {

	@Resource(name = "boardService")
	private BoardService boardService;
	
	@RequestMapping("board")
	public String board(@RequestParam Map<String, Object> search, Model model, HttpSession session) {
		boardService.list(search, model, session);
		return "board";
	}
	
	@RequestMapping("condition")
	public String condition(@RequestParam Map<String, Object> ajax, Model model, HttpSession session) {
		boardService.ajax(ajax, model, session);
		return "condition";
	}
	
	@RequestMapping(value = "write", method = RequestMethod.GET)
	public String write(HttpSession session) {
		String writeCount = boardService.count(session);
		return writeCount;
	}
	
	@RequestMapping(value = "write", method = RequestMethod.POST)
	public String write(HttpServletRequest req, Model model, HttpSession session) {
		System.out.println("성공");
		System.out.println("form으로 받아온 값 : "+req.getParameter("boardNum"));
		System.out.println("form으로 받아온 값 : "+req.getParameter("empName"));
		System.out.println("form으로 받아온 값 : "+req.getParameter("boardSubject"));
		System.out.println("form으로 받아온 값 : "+req.getParameter("boardContent"));
		System.out.println("form으로 받아온 값 : "+req.getParameter("fail"));
		System.out.println("form으로 받아온 값 : "+req.getParameter("save"));
		System.out.println("form으로 받아온 값 : "+req.getParameter("payment"));
		String write = boardService.write(req, model, session);
		return write;
	}
	
	@RequestMapping("modify")
	public String modify(@RequestParam("board_num") String boardNum, Model model) {
		String mod = boardService.modify(boardNum, model);
		return mod;
	}
	
	@RequestMapping(value = "substitute", method = RequestMethod.GET)
	public String substitute(HttpSession session ,Model model) {
		String ok = boardService.substitute(session, model);
		return ok;
	}
	
	@RequestMapping(value = "substitute", method = RequestMethod.POST)
	public String substitute(@RequestParam("subName") String subName, @RequestParam("subRank") String subRank, HttpSession session, Model model) {
		String okay = boardService.insertsub(subName, subRank, session, model);
		return okay;
	}
}
