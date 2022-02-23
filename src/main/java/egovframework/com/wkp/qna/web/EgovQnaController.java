package egovframework.com.wkp.qna.web;

import egovframework.com.cmm.EgovComException;
import egovframework.com.cmm.service.EgovFileMngService;
import egovframework.com.cmm.service.EgovFileMngUtil;
import egovframework.com.cmm.service.FileVO;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.com.utl.wed.comm.ListWithPageNavigation;
import egovframework.com.utl.wed.enums.QuestionType;
import egovframework.com.utl.wed.enums.YnEnum;
import egovframework.com.wkp.qna.service.FaqVO;
import egovframework.com.wkp.qna.service.AnswerRecommendVO;
import egovframework.com.wkp.qna.service.AnswerVO;
import egovframework.com.wkp.qna.service.EgovQnaService;
import egovframework.com.wkp.qna.service.QuestionVO;
import egovframework.com.wkp.usr.service.UserVO;
import egovframework.mgt.wkp.mnu.service.EgovMenuService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/qna")
public class EgovQnaController {

    private static final Logger LOGGER = LoggerFactory.getLogger(EgovQnaController.class);

    @Resource(name = "menuService")
    EgovMenuService menuService;

    @Resource(name = "qnaService")
    EgovQnaService qnaService;

    @Resource(name = "EgovFileMngService")
    private EgovFileMngService fileMngService;

    @Resource(name = "EgovFileMngUtil")
    private EgovFileMngUtil fileUtil;

    @RequestMapping("/list.do")
    public String index(Model model
            , @RequestParam(value = "type", required = false) QuestionType type
            , @RequestParam(value = "searchText", required = false) String searchText
            , @RequestParam(value = "searchKey", required = false) String searchKey
            , @RequestParam(value = "page", required = false, defaultValue = "1") int page) {

        try {

            ListWithPageNavigation<QuestionVO> questionList = null;

            UserVO user = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();

            QuestionVO param = new QuestionVO();
            param.setPage(page);
            param.setRegisterId(user.getSid());

            QuestionType paramType = type;

            param.setSearchText(searchText);
            param.setSearchKey(searchKey);
            if (QuestionType.DOING == paramType) {
                param.setSlctnYn(YnEnum.N.name());
            } else if (QuestionType.DONE == paramType) {
                param.setSlctnYn(YnEnum.Y.name());
            } else if (QuestionType.MINE == paramType) {
                param.setMyQuestion(true);
            } else if (QuestionType.MINEANSWER == paramType) {
                param.setMyAnswer(true);
            } else {
                paramType = QuestionType.ALL;
            }
            questionList = qnaService.selectQuestionList(param);

            model.addAttribute("questionList", questionList);
            model.addAttribute("waitCount", qnaService.selectQuestionWaitCount(user.getSid()));
            model.addAttribute("questionTypes", QuestionType.values());
            model.addAttribute("type", paramType);
            model.addAttribute("page", page);
            model.addAttribute("searchText", searchText);
            model.addAttribute("searchKey", searchKey);
            model.addAttribute("user", user);
            model.addAttribute("rank", qnaService.selectQuestionRank(user.getSid()));

        } catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}

