package egovframework.mgt.wkp.mnu.service.impl;

import java.util.List;
import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.mgt.wkp.mnu.service.EgovMenuService;
import egovframework.mgt.wkp.mnu.service.MenuVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service("menuService")
public class EgovMenuServiceImpl extends EgovAbstractServiceImpl implements EgovMenuService {

    @Resource(name="menuDAO")
    private MenuDAO menuDAO;

	@Override
	public List<MenuVO> selectMenuList(MenuVO menuVO) {
		return menuDAO.selectMenuList(menuVO);
	}

	@Override
	public MenuVO selectMenu(MenuVO menuVO) {
		return menuDAO.selectMenu(menuVO);
	}

	@Override
	public int insertMenu(MenuVO menuVO) {
		return menuDAO.insertMenu(menuVO);
	}

	@Override
	public int updateMenu(MenuVO menuVO) {
		return menuDAO.updateMenu(menuVO);
	}

	@Override
	public int deleteMenu(MenuVO menuVO) {
		return menuDAO.deleteMenu(menuVO);
	}

}
