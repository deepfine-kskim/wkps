package egovframework.com.wkp.req.web;

import egovframework.com.cmm.EgovComException;
import egovframework.com.cmm.service.EgovFileMngService;
import egovframework.com.cmm.service.EgovFileMngUtil;
import egovframework.com.cmm.service.FileVO;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.com.utl.wed.comm.ListWithPageNavigation;
import egovframework.com.wkp.kno.service.EgovKnowledgeService;
import egovframework.com.wkp.kno.service.KnowledgeVO;
import egovframework.com.wkp.req.service.ReqService;
import egovframework.com.wkp.req.service.ReqVO;
import egovframework.com.wkp.srv.service.SurveyDTO;
import egovframework.com.wkp.usr.service.UserVO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.annotation.Resource;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/req")
public class ReqController {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(ReqController.class);
		
	@Resource(name="reqService")
	ReqService reqService;
	
    @Resource(name = "EgovFileMngService")
    private EgovFileMngService fileMngService;

    @Resource(name = "EgovFileMngUtil")
    private EgovFileMngUtil fileUtil;

	@Resource(name = "knowledgeService")
	private EgovKnowledgeService knowledgeService;
	
	@RequestMapping("/requestList.do")
	public String requestList(@ModelAttribute("reqVO") ReqVO reqVO, Model model) {

		try {
			if(reqVO.getPage() == null) {
				reqVO.setPage(1);
			}
			
			ListWithPageNavigation<ReqVO> requestList = reqService.selectRequestList(reqVO);
			
            int seqNum = requestList.getPageNavigation().getTotalItemCount() - (reqVO.getPage() - 1) * requestList.getPageNavigation().getItemCountPerPage();
            
			model.addAttribute("requestList", requestList);
            model.addAttribute("seqNum", seqNum);
            
            if(reqVO.getSearchText() != null && !reqVO.getSearchText().equals("")){
            	model.addAttribute("searchText", reqVO.getSearchText());
            }
		} catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}
		
