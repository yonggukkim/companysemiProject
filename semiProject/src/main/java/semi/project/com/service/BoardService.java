package semi.project.com.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.ui.Model;

public interface BoardService {

	void list(Map<String, Object> search, Model model, HttpSession session);
	
	String count(HttpSession session);

	String write(HttpServletRequest req, Model model, HttpSession session);

	String modify(String boardNum, Model model);

	void ajax(Map<String, Object> ajax, Model model, HttpSession session);

	String substitute(HttpSession session, Model model);

	String insertsub(String subName, String subRank, HttpSession session, Model model);
}
