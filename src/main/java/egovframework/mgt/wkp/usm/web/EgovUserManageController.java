package egovframework.mgt.wkp.usm.web;

import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.com.wkp.cmm.service.EgovCommonService;
import egovframework.com.wkp.cmm.service.ExcellenceOrgVO;
import egovframework.com.wkp.cmm.service.ExcellenceUserVO;
import egovframework.com.wkp.usr.service.EgovUserService;
import egovframework.com.wkp.usr.service.UserVO;
import egovframework.rte.fdl.access.bean.AuthorityResourceMetadata;

@Controller
@RequestMapping("/adm")
public class EgovUserManageController {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(EgovUserManageController.class);
	
    @Resource(name="commonService")
    private EgovCommonService commonService;
    
	@Resource(name = "userService")
	private EgovUserService userService;
	
	@Resource(name="authorityResource")
	AuthorityResourceMetadata authorityResource;
	
	@RequestMapping("/excellentUser.do")
	public String excellentUser(@ModelAttribute("excellenceUserVO") ExcellenceUserVO excellenceUserVO, Model model) {
		
		try {
            List<ExcellenceUserVO> excellenceUserList = commonService.selectExcellenceUserList(excellenceUserVO);
            model.addAttribute("excellenceUserList", excellenceUserList);		
		} catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}
		
		return "/mgt/wkp/ugm/EgovExcellentUser";
		
	}
	
	@RequestMapping("/insertExcellentUser.do")
	public String insertExcellentUser(@ModelAttribute("excellenceUserVO") ExcellenceUserVO excellenceUserVO, RedirectAttributes redirect) {
		
		try {
			UserVO user = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();
			excellenceUserVO.setRegisterId(user.getSid());
            int result = commonService.insertExcellenceUser(excellenceUserVO);
            if(result <= 0) {
            	redirect.addFlashAttribute("errMsg", "등록할 수 없습니다.");
            }
		} catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}
		
		return "redirect:/adm/excellentUser.do";
		
	}
	
	@RequestMapping("/deleteExcellentUser.do")
	public String deleteExcellentUser(@ModelAttribute("excellenceUserVO") ExcellenceUserVO excellenceUserVO) {
		
		try {
			UserVO user = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();
			excellenceUserVO.setRegisterId(user.getSid());
			
            commonService.deleteExcellenceUser(excellenceUserVO);
		} catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}
		
		return "redirect:/adm/excellentUser.do";
		
	}
	
	@RequestMapping("/excellentOrg.do")
	public String excellentDept(@ModelAttribute("excellenceOrgVO") ExcellenceOrgVO excellenceOrgVO, Model model) {
		
		try {
			List<ExcellenceOrgVO> excellenceOrgList = commonService.selectExcellenceOrgList(excellenceOrgVO);
            model.addAttribute("excellenceOrgList", excellenceOrgList);
		} catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}
		
		return "/mgt/wkp/ugm/EgovExcellentOrg";
	}
	
	@RequestMapping("/insertExcellentOrg.do")
	public String insertExcellentOrg(@ModelAttribute("excellenceOrgVO") ExcellenceOrgVO excellenceOrgVO, RedirectAttributes redirect) {
		
		try {
			UserVO user = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();
			excellenceOrgVO.setRegisterId(user.getSid());
			
            int result = commonService.insertExcellenceOrg(excellenceOrgVO);
            if(result <= 0) {
            	redirect.addFlashAttribute("errMsg", "등록할 수 없습니다.");
            }
		} catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}
		
		return "redirect:/adm/excellentOrg.do";
		
	}
	
	@RequestMapping("/deleteExcellentOrg.do")
	public String deleteExcellentOrg(@ModelAttribute("excellenceOrgVO") ExcellenceOrgVO excellenceOrgVO) {
		
		try {
			UserVO user = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();
			excellenceOrgVO.setRegisterId(user.getSid());
			
            commonService.deleteExcellenceOrg(excellenceOrgVO);
		} catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}
		
		return "redirect:/adm/excellentOrg.do";
		
	}
	
	@RequestMapping("/manager.do")
	public String manager(@ModelAttribute("userVO") UserVO userVO, Model model) {
		
		try {
			if(userVO.getPage() == null || userVO.getPage() == 0) {
				userVO.setPage(1);
			}
			
			List<UserVO> managerList = userService.selectManagerList(userVO);
			model.addAttribute("managerList", managerList);
		} catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}
		
		return "/mgt/wkp/ugm/EgovManager";
		
	}
	
	@RequestMapping("/insertManager.do")
	public String insertManager(@ModelAttribute("userVO") UserVO userVO) {
		
		try {
			UserVO user = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();
			userVO.setRegisterId(user.getSid());
			
			userService.insertManager(userVO);
			authorityResource.reload();
		}  catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		} catch (Exception e) {
			LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}
		
		return "redirect:/adm/manager.do";
		
	}
	
	@RequestMapping("/deleteManager.do")
	public String deleteManager(@ModelAttribute("userVO") UserVO userVO) {
		
		try {
			UserVO user = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();
			userVO.setRegisterId(user.getSid());
			
			userService.deleteManager(userVO);
			authorityResource.reload();
		} catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		} catch (Exception e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}
		
		return "redirect:/adm/manager.do";
		
	}
	
	@RequestMapping("/updateManager.do")
	public String updateManager(@ModelAttribute("userVO") UserVO userVO) {
		
		try {
			UserVO user = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();
			userVO.setRegisterId(user.getSid());
			
			userService.updateManager(userVO);
			authorityResource.reload();
		} catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		} catch (Exception e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}
		
		return "redirect:/adm/manager.do";
		
	}
	
	@RequestMapping("/requestManagerList.do")
	public String requestManagerList(@ModelAttribute("userVO") UserVO userVO, Model model) {
		
		try {
			if(userVO.getPage() == null || userVO.getPage() == 0) {
				userVO.setPage(1);
			}
			
			List<UserVO> requestManagerList = userService.selectRequestManagerList(userVO);
			model.addAttribute("requestManagerList", requestManagerList);
		} catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}
		
		return "/mgt/wkp/ugm/EgovRequestManager";		
		
	}
	
	@RequestMapping("/insertOrgManager.do")
	public String insertOrgManager(@ModelAttribute("userVO") UserVO userVO) {
		
		try {
			UserVO user = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();
			
			int result = 0;
			for(UserVO org:userVO.getUserList()) {
				org.setRegisterId(user.getSid());
				result += userService.insertOrgManager(org);	
			}
			if(result > 0) {
				for(UserVO org:userVO.getUserList()) {
					userVO.setSid(org.getSid());
					userService.deleteRequestManager(org);
				}
			}
			authorityResource.reload();
		} catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		} catch (Exception e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}
		
		return "redirect:/adm/requestManagerList.do";		
		
	}
	
	@RequestMapping("/deleteRequestManager.do")
	public String deleteRequestManager(@ModelAttribute("userVO") UserVO userVO) {
		
		try {
			UserVO user = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();
			userVO.setRegisterId(user.getSid());
			
			userService.deleteRequestManager(userVO);	
		} catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}
		
		return "redirect:/adm/requestManagerList.do";		
		
	}

}
