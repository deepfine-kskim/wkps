package egovframework.mgt.wkp.bbm.web;

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
import egovframework.com.wkp.bbs.service.NoticeVO;
import egovframework.com.wkp.usr.service.UserVO;
import egovframework.com.wkp.qna.service.EgovQnaService;
import egovframework.com.wkp.qna.service.FaqVO;

@Controller
@RequestMapping("/adm")
public class EgovBbsManageController {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(EgovBbsManageController.class);
		
	@Resource(name="bbsService")
	EgovBbsService bbsService;
	
    @Resource(name = "qnaService")
    EgovQnaService qnaService;
	
	@Resource(name="EgovFileMngService")
	private EgovFileMngService fileMngService;	
	 
	@Resource(name="EgovFileMngUtil")
	private EgovFileMngUtil fileUtil;
	
	@RequestMapping("/noticeList.do")
	public String noticeList(@ModelAttribute("noticeVO") NoticeVO noticeVO, Model model) {
		
		try {

			if(noticeVO.getPage() == null || noticeVO.getPage() == 0) {
				noticeVO.setPage(1);
			}
			
			ListWithPageNavigation<NoticeVO> noticeList = bbsService.selectNoticeList(noticeVO);
            int seqNum = noticeList.getPageNavigation().getTotalItemCount() - (noticeVO.getPage() - 1) * noticeList.getPageNavigation().getItemCountPerPage();
			
            model.addAttribute("noticeList", noticeList);
            model.addAttribute("seqNum", seqNum); 
			
            if(noticeVO.getSearchText() != null && !noticeVO.getSearchText().equals("")){
            	model.addAttribute("searchText", noticeVO.getSearchText());
            }
			
		} catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}
		
