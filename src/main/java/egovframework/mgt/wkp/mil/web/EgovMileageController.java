package egovframework.mgt.wkp.mil.web;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import egovframework.com.utl.wed.comm.ListWithPageNavigation;
import egovframework.com.wkp.kno.service.EgovKnowledgeService;
import egovframework.com.wkp.kno.service.OrgMileageVO;
import egovframework.com.wkp.kno.service.UserMileageVO;

@Controller
@RequestMapping("/adm")
public class EgovMileageController {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(EgovMileageController.class);
	
	@Resource(name="knowledgeService")
	private EgovKnowledgeService knowledgeService;
	
	@RequestMapping("/orgMileageList.do")
	public String orgMileageList(@ModelAttribute() OrgMileageVO orgMileageVO, Model model) {
		try {
			if(orgMileageVO.getPage() == null || orgMileageVO.getPage() == 0) {
				orgMileageVO.setPage(1);
			}
			
			ListWithPageNavigation<OrgMileageVO> orgMileageList = knowledgeService.selectOrgMileageList(orgMileageVO);
			model.addAttribute("orgMileageList", orgMileageList);
			
		} catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}
		
		return "/mgt/wkp/mil/EgovOrgMileageList";
	}
	
	@RequestMapping("/orgMileageDetail.do")
	public String orgMileageDetail(@ModelAttribute() OrgMileageVO orgMileageVO, Model model) {
		try {
			
			if(orgMileageVO.getPage() == null || orgMileageVO.getPage() == 0) {
				orgMileageVO.setPage(1);
			}
			
			ListWithPageNavigation<OrgMileageVO> orgMileageList = knowledgeService.selectOrgMileageDetail(orgMileageVO);
			model.addAttribute("orgMileageList", orgMileageList);
			model.addAttribute("ouCode", orgMileageVO.getOuCode());
		} catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}
		
		return "/mgt/wkp/mil/EgovOrgMileageDetail";
	}
	
	@RequestMapping("/userMileageList.do")
	public String userMileageList(@ModelAttribute() UserMileageVO userMileageVO, Model model) {
		try {
			if(userMileageVO.getPage() == null || userMileageVO.getPage() == 0) {
				userMileageVO.setPage(1);
			}
			
			ListWithPageNavigation<UserMileageVO> userMileageList = knowledgeService.selectUserMileageList(userMileageVO);
			model.addAttribute("userMileageList", userMileageList);
			
		} catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}
		
		return "/mgt/wkp/mil/EgovUserMileageList";
	}
	
	@RequestMapping("/userMileageDetail.do")
	public String userMileageDetail(@ModelAttribute() UserMileageVO userMileageVO, Model model) {
		try {
			if(userMileageVO.getPage() == null || userMileageVO.getPage() == 0) {
				userMileageVO.setPage(1);
			}
			
			ListWithPageNavigation<UserMileageVO> userMileageList = knowledgeService.selectUserMileageDetail(userMileageVO);
			model.addAttribute("userMileageList", userMileageList);
			model.addAttribute("sid", userMileageVO.getSid());
		} catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}
		
		return "/mgt/wkp/mil/EgovUserMileageDetail";
	}

}
