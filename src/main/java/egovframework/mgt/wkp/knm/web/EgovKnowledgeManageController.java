package egovframework.mgt.wkp.knm.web;

import egovframework.com.cmm.service.EgovFileMngService;
import egovframework.com.cmm.service.FileVO;
import egovframework.com.cmm.service.MessengerService;
import egovframework.com.cmm.service.MessengerVO;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.com.utl.wed.comm.ListWithPageNavigation;
import egovframework.com.wkp.cmm.service.EgovCommonService;
import egovframework.com.wkp.cmm.service.PersonalizeVO;
import egovframework.com.wkp.cmm.service.RecommendVO;
import egovframework.com.wkp.kno.service.*;
import egovframework.com.wkp.usr.service.EgovOrgService;
import egovframework.com.wkp.usr.service.OrgVO;
import egovframework.com.wkp.usr.service.UserVO;
import egovframework.mgt.wkp.log.service.LogVO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.annotation.Resource;
import java.util.List;

@Controller
@RequestMapping("/adm")
public class EgovKnowledgeManageController {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(EgovKnowledgeManageController.class);
	
	@Resource(name="knowledgeService")
	private EgovKnowledgeService knowledgeService;
	
	@Resource(name="EgovFileMngService")
	private EgovFileMngService fileMngService;
	
    @Resource(name="commonService")
    private EgovCommonService commonService;
    
	@Resource(name = "orgService")
	private EgovOrgService orgService;

	@Resource(name = "messengerService")
	private MessengerService messengerService;
	
	@RequestMapping("/approvalList.do")
	public String approvalList(@ModelAttribute(name="knowledgeVO") KnowledgeVO param, Model model) {
		UserVO user = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();
		if (param.getPage() == null || param.getPage() == 0) {
			param.setPage(1);
		}
		param.setOuCode(user.getOuCode());
		ListWithPageNavigation<KnowledgeVO> listWithPageNavigation = knowledgeService.selectApprovalList(param);
		model.addAttribute("resultList", listWithPageNavigation.getList());
		model.addAttribute("pageNavigation", listWithPageNavigation.getPageNavigation());
		return "/mgt/wkp/knm/EgovApprovalList";
	}
	
	@RequestMapping("/approvalDetail.do")
	public String approvalDetail(@ModelAttribute("knowledgeVO") KnowledgeVO knowledgeVO, Model model) {
		// 지식 상세 정보
		KnowledgeVO knowledgeDetail = knowledgeService.selectKnowledgeDetail(knowledgeVO);

		// 지식 내용
		List<KnowledgeContentsVO> knowledgeContentsList = knowledgeService.selectKnowledgeContentsList(knowledgeDetail);

		// 첨부파일
		FileVO fileVO = new FileVO();
		fileVO.setAtchFileNo(knowledgeDetail.getAtchFileNo());
		List<FileVO> fileList = fileMngService.selectFileInfs(fileVO);

		// 관련지식
		List<String> relateKnowledgeList = knowledgeService.selectRelateKnowledgeList(knowledgeDetail.getRelateKnowlgNo());
		List<RelateKnowlgVO> relateKnowlgVO = knowledgeService.selectRelateKnowledgeListDelChk(knowledgeDetail.getRelateKnowlgNo());

		model.addAttribute("knowledgeDetail", knowledgeDetail);
		model.addAttribute("knowledgeContentsList", knowledgeContentsList);
		model.addAttribute("fileList", fileList);
		model.addAttribute("relateKnowledgeList", relateKnowledgeList);
		model.addAttribute("relateKnowlgVO", relateKnowlgVO);

		return "/mgt/wkp/knm/EgovApprovalDetail";
	}
	
	@RequestMapping("/updateApproval.do")
	public String updateApproval(@ModelAttribute("knowledgeVO") KnowledgeVO knowledgeVO, Model model) {
		
		try {
            UserVO user = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();
            knowledgeVO.setApproverId(user.getSid());
			knowledgeService.updateApproval(knowledgeVO);
		} catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}
		
