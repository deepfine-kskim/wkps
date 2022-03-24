package egovframework.mgt.wkp.usm.web;

import java.util.List;

import javax.annotation.Resource;

import egovframework.com.wkp.cmm.service.Scheduler;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
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

	@Resource(name = "scheduler")
	private Scheduler scheduler;

	/**
	 * 사용자 관리 > 우수 사용자 > 목록 조회
	 * @param excellenceUserVO VO
	 * @param model Model
	 * @return View Page
	 */
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

	/**
	 * 사용자 관리 > 우수 사용자 > 등록
	 * @param excellenceUserVO VO
	 * @param redirect Model
	 * @return Redirect
	 */
	@RequestMapping("/insertExcellentUser.do")
	public String insertExcellentUser(@ModelAttribute("excellenceUserVO") ExcellenceUserVO excellenceUserVO, RedirectAttributes redirect) {
		try {
			UserVO user = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();
			excellenceUserVO.setRegisterId(user.getSid());
			int result = commonService.insertExcellenceUser(excellenceUserVO);
			if (result <= 0) {
				redirect.addFlashAttribute("errMsg", "등록할 수 없습니다.");
			}
		} catch (NullPointerException e) {
			LOGGER.error("[" + e.getClass() + "] :" + e.getMessage());
		}
		return "redirect:/adm/excellentUser.do";
	}

	/**
	 * 사용자 관리 > 우수 사용자 > 삭제
	 * @param excellenceUserVO VO
	 * @return Redirect
	 */
	@RequestMapping("/deleteExcellentUser.do")
	public String deleteExcellentUser(@ModelAttribute("excellenceUserVO") ExcellenceUserVO excellenceUserVO) {
		try {
            commonService.deleteExcellenceUser(excellenceUserVO);
		} catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}
		return "redirect:/adm/excellentUser.do";
	}

	/**
	 * 사용자 관리 > 우수 부서 > 목록 조회
	 * @param excellenceOrgVO VO
	 * @param model Model
	 * @return View Page
	 */
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

	/**
	 * 사용자 관리 > 우수 부서 > 등록
	 * @param excellenceOrgVO VO
	 * @param redirect Model
	 * @return Redirect
	 */
	@RequestMapping("/insertExcellentOrg.do")
	public String insertExcellentOrg(@ModelAttribute("excellenceOrgVO") ExcellenceOrgVO excellenceOrgVO, RedirectAttributes redirect) {
		try {
			UserVO user = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();
			excellenceOrgVO.setRegisterId(user.getSid());
			int result = commonService.insertExcellenceOrg(excellenceOrgVO);
			if (result <= 0) {
				redirect.addFlashAttribute("errMsg", "등록할 수 없습니다.");
			}
		} catch (NullPointerException e) {
			LOGGER.error("[" + e.getClass() + "] :" + e.getMessage());
		}
		return "redirect:/adm/excellentOrg.do";
	}

	/**
	 * 사용자 관리 > 우수 부서 > 삭제
	 * @param excellenceOrgVO VO
	 * @return Redirect
	 */
	@RequestMapping("/deleteExcellentOrg.do")
	public String deleteExcellentOrg(@ModelAttribute("excellenceOrgVO") ExcellenceOrgVO excellenceOrgVO) {
		try {
			commonService.deleteExcellenceOrg(excellenceOrgVO);
		} catch (NullPointerException e) {
			LOGGER.error("[" + e.getClass() + "] :" + e.getMessage());
		}
		return "redirect:/adm/excellentOrg.do";
	}

	/**
	 * 사용자 관리 > 관리자 관리 > 목록 조회
	 * @param userVO VO
	 * @param model  Model
	 * @return View Page
	 */
	@RequestMapping("/manager.do")
	public String manager(@ModelAttribute("userVO") UserVO userVO, Model model) {
		try {
			if (userVO.getPage() == null || userVO.getPage() == 0) {
				userVO.setPage(1);
			}

			List<UserVO> managerList = userService.selectManagerList(userVO);
			model.addAttribute("managerList", managerList);
		} catch (NullPointerException e) {
			LOGGER.error("[" + e.getClass() + "] :" + e.getMessage());
		}
		return "/mgt/wkp/ugm/EgovManager";
	}

	/**
	 * 사용자 관리 > 관리자 관리 > 등록
	 * @param userVO VO
	 * @return Redirect
	 */
	@RequestMapping("/insertManager.do")
	public String insertManager(@ModelAttribute("userVO") UserVO userVO) {
		try {
			UserVO user = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();
			userVO.setRegisterId(user.getSid());

			userService.insertManager(userVO);
			authorityResource.reload();
		} catch (NullPointerException e) {
			LOGGER.error("[" + e.getClass() + "] :" + e.getMessage());
		} catch (Exception e) {
			LOGGER.error("[" + e.getClass() + "] :" + e.getMessage());
		}
		return "redirect:/adm/manager.do";
	}

	/**
	 * 사용자 관리 > 관리자 관리 > 삭제
	 * @param userVO VO
	 * @return Redirect
	 */
	@RequestMapping("/deleteManager.do")
	public String deleteManager(@ModelAttribute("userVO") UserVO userVO) {
		try {
			UserVO user = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();
			userVO.setRegisterId(user.getSid());

			userService.deleteManager(userVO);
			authorityResource.reload();
		} catch (NullPointerException e) {
			LOGGER.error("[" + e.getClass() + "] :" + e.getMessage());
		} catch (Exception e) {
			LOGGER.error("[" + e.getClass() + "] :" + e.getMessage());
		}
		return "redirect:/adm/manager.do";
	}

	/**
	 * 사용자 관리 > 관리자 관리 > 수정
	 * @param userVO VO
	 * @return Redirect
	 */
	@RequestMapping("/updateManager.do")
	public String updateManager(@ModelAttribute("userVO") UserVO userVO) {
		try {
			UserVO user = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();
			userVO.setRegisterId(user.getSid());

			userService.updateManager(userVO);
			authorityResource.reload();
		} catch (NullPointerException e) {
			LOGGER.error("[" + e.getClass() + "] :" + e.getMessage());
		} catch (Exception e) {
			LOGGER.error("[" + e.getClass() + "] :" + e.getMessage());
		}
		return "redirect:/adm/manager.do";
	}

	// ↓↓↓↓↓↓↓ 부서지식 관리자 관련 기능 사용안하므로 주석 처리 ↓↓↓↓↓↓↓
	// ↓↓↓↓↓↓↓ 부서지식 관리자 관련 기능 사용안하므로 주석 처리 ↓↓↓↓↓↓↓
	// ↓↓↓↓↓↓↓ 부서지식 관리자 관련 기능 사용안하므로 주석 처리 ↓↓↓↓↓↓↓
	/*@RequestMapping("/requestManagerList.do")
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
		
	}*/

	@ResponseBody
	@RequestMapping("/tempUserImport.do")
	public String tempUserImport() {
		scheduler.userImport();
		return "success";
	}

	@ResponseBody
	@RequestMapping("/tempTopMileageUser.do")
	public String tempTopMileageUser() {
		scheduler.topMileageUser();
		return "success";
	}

	@ResponseBody
	@RequestMapping("/tempTopMileageOrg.do")
	public String tempTopMileageOrg() {
		scheduler.topMileageOrg();
		return "success";
	}
}
