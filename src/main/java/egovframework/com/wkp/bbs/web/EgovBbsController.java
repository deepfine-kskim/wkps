package egovframework.com.wkp.bbs.web;

import java.util.List;
import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import egovframework.com.cmm.service.EgovFileMngService;
import egovframework.com.cmm.service.EgovFileMngUtil;
import egovframework.com.cmm.service.FileVO;
import egovframework.com.utl.fcc.service.EgovFileUploadUtil;
import egovframework.com.utl.wed.comm.ListWithPageNavigation;
import egovframework.com.utl.wed.enums.FileType;
import egovframework.com.wkp.bbs.service.EgovBbsService;
import egovframework.com.wkp.bbs.service.NoticeVO;

@Controller
@RequestMapping("/bbs")
public class EgovBbsController {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(EgovBbsController.class);
		
	@Resource(name="bbsService")
	EgovBbsService bbsService;
	
    @Resource(name = "EgovFileMngService")
    private EgovFileMngService fileMngService;

    @Resource(name = "EgovFileMngUtil")
    private EgovFileMngUtil fileUtil;
	
	@RequestMapping( "/noticeList.do")
	public String noticeList(@ModelAttribute("noticeVO") NoticeVO noticeVO, Model model) {
		
		try {
			if(noticeVO.getPage() == null) {
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
		
		return "/com/wkp/bbs/EgovNoticeList";
		
	}
	
	@RequestMapping("/noticeDetail.do")
	public String noticeDetail(@ModelAttribute("noticeVO") NoticeVO noticeVO, @RequestParam(value = "noticeNo", required = false) Long noticeNo, Model model) {

		try {
			if(noticeNo != null) {
				noticeVO.setNoticeNo(noticeNo);
			}
			
			bbsService.updateInqCnt(noticeVO);

			NoticeVO noticeDetail = bbsService.selectNoticeDetail(noticeVO);
			
			FileVO fileVO = new FileVO();
			fileVO.setAtchFileNo(noticeDetail.getAtchFileNo());
			List<FileVO> result = fileMngService.selectFileInfs(fileVO);
			
			FileType fileType = null;
	        for (FileVO vo : result) {
	            fileType = EgovFileUploadUtil.getFileType(vo.getFileExtsn());
	        }
			
			if(noticeVO.getPage() != null) {
				noticeDetail.setPage(noticeVO.getPage());
			}
			
			if(noticeVO.getSearchText() != null) {
				noticeDetail.setSearchText(noticeVO.getSearchText());
			}
			
			model.addAttribute("noticeDetail", noticeDetail);
			model.addAttribute("fileList", result);
			model.addAttribute("fileType", fileType);
            model.addAttribute("noticePre", bbsService.selectNoticePre(noticeVO));
            model.addAttribute("noticeNext", bbsService.selectNoticeNext(noticeVO));
			
		} catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}
		
		return "/com/wkp/bbs/EgovNoticeDetail";
		
	}

}
