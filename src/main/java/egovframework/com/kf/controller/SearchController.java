package egovframework.com.kf.controller;

import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.com.kf.common.CommonUtil;
import egovframework.com.kf.common.SetParameter;
import egovframework.com.kf.dao.KsfModule;
import egovframework.com.kf.data.ParameterVO;
import egovframework.com.kf.data.RestResultVO;
import egovframework.com.kf.service.SrhKnowledgeService;
import egovframework.com.kf.service.SrhQnaService;
import egovframework.com.kf.service.SrhSurveyService;
import egovframework.com.wkp.usr.service.UserVO;
import egovframework.com.kf.service.SrhCommunityService;
import egovframework.com.kf.service.SrhNoticeService;
import egovframework.com.kf.service.SrhFaqService;
import egovframework.com.kf.service.SrhEdmsPostService;
import egovframework.com.kf.service.SrhEdmsRecvService;


/**
 * Class Name : SearchController.java
 * Description : 통합검색 조회를 위한 컨트롤러
 *
 * Modification Information
 *
 * 수정일                        수정자           수정내용
 * --------------------  -----------  ---------------------------------------
 * 2017년 12월  00일     김승희           최초 작성
 *
 * @since 2017년
 * @version V1.0
 * @see (c) Copyright (C) by KONANTECH All right reserved
 */
@Controller
public class SearchController {
//	private static final Logger logger = LoggerFactory.getLogger(SearchController.class);

	/** srhKnowledgeService */
	@Resource(name = "srhKnowledgeService")
	private SrhKnowledgeService knowledgeService;
	
	/** srhQnaService */
	@Resource(name = "srhQnaService")
	private SrhQnaService srhQnaService;
	
	/** srhSurveyService */
	@Resource(name = "srhSurveyService")
	private SrhSurveyService srhSurveyService;
	
	/** srhCommunityService */
	@Resource(name = "srhCommunityService")
	private SrhCommunityService srhCommunityService;
	
	/** srhNoticeService */
	@Resource(name = "srhNoticeService")
	private SrhNoticeService srhNoticeService;
	
	/** srhFaqService */
	@Resource(name = "srhFaqService")
	private SrhFaqService srhFaqService;	
	
	/** srhEdmsPostService */
	@Resource(name = "srhEdmsPostService")
	private SrhEdmsPostService srhEdmsPostService;
	
	/** srhEdmsRecvService */
	@Resource(name = "srhEdmsRecvService")
	private SrhEdmsRecvService srhEdmsRecvService;
	
	/** Parameter Setting */
	@Resource(name = "setParameter")
	private SetParameter setParameter;
	
	/** common util Setting */
	@Resource(name = "commonUtil")
	private CommonUtil commonUtil;
	
