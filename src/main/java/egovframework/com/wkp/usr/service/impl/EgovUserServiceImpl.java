package egovframework.com.wkp.usr.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.com.wkp.usr.service.EgovUserService;
import egovframework.com.wkp.usr.service.UserVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service("userService")
public class EgovUserServiceImpl extends EgovAbstractServiceImpl implements EgovUserService {

    @Resource(name="userDAO")
    private UserDAO userDAO;

	@Override
	public List<UserVO> selectUserList(UserVO userVO) {
		return userDAO.selectUserList(userVO);
	}
	
	@Override
	public int selectUserRoleCheck(UserVO userVO) {
		return userDAO.selectUserRoleCheck(userVO);
	}
	
	@Override
	public UserVO selectUserDetail(UserVO userVO) {
		return userDAO.selectUserDetail(userVO);
	}
	
	@Override
	public UserVO selectUserLogin(UserVO userVO) {
		return userDAO.selectUserLogin(userVO);
	}

	@Override
	public int insertUser(UserVO userVO) {
		return userDAO.insertUser(userVO);
	}

	@Override
	public int updateUser(UserVO userVO) {
		return userDAO.updateUser(userVO);
	}

	@Override
	public int deleteUser(UserVO userVO) {
		return userDAO.deleteUser(userVO);
	}

	@Override
	public List<UserVO> selectManagerList(UserVO userVO) {
		return userDAO.selectManagerList(userVO);
	}

	@Override
	public int insertManager(UserVO userVO) {
		return userDAO.insertManager(userVO);
	}

	@Override
	public int deleteManager(UserVO userVO) {
		return userDAO.deleteManager(userVO);
	}

	@Override
	public int updateManager(UserVO userVO) {
		return userDAO.updateManager(userVO);
	}

	@Override
	public int insertNickName(UserVO userVO) {
		return userDAO.insertNickName(userVO);
	}
	
	@Override
	public int insertRequestManager(UserVO userVO) {
		return userDAO.insertRequestManager(userVO);
	}
	
	@Override
	public int deleteRequestManager(UserVO userVO) {
		return userDAO.deleteRequestManager(userVO);
	}

	@Override
	public List<UserVO> selectRequestManagerList(UserVO userVO) {
		return userDAO.selectRequestManagerList(userVO);
	}

	@Override
	public int insertOrgManager(UserVO userVO) {
		return userDAO.insertOrgManager(userVO);
	}

	@Override
	public void deleteUser() {
		userDAO.deleteUser();
	}
}