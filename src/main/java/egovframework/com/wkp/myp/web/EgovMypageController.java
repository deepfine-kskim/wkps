package egovframework.com.wkp.myp.web;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import egovframework.com.cmm.EgovComException;
import egovframework.com.cmm.service.EgovFileMngService;
import egovframework.com.cmm.service.EgovFileMngUtil;
import egovframework.com.cmm.service.FileVO;
import egovframework.com.utl.wed.comm.ListWithPageNavigation;
import egovframework.com.utl.wed.enums.LogSubjectType;
import egovframework.com.utl.wed.enums.LogType;
import egovframework.com.wkp.kno.service.KnowledgeContentsVO;
import egovframework.com.wkp.qna.service.ImprovementVO;
import egovframework.mgt.wkp.log.service.EgovLogService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import egovframework.com.wkp.cmm.service.EgovCommonService;
import egovframework.com.wkp.cmm.service.ExcellenceOrgVO;
import egovframework.com.wkp.cmm.service.ExcellenceUserVO;
import egovframework.com.wkp.cmm.service.GroupVO;
import egovframework.com.wkp.kno.service.EgovKnowledgeService;
import egovframework.com.wkp.kno.service.ErrorStatementVO;
import egovframework.com.wkp.kno.service.KnowledgeVO;
import egovframework.com.wkp.kno.service.impl.KnowledgeDAO;
import egovframework.com.wkp.qna.service.AnswerVO;
import egovframework.com.wkp.qna.service.EgovQnaService;
import egovframework.com.wkp.usr.service.EgovOrgService;
import egovframework.com.wkp.usr.service.EgovUserService;
import egovframework.com.wkp.usr.service.OrgVO;
import egovframework.com.wkp.usr.service.UserVO;
import egovframework.rte.fdl.access.service.EgovUserDetailsHelper;

@Controller
@RequestMapping("/myp")
public class EgovMypageController {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(EgovMypageController.class);
	
    @Resource(name = "commonService")
    private EgovCommonService commonService;

	@Resource(name = "logService")
	EgovLogService egovLogService;
	
    @Resource(name = "knowledgeService")
    private EgovKnowledgeService knowledgeService;
    
    @Resource(name="knowledgeDAO")
    private KnowledgeDAO knowledgeDAO;
    
    @Resource(name = "qnaService")
    EgovQnaService qnaService;
    
	@Resource(name = "userService")
	private EgovUserService userService;
    
    @Resource(name = "EgovFileMngService")
    private EgovFileMngService fileMngService;

    @Resource(name = "EgovFileMngUtil")
    private EgovFileMngUtil fileUtil;
    
    @Resource(name = "orgService")
	private EgovOrgService orgService;
	
	@RequestMapping("/mypage.do")
	public String myPage(Model model) {

		try {
			UserVO userVO = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();
			
			GroupVO groupVO = new GroupVO();
			groupVO.setRegisterId(userVO.getSid());
			List<GroupVO> groupList = commonService.selectGroupList(groupVO);
			
			KnowledgeVO knowledgeVO = new KnowledgeVO();
			knowledgeVO.setRegisterId(userVO.getSid());
			List<KnowledgeVO> bookmarkList = knowledgeService.selectBookmarkList(knowledgeVO);
			List<KnowledgeVO> interestsList = knowledgeDAO.selectInterestsList(knowledgeVO);
			int myCnt = knowledgeService.selectKnowledgeListCount(knowledgeVO);
			
			AnswerVO answerVO = new AnswerVO();
			answerVO.setRegisterId(userVO.getSid());
			int myAnswerCnt = qnaService.selectMyAnswerCount(answerVO);
			int myQuestionCnt = qnaService.selectMyQuestionCount(answerVO);
			
			float myMileageScore = commonService.selectMileageScore(userVO).getMileageScore();
			
			UserVO myBg = userService.selectUserDetail(userVO);
			
			FileVO fileVO = new FileVO();
			fileVO.setAtchFileNo(myBg.getAtchFileNo());
			List<FileVO> myBG = fileMngService.selectFileInfs(fileVO);
			
			ErrorStatementVO errorStatementVO = new ErrorStatementVO();
			errorStatementVO.setRegisterId(userVO.getSid());
			int errorCnt = knowledgeService.selectErrorStatementListCount(errorStatementVO);

			egovLogService.insert(LogType.SELECT_LIST, LogSubjectType.MYPAGE, null);

			model.addAttribute("groupList", groupList);
			model.addAttribute("bookmarkList", bookmarkList);
			model.addAttribute("interestsList", interestsList);
			model.addAttribute("myAnswerCnt", myAnswerCnt);
			model.addAttribute("myQuestionCnt", myQuestionCnt);
			model.addAttribute("myMileageScore", myMileageScore);
			model.addAttribute("myBG", myBG);
			model.addAttribute("myCnt", myCnt);
			model.addAttribute("errorCnt", errorCnt);
		} catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}
		
