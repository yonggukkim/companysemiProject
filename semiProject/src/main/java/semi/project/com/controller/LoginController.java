package semi.project.com.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import semi.project.com.service.LoginService;

@Controller
public class LoginController {
	
	@Resource(name = "loginService")
	private LoginService loginService;
	
	@RequestMapping(value="/login", method = RequestMethod.GET)
	public String login(Model model, HttpServletRequest req) {
		model.addAttribute("login",req);
		return "login";
	}
	
	@RequestMapping(value="/login", method = RequestMethod.POST)
	public String login(HttpServletRequest req, HttpSession session) {
		System.out.println("로그인 시작");
		String success = loginService.login(req, session);
		System.out.println("로그인 끝");
		return success;
	}
	
	@RequestMapping("logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/login";
	}
}