		return "/com/wkp/req/EgovRequestList";
		
	}
	
	@RequestMapping("/requestDetail.do")
	public String noticeDetail(@ModelAttribute("reqVO") ReqVO reqVO, @RequestParam(value = "requestNo", required = false) Long requstNo, Model model) {

		try {
			if(requstNo != null) {
				reqVO.setRequstNo(requstNo);
			}
			
			reqService.updateRequestInqCnt(reqVO);

			ReqVO requestDetail = reqService.selectRequestDetail(reqVO);
			
			FileVO fileVO = new FileVO();
			fileVO.setAtchFileNo(requestDetail.getAtchFileNo());
			List<FileVO> result = fileMngService.selectFileInfs(fileVO);
			
			if(reqVO.getPage() != null) {
				requestDetail.setPage(reqVO.getPage());
			}
			
			if(reqVO.getSearchText() != null) {
				requestDetail.setSearchText(reqVO.getSearchText());
			}

			List<ReqVO> answerList = reqService.selectAnswerList(reqVO);

			boolean isSelection = answerList.stream().anyMatch(answer -> "Y".equals(answer.getSlctnYn()));

			model.addAttribute("requestDetail", requestDetail);
			model.addAttribute("fileList", result);
            model.addAttribute("requestPre", reqService.selectRequestPre(reqVO));
            model.addAttribute("requestNext", reqService.selectRequestNext(reqVO));
            model.addAttribute("answerList", answerList);
            model.addAttribute("isSelection", isSelection);

		} catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}
		
		return "/com/wkp/req/EgovRequestDetail";
		
	}
	
	@RequestMapping("/insertRequestView.do")
	public String insertRequestView(@ModelAttribute("reqVO") ReqVO reqVO, Model model) {
		return "/com/wkp/req/EgovRequestRegist";
	}
	
	@RequestMapping("/insertRequest.do")
	public String insertRequest(final MultipartHttpServletRequest multiRequest, @ModelAttribute("reqVO") ReqVO reqVO, Model model) {
		
		try {
			UserVO userVO = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();
			reqVO.setRegisterId(userVO.getSid());

			List<FileVO> result = new ArrayList<FileVO>();
			long atchFileNo = 0;
			final Map<String, MultipartFile> files = multiRequest.getFileMap();
			if (!files.isEmpty()) {
				result = fileUtil.parseFileInf(files, "REQUST_", 0, "");
				atchFileNo = fileMngService.insertFileInfs(result);
			}

			reqVO.setAtchFileNo(atchFileNo);
			long requestKnowlgNo = reqService.insertRequest(reqVO);

			/* 지식 요청 질문 2점*/
			KnowledgeVO knowledgeViewVO = new KnowledgeVO();
			knowledgeViewVO.setMileageType("REQUEST");
			knowledgeViewVO.setRequestNo(requestKnowlgNo);
			knowledgeViewVO.setMileageScore(2.0f);
			knowledgeViewVO.setOuCode(userVO.getOuCode());
			knowledgeViewVO.setRegisterId(userVO.getSid());

			reqService.insertUserRequestMileage(knowledgeViewVO);
			reqService.insertOrgRequestMileage(knowledgeViewVO);
		} catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		} catch (IOException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		} catch (EgovComException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}
		
		return "redirect:/req/requestList.do";
		
	}
	
	@RequestMapping("/updateRequestView.do")
	public String updateNoticeView(@ModelAttribute("reqVO") ReqVO reqVO, Model model) {
		
		try {
			ReqVO requestDetail = reqService.selectRequestDetail(reqVO);
			
			FileVO fileVO = new FileVO();
			fileVO.setAtchFileNo(requestDetail.getAtchFileNo());
			List<FileVO> result = fileMngService.selectFileInfs(fileVO);
			
			if(reqVO.getPage() != null) {
				requestDetail.setPage(reqVO.getPage());
			}
			
			if(reqVO.getSearchText() != null) {
				requestDetail.setSearchText(reqVO.getSearchText());
			}
			
			model.addAttribute("requestDetail", requestDetail);
			model.addAttribute("fileList", result);
		} catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}
		
		return "/com/wkp/req/EgovRequestUpdate";
		
	}
	
	@RequestMapping("/updateRequest.do")
	public String updateNotice(final MultipartHttpServletRequest multiRequest
			, @ModelAttribute("reqVO") ReqVO reqVO
			, Model model) {
		
		try {
			UserVO userVO = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();
			reqVO.setRegisterId(userVO.getSid());
			
            long atchFileNo = 0;
            List<FileVO> result = new ArrayList<FileVO>();
            final Map<String, MultipartFile> files = multiRequest.getFileMap();
            if (!files.isEmpty()) {
                result = fileUtil.parseFileInf(files, "REQUST_", 0, "");
                atchFileNo = fileMngService.insertFileInfs(result);
            }

            if (atchFileNo != 0) {
            	reqVO.setAtchFileNo(atchFileNo);
            }
			
			reqService.updateRequest(reqVO);
		} catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}  catch (IOException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		} catch (EgovComException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}
		
		return "redirect:/req/requestList.do";
		
	}
	
	@RequestMapping("/deleteRequest.do")
	public String deleteNotice(@ModelAttribute("reqVO") ReqVO reqVO, Model model) {
		
		try {
            KnowledgeVO knowledgeViewVO = new KnowledgeVO();
			reqService.deleteRequest(reqVO);
            knowledgeViewVO.setRequestNo(reqVO.getRequstNo());
            reqService.deleteUserRequestMileage(knowledgeViewVO);
            reqService.deleteOrgRequestMileage(knowledgeViewVO);
		} catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}
		
		return "redirect:/req/requestList.do";
		
	}

	@ResponseBody
	@RequestMapping(value = "/updateRequestAnswer.do")
	public ReqVO updateRequestAnswer(@RequestBody ReqVO reqVO) {

		try {
			UserVO userVO = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();
			reqVO.setAnswerId(userVO.getSid());

			reqService.updateRequestAnswer(reqVO);
		} catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}

		return reqVO;

	}

	@RequestMapping("/insertRequestAnswer.do")
	public String insertRequestAnswer(@ModelAttribute("reqVO") ReqVO reqVO, Model model) {

		try {
			UserVO userVO = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();
			reqVO.setRegisterId(userVO.getSid());
			reqService.insertRequestAnswer(reqVO);

			/* 답변작성 5점*/
			KnowledgeVO knowledgeViewVO = new KnowledgeVO();
			knowledgeViewVO.setMileageType("REG");
			knowledgeViewVO.setRequestNo(reqVO.getRequstNo());
			knowledgeViewVO.setMileageScore(5.0f);
			knowledgeViewVO.setOuCode(userVO.getOuCode());
			knowledgeViewVO.setRegisterId(reqVO.getRegisterId());

			reqService.insertUserRequestMileage(knowledgeViewVO);
			reqService.insertOrgRequestMileage(knowledgeViewVO);
		} catch (NullPointerException e) {
			LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}

		return "redirect:/req/requestDetail.do?requstNo="+reqVO.getRequstNo();

	}

	@ResponseBody
	@RequestMapping(value = "/updateAnswerSelection.do")
	public ReqVO updateAnswerSelection(@RequestBody ReqVO reqVO) {
		UserVO user = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();
		reqVO.setUpdaterId(user.getSid());
		reqService.updateAnswerSelection(reqVO);

		/* 답변채택 1점*/
		KnowledgeVO knowledgeViewVO = new KnowledgeVO();
		knowledgeViewVO.setMileageType("CHOOSE");
		knowledgeViewVO.setRequestNo(reqVO.getRequstNo());
		knowledgeViewVO.setMileageScore(1.0f);
		knowledgeViewVO.setOuCode(user.getOuCode());
		knowledgeViewVO.setRegisterId(reqVO.getRegisterId());

		reqService.insertUserRequestMileage(knowledgeViewVO);
		reqService.insertOrgRequestMileage(knowledgeViewVO);
		return reqVO;
	}

}
