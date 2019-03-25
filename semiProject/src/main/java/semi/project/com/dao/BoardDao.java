package semi.project.com.dao;

import java.util.List;
import java.util.Map;

public interface BoardDao {

	List<Map<String, Object>> list(Map<String, Object> map);

	String count();

	int write(Map<String, Object> map);

	int history(Map<String, Object> map);

	List<Map<String, Object>> hisList(String boardNum);

	Map<String, Object> modify(String boardNum);

	int upwrite(Map<String, Object> map);

	List<Map<String, Object>> ajax(Map<String, Object> ajaxaa);

	List<Map<String, Object>> substitute(Map<String, Object> sess);

	int update(Map<String, Object> emp);

	int insertsub(Map<String, Object> emp);
}
