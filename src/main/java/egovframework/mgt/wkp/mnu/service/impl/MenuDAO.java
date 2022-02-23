package egovframework.mgt.wkp.mnu.service.impl;

import java.util.List;
import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import egovframework.mgt.wkp.mnu.service.MenuVO;

@Repository("menuDAO")
public class MenuDAO extends EgovComAbstractDAO {

	public List<MenuVO> selectMenuList(MenuVO menuVO) {
		return selectList("MenuDAO.selectMenuList", menuVO);
	}

	public MenuVO selectMenu(MenuVO menuVO) {
		return selectOne("MenuDAO.selectMenu", menuVO);
	}

	public int insertMenu(MenuVO menuVO) {
		return insert("MenuDAO.insertMenu", menuVO);
	}

	public int updateMenu(MenuVO menuVO) {
		return update("MenuDAO.updateMenu", menuVO);
	}

	public int deleteMenu(MenuVO menuVO) {
		return delete("MenuDAO.deleteMenu", menuVO);
	}

}
