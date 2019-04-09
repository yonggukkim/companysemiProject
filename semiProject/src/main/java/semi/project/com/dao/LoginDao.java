package semi.project.com.dao;

import java.util.Map;

public interface LoginDao {

	Map<String, Object> login(Map<String, Object> map1);

	Map<String, Object> subeq(Map<String, Object> map);

	Map<String, Object> snscheck(String userNickName);

	Map<String, Object> snslogin(Map<String, Object> map1);
}
