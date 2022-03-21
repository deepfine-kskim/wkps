package egovframework.com.wkp.usr.service;

import java.util.List;

public interface EgovUserService {
	
    public List<UserVO> selectUserList(UserVO userVO);

    public List<UserVO> selectUserListByOuCode(UserVO userVO);
    
    public int selectUserRoleCheck(UserVO userVO);
    
    public UserVO selectUserDetail(UserVO userVO);
    
    public UserVO selectUserLogin(UserVO userVO);
    
    public int insertUser(UserVO userVO);
    
    public int updateUser(UserVO userVO);
    
    public int deleteUser(UserVO userVO);

    public List<UserVO> selectManagerList(UserVO userVO);
    
    public int insertManager(UserVO userVO);
    
    public int deleteManager(UserVO userVO);
    
    public int updateManager(UserVO userVO);
    
    public int insertNickName(UserVO userVO);
    
    public int insertRequestManager(UserVO userVO);
    
    public int deleteRequestManager(UserVO userVO);
    
    public List<UserVO> selectRequestManagerList(UserVO userVO);
    
    public int insertOrgManager(UserVO userVO);

    public void deleteUser();
    
}
