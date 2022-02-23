package egovframework.mgt.wkp.mnu.web;

import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.mgt.wkp.mnu.service.EgovMenuService;
import egovframework.mgt.wkp.mnu.service.MenuVO;

@Controller
@RequestMapping("/adm")
public class EgovMenuController {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(EgovMenuController.class);
	
	@Resource(name="menuService")
	private EgovMenuService menuService;
	
	@RequestMapping("/menuList.do")
	public String menuList(@ModelAttribute("menuVO") MenuVO menuVO, Model model) {
		
		try {
			List<MenuVO> menuList = menuService.selectMenuList(menuVO);		
			model.addAttribute("menuList", menuList);
		} catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}
		
		return "/mgt/wkp/mnu/EgovMenu";		
	}
	
	@RequestMapping("/updateMenu.do")
	public String updateMenu(@ModelAttribute("menuVO") MenuVO menuVO, Model model) {
		
		try {
			for(MenuVO menu: menuVO.getMenuList()) {
				menuService.updateMenu(menu);
			}			
		} catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}
		
		return "redirect:/adm/menuList.do";		
	}

}
