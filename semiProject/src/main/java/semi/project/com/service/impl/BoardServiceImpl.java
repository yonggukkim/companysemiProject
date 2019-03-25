package semi.project.com.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import semi.project.com.dao.BoardDao;
import semi.project.com.service.BoardService;

@Service("boardService")
public class BoardServiceImpl implements BoardService {

	@Resource(name = "boardDao")
	private BoardDao boardDao;

	@Override
	public void list(Map<String, Object> search, Model model, HttpSession session) {
		// search
//		LocalDate currentDate = LocalDate.now();
//		if (search.get("datepicker") == "" && search.get("datepicker1") == "" && search.get("keyword") != "") {
//			search.remove("datepicker");
//			search.remove("datepicker1");
//			search.put("datepicker", currentDate.toString());
//			search.put("datepicker1", currentDate.toString());
//		}else if (search.get("datepicker") != "" && search.get("datepicker1") == "") {
//			search.remove("datepicker1");
//			search.put("datepicker1", search.get("datepicker"));
//		}else if (search.get("datepicker") == "" && search.get("datepicker1") != "") {
//			search.remove("datepicker");
//			search.put("datepicker", search.get("datepicker1"));
//		}
		System.out.println("data수신:" + search);
		model.addAttribute("reset", search);
		// search
		if(session.getAttribute("login") != null) {
		@SuppressWarnings("unchecked")
		Map<String, Object> map = (Map<String, Object>) session.getAttribute("login");
		System.out.println("맵 값 확인 : " + map);
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();

		if (search == null) {
			list = boardDao.list(map);
		} else {
			search.put("empId", map.get("empId"));
			search.put("empRank", map.get("empRank"));
			search.put("empSub", map.get("empSub"));
			search.put("EMP_RANK1", map.get("EMP_RANK1"));
			search.put("EMP_NAME1", map.get("EMP_NAME1"));
			search.put("empNum", map.get("empNum"));
			search.put("empName", map.get("empName"));
			list = boardDao.list(search);
		}
		model.addAttribute("list", list);
		}
	}

	@Override
	public String count(HttpSession session) {
		String count = boardDao.count();
		session.setAttribute("count", count);
		return "write";
	}

	/*
	 * @SuppressWarnings("unchecked") // insert, update 따로
	 * 
	 * @Override public String write(HttpServletRequest req, Model model,
	 * HttpSession session) { Map<String, Object> map = new HashMap<String,
	 * Object>(); map.put("boardNum", req.getParameter("boardNum"));
	 * map.put("empName", req.getParameter("empName")); map.put("boardSubject",
	 * req.getParameter("boardSubject")); map.put("boardContent",
	 * req.getParameter("boardContent")); if(req.getParameter("fail") != null ||
	 * req.getParameter("save") != null || req.getParameter("payment") != null ) {
	 * map.put("fail", req.getParameter("fail")); map.put("save",
	 * req.getParameter("save")); map.put("payment", req.getParameter("payment"));
	 * System.out.println("맵 값 확인 : "+map); int writeInsert = boardDao.write(map);
	 * 
	 * if(writeInsert == 1) { System.out.println("성공"); int hisInsert =
	 * boardDao.history(map); if(hisInsert == 1) { System.out.println("히스토리 성공");
	 * }else { System.out.println("히스토리 실패"); } return "redirect:/board"; }else {
	 * System.out.println("실패"); return "write"; }
	 * 
	 * }else { Map<String, Object> change = new HashMap<String, Object>(); change =
	 * (Map<String, Object>) session.getAttribute("login");
	 * System.out.println("change 값 확인 : "+change); if(req.getParameter("empName")
	 * != change.get("empName")) { map.put("empName", change.get("empName")); }
	 * map.put("upfail", req.getParameter("upfail")); map.put("upsave",
	 * req.getParameter("upsave")); map.put("uppayment",
	 * req.getParameter("uppayment")); System.out.println("맵 값 확인 : "+map); int
	 * writeUpdate = boardDao.upwrite(map);
	 * 
	 * if(writeUpdate == 1) { System.out.println("성공"); int hisInsert =
	 * boardDao.history(map); if(hisInsert == 1) { System.out.println("히스토리 성공");
	 * }else { System.out.println("히스토리 실패"); } return "redirect:/board"; }else {
	 * System.out.println("실패"); return "write"; } } }
	 */