        return "/com/wkp/qna/EgovQuestionList";
    }

    @RequestMapping("/detail.do")
    public String detail(Model model
            , @RequestParam Long questionNo
            , @RequestParam(value = "type", required = false) QuestionType type
            , @RequestParam(value = "searchText", required = false) String searchText
            , @RequestParam(value = "searchKey", required = false) String searchKey
            , @RequestParam(value = "page", required = false, defaultValue = "1") int page) {
        try {

            QuestionVO param = new QuestionVO();


            UserVO user = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();
            param.setQuestionNo(questionNo);
            param.setRegisterId(user.getSid());
            param.setSearchText(searchText);
            param.setPage(page);

            QuestionType paramType = type;

            if (QuestionType.DOING == paramType) {
                param.setSlctnYn(YnEnum.N.name());
            } else if (QuestionType.DONE == paramType) {
                param.setSlctnYn(YnEnum.Y.name());
            } else if (QuestionType.MINE == paramType) {
                param.setMyQuestion(true);
            } else if (QuestionType.MINEANSWER == paramType) {
                param.setMyAnswer(true);
            } else {
                paramType = QuestionType.ALL;
            }

            QuestionVO detail = qnaService.selectQuestionDetail(param);
            if (detail != null) {
                String str = detail.getCont();
                str = str.replaceAll("&lt;", "<");
                str = str.replaceAll("&gt;", ">");
                str = str.replaceAll("&quot;", "\"");
                detail.setCont(str);
                model.addAttribute("detail", detail);
                model.addAttribute("detailPre", qnaService.selectQuestionPre(param));
                model.addAttribute("detailNext", qnaService.selectQuestionNext(param));
            } else {
                return "redirect:/qna/list.do";
            }

            model.addAttribute("type", paramType);
            model.addAttribute("page", page);
            model.addAttribute("searchText", searchText);
            model.addAttribute("searchKey", searchKey);
            model.addAttribute("user", user);
            model.addAttribute("rank", qnaService.selectQuestionRank(user.getSid()));

        } catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}

        return "/com/wkp/qna/EgovQuestionDetail";
    }


    @RequestMapping("/questionWrite.do")
    public String insertQuestionView(Model model
    ) {
        try {
            UserVO user = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();

            model.addAttribute("detail", new QuestionVO());
            model.addAttribute("rank", qnaService.selectQuestionRank(user.getSid()));
        } catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}

        return "/com/wkp/qna/EgovQuestionRegist";
    }

    @RequestMapping(value = "/questionWriteProc.do", method = RequestMethod.POST)
    public String insertQuestion(@RequestParam String title, @RequestParam String cont
            , final MultipartHttpServletRequest multiRequest
    ) {
        try {
            QuestionVO param = new QuestionVO();

            UserVO user = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();

            param.setTitle(title);
            param.setCont(cont);

            List<FileVO> result = new ArrayList<FileVO>();
            Long atchFileNo = null;
            final Map<String, MultipartFile> files = multiRequest.getFileMap();
            if (!files.isEmpty()) {
                result = fileUtil.parseFileInf(files, "QnA_", 0, "");
                atchFileNo = fileMngService.insertFileInfs(result);
            }

            if (atchFileNo != null) {
                param.setAtchFileNo(atchFileNo);
            }

            param.setRegisterId(user.getSid());
            param.setUpdaterId(user.getSid());
            qnaService.insertQuestion(param);
        } catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		} catch (IOException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		} catch (EgovComException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}

        return "redirect:/qna/list.do";
    }

    @RequestMapping("/questionUpdate.do")
    public String updateQuestionView(Model model
            , @RequestParam Long questionNo
    ) {
        try {
            QuestionVO param = new QuestionVO();
            UserVO user = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();
            param.setQuestionNo(questionNo);
            QuestionVO detail = qnaService.selectQuestionDetail(param);
            if (detail != null) {
                model.addAttribute("detail", detail);
            } else {
                return "redirect:/qna/list.do";
            }

            model.addAttribute("rank", qnaService.selectQuestionRank(user.getSid()));
        } catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}

        return "/com/wkp/qna/EgovQuestionRegist";
    }

    @RequestMapping(value = "/questionUpdateProc.do", method = RequestMethod.POST)
    public String updateQuestion(@RequestParam String title, @RequestParam String cont, @RequestParam Long questionNo
            , @RequestParam(value = "atchFileNo", required = false) Long atchFileNo
            , final MultipartHttpServletRequest multiRequest
    ) {
        try {

            QuestionVO param = new QuestionVO();
            param.setTitle(title);
            param.setCont(cont);

            UserVO user = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();
            Long fileNo = atchFileNo;
            List<FileVO> result = new ArrayList<FileVO>();
            final Map<String, MultipartFile> files = multiRequest.getFileMap();
            if (!files.isEmpty()) {
                result = fileUtil.parseFileInf(files, "QnA_", 0, "");
                fileNo = fileMngService.insertFileInfs(result);
            }

            if (fileNo != null) {
                param.setAtchFileNo(fileNo);
            }

            param.setUpdaterId(user.getSid());
            param.setRegisterId(user.getSid());
            param.setQuestionNo(questionNo);
            qnaService.updateQuestion(param);
        } catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		} catch (IOException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		} catch (EgovComException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}

        return "redirect:/qna/list.do";
    }

    @RequestMapping(value = "/questionDelete.do", method = RequestMethod.POST)
    public String deleteQuestion(@RequestParam Long questionNo

    ) {
        try {

            UserVO user = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();

            QuestionVO param = new QuestionVO();
            param.setQuestionNo(questionNo);
            param.setRegisterId(user.getSid());
            param.setUpdaterId(user.getSid());
            qnaService.deleteQuestion(param);
        } catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}

        return "redirect:/qna/list.do";
    }

    @RequestMapping(value = "/answerWriteProc.do", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public ModelAndView insertAnswer(@RequestParam String cont, @RequestParam Long questionNo
            , @RequestParam(value = "file", required = false) MultipartFile file
    ) {

        boolean result = false;
        ModelAndView mav = new ModelAndView("jsonView");
        try {

            UserVO user = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();

            AnswerVO param = new AnswerVO();
            param.setCont(cont);
            param.setQuestionNo(questionNo);

            Map<String, MultipartFile> files = new HashMap<String, MultipartFile>();
            if (file != null)
                files.put("file", file);

            List<FileVO> fileResult = new ArrayList<FileVO>();

            Long atchFileNo = null;
            if (!files.isEmpty()) {
                fileResult = fileUtil.parseFileInf(files, "QnA_Answer_", 0, "");
                atchFileNo = fileMngService.insertFileInfs(fileResult);
            }

            if (atchFileNo != null) {
                param.setAtchFileNo(atchFileNo);
            }

            param.setRegisterId(user.getSid());
            param.setUpdaterId(user.getSid());
            result = qnaService.insertAnswer(param) > 0;
        } catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		} catch (IOException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		} catch (EgovComException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}

        mav.addObject("result", result);

        return mav;
    }

    @RequestMapping(value = "/updateAnswerSelection.do", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public ModelAndView answerSelection(@RequestParam Long answerNo, @RequestParam Long questionNo
    ) {

        boolean result = false;
        try {

            UserVO user = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();

            AnswerVO param = new AnswerVO();
            param.setQuestionNo(questionNo);
            param.setAnswerNo(answerNo);
            param.setRegisterId(user.getSid());
            param.setUpdaterId(user.getSid());
            result = qnaService.updateAnswerSelection(param) > 0;
        } catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}

        ModelAndView mav = new ModelAndView("jsonView");
        mav.addObject("result", result);

        return mav;
    }

    @RequestMapping(value = "/toggleAnswerRecommend.do", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public ModelAndView toggleAnswerRecommend(@RequestParam Long answerNo
    ) {

        ModelAndView mav = new ModelAndView("jsonView");
        AnswerRecommendVO vo = null;
        try {

            UserVO user = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();

            AnswerRecommendVO param = new AnswerRecommendVO();
            param.setAnswerNo(answerNo);
            param.setRegisterId(user.getSid());
            vo = qnaService.toggleAnswerRecommend(param);
        } catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}

        mav.addObject("result", vo != null ? true : false);
        mav.addObject("count", vo.getRecommendCount());
        mav.addObject("mine", vo.isMine());
        return mav;
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
			
			for(int i = 0; i < faqList.getList().size(); i++) {
				FileVO fileVO = new FileVO();
				fileVO.setAtchFileNo(faqList.getList().get(i).getAtchFileNo());
				List<FileVO> result = fileMngService.selectFileInfs(fileVO);
				faqList.getList().get(i).setFileList(result);
			}
			
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
		
		return "/com/wkp/qna/EgovFaqList";
		
	}


}
