package egovframework.com.wkp.usr.service.impl;

import java.util.List;
import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import egovframework.com.wkp.usr.service.UserVO;

@Repository("userDAO")
public class UserDAO extends EgovComAbstractDAO {

	public List<UserVO> selectUserList(UserVO userVO) {
		return selectList("UserDAO.selectUserList", userVO);
	}
	
	public int selectUserRoleCheck(UserVO userVO) {
		return selectOne("UserDAO.selectUserRoleCheck", userVO);
	}
	
	public UserVO selectUserDetail(UserVO userVO) {
		return selectOne("UserDAO.selectUserDetail", userVO);
	}
	
	public UserVO selectUserLogin(UserVO userVO) {
		return selectOne("UserDAO.selectUserLogin", userVO);
	}

	public int insertUser(UserVO userVO) {
		return insert("UserDAO.insertUser", userVO);
	}

	public int updateUser(UserVO userVO) {
		return update("UserDAO.updateUser", userVO);
	}

	public int deleteUser(UserVO userVO) {
		return delete("UserDAO.deleteUser", userVO);
	}
	
	public List<UserVO> selectManagerList(UserVO userVO) {
		return selectList("UserDAO.selectManagerList", userVO);
	}
	
	public int insertManager(UserVO userVO) {
		return insert("UserDAO.insertManager", userVO);
	}
	
	public int deleteManager(UserVO userVO) {
		return delete("UserDAO.deleteManager", userVO);
	}

	public int updateManager(UserVO userVO) {
		return update("UserDAO.updateManager", userVO);
	}
	
	public int insertNickName(UserVO userVO) {
		return insert("UserDAO.insertNickName", userVO);
	}
    
	public int insertRequestManager(UserVO userVO) {
		return insert("UserDAO.insertRequestManager", userVO);
	}
	
	public int deleteRequestManager(UserVO userVO) {
		return delete("UserDAO.deleteRequestManager", userVO);
	} 
	
	public List<UserVO> selectRequestManagerList(UserVO userVO) {
		return selectList("UserDAO.selectRequestManagerList", userVO);
	}
	
	public int insertOrgManager(UserVO userVO) {
		return insert("UserDAO.insertOrgManager", userVO);
	}

	public void deleteUser() {
		update("UserDAO.deleteUser");
	}
	
}