	/** common util Setting */
	@Resource(name = "ksfModule")
	private KsfModule ksfModule;	
	
	
	@RequestMapping(value = "/search.do")
	public String search(@RequestParam Map<String, String> map, Model model) throws Exception {
		
		// 파라미터 세팅
		ParameterVO paramVO = setParameter.setParameter(map);
		UserVO user = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();
		model.addAttribute("UserVO", user);
		if(paramVO.getKwd().isEmpty()) {
			return "/com/search/search";
		}
		//연관검색
		getSuggestion(model, paramVO);	
		
		//인기검색
		model.addAttribute("ppkList", ksfModule.getPopularKwd(0, 10));
		// 카테고리별 문서 호출
		setCategoryModel(model, paramVO);	
		
		//파라미터
		model.addAttribute("params", paramVO);
		
		return "/com/wkp/search/search";
	}
	
	
	/**
	 * 모델 세팅 부분을 분리
	 * 카테고리 :	 게시판 조회 
	 * @return Model
	 * 
	 * @throws Exception
	 */
	private Model setCategoryModel(Model model, ParameterVO paramVO) throws Exception {
		RestResultVO result;
		int total = 0;
		//setCategorySch
		// 카테고리 여부
		if(paramVO.getKwd().length() > 0) {
			for(String cate : paramVO.getCategorySch()) {
				//지식백과
				if (commonUtil.easyChkEqual("TOTAL,kno", cate, ",", false)) {
					result = knowledgeService.KnowledgeSearch(paramVO);
					total += result.getTotal();
//					logger.debug("GET kno TOTAL :::::::"+result.getTotal());
					model.addAttribute("kno", "kno");
					model.addAttribute("knoRow", result.getRows());
					model.addAttribute("knoList", result.getResult());
					model.addAttribute("knoTotal", result.getTotal());				
				}
				//qna
				if (commonUtil.easyChkEqual("TOTAL,qna", cate, ",", false)) {
					result = srhQnaService.QnaSearch(paramVO);
					total += result.getTotal();
//					logger.debug("GET qna TOTAL :::::::"+result.getTotal());
					model.addAttribute("qna", "qna");
					model.addAttribute("qnaRow", result.getRows());
					model.addAttribute("qnaList", result.getResult());
					model.addAttribute("qnaTotal", result.getTotal());				
				}
				//설문조사
				if (commonUtil.easyChkEqual("TOTAL,srv", cate, ",", false)) {
					// 문서만 검색일경우 설문조사 검색제외
					if(!(paramVO.getSchAreaAll().equals("false") && "false".equals(paramVO.getSchArea1())&&"false".equals(paramVO.getSchArea2())&&"true".equals(paramVO.getSchArea3()))) {
						result = srhSurveyService.SurveySearch(paramVO);
						total += result.getTotal();
//						logger.debug("GET srv TOTAL :::::::"+result.getTotal());
						model.addAttribute("srv", "srv");
						model.addAttribute("srvRow", result.getRows());
						model.addAttribute("srvList", result.getResult());
						model.addAttribute("srvTotal", result.getTotal());	
					}
				}
				//커뮤니티
				if (commonUtil.easyChkEqual("TOTAL,comm", cate, ",", false)) {
					// 문서만 검색일경우 커뮤니티 검색제외
					if(!(paramVO.getSchAreaAll().equals("false") && "false".equals(paramVO.getSchArea1())&&"false".equals(paramVO.getSchArea2())&&"true".equals(paramVO.getSchArea3()))) {
						result = srhCommunityService.CommunitySearch(paramVO);
						total += result.getTotal();
//						logger.debug("GET comm TOTAL :::::::"+result.getTotal());
						model.addAttribute("comm", "comm");
						model.addAttribute("commRow", result.getRows());
						model.addAttribute("commList", result.getResult());
						model.addAttribute("commTotal", result.getTotal());
					}
				}
				//공지사항
				if (commonUtil.easyChkEqual("TOTAL,notice", cate, ",", false)) {
					result = srhNoticeService.NoticeSearch(paramVO);
					total += result.getTotal();
//					logger.debug("GET notice TOTAL :::::::"+result.getTotal());
					model.addAttribute("notice", "notice");
					model.addAttribute("noticeRow", result.getRows());
					model.addAttribute("noticeList", result.getResult());
					model.addAttribute("noticeTotal", result.getTotal());				
				}
				//faq
				if (commonUtil.easyChkEqual("TOTAL,faq", cate, ",", false)) {
					result = srhFaqService.FaqSearch(paramVO);
					total += result.getTotal();
//					logger.debug("GET faq TOTAL :::::::"+result.getTotal());
					model.addAttribute("faq", "faq");
					model.addAttribute("faqRow", result.getRows());
					model.addAttribute("faqList", result.getResult());
					model.addAttribute("faqTotal", result.getTotal());				
				}
				//온나라 접수함
				if (commonUtil.easyChkEqual("TOTAL,edmsRecv", cate, ",", false)) {
					model.addAttribute("edmsRecv", "edmsRecv");
					int i=srhEdmsRecvService.RecvSearch(paramVO,model);
					total += i;
				}
				//온나라 생산함
				if (commonUtil.easyChkEqual("TOTAL,edmsPost", cate, ",", false)) {
					model.addAttribute("edmsPost", "edmsPost");
					int i = srhEdmsPostService.PostSearch(paramVO,model);
					total += i;
				}
			}
		 
		}
		
		model.addAttribute("formatTotal", commonUtil.formatMoney(total));
		model.addAttribute("total", total);
		
		return model;
	}	
	
	private Model getSuggestion(Model model, ParameterVO paramVO) throws Exception {
		RestResultVO result;
		int domainNo=0, maxResult=8;
		model.addAttribute("suggestions", ksfModule.getSuggestionKwd(domainNo, maxResult, paramVO.getKwd().toString()));
		/*logger.debug("GET suggestions :::::::"+model);*/
		return model;
		
	}
}
