package egovframework.com.wkp.bbs.web;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import egovframework.com.cmm.EgovComException;
import egovframework.com.cmm.service.EgovFileMngService;
import egovframework.com.cmm.service.EgovFileMngUtil;
import egovframework.com.cmm.service.FileVO;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.com.utl.wed.comm.ListWithPageNavigation;
import egovframework.com.wkp.bbs.service.EgovBbsService;
import egovframework.com.wkp.bbs.service.RequestVO;
import egovframework.com.wkp.usr.service.UserVO;

@Controller
@RequestMapping("/req")
public class EgovReqController {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(EgovReqController.class);
		
	@Resource(name="bbsService")
	EgovBbsService bbsService;
	
    @Resource(name = "EgovFileMngService")
    private EgovFileMngService fileMngService;

    @Resource(name = "EgovFileMngUtil")
    private EgovFileMngUtil fileUtil;
	
	@RequestMapping("/requestList.do")
	public String requestList(@ModelAttribute("requestVO") RequestVO requestVO, Model model) { 

		try {
			if(requestVO.getPage() == null) {
				requestVO.setPage(1);
			}
			
			ListWithPageNavigation<RequestVO> requestList = bbsService.selectRequestList(requestVO);
			
            int seqNum = requestList.getPageNavigation().getTotalItemCount() - (requestVO.getPage() - 1) * requestList.getPageNavigation().getItemCountPerPage();
            
			model.addAttribute("requestList", requestList);
            model.addAttribute("seqNum", seqNum);
            
            if(requestVO.getSearchText() != null && !requestVO.getSearchText().equals("")){
            	model.addAttribute("searchText", requestVO.getSearchText());
            }
		} catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}
		
		return "/com/wkp/req/EgovRequestList";
		
	}
	
	@RequestMapping("/requestDetail.do")
	public String noticeDetail(@ModelAttribute("requestVO") RequestVO requestVO, @RequestParam(value = "requestNo", required = false) Long requstNo, Model model) {

		try {
			if(requstNo != null) {
				requestVO.setRequstNo(requstNo);
			}
			
			bbsService.updateRequestInqCnt(requestVO);

			RequestVO requestDetail = bbsService.selectRequestDetail(requestVO);
			
			FileVO fileVO = new FileVO();
			fileVO.setAtchFileNo(requestDetail.getAtchFileNo());
			List<FileVO> result = fileMngService.selectFileInfs(fileVO);
			
			if(requestVO.getPage() != null) {
				requestDetail.setPage(requestVO.getPage());
			}
			
			if(requestVO.getSearchText() != null) {
				requestDetail.setSearchText(requestVO.getSearchText());
			}
			
			model.addAttribute("requestDetail", requestDetail);
			model.addAttribute("fileList", result);
            model.addAttribute("requestPre", bbsService.selectRequestPre(requestVO));
            model.addAttribute("requestNext", bbsService.selectRequestNext(requestVO));
			
		} catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}
		
		return "/com/wkp/req/EgovRequestDetail";
		
	}
	
	@RequestMapping("/insertRequestView.do")
	public String insertRequestView(@ModelAttribute("requestVO") RequestVO requestVO, Model model) {
		return "/com/wkp/req/EgovRequestRegist";
	}
	
	@RequestMapping("/insertRequest.do")
	public String insertRequest(final MultipartHttpServletRequest multiRequest, @ModelAttribute("requestVO") RequestVO requestVO, Model model) {
		
		try {
			UserVO userVO = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();
			requestVO.setRegisterId(userVO.getSid());
			
			List<FileVO> result = new ArrayList<FileVO>();
			long atchFileNo = 0;
			final Map<String, MultipartFile> files = multiRequest.getFileMap();
			if (!files.isEmpty()) {
				result = fileUtil.parseFileInf(files, "REQUST_", 0, "");
				atchFileNo = fileMngService.insertFileInfs(result);
			}
			
			requestVO.setAtchFileNo(atchFileNo);
			bbsService.insertRequest(requestVO);			
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
	public String updateNoticeView(@ModelAttribute("requestVO") RequestVO requestVO, Model model) {
		
		try {
			RequestVO requestDetail = bbsService.selectRequestDetail(requestVO);
			
			FileVO fileVO = new FileVO();
			fileVO.setAtchFileNo(requestDetail.getAtchFileNo());
			List<FileVO> result = fileMngService.selectFileInfs(fileVO);
			
			if(requestVO.getPage() != null) {
				requestDetail.setPage(requestVO.getPage());
			}
			
			if(requestVO.getSearchText() != null) {
				requestDetail.setSearchText(requestVO.getSearchText());
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
			, @ModelAttribute("requestVO") RequestVO requestVO
			, Model model) {
		
		try {
			UserVO userVO = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();
			requestVO.setRegisterId(userVO.getSid());
			
            long atchFileNo = 0;
            List<FileVO> result = new ArrayList<FileVO>();
            final Map<String, MultipartFile> files = multiRequest.getFileMap();
            if (!files.isEmpty()) {
                result = fileUtil.parseFileInf(files, "REQUST_", 0, "");
                atchFileNo = fileMngService.insertFileInfs(result);
            }

            if (atchFileNo != 0) {
            	requestVO.setAtchFileNo(atchFileNo);
            }
			
			bbsService.updateRequest(requestVO);
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
	public String deleteNotice(@ModelAttribute("requestVO") RequestVO requestVO, Model model) {
		
		try {
			bbsService.deleteRequest(requestVO);			
		} catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}
		
		return "redirect:/req/requestList.do";
		
	}
	
	@RequestMapping("/updateRequestAnswer.do")
	public String updateRequestAnswer(@ModelAttribute("requestVO") RequestVO requestVO, Model model) {
		
		try {
			UserVO userVO = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();
			requestVO.setAnswerId(userVO.getSid());
			
			bbsService.updateRequestAnswer(requestVO);			
		} catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}
		
		return "redirect:/req/requestDetail.do?requstNo="+requestVO.getRequstNo();
		
	}

}