	@Override
	public String write(HttpServletRequest req, Model model, HttpSession session) { // merge 사용
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("boardNum", req.getParameter("boardNum"));
		map.put("empName", req.getParameter("empName"));
		map.put("boardSubject", req.getParameter("boardSubject"));
		map.put("boardContent", req.getParameter("boardContent"));
		map.put("sessName", req.getParameter("sessName"));
		map.put("fail", req.getParameter("fail"));
		map.put("save", req.getParameter("save"));
		map.put("payment", req.getParameter("payment"));
		map.put("EMP_RANK1", req.getParameter("EMP_RANK1"));
		map.put("EMP_NAME1", req.getParameter("EMP_NAME1"));
		System.out.println("맵 값 확인 : " + map);
		int writeInsert = boardDao.write(map);

		if (writeInsert == 1) {
			System.out.println("성공");
			int hisInsert = boardDao.history(map);
			if (hisInsert == 1) {
				System.out.println("히스토리 성공");
			} else {
				System.out.println("히스토리 실패");
			}
			return "redirect:/board";
		} else {
			System.out.println("실패");
			return "write";
		}
	}

	@Override
	public String modify(String boardNum, Model model) {
		Map<String, Object> board = new HashMap<String, Object>();
		board = boardDao.modify(boardNum);
		System.out.println("게시글 확인 : " + board);
		model.addAttribute("board", board);
		List<Map<String, Object>> his = new ArrayList<Map<String, Object>>();
		his = boardDao.hisList(boardNum);
		System.out.println("히스토리 값 확인 : " + his);
		model.addAttribute("history", his);
		return "write";
	}

	@Override
	public void ajax(Map<String, Object> ajaxaa, Model model, HttpSession session) {
//		LocalDate currentDate = LocalDate.now();
//		if (ajax.get("datepicker") == "" && ajax.get("datepicker1") == "" && ajax.get("keyword") != "") {
//			ajax.remove("datepicker");
//			ajax.remove("datepicker1");
//			ajax.put("datepicker", currentDate.toString());
//			ajax.put("datepicker1", currentDate.toString());
//		}else if (ajax.get("datepicker") != "" && ajax.get("datepicker1") == "") {
//			ajax.remove("datepicker1");
//			ajax.put("datepicker1", ajax.get("datepicker"));
//		}else if (ajax.get("datepicker") == "" && ajax.get("datepicker1") != "") {
//			ajax.remove("datepicker");
//			ajax.put("datepicker", ajax.get("datepicker1"));
//		}
		System.out.println("data수신:" + ajaxaa);
		model.addAttribute("reset", ajaxaa);
		// search
		@SuppressWarnings("unchecked")
		Map<String, Object> map = (Map<String, Object>) session.getAttribute("login");
		System.out.println("맵 값 확인 : " + map);
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		ajaxaa.put("empId", map.get("empId"));
		ajaxaa.put("empRank", map.get("empRank"));
		ajaxaa.put("empNum", map.get("empNum"));
		ajaxaa.put("empName", map.get("empName"));
		System.out.println("에이작스 값 보여줘 !!!! ㄹㅇㅁㄹㅇㄴ" + ajaxaa);
		list = boardDao.ajax(ajaxaa);
		System.out.println("리스트 값 보여줘 에이작스 !!!" + list);
		model.addAttribute("list", list);
	}

	@Override
	public String substitute(HttpSession session, Model model) {
		
		List<Map<String, Object>> map = new ArrayList<Map<String, Object>>();
		@SuppressWarnings("unchecked")
		Map<String, Object> sess = (Map<String, Object>) session.getAttribute("login");
		map = boardDao.substitute(sess);
		model.addAttribute("sublist",map);
		return "substitute";
	}

	@SuppressWarnings("unchecked")
	@Override
	public String insertsub(String subName, String subRank, HttpSession session, Model model) {
		System.out.println("이름 :"+subName);
		System.out.println("직급 :"+subRank);
		Map<String, Object> emp = new HashMap<String, Object>();
		emp.put("subName", subName);
		emp.put("subRank", subRank);
		int upok = boardDao.update(emp);
		if(upok == 1) { 
			System.out.println("up성공");
			emp = (Map<String, Object>) session.getAttribute("login");
			emp.put("subName", subName);
			emp.put("subRank", subRank);
			System.out.println("emp 확인 :"+emp);
			int inok = boardDao.insertsub(emp);
			if(inok == 1) System.out.println("in성공");
			else System.out.println("in실패");
		}else System.out.println("up실패");
		return "substitute";
	}

}