		return "redirect:/adm/approvalList.do";
		
	}
	
	@RequestMapping("/recommendList.do")
	public String recommendList(@ModelAttribute(name="recommendVO") RecommendVO recommendVO, Model model) {

		try {
			List<RecommendVO> recommendList = commonService.selectRecommendList();
			model.addAttribute("recommendList", recommendList);
		} catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}
		
		return "/mgt/wkp/knm/EgovRecommendList";
		
	}
		
	@RequestMapping("/insertRecommend.do")
	public String insertRecommend(@ModelAttribute(name="recommendVO") RecommendVO recommendVO, RedirectAttributes redirect) {

		try {
            UserVO user = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();
            recommendVO.setRegisterId(user.getSid());
            
            int result = commonService.insertRecommend(recommendVO);
            if(result <= 0) {
            	redirect.addFlashAttribute("errMsg", "등록할 수 없습니다.");
            }
		} catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}
		
		return "redirect:/adm/recommendList.do";
		
	}
	
	@RequestMapping("/deleteRecommend.do")
	public String deleteRecommend(@ModelAttribute(name="recommendVO") RecommendVO recommendVO) {

		try {
            UserVO user = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();
            recommendVO.setRegisterId(user.getSid());
            
            commonService.deleteRecommend(recommendVO);
		} catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}
		
		return "redirect:/adm/recommendList.do";
		
	}
	
	@RequestMapping("/personalizeList.do")
	public String personalizeList(@ModelAttribute(name="personalizeVO") PersonalizeVO personalizeVO, Model model) {

		try {
			OrgVO orgVO = new OrgVO();
			orgVO.setOuLevel(2);
			List<OrgVO> orgList = orgService.selectOrgList(orgVO);
			
			if(personalizeVO.getOuCode() != null) {
				model.addAttribute("ouCode", personalizeVO.getOuCode());
			} else {
				personalizeVO.setOuCode(orgList.get(0).getOuCode());
				model.addAttribute("ouCode", orgList.get(0).getOuCode());
			}
			
			List<PersonalizeVO> personalizeList = commonService.selectPersonalizeList(personalizeVO);
			model.addAttribute("orgList", orgList);
			model.addAttribute("personalizeList", personalizeList);
		} catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}
		
		return "/mgt/wkp/knm/EgovPersonalizeList";
		
	}
	
	@RequestMapping("/insertPersonalize.do")
	public String insertPersonalize(@ModelAttribute(name="personalizeVO") PersonalizeVO personalizeVO, RedirectAttributes redirect) {

		try {
            UserVO user = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();
            personalizeVO.setRegisterId(user.getSid());
            
            int result = commonService.insertPersonalize(personalizeVO);
            if(result <= 0) {
            	redirect.addFlashAttribute("errMsg", "등록할 수 없습니다.");
            }
		} catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}
		
		return "redirect:/adm/personalizeList.do";
		
	}
	
	@RequestMapping("/deletePersonalize.do")
	public String deletePersonalize(@ModelAttribute(name="personalizeVO") PersonalizeVO personalizeVO) {

		try {
            UserVO user = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();
            personalizeVO.setRegisterId(user.getSid());
            
            commonService.deletePersonalize(personalizeVO);
		} catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}
		
		return "redirect:/adm/personalizeList.do";
		
	}
	
	@RequestMapping("/errorList.do")
	public String errorList(@ModelAttribute(name="errorStatementVO") ErrorStatementVO errorStatementVO, Model model) {

		try {			
			if(errorStatementVO.getPage() == null) {
				errorStatementVO.setPage(1);
			}
			
			ListWithPageNavigation<ErrorStatementVO> errorStatementList = knowledgeService.selectErrorStatementList(errorStatementVO);
			model.addAttribute("errorStatementList", errorStatementList);
		} catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}
		
		return "/mgt/wkp/knm/EgovErrorList";
		
	}
	
	@RequestMapping("/errorDetail.do")
	public String errorDetail(@ModelAttribute(name="errorStatementVO") ErrorStatementVO errorStatementVO,  Model model) {

		try {
			ErrorStatementVO errorStatementDetail = knowledgeService.selectErrorStatementDetail(errorStatementVO);
			model.addAttribute("errorStatementDetail", errorStatementDetail);
		} catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}
		
		return "/mgt/wkp/knm/EgovErrorDetail";
		
	}
	
	@RequestMapping("/updateErrorStatementAnswer.do")
	public String updateErrorStatementAnswer(@ModelAttribute(name="errorStatementVO") ErrorStatementVO errorStatementVO) {

		try {
            UserVO user = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();
            errorStatementVO.setAnswerId(user.getSid());
            
			knowledgeService.updateErrorStatementAnswer(errorStatementVO);
		} catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}
		
		return "redirect:/adm/errorDetail.do?statmntNo="+errorStatementVO.getStatmntNo();
		
	}
	
	@RequestMapping("/knowledgeMapList.do")
	public String knowledgeMapList(@ModelAttribute("knowledgeMapVO") KnowledgeMapVO knowledgeMapVO,  Model model){
		
		try {
			if(knowledgeMapVO.getKnowlgMapType() != null) {
				model.addAttribute("knowlgMapType", knowledgeMapVO.getKnowlgMapType());
			} else {
				knowledgeMapVO.setKnowlgMapType("REPORT");
				model.addAttribute("knowlgMapType", "REPORT");
			}
			
			List<KnowledgeMapVO> knowledgeMapList = knowledgeService.selectKnowledgeMapList(knowledgeMapVO);
			List<LogVO> logList = knowledgeService.selectKnowledgeMapLogList();
			model.addAttribute("knowledgeMapList", knowledgeMapList);
			model.addAttribute("logList", logList);
		} catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}
		
		return "/mgt/wkp/knm/EgovKnowledgeMap";
		
	}
	
	@RequestMapping("/knowledgeMap.do")
	public ModelAndView knowledgeMap(@ModelAttribute("knowledgeMapVO") KnowledgeMapVO knowledgeMapVO){
		
		ModelAndView mav = new ModelAndView("jsonView");
		
		try {
			List<KnowledgeMapVO> knowledgeMapList = knowledgeService.selectKnowledgeMapList(knowledgeMapVO);
			mav.addObject("knowledgeMapList", knowledgeMapList);
		} catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}
		
		return mav;
		
	}
	
	@RequestMapping("/insertKnowledgeMap.do")
	public String insertKnowledgeMap(@ModelAttribute("knowledgeMapVO") KnowledgeMapVO knowledgeMapVO, RedirectAttributes redirect){
		
		try {
            UserVO user = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();
            knowledgeMapVO.setRegisterId(user.getSid());
            
			int result = knowledgeService.insertKnowledgeMap(knowledgeMapVO);
            if(result <= 0) {
            	redirect.addFlashAttribute("errMsg", "등록할 수 없습니다.");
            }
		} catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}
		
		return "redirect:/adm/knowledgeMapList.do";
		
	}
	
	@RequestMapping("/updateKnowledgeMap.do")
	public String updateKnowledgeMap(@ModelAttribute("knowledgeMapVO") KnowledgeMapVO knowledgeMapVO,  Model model){
		
		try {
            UserVO user = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();
            
            for(KnowledgeMapVO vo:knowledgeMapVO.getKnowledgeMapList()) {
            	vo.setRegisterId(user.getSid());
            	knowledgeService.updateKnowledgeMap(vo);
            }
		} catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}
		
		return "redirect:/adm/knowledgeMapList.do";
		
	}

	/**
	 * 지식맵 삭제
	 */
	@ResponseBody
	@RequestMapping("/deleteKnowledgeMap.do")
	public KnowledgeMapVO deleteKnowledgeMap(@RequestBody KnowledgeMapVO knowledgeMapVO) {
		UserVO user = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();
        knowledgeMapVO.setRegisterId(user.getSid());
		knowledgeService.deleteKnowledgeMap(knowledgeMapVO);
		return knowledgeMapVO;
	}

	@RequestMapping("/succeedList.do")
	public String succeedList(@ModelAttribute("knowledgeVO") KnowledgeVO param, Model model) {
		if (param.getPage() == null || param.getPage() == 0) {
			param.setPage(1);
		}
		ListWithPageNavigation<KnowledgeVO> listWithPageNavigation = knowledgeService.selectSucceedList(param);
		model.addAttribute("resultList", listWithPageNavigation.getList());
		model.addAttribute("pageNavigation", listWithPageNavigation.getPageNavigation());
		return "/mgt/wkp/knm/EgovSucceedList";
	}

	@ResponseBody
	@RequestMapping("/succeedSave.do")
	public KnowledgeVO succeedList(@RequestBody KnowledgeVO param) {
		knowledgeService.updateOwner(param);
		return param;
	}

	@RequestMapping("/modificationList.do")
	public String modificationList(@ModelAttribute("knowledgeVO") KnowledgeVO param, Model model) {
		ListWithPageNavigation<KnowledgeVO> listWithPageNavigation = knowledgeService.selectModificationRequestHoldList(param);
		model.addAttribute("resultList", listWithPageNavigation.getList());
		model.addAttribute("pageNavigation", listWithPageNavigation.getPageNavigation());
		return "/mgt/wkp/knm/EgovModificationList";
	}

	@ResponseBody
	@RequestMapping("/resendNotification.do")
	public List<KnowledgeVO> resendNotification(@RequestBody List<KnowledgeVO> param) {
		UserVO userVO = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();

		param.forEach(item -> {
			MessengerVO messengerVO = new MessengerVO();
			messengerVO.setSndUser(userVO.getDisplayName());
			messengerVO.setRecvId(item.getOwnerId());
			messengerVO.setDocTitle("[도정지식포털 알림]");
			KnowledgeVO knowledgeDetail = knowledgeService.selectKnowledgeDetail(item);
			if (knowledgeDetail.getOuCode().equals(knowledgeDetail.getOwnerOuCode())) {
				messengerVO.setDocDesc("[도정지식포털] 지식 수정요청이 접수되었습니다");
				messengerVO.setDocUrl("http://105.0.1.229/magicsso/connect.jsp?returnUrl=http://105.0.1.229/myp/modificationDetail.do?requestNo=" + item.getRequestNo());
			} else {
				messengerVO.setDocDesc("[도정지식포털] 지식 승계 처리가 필요한 지식이 존재합니다");
				messengerVO.setDocUrl("http://105.0.1.229/magicsso/connect.jsp?returnUrl=http://105.0.1.229/myp/succeedList.do");
			}
			messengerService.insert(messengerVO);
		});

		return param;
	}
}
