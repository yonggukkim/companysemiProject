package semi.project.com.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

public interface LoginService {

	String login(HttpServletRequest req, HttpSession session);

	String snslogin(String userNickName, HttpSession session);

}
