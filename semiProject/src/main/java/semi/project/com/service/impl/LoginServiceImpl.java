package semi.project.com.service.impl;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;

import semi.project.com.dao.LoginDao;
import semi.project.com.service.LoginService;

@Service("loginService")
public class LoginServiceImpl implements LoginService{

	@Resource(name = "loginDao")
	private LoginDao loginDao;

	@Override
	public String login(HttpServletRequest req, HttpSession session) {
		Map<String, Object> map = new HashMap<String, Object>();
			map.put("empId", req.getParameter("empId"));
			map.put("empPass", req.getParameter("empPass"));
			System.out.println("map 값 검사 : "+map );
		Map<String, Object> map1 = new HashMap<String, Object>();
			map1 = loginDao.subeq(map);
			System.out.println("map1 값 검사 : "+map1);
		Map<String, Object> impoLogin = loginDao.login(map1);
		if(impoLogin != null) {
			impoLogin.put("empPass", "****");
			session.setAttribute("login", impoLogin);
			System.out.println("세션 값 확인 : "+session.getAttribute("login"));
			System.out.println("성공");
			return "redirect:/board";
		}else {
			System.out.println("실패");
			System.out.println("map 실패 값 확인 : "+map);
			return "loginfail";
		}
	}
	@Override
	public String snslogin(String userNickName, HttpSession session) {
		userNickName = "kook7749@naver.com";
		System.out.println(userNickName);
		Map<String, Object> map1 = new HashMap<String, Object>();
		map1 = loginDao.snscheck(userNickName);
		Map<String, Object> map = loginDao.snslogin(map1);
		if(map != null) {
			map.put("empPass", "****");
			session.setAttribute("login", map);
			System.out.println("세션 값 확인 : "+session.getAttribute("login"));
			System.out.println("성공");
			return "redirect:/board";
		}else {
			System.out.println("실패");
			return "loginfail";
		}
	}
}
