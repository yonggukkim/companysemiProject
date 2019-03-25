package semi.project.com.dao.impl;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import semi.project.com.dao.BoardDao;
@Repository("boardDao")
public class BoardDaoImpl implements BoardDao{

	@Autowired
	private SqlSessionTemplate sqlSession;

	
	@Override
	public List<Map<String, Object>> list(Map<String, Object> map) {
		return sqlSession.selectList("boardmapper.list", map);
	}
	
	@Override
	public String count() {
		return sqlSession.selectOne("boardmapper.count");
	}

	@Override
	public int write(Map<String, Object> map) {
		return sqlSession.insert("boardmapper.write", map);
	}

	@Override
	public int upwrite(Map<String, Object> map) {
		return sqlSession.update("boardmapper.upwrite", map);
	}
	
	@Override
	public int history(Map<String, Object> map) {
		return sqlSession.insert("boardmapper.history", map);
	}

	@Override
	public List<Map<String, Object>> hisList(String boardNum) {
		return sqlSession.selectList("boardmapper.hisList", boardNum);
	}

	@Override
	public Map<String, Object> modify(String boardNum) {
		return sqlSession.selectOne("boardmapper.modify", boardNum);
	}

	@Override
	public List<Map<String, Object>> ajax(Map<String, Object> ajaxaa) {
		return sqlSession.selectList("boardmapper.ajaxaa", ajaxaa);
	}

	@Override
	public List<Map<String, Object>> substitute(Map<String, Object> sess) {
		return sqlSession.selectList("boardmapper.substitute", sess);
	}

	@Override
	public int update(Map<String, Object> emp) {
		return sqlSession.update("boardmapper.update", emp);
	}

	@Override
	public int insertsub(Map<String, Object> emp) {
		return sqlSession.insert("boardmapper.insertsub", emp);
	}
}
