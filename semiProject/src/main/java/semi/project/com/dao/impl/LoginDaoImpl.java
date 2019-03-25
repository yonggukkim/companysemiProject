package semi.project.com.dao.impl;

import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import semi.project.com.dao.LoginDao;

@Repository("loginDao")
public class LoginDaoImpl implements LoginDao{
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public Map<String, Object> login(Map<String, Object> map1) {
		return sqlSession.selectOne("loginmapper.login", map1);
	}

	@Override
	public Map<String, Object> subeq(Map<String, Object> map) {
		return sqlSession.selectOne("loginmapper.subeq", map);
	}

	
}