		return "/mgt/wkp/bbm/EgovNoticeList";
	}
	
	@RequestMapping("/noticeDetail.do")
	public String noticeDetail(@ModelAttribute("noticeVO") NoticeVO noticeVO, Model model) {
		
		try {
			NoticeVO noticeDetail = bbsService.selectNoticeDetail(noticeVO);
			
			FileVO fileVO = new FileVO();
			fileVO.setAtchFileNo(noticeDetail.getAtchFileNo());
			List<FileVO> result = fileMngService.selectFileInfs(fileVO);
			
			if(noticeVO.getPage() != null) {
				noticeDetail.setPage(noticeVO.getPage());
			}
			
			if(noticeVO.getSearchText() != null) {
				noticeDetail.setSearchText(noticeVO.getSearchText());
			}
			
			model.addAttribute("noticeDetail", noticeDetail);
			model.addAttribute("fileList", result);
			
		} catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}
		
		return "/mgt/wkp/bbm/EgovNoticeDetail";
	}
	
	@RequestMapping("/insertNoticeView.do")
	public String insertNoticeView(Model model) {		
		return "/mgt/wkp/bbm/EgovNoticeRegist";
	}
	
	@RequestMapping("/insertNotice.do")
	public String insertNotice(final MultipartHttpServletRequest multiRequest, @ModelAttribute("noticeVO") NoticeVO noticeVO, Model model) {
		
		try {
			UserVO userVO = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();
			noticeVO.setRegisterId(userVO.getSid());
			
			List<FileVO> result = new ArrayList<FileVO>();
			long atchFileNo = 0;
			final Map<String, MultipartFile> files = multiRequest.getFileMap();
			if (!files.isEmpty()) {
				result = fileUtil.parseFileInf(files, "NOTICE_", 0, "");
				atchFileNo = fileMngService.insertFileInfs(result);
			}
			
			noticeVO.setAtchFileNo(atchFileNo);
			bbsService.insertNotice(noticeVO);
			
		} catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		} catch (IOException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		} catch (EgovComException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}
		
		return "redirect:/adm/noticeList.do";
	}
	
	@RequestMapping("/updateNoticeView.do")
	public String updateNoticeView(@ModelAttribute("noticeVO") NoticeVO noticeVO
            , @RequestParam(value = "noticeNo") Long noticeNo
			, Model model) {
		
		try {
			noticeVO.setNoticeNo(noticeNo);
			NoticeVO noticeDetail = bbsService.selectNoticeDetail(noticeVO);
			
			FileVO fileVO = new FileVO();
			fileVO.setAtchFileNo(noticeDetail.getAtchFileNo());
			List<FileVO> result = fileMngService.selectFileInfs(fileVO);
			
			if(noticeVO.getPage() != null) {
				noticeDetail.setPage(noticeVO.getPage());
			}
			
			if(noticeVO.getSearchText() != null) {
				noticeDetail.setSearchText(noticeVO.getSearchText());
			}
			
			model.addAttribute("noticeDetail", noticeDetail);
			model.addAttribute("fileList", result);
		} catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}
		
		return "/mgt/wkp/bbm/EgovNoticeUpdate";
	}
	
	@RequestMapping("/updateNotice.do")
	public String updateNotice(final MultipartHttpServletRequest multiRequest, @ModelAttribute("noticeVO") NoticeVO noticeVO, Model model) {
		try {
			UserVO userVO = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();
			noticeVO.setRegisterId(userVO.getSid());
			
			List<FileVO> result = new ArrayList<FileVO>();
			long atchFileNo = 0;
			final Map<String, MultipartFile> files = multiRequest.getFileMap();
			if (!files.isEmpty()) {
				result = fileUtil.parseFileInf(files, "NOTICE_", 0, "");
				atchFileNo = fileMngService.insertFileInfs(result);
			}
			
			noticeVO.setAtchFileNo(atchFileNo);
			bbsService.updateNotice(noticeVO);
		} catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		} catch (IOException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		} catch (EgovComException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}
		
		return "redirect:/adm/noticeList.do";
	}
	
	@RequestMapping("/deleteNotice.do")
	public String deleteNotice(@ModelAttribute("noticeVO") NoticeVO noticeVO
            , @RequestParam(value = "noticeNo") Long noticeNo
			, Model model) {
		
		try {
			noticeVO.setNoticeNo(noticeNo);
			bbsService.deleteNotice(noticeVO);			
		} catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}
		
		return "redirect:/adm/noticeList.do";
	}
	
	@RequestMapping("/faqList.do")
	public String faqList(@ModelAttribute("faqVO") FaqVO faqVO, Model model) {
		
		try {
			if(faqVO.getPage() == null || faqVO.getPage() == 0) {
				faqVO.setPage(1);
			}
			
			if(faqVO.getFaqType() == null) {
				faqVO.setFaqType("KNOWLEDGE");
			}
			
			ListWithPageNavigation<FaqVO> faqList = qnaService.selectFaqList(faqVO);
            int seqNum = faqList.getPageNavigation().getTotalItemCount() - (faqVO.getPage() - 1) * faqList.getPageNavigation().getItemCountPerPage();
            
			model.addAttribute("faqList", faqList);
            model.addAttribute("seqNum", seqNum);
            model.addAttribute("faqType", faqVO.getFaqType());
            
            if(faqVO.getSearchText() != null && !faqVO.getSearchText().equals("")){
            	model.addAttribute("searchText", faqVO.getSearchText());
            }
		} catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}
		
		return "/mgt/wkp/bbm/EgovFaqList";
		
	}
	
	@RequestMapping("/faqDetail.do")
	public String faqDetail(@ModelAttribute("faqVO") FaqVO faqVO, Model model) {
		
		try {
			FaqVO faqDetail = qnaService.selectFaqDetail(faqVO);
			
			FileVO fileVO = new FileVO();
			fileVO.setAtchFileNo(faqDetail.getAtchFileNo());
			List<FileVO> result = fileMngService.selectFileInfs(fileVO);
			
			if(faqVO.getPage() != null) {
				faqDetail.setPage(faqVO.getPage());
			}
			
			if(faqVO.getSearchText() != null) {
				faqDetail.setSearchText(faqVO.getSearchText());
			}
			
			model.addAttribute("faqDetail", faqDetail);
			model.addAttribute("fileList", result);
		} catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}
		
		return "/mgt/wkp/bbm/EgovFaqDetail";
	}
	
	@RequestMapping("/insertFaqView.do")
	public String insertFaqView(@ModelAttribute("faqVO") FaqVO faqVO, Model model) {
		return "/mgt/wkp/bbm/EgovFaqRegist";
	}
	
	@RequestMapping("/insertFaq.do")
	public String insertFaq(final MultipartHttpServletRequest multiRequest, @ModelAttribute("faqVO") FaqVO faqVO, Model model) {
		
		try {			
			UserVO userVO = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();
			faqVO.setRegisterId(userVO.getSid());
			
			List<FileVO> result = new ArrayList<FileVO>();
			long atchFileNo = 0;
			final Map<String, MultipartFile> files = multiRequest.getFileMap();
			if (!files.isEmpty()) {
				result = fileUtil.parseFileInf(files, "FAQ_", 0, "");
				atchFileNo = fileMngService.insertFileInfs(result);
			}
			
			faqVO.setAtchFileNo(atchFileNo);
			qnaService.insertFaq(faqVO);
		} catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		} catch (IOException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		} catch (EgovComException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}
		
		return "redirect:/adm/faqList.do";
	}
	
	@RequestMapping("/updateFaqView.do")
	public String updateFaqView(@ModelAttribute("faqVO") FaqVO faqVO
            , @RequestParam(value = "faqNo") Long faqNo
			, Model model) {
		
		try {			
			faqVO.setFaqNo(faqNo);
			FaqVO faqDetail = qnaService.selectFaqDetail(faqVO);
			
			FileVO fileVO = new FileVO();
			fileVO.setAtchFileNo(faqDetail.getAtchFileNo());
			List<FileVO> result = fileMngService.selectFileInfs(fileVO);
			
			if(faqVO.getPage() != null) {
				faqDetail.setPage(faqVO.getPage());
			}
			
			if(faqVO.getSearchText() != null) {
				faqDetail.setSearchText(faqVO.getSearchText());
			}
			
			model.addAttribute("faqDetail", faqDetail);
			model.addAttribute("fileList", result);
		} catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}
		
		return "/mgt/wkp/bbm/EgovFaqUpdate";
	}
	
	@RequestMapping("/updateFaq.do")
	public String updateFaq(final MultipartHttpServletRequest multiRequest, @ModelAttribute("faqVO") FaqVO faqVO, Model model) {
		
		try {
			UserVO userVO = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();
			faqVO.setRegisterId(userVO.getSid());
			
			List<FileVO> result = new ArrayList<FileVO>();
			long atchFileNo = 0;
			final Map<String, MultipartFile> files = multiRequest.getFileMap();
			if (!files.isEmpty()) {
				result = fileUtil.parseFileInf(files, "FAQ_", 0, "");
				atchFileNo = fileMngService.insertFileInfs(result);
			}
			
			faqVO.setAtchFileNo(atchFileNo);
			qnaService.updateFaq(faqVO);
		} catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		} catch (IOException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		} catch (EgovComException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}
		
		return "redirect:/adm/faqList.do";
	}
	
	@RequestMapping("/deleteFaq.do")
	public String deleteFaq(@ModelAttribute("faqVO") FaqVO faqVO
            , @RequestParam(value = "faqNo") Long faqNo
			, Model model) {
		
		try {
			faqVO.setFaqNo(faqNo);
			qnaService.deleteFaq(faqVO);			
		} catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}
		
		return "redirect:/adm/faqList.do";
	}

}
