package egovframework.mgt.wkp.mnu.service;

import java.util.List;

public interface EgovMenuService {
	
    public List<MenuVO> selectMenuList(MenuVO menuVO);
    
    public MenuVO selectMenu(MenuVO menuVO);
	
    public int insertMenu(MenuVO menuVO);
    
    public int updateMenu(MenuVO menuVO);
    
    public int deleteMenu(MenuVO menuVO);
    
}
