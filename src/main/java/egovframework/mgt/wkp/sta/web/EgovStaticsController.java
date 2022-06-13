package egovframework.mgt.wkp.sta.web;

import egovframework.com.cmm.service.EgovProperties;
import egovframework.com.utl.fcc.service.EgovFileUploadUtil;
import egovframework.com.utl.wed.comm.ListWithPageNavigation;
import egovframework.com.wkp.kno.service.KnowledgeVO;
import egovframework.mgt.wkp.sta.service.*;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
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
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.net.URLEncoder;
import java.text.DecimalFormat;
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

	@RequestMapping("/statActiveUserKnowledge.do")
	public String statActiveUserKnowledge(@ModelAttribute StaticsKnowledgeVO param, Model model) {
		if (StringUtils.isEmpty(param.getStartDate())) {
			param.setStartDate(LocalDate.now().minusDays(6).format(DateTimeFormatter.ofPattern("yyyy-MM-dd")));
		}
		if (StringUtils.isEmpty(param.getEndDate())) {
			param.setEndDate(LocalDate.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd")));
		}
		ListWithPageNavigation<StaticsKnowledgeVO> listWithPageNavigation = egovStaticsService.selectActiveUserStatics(param);
		model.addAttribute("resultList", listWithPageNavigation.getList());
		model.addAttribute("pageNavigation", listWithPageNavigation.getPageNavigation());
		return "/mgt/wkp/sta/EgovStatActiveUserKnowledge";
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

	@RequestMapping(value = "/knowledgeStatisticsExcelDownload.do", method = {RequestMethod.POST})
	public void knowledgeStatisticsExcelDownload(@ModelAttribute StaticsKnowledgeVO staticsKnowledgeVO, HttpServletResponse httpServletResponse) throws IOException {
		if (StringUtils.isEmpty(staticsKnowledgeVO.getStartDate())) {
			staticsKnowledgeVO.setStartDate(LocalDate.now().minusDays(6).format(DateTimeFormatter.ofPattern("yyyy-MM-dd")));
		}
		if (StringUtils.isEmpty(staticsKnowledgeVO.getEndDate())) {
			staticsKnowledgeVO.setEndDate(LocalDate.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd")));
		}

		List<StaticsKnowledgeVO> resultList = null;
		String fileName = null;
		String[] colNames = null;
		int[] colWidths = null;

		switch (staticsKnowledgeVO.getType()) {
			case "statViewKnowledge":
				resultList = egovStaticsService.selectViewStaticsExcelList(staticsKnowledgeVO);
				fileName = "최다 조회 지식 통계";
				colNames = new String[] { "순위", "제목", "조회수", "추천수", "부서", "담당자", "최근등록일" };
				colWidths = new int[] { 5000, 10000, 5000, 5000, 5000, 5000, 5000 };
				break;
			case "statRecommendKnowledge":
				resultList = egovStaticsService.selectRecommendStaticsExcelList(staticsKnowledgeVO);
				fileName = "최다 추천 지식 통계";
				colNames = new String[] { "순위", "제목", "추천수", "조회수", "부서", "담당자", "최근등록일" };
				colWidths = new int[] { 5000, 10000, 5000, 5000, 5000, 5000, 5000 };
				break;
			case "statUserKnowledge":
				resultList = egovStaticsService.selectUserStaticsExcelList(staticsKnowledgeVO);
				fileName = "최다 게시자 통계";
				colNames = new String[] { "순위", "성명", "부서", "게시건수(수정포함)", "조회누계", "추천누계" };
				colWidths = new int[] { 5000, 5000, 5000, 5000, 5000, 5000 };
				break;
			case "statRecommendUserKnowledge":
				resultList = egovStaticsService.selectRecommendUserStaticsExcelList(staticsKnowledgeVO);
				fileName = "최다 추천자 통계";
				colNames = new String[] { "순위", "성명", "부서", "게시건수(수정포함)", "조회누계", "추천누계" };
				colWidths = new int[] { 5000, 5000, 5000, 5000, 5000, 5000 };
				break;
			case "statActiveUserKnowledge":
				resultList = egovStaticsService.selectActiveUserStaticsExcelList(staticsKnowledgeVO);
				fileName = "최다 활동자 통계";
				colNames = new String[] { "순위", "성명", "부서", "마일리지 합계", "조회", "추천", "등록", "수정" };
				colWidths = new int[] { 5000, 5000, 5000, 5000, 5000, 5000, 5000, 5000 };
				break;
			case "statOrgKnowledge":
				resultList = egovStaticsService.selectOrgStaticsExcelList(staticsKnowledgeVO);
				fileName = "최다 등록부서 통계";
				colNames = new String[] { "순위", "부서명", "행정자료", "업무참고자료", "개인행정지식", "추천누계" };
				colWidths = new int[] { 5000, 5000, 5000, 5000, 5000, 5000 };
				break;
		}

		DecimalFormat decimalFormat = new DecimalFormat("###,###,###");

		XSSFWorkbook workbook = new XSSFWorkbook();
		XSSFSheet sheet = workbook.createSheet(fileName); // 엑셀 시트명 설정
		XSSFRow row = null;
		XSSFCell cell = null;

		//Font
		Font font = workbook.createFont();
		font.setFontName("맑은 고딕");
		font.setFontHeight((short)(10 * 20));
		Font headerFont = workbook.createFont();
		headerFont.setFontName("맑은 고딕");
		headerFont.setBold(true);
		// 엑셀 헤더 셋팅
		CellStyle headerStyle = workbook.createCellStyle();
		headerStyle.setFont(headerFont);
		headerStyle.setAlignment(HorizontalAlignment.CENTER);
		// 엑셀 바디 셋팅
		CellStyle bodyStyle = workbook.createCellStyle();
		bodyStyle.setFont(font);

		// rows
		int rowCnt = 0;

		row = sheet.createRow(rowCnt++);
		//헤더 정보 구성
		for (int i = 0; i < colNames.length; i++) {
			cell = row.createCell(i);
			cell.setCellStyle(headerStyle);
			cell.setCellValue(colNames[i]);
			sheet.setColumnWidth(i, colWidths[i]);	//column width 지정
		}

		switch (staticsKnowledgeVO.getType()) {
			case "statViewKnowledge":
				// "순위", "제목", "조회수", "추천수", "부서", "담당자", "최근등록일"
				for(StaticsKnowledgeVO result : resultList) {
					int cellCnt = 0;
					row = sheet.createRow(rowCnt++);
					// 순위
					cell = row.createCell(cellCnt++);
					cell.setCellStyle(bodyStyle);
					cell.setCellValue(rowCnt - 1);
					// 제목
					cell = row.createCell(cellCnt++);
					cell.setCellStyle(bodyStyle);
					cell.setCellValue(result.getTitle());
					// 조회수
					cell = row.createCell(cellCnt++);
					cell.setCellStyle(bodyStyle);
					cell.setCellValue(decimalFormat.format(result.getInqCnt()));
					// 추천수
					cell = row.createCell(cellCnt++);
					cell.setCellStyle(bodyStyle);
					cell.setCellValue(decimalFormat.format(result.getRecCnt()));
					// 부서
					cell = row.createCell(cellCnt++);
					cell.setCellStyle(bodyStyle);
					cell.setCellValue(result.getOu());
					// 담당자
					cell = row.createCell(cellCnt++);
					cell.setCellStyle(bodyStyle);
					cell.setCellValue(result.getOwnerName() + "(" + result.getOwnerOu() + ")");
					// 최근등록일
					cell = row.createCell(cellCnt++);
					cell.setCellStyle(bodyStyle);
					cell.setCellValue(result.getRegistDtm().toString());
				}
				break;
			case "statRecommendKnowledge":
				// "순위", "제목", "추천수", "조회수", "부서", "담당자", "최근등록일"
				for(StaticsKnowledgeVO result : resultList) {
					int cellCnt = 0;
					row = sheet.createRow(rowCnt++);
					// 순위
					cell = row.createCell(cellCnt++);
					cell.setCellStyle(bodyStyle);
					cell.setCellValue(rowCnt - 1);
					// 제목
					cell = row.createCell(cellCnt++);
					cell.setCellStyle(bodyStyle);
					cell.setCellValue(result.getTitle());
					// 추천수
					cell = row.createCell(cellCnt++);
					cell.setCellStyle(bodyStyle);
					cell.setCellValue(decimalFormat.format(result.getRecCnt()));
					// 조회수
					cell = row.createCell(cellCnt++);
					cell.setCellStyle(bodyStyle);
					cell.setCellValue(decimalFormat.format(result.getInqCnt()));
					// 부서
					cell = row.createCell(cellCnt++);
					cell.setCellStyle(bodyStyle);
					cell.setCellValue(result.getOu());
					// 담당자
					cell = row.createCell(cellCnt++);
					cell.setCellStyle(bodyStyle);
					cell.setCellValue(result.getOwnerName() + "(" + result.getOwnerOu() + ")");
					// 최근등록일
					cell = row.createCell(cellCnt++);
					cell.setCellStyle(bodyStyle);
					cell.setCellValue(result.getRegistDtm().toString());
				}
				break;
			case "statUserKnowledge":
				// "순위", "성명", "부서", "게시건수(수정포함)", "조회누계", "추천누계"
				for(StaticsKnowledgeVO result : resultList) {
					int cellCnt = 0;
					row = sheet.createRow(rowCnt++);
					// 순위
					cell = row.createCell(cellCnt++);
					cell.setCellStyle(bodyStyle);
					cell.setCellValue(rowCnt - 1);
					// 성명
					cell = row.createCell(cellCnt++);
					cell.setCellStyle(bodyStyle);
					cell.setCellValue(result.getDisplayName());
					// 부서
					cell = row.createCell(cellCnt++);
					cell.setCellStyle(bodyStyle);
					cell.setCellValue(result.getOu());
					// 게시건수(수정포함)
					cell = row.createCell(cellCnt++);
					cell.setCellStyle(bodyStyle);
					cell.setCellValue(decimalFormat.format(result.getRegCnt()));
					// 조회누계
					cell = row.createCell(cellCnt++);
					cell.setCellStyle(bodyStyle);
					cell.setCellValue(decimalFormat.format(result.getInqCnt()));
					// 추천누계
					cell = row.createCell(cellCnt++);
					cell.setCellStyle(bodyStyle);
					cell.setCellValue(decimalFormat.format(result.getRecCnt()));
				}
				break;
			case "statRecommendUserKnowledge":
				// "순위", "성명", "부서", "게시건수(수정포함)", "조회누계", "추천누계"
				for(StaticsKnowledgeVO result : resultList) {
					int cellCnt = 0;
					row = sheet.createRow(rowCnt++);
					// 순위
					cell = row.createCell(cellCnt++);
					cell.setCellStyle(bodyStyle);
					cell.setCellValue(rowCnt - 1);
					// 성명
					cell = row.createCell(cellCnt++);
					cell.setCellStyle(bodyStyle);
					cell.setCellValue(result.getDisplayName());
					// 부서
					cell = row.createCell(cellCnt++);
					cell.setCellStyle(bodyStyle);
					cell.setCellValue(result.getOu());
					// 게시건수(수정포함)
					cell = row.createCell(cellCnt++);
					cell.setCellStyle(bodyStyle);
					cell.setCellValue(decimalFormat.format(result.getRegCnt()));
					// 조회누계
					cell = row.createCell(cellCnt++);
					cell.setCellStyle(bodyStyle);
					cell.setCellValue(decimalFormat.format(result.getInqCnt()));
					// 추천누계
					cell = row.createCell(cellCnt++);
					cell.setCellStyle(bodyStyle);
					cell.setCellValue(decimalFormat.format(result.getRecCnt()));
				}
				break;
			case "statActiveUserKnowledge":
				// "순위", "성명", "부서", "마일리지 합계", "조회", "추천", "등록", "수정"
				for(StaticsKnowledgeVO result : resultList) {
					int cellCnt = 0;
					row = sheet.createRow(rowCnt++);
					// 순위
					cell = row.createCell(cellCnt++);
					cell.setCellStyle(bodyStyle);
					cell.setCellValue(rowCnt - 1);
					// 성명
					cell = row.createCell(cellCnt++);
					cell.setCellStyle(bodyStyle);
					cell.setCellValue(result.getDisplayName());
					// 부서
					cell = row.createCell(cellCnt++);
					cell.setCellStyle(bodyStyle);
					cell.setCellValue(result.getOu());
					// 마일리지 합계
					cell = row.createCell(cellCnt++);
					cell.setCellStyle(bodyStyle);
					cell.setCellValue(decimalFormat.format(result.getTotalMileage()));
					// 조회
					cell = row.createCell(cellCnt++);
					cell.setCellStyle(bodyStyle);
					if (result.getViewCnt() != 0) {
						cell.setCellValue(decimalFormat.format(result.getViewCnt()) + "건 (" + decimalFormat.format(result.getViewMileage()) + "점)");
					} else {
						cell.setCellValue("-");
					}
					// 추천
					cell = row.createCell(cellCnt++);
					cell.setCellStyle(bodyStyle);
					if (result.getRecCnt() != 0) {
						cell.setCellValue(decimalFormat.format(result.getRecCnt()) + "건 (" + decimalFormat.format(result.getRecMileage()) + "점)");
					} else {
						cell.setCellValue("-");
					}
					// 등록
					cell = row.createCell(cellCnt++);
					cell.setCellStyle(bodyStyle);
					if (result.getNewCnt() != 0) {
						cell.setCellValue(decimalFormat.format(result.getNewCnt()) + "건 (" + decimalFormat.format(result.getNewMileage()) + "점)");
					} else {
						cell.setCellValue("-");
					}
					// 수정
					cell = row.createCell(cellCnt++);
					cell.setCellStyle(bodyStyle);
					if (result.getUpdCnt() != 0) {
						cell.setCellValue(decimalFormat.format(result.getUpdCnt()) + "건 (" + decimalFormat.format(result.getUpdMileage()) + "점)");
					} else {
						cell.setCellValue("-");
					}
				}
				break;
			case "statOrgKnowledge":
				// "순위", "부서명", "행정자료", "업무참고자료", "개인행정지식", "추천누계"
				for(StaticsKnowledgeVO result : resultList) {
					int cellCnt = 0;
					row = sheet.createRow(rowCnt++);
					// 순위
					cell = row.createCell(cellCnt++);
					cell.setCellStyle(bodyStyle);
					cell.setCellValue(rowCnt - 1);
					// 부서명
					cell = row.createCell(cellCnt++);
					cell.setCellStyle(bodyStyle);
					cell.setCellValue(result.getOu());
					// 행정자료
					cell = row.createCell(cellCnt++);
					cell.setCellStyle(bodyStyle);
					cell.setCellValue(decimalFormat.format(result.getReportCnt()));
					// 업무참고자료
					cell = row.createCell(cellCnt++);
					cell.setCellStyle(bodyStyle);
					cell.setCellValue(decimalFormat.format(result.getReferenceCnt()));
					// 개인행정지식
					cell = row.createCell(cellCnt++);
					cell.setCellStyle(bodyStyle);
					cell.setCellValue(decimalFormat.format(result.getPersonalCnt()));
					// 추천누계
					cell = row.createCell(cellCnt++);
					cell.setCellStyle(bodyStyle);
					cell.setCellValue(decimalFormat.format(result.getRecCnt()));
				}
				break;
		}

		httpServletResponse.setContentType("application/vnd.ms-excel");
		httpServletResponse.setHeader("Content-Disposition", "attachment;filename=" + URLEncoder.encode(fileName + "(" + staticsKnowledgeVO.getStartDate().replace("-", "") + " - " + staticsKnowledgeVO.getEndDate().replace("-", "") + ")", "UTF-8").replace("+", "%20") + ".xlsx");

		workbook.write(httpServletResponse.getOutputStream());
	}
}
