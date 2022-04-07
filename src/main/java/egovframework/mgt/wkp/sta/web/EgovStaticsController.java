package egovframework.mgt.wkp.sta.web;

import egovframework.com.cmm.service.EgovProperties;
import egovframework.com.utl.fcc.service.EgovFileUploadUtil;
import egovframework.com.utl.wed.comm.ListWithPageNavigation;
import egovframework.com.wkp.kno.service.KnowledgeVO;
import egovframework.mgt.wkp.sta.service.EgovStaticsService;
import egovframework.mgt.wkp.sta.service.StaticsConnectVO;
import egovframework.mgt.wkp.sta.service.StaticsKnowledgeVO;
import egovframework.mgt.wkp.sta.service.StaticsQnaVO;
import egovframework.mgt.wkp.sta.service.StaticsVO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.*;

@Controller
@RequestMapping("/adm")
public class EgovStaticsController {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(EgovStaticsController.class);

	@Resource(name = "staticsService")
	EgovStaticsService egovStaticsService;
		
	@RequestMapping("/statConnect.do")
	public String statConnect(Model model,
			@RequestParam(value = "year", required = false) Integer year,
			@RequestParam(value = "month", required = false) Integer month) throws IOException {
		
		try {

			int nowYear = Calendar.getInstance().get(Calendar.YEAR);	
			if(year == null) {
				year = nowYear;
			}
			
			int nowMonth = Calendar.getInstance().get(Calendar.MONTH) + 1;
			if(month == null) {
				month = nowMonth;
			}
			
			model.addAttribute("statics", egovStaticsService.selectConnectStatics(year, month));
			model.addAttribute("year", year);
			model.addAttribute("nowYear", nowYear);
			model.addAttribute("month", month);
			model.addAttribute("nowMonth", nowMonth);
		} catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}
		