		return "/com/wkp/myp/EgovMyPage";
	}
	
	@RequestMapping("/errorList.do")
	public String errorList(@ModelAttribute("errorStatementVO") ErrorStatementVO errorStatementVO, Model model) {
		
		try {
			UserVO userVO = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();
			errorStatementVO.setRegisterId(userVO.getSid());
			
			if(errorStatementVO.getPage() == null || errorStatementVO.getPage() == 0) {
				errorStatementVO.setPage(1);
			}
			
			ListWithPageNavigation<ErrorStatementVO> errorStatementList = knowledgeService.selectErrorStatementList(errorStatementVO);
			model.addAttribute("errorStatementList", errorStatementList);
		} catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}
		
		return "/com/wkp/myp/EgovMyErrorList";
	}
	
	@RequestMapping("/errorDetail.do")
	public String errorDetail(@ModelAttribute("errorStatementVO") ErrorStatementVO errorStatementVO, Model model) {
		
		try {
			UserVO userVO = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();
			errorStatementVO.setRegisterId(userVO.getSid());
			
			ErrorStatementVO errorStatementDetail = knowledgeService.selectErrorStatementDetail(errorStatementVO);
			model.addAttribute("errorStatementDetail", errorStatementDetail);
			model.addAttribute("errorStatementPre", knowledgeService.selectErrorStatementPre(errorStatementVO));
			model.addAttribute("errorStatementNext", knowledgeService.selectErrorStatementNext(errorStatementVO));
		} catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}
		
		return "/com/wkp/myp/EgovMyErrorDetail";
	}
		
	@RequestMapping("/approvalList.do")
	public String approvalList(@ModelAttribute("knowledgeVO") KnowledgeVO knowledgeVO, Model model) {
		
		try {
			UserVO userVO = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();
			knowledgeVO.setRegisterId(userVO.getSid());
			
			if(knowledgeVO.getPage() == null || knowledgeVO.getPage() == 0) {
				knowledgeVO.setPage(1);
			}
			
			knowledgeVO.setIsMyList("YES");
			
			ListWithPageNavigation<KnowledgeVO> knowledgeList = knowledgeService.selectKnowledgeList(knowledgeVO);
			model.addAttribute("knowledgeList", knowledgeList);
		} catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}
		
		return "/com/wkp/myp/EgovMyApprovalList";
	}
	
	@ResponseBody
	@RequestMapping(value = "/groupListRole.do")
	public int insertGroupCheck(@ModelAttribute("groupVO") GroupVO groupVO, HttpServletRequest request, HttpServletResponse response, ModelMap model) {
		
		int groupCheck = 0;
		System.out.println("groupVO - " + groupVO);

		try {
			groupCheck = commonService.insertGroupCheck(groupVO);
			 
		} catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}
		
		return groupCheck;
	}
		
	@RequestMapping("/insertGroup.do")
	public ModelAndView insertGroup(@ModelAttribute("groupVO") GroupVO groupVO, Model model) {
		
		ModelAndView mav = new ModelAndView("jsonView");
		
		try {
			UserVO userVO = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();
			groupVO.setRegisterId(userVO.getSid());
			
			int groupCheck = commonService.insertGroupCheck(groupVO);
			
			if(groupCheck < 1 ) {
				long groupNo = commonService.insertGroup(groupVO);
				mav.addObject("groupNo", groupNo);
			}
		} catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}
		
		return mav;
	}
	
	@RequestMapping("/deleteGroup.do")
	public String deleteGroup(@ModelAttribute("groupVO") GroupVO groupVO, Model model) {
		
		try {
			UserVO userVO = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();
			groupVO.setRegisterId(userVO.getSid());
			long groupNo = commonService.deleteGroup(groupVO);
		} catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}
		
		return "redirect:/myp/mypage.do";
	}
	
	@RequestMapping("/insertGroupDetailView.do")
	public String insertGroupView(@ModelAttribute("groupVO") GroupVO groupVO, @RequestParam(value="groupNo") long groupNo, Model model) {
		
		try {
			UserVO userVO = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();
			groupVO.setRegisterId(userVO.getSid());
			groupVO.setGroupNo(groupNo);
			
			String groupNm = commonService.selectGroupName(groupNo);
			
			List<GroupVO> groupDetail = commonService.selectGroupDetail(groupVO);
			
			List<ExcellenceOrgVO> excellenceOrgList = commonService.selectExcellenceOrgList(new ExcellenceOrgVO());
            List<ExcellenceUserVO> excellenceUserList = commonService.selectExcellenceUserList(new ExcellenceUserVO());
            
            OrgVO orgVO = new OrgVO();
            orgVO.setOuLevel(2);
            List<OrgVO> topList = orgService.selectOrgList(orgVO);
            
            orgVO.setOuLevel(3);
            List<OrgVO> parentList = orgService.selectOrgList(orgVO);
            
            orgVO.setOuLevel(4);
            List<OrgVO> childList = orgService.selectOrgList(orgVO);
			
            model.addAttribute("excellenceUserList", excellenceUserList);
            model.addAttribute("excellenceOrgList", excellenceOrgList);
            model.addAttribute("topList", topList);
            model.addAttribute("parentList", parentList);
            model.addAttribute("childList", childList);
			model.addAttribute("groupNm", groupNm);
			model.addAttribute("groupNo", groupNo);
			model.addAttribute("groupDetail", groupDetail);
		} catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}
		
		return "/com/wkp/myp/EgovMyGroup";
	}
	
	@RequestMapping("/insertGroupDetail.do")
	public String insertGroupDetail(@ModelAttribute("groupVO") GroupVO groupVO, Model model) {
		
		try {
			UserVO userVO = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();
			groupVO.setRegisterId(userVO.getSid());
			
			int sortOrder = commonService.selectSortOrder(groupVO);
			
			if(sortOrder == -1) {
				groupVO.setSortOrdr(0);
			} else {
				groupVO.setSortOrdr(sortOrder + 1 );
			}
			
			System.out.println("groupVO - " + groupVO);
			int result = commonService.insertGroupDetail(groupVO);	

		} catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}
		
		return "redirect:/myp/insertGroupDetailView.do?groupNo=" + groupVO.getGroupNo();
	}
	
	@RequestMapping("/deleteGroupDetail.do")
	public String deleteGroupDetail(@ModelAttribute("groupVO") GroupVO groupVO, @RequestParam(value="groupNo") long groupNo, Model model) {
		
		try {
			UserVO userVO = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();
			groupVO.setRegisterId(userVO.getSid());
			groupVO.setGroupNo(groupNo);
			System.out.println("groupVO --- " + groupVO);
			
			commonService.deleteGroupDetail(groupVO);			
		} catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}
		
		return "redirect:/myp/insertGroupDetailView.do?groupNo=7";
	}
	
	@RequestMapping("/myBG.do")
	public String myBG(Model model) {
		return "/com/wkp/myp/EgovMyBG";
	}
	
	@RequestMapping("/updateMyBG.do")
	public String updateMyBG(final MultipartHttpServletRequest multiRequest, Model model) {
		
		UserVO userVO = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();
		
		List<FileVO> result = new ArrayList<FileVO>();
		long atchFileNo = 0;
		final Map<String, MultipartFile> files = multiRequest.getFileMap();
		if (!files.isEmpty()) {
			try {
				result = fileUtil.parseFileInf(files, "BG_", 0, "");
			} catch (IOException e) {
	        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
			} catch (EgovComException e) {
	        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
			}
			atchFileNo = fileMngService.insertFileInfs(result);
		}
		
		userVO.setAtchFileNo(atchFileNo);
		commonService.updateMyBG(userVO);
		
		return "redirect:/myp/mypage.do";
	}
	
	@RequestMapping("/deleteMyBG.do")
	public String deleteMyBG(Model model) {
		UserVO userVO = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();
		commonService.deleteMyBG(userVO);		
		return "redirect:/myp/mypage.do";
	}

	@RequestMapping("/deleteBookmark.do")
	public String deleteBookmark(@ModelAttribute KnowledgeVO knowledgeVO) {
		UserVO userVO = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();
		knowledgeVO.setRegisterId(userVO.getSid());
		knowledgeService.deleteBookmark(knowledgeVO);
		return "redirect:/myp/mypage.do";
	}

	@RequestMapping("/modificationList.do")
	public String modificationList(@ModelAttribute("knowledgeVO") KnowledgeVO param, Model model) {
		UserVO userVO = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();
		if (param.getPage() == null || param.getPage() == 0) {
			param.setPage(1);
		}
		param.setOwnerId(userVO.getSid());
		ListWithPageNavigation<KnowledgeVO> listWithPageNavigation = knowledgeService.selectModificationRequestList(param);
		model.addAttribute("resultList", listWithPageNavigation.getList());
		model.addAttribute("pageNavigation", listWithPageNavigation.getPageNavigation());
		return "/com/wkp/myp/EgovMyModificationList";
	}

	@RequestMapping("/modificationDetail.do")
	public String modificationDetail(@ModelAttribute("knowledgeVO") KnowledgeVO param, Model model) {
		UserVO userVO = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();
		param.setOwnerId(userVO.getSid());
		KnowledgeVO result = knowledgeService.selectModificationRequestDetail(param);
		List<KnowledgeContentsVO> contentList = knowledgeService.selectModificationRequestContentList(param);
		model.addAttribute("result", result);
		model.addAttribute("contentList", contentList);
		return "/com/wkp/myp/EgovMyModificationDetail";
	}

	@RequestMapping("/succeedList.do")
	public String succeedList(@ModelAttribute("knowledgeVO") KnowledgeVO param, Model model) {
		UserVO userVO = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();
		if (param.getPage() == null || param.getPage() == 0) {
			param.setPage(1);
		}
		param.setOwnerId(userVO.getSid());
		param.setOuCode(userVO.getOuCode());
		ListWithPageNavigation<KnowledgeVO> listWithPageNavigation = knowledgeService.selectSucceedList(param);
		model.addAttribute("resultList", listWithPageNavigation.getList());
		model.addAttribute("pageNavigation", listWithPageNavigation.getPageNavigation());
		return "/com/wkp/myp/EgovMySucceedList";
	}

	@ResponseBody
	@RequestMapping("/succeedSave.do")
	public KnowledgeVO succeedList(@RequestBody KnowledgeVO param) {
		knowledgeService.updateOwner(param);
		return param;
	}
}