		return "/mgt/wkp/sta/EgovStatConnect";
	}

	//접속통계 엑셀 다운로드
	@RequestMapping(value = "/statConnectExcelDownload.do", method = {RequestMethod.POST})
	public ModelAndView statConnectExcelDownload(
			@RequestParam(value = "year", required = false) Integer year,
			@RequestParam(value = "month", required = false) Integer month) throws IOException {
		Map<String, Object> downloadData = new HashMap<String, Object>();
		String today = new SimpleDateFormat("yyyy_MM_dd_hh_mm_ss", Locale.KOREA).format(new Date());
		String filename = "connectStatExcelDown" + "_" + today + ".csv";

		List<String[]> data = new ArrayList<String[]>();
		data.add(new String[]{"일자", "방문자수", "전일 대비 방문자수", "방문횟수", "전일대비 방문횟수"});
		try {
			StaticsVO vo  = egovStaticsService.selectConnectStatics(year, month);
			if (vo != null && vo.getStaticsConnectVoList() != null) {
				for(StaticsConnectVO s : vo.getStaticsConnectVoList()) {
					data.add(new String[]{s.getDt(), String.valueOf(s.getVisitUserCount())
							, String.valueOf(s.getPreVisitCount()), String.valueOf(s.getVisitCount())
							, String.valueOf(s.getPreVisitCount())});
				}
				data.add(new String[]{"총"
						, String.valueOf(vo.getTotalConnectUserCount())
						, String.valueOf(vo.getTotalPreConnectUserCount())
						, String.valueOf(vo.getTotalConnectCount())
						, String.valueOf(vo.getTotalPreConnectCount())});

			}
		} catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}

		String tempPath = EgovProperties.getProperty("Globals.fileStorePath");

		EgovFileUploadUtil.writeCsv(data, tempPath + filename); //csv 쓰기 메소드 호출
		downloadData.put("rname", filename);
		downloadData.put("downloadFile", new File(tempPath + filename));

		return new ModelAndView("downloadView", "downloadData", downloadData);
	}

	@RequestMapping("/statQna.do")
	public String statQna(Model model,
			@RequestParam(value = "year", required = false) Integer year,
			@RequestParam(value = "month", required = false) Integer month) throws IOException {
		
		try {

			int nowYear = Calendar.getInstance().get(Calendar.YEAR);	
			if(year == null) {
				year = nowYear;
			}
			
			int nowMonth = Calendar.getInstance().get(Calendar.MONTH) + 1;
			if(month == null) {
				month = nowMonth;
			}

			model.addAttribute("statics", egovStaticsService.selectQnaStatics(year, month));
			model.addAttribute("year", year);
			model.addAttribute("nowYear", nowYear);
			model.addAttribute("month", month);
			model.addAttribute("nowMonth", nowMonth);
		} catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}

		return "/mgt/wkp/sta/EgovStatQna";
	}

	//Qna 통계 엑셀 다운로드
	@RequestMapping(value = "/statQnaExcelDownload.do", method = {RequestMethod.POST})
	public ModelAndView statQnaExcelDownload(
			@RequestParam(value = "year", required = false) Integer year,
			@RequestParam(value = "month", required = false) Integer month) throws IOException {
		Map<String, Object> downloadData = new HashMap<String, Object>();
		String today = new SimpleDateFormat("yyyy_MM_dd_hh_mm_ss", Locale.KOREA).format(new Date());
		String filename = "qnaStatExcelDown" + "_" + today + ".csv";

		List<String[]> data = new ArrayList<String[]>();
		data.add(new String[]{"일자", "질문 작성수", "전일 대비 질문 작성 수","답변수", "전일 대비 답변 수"});
		try {
			StaticsVO vo  = egovStaticsService.selectQnaStatics(year, month);
			if (vo != null && vo.getStaticsQnaVoList() != null) {
				for(StaticsQnaVO s : vo.getStaticsQnaVoList()) {
					data.add(new String[]{s.getDt(), String.valueOf(s.getQuestionCount())
							, String.valueOf(s.getPreQuestionCount()), String.valueOf(s.getAnswerCount())
							, String.valueOf(s.getPreAnswerCount())});
				}
				data.add(new String[]{"총"
						, String.valueOf(vo.getTotalQuestionCount())
						, String.valueOf(vo.getTotalPreQuestionCount())
						, String.valueOf(vo.getTotalAnswerCountCount())
						, String.valueOf(vo.getTotalPreAnswerCountCount())});

			}
		} catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}

		String tempPath = EgovProperties.getProperty("Globals.fileStorePath");

		EgovFileUploadUtil.writeCsv(data, tempPath + filename); //csv 쓰기 메소드 호출
		downloadData.put("rname", filename);
		downloadData.put("downloadFile", new File(tempPath + filename));

		return new ModelAndView("downloadView", "downloadData", downloadData);
	}

	@RequestMapping("/statKnowledge.do")
	public String statKnowledge(Model model,
			@RequestParam(value = "year", required = false) Integer year,
			@RequestParam(value = "month", required = false) Integer month) throws IOException {
		
		try {

			int nowYear = Calendar.getInstance().get(Calendar.YEAR);	
			if(year == null) {
				year = nowYear;
			}
			
			int nowMonth = Calendar.getInstance().get(Calendar.MONTH) + 1;
			if(month == null) {
				month = nowMonth;
			}

			model.addAttribute("statics", egovStaticsService.selectKnowledgeStatics(year, month));
			model.addAttribute("year", year);
			model.addAttribute("nowYear", nowYear);
			model.addAttribute("month", month);
			model.addAttribute("nowMonth", nowMonth);
		} catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}
		
		return "/mgt/wkp/sta/EgovStatKnowledge";
	}
	
	//지식건수 통계 엑셀 다운로드
	@RequestMapping(value = "/statKnowledgeExcelDownload.do", method = {RequestMethod.POST})
	public ModelAndView statKnowledgeExcelDownload(
			@RequestParam(value = "year", required = false) Integer year,
			@RequestParam(value = "month", required = false) Integer month) throws IOException {
		Map<String, Object> downloadData = new HashMap<String, Object>();
		String today = new SimpleDateFormat("yyyy_MM_dd_hh_mm_ss", Locale.KOREA).format(new Date());
		String filename = "knoStatExcelDown" + "_" + today + ".csv";

		List<String[]> data = new ArrayList<String[]>();
		data.add(new String[]{"일자", "지식 등록 수", "전일 대비 지식 등록 수"});
		try {
			StaticsVO vo  = egovStaticsService.selectKnowledgeStatics(year, month);
			if (vo != null && vo.getStaticsKnowledgeVoList() != null) {
				for(StaticsKnowledgeVO s : vo.getStaticsKnowledgeVoList()) {
					data.add(new String[]{s.getDt(), String.valueOf(s.getKnowledgeCount())
							, String.valueOf(s.getPreKnowledgeCount())});
				}
				data.add(new String[]{"총"
						, String.valueOf(vo.getTotalKnowledgeCount())
						, String.valueOf(vo.getTotalPreKnowledgeCount())});

			}
		} catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}

		String tempPath = EgovProperties.getProperty("Globals.fileStorePath");

		EgovFileUploadUtil.writeCsv(data, tempPath + filename); //csv 쓰기 메소드 호출
		downloadData.put("rname", filename);
		downloadData.put("downloadFile", new File(tempPath + filename));

		return new ModelAndView("downloadView", "downloadData", downloadData);
	}
	
	@RequestMapping("/statKnowledgeList.do")
	public String statKnowledgeList(@ModelAttribute("knowledgeVO") KnowledgeVO knowledgeVO, Model model) throws IOException {
		
		try {
			if(knowledgeVO.getPage() == null || knowledgeVO.getPage() == 0) {
				knowledgeVO.setPage(1);
			}
			
			ListWithPageNavigation<KnowledgeVO> knowledgeList = egovStaticsService.selectKnowledgeList(knowledgeVO);
			model.addAttribute("knowledgeList", knowledgeList);
		} catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}
		
		return "/mgt/wkp/sta/EgovStatKnowledgeList";
		
	}
	
	@RequestMapping("/statInterestsList.do")
	public String statInterestsList(@ModelAttribute("knowledgeVO") KnowledgeVO knowledgeVO, Model model) throws IOException {
		
		try {
			if(knowledgeVO.getPage() == null || knowledgeVO.getPage() == 0) {
				knowledgeVO.setPage(1);
			}
			
			ListWithPageNavigation<KnowledgeVO> interestsList = egovStaticsService.selectInterestsList(knowledgeVO);
			model.addAttribute("interestsList", interestsList);
		} catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}
		
		return "/mgt/wkp/sta/EgovStatInterestsList";
	}

	@RequestMapping("/statViewKnowledge.do")
	public String statViewKnowledge(@ModelAttribute StaticsKnowledgeVO param, Model model) {
		if (StringUtils.isEmpty(param.getStartDate())) {
			param.setStartDate(LocalDate.now().minusDays(6).format(DateTimeFormatter.ofPattern("yyyy-MM-dd")));
		}
		if (StringUtils.isEmpty(param.getEndDate())) {
			param.setEndDate(LocalDate.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd")));
		}
		ListWithPageNavigation<StaticsKnowledgeVO> listWithPageNavigation = egovStaticsService.selectViewStatics(param);
		model.addAttribute("resultList", listWithPageNavigation.getList());
		model.addAttribute("pageNavigation", listWithPageNavigation.getPageNavigation());
		return "/mgt/wkp/sta/EgovStatViewKnowledge";
	}

	@RequestMapping("/statRecommendKnowledge.do")
	public String statRecommendKnowledge(@ModelAttribute StaticsKnowledgeVO param, Model model) {
		if (StringUtils.isEmpty(param.getStartDate())) {
			param.setStartDate(LocalDate.now().minusDays(6).format(DateTimeFormatter.ofPattern("yyyy-MM-dd")));
		}
		if (StringUtils.isEmpty(param.getEndDate())) {
			param.setEndDate(LocalDate.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd")));
		}
		ListWithPageNavigation<StaticsKnowledgeVO> listWithPageNavigation = egovStaticsService.selectRecommendStatics(param);
		model.addAttribute("resultList", listWithPageNavigation.getList());
		model.addAttribute("pageNavigation", listWithPageNavigation.getPageNavigation());
		return "/mgt/wkp/sta/EgovStatRecommendKnowledge";
	}

	@RequestMapping("/statUserKnowledge.do")
	public String statUserKnowledge(@ModelAttribute StaticsKnowledgeVO param, Model model) {
		if (StringUtils.isEmpty(param.getStartDate())) {
			param.setStartDate(LocalDate.now().minusDays(6).format(DateTimeFormatter.ofPattern("yyyy-MM-dd")));
		}
		if (StringUtils.isEmpty(param.getEndDate())) {
			param.setEndDate(LocalDate.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd")));
		}
		ListWithPageNavigation<StaticsKnowledgeVO> listWithPageNavigation = egovStaticsService.selectUserStatics(param);
		model.addAttribute("resultList", listWithPageNavigation.getList());
		model.addAttribute("pageNavigation", listWithPageNavigation.getPageNavigation());
		return "/mgt/wkp/sta/EgovStatUserKnowledge";
	}

	@RequestMapping("/statRecommendUserKnowledge.do")
	public String statRecommendUserKnowledge(@ModelAttribute StaticsKnowledgeVO param, Model model) {
		if (StringUtils.isEmpty(param.getStartDate())) {
			param.setStartDate(LocalDate.now().minusDays(6).format(DateTimeFormatter.ofPattern("yyyy-MM-dd")));
		}
		if (StringUtils.isEmpty(param.getEndDate())) {
			param.setEndDate(LocalDate.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd")));
		}
		ListWithPageNavigation<StaticsKnowledgeVO> listWithPageNavigation = egovStaticsService.selectRecommendUserStatics(param);
		model.addAttribute("resultList", listWithPageNavigation.getList());
		model.addAttribute("pageNavigation", listWithPageNavigation.getPageNavigation());
		return "/mgt/wkp/sta/EgovStatRecommendUserKnowledge";
	}

	@RequestMapping("/statOrgKnowledge.do")
	public String statOrgKnowledge(@ModelAttribute StaticsKnowledgeVO param, Model model) {
		if (StringUtils.isEmpty(param.getStartDate())) {
			param.setStartDate(LocalDate.now().minusDays(6).format(DateTimeFormatter.ofPattern("yyyy-MM-dd")));
		}
		if (StringUtils.isEmpty(param.getEndDate())) {
			param.setEndDate(LocalDate.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd")));
		}
		ListWithPageNavigation<StaticsKnowledgeVO> listWithPageNavigation = egovStaticsService.selectOrgStatics(param);
		model.addAttribute("resultList", listWithPageNavigation.getList());
		model.addAttribute("pageNavigation", listWithPageNavigation.getPageNavigation());
		return "/mgt/wkp/sta/EgovStatOrgKnowledge";
	}
}
