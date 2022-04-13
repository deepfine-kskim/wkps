package egovframework.com.wkp.kno.web;

import egovframework.com.cmm.EgovComException;
import egovframework.com.cmm.EgovWebUtil;
import egovframework.com.cmm.service.*;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.com.utl.wed.comm.ListWithPageNavigation;
import egovframework.com.wkp.cmm.service.*;
import egovframework.com.wkp.kno.service.*;
import egovframework.com.wkp.kno.service.impl.KnowledgeDAO;
import egovframework.com.wkp.usr.service.EgovOrgService;
import egovframework.com.wkp.usr.service.EgovUserService;
import egovframework.com.wkp.usr.service.OrgVO;
import egovframework.com.wkp.usr.service.UserVO;
import kr.dogfoot.hwplib.object.HWPFile;
import kr.dogfoot.hwplib.object.bindata.EmbeddedBinaryData;
import kr.dogfoot.hwplib.object.bodytext.Section;
import kr.dogfoot.hwplib.object.bodytext.control.Control;
import kr.dogfoot.hwplib.object.bodytext.control.ControlTable;
import kr.dogfoot.hwplib.object.bodytext.control.ControlType;
import kr.dogfoot.hwplib.object.bodytext.control.gso.*;
import kr.dogfoot.hwplib.object.bodytext.control.gso.shapecomponent.ShapeComponentNormal;
import kr.dogfoot.hwplib.object.bodytext.control.gso.shapecomponenteach.polygon.PositionXY;
import kr.dogfoot.hwplib.object.bodytext.control.table.Cell;
import kr.dogfoot.hwplib.object.bodytext.control.table.Row;
import kr.dogfoot.hwplib.object.bodytext.paragraph.Paragraph;
import kr.dogfoot.hwplib.object.bodytext.paragraph.text.HWPChar;
import kr.dogfoot.hwplib.object.bodytext.paragraph.text.HWPCharType;
import kr.dogfoot.hwplib.object.docinfo.BorderFill;
import kr.dogfoot.hwplib.object.docinfo.CharShape;
import kr.dogfoot.hwplib.object.docinfo.ParaShape;
import kr.dogfoot.hwplib.object.docinfo.parashape.Alignment;
import kr.dogfoot.hwplib.reader.HWPReader;
import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.fit.pdfdom.PDFDomTree;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.support.RequestContextUtils;
import org.zwobble.mammoth.DocumentConverter;
import org.zwobble.mammoth.Result;

import javax.annotation.Resource;
import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.TransformerException;
import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.*;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/kno")
public class EgovKnowledgeController {

    private static final Logger LOGGER = LoggerFactory.getLogger(EgovKnowledgeController.class);

    @Resource(name = "knowledgeDAO")
    private KnowledgeDAO knowledgeDAO;

    @Resource(name = "knowledgeService")
    private EgovKnowledgeService knowledgeService;

    @Resource(name = "EgovFileMngService")
    private EgovFileMngService fileMngService;

    @Resource(name = "EgovFileMngUtil")
    private EgovFileMngUtil fileUtil;

    @Resource(name = "commonService")
    private EgovCommonService commonService;
    
	@Resource(name = "orgService")
	private EgovOrgService orgService;

    @Resource(name = "messengerService")
    private MessengerService messengerService;

    @Resource(name = "userService")
    private EgovUserService userService;

    /**
     * 지식백과 > 목록
     * @return View Page
     */
    @RequestMapping("/knowledgeList.do")
    public String knowledgeList(@ModelAttribute("knowledgeVO") KnowledgeVO knowledgeVO
            , @RequestParam(value = "errMsg", required = false) String errMsg
    		, Model model
    		, HttpServletRequest request) {
        try {
        	
        	Map<String, ?> flashMap = RequestContextUtils.getInputFlashMap(request);
             
            if(flashMap != null) {                 
            	knowledgeVO.setKnowlgMapType((String) flashMap.get("knowlgMapType"));
            }
             
            UserVO user = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();
            KnowledgeMapVO knowledgeMapVO = new KnowledgeMapVO();

            if (knowledgeVO.getKnowlgMapType() != null) {
                knowledgeMapVO.setKnowlgMapType(knowledgeVO.getKnowlgMapType());
                model.addAttribute("knowlgMapType", knowledgeVO.getKnowlgMapType());
            } else {
                knowledgeVO.setKnowlgMapType("REPORT");
                knowledgeMapVO.setKnowlgMapType("REPORT");
                model.addAttribute("knowlgMapType", "REPORT");
            }

            if (knowledgeVO.getKnowlgMapNo() != 0) {
                model.addAttribute("knowlgMap", knowledgeService.selectKnowledgeMap(knowledgeVO.getKnowlgMapNo()));
            } else {
            	KnowledgeMapVO knowlgMap = new KnowledgeMapVO();
            	knowlgMap.setKnowlgMapNo(0);
                model.addAttribute("knowlgMap", knowlgMap);
            }

            if (knowledgeVO.getPage() == null || knowledgeVO.getPage() == 0) {
                knowledgeVO.setPage(1);
            }
            
			if(errMsg != null) {
				model.addAttribute("errMsg", errMsg);
			}

			//System.out.println("knowledgeVO - " + knowledgeVO);
			
            List<KnowledgeMapVO> knowledgeMapList = knowledgeService.selectKnowledgeMapList(knowledgeMapVO);
            ListWithPageNavigation<KnowledgeVO> knowledgeList = knowledgeService.selectKnowledgeList(knowledgeVO);
            
            model.addAttribute("knowledgeVO", knowledgeVO);
            
            model.addAttribute("searchInfo", knowledgeVO.getSearchText());
            if(knowledgeVO.getSearchType() != null) {
            	model.addAttribute("searchType", knowledgeVO.getSearchType());
            }
            if(knowledgeVO.getSearchText() != null) {
            	model.addAttribute("searchText", knowledgeVO.getSearchText());
            }
            if(knowledgeVO.getSearchDate() != null) {
            	model.addAttribute("searchDate", knowledgeVO.getSearchDate());
            }
            if(knowledgeVO.getSearchWriter() != null) {
            	model.addAttribute("searchWriter", knowledgeVO.getSearchWriter());
            }
            if(knowledgeVO.getStartDate() != null) {
            	model.addAttribute("startDate", knowledgeVO.getStartDate());
            }
            if(knowledgeVO.getEndDate() != null) {
            	model.addAttribute("endDate", knowledgeVO.getEndDate());
            }
            if(knowledgeVO.getUserList() != null) {
            	model.addAttribute("userList", knowledgeVO.getUserList());
            }
            
            Boolean isInterests = false;
            knowledgeVO.setRegisterId(user.getSid());
            if(knowledgeService.selectInterests(knowledgeVO) != null) {
            	isInterests = true;
            }
            
			/*
			 * GroupVO groupVO = new GroupVO(); groupVO.setRegisterId(userVO.getSid());
			 * List<GroupVO> groupList; groupList = commonService.selectGroupList(groupVO);
			 */
            
			List<ExcellenceOrgVO> excellenceOrgList = commonService.selectExcellenceOrgList(new ExcellenceOrgVO());
            List<ExcellenceUserVO> excellenceUserList = commonService.selectExcellenceUserList(new ExcellenceUserVO());
            
            OrgVO orgVO = new OrgVO();
            orgVO.setOuLevel(2);
            List<OrgVO> topList = orgService.selectOrgList(orgVO);
            
            orgVO.setOuLevel(3);
            List<OrgVO> parentList = orgService.selectOrgList(orgVO);
            
            orgVO.setOuLevel(4);
            List<OrgVO> childList = orgService.selectOrgList(orgVO);

            parentList.forEach(parent -> {
                String ouCode = parent.getOuCode();
                List<OrgVO> list = childList.stream().filter(child -> ouCode.equals(child.getParentOuCode())).collect(Collectors.toList());
                parent.setNextDepthList(list);
            });

            topList.forEach(top -> {
                String ouCode = top.getOuCode();
                List<OrgVO> list = parentList.stream().filter(parent -> ouCode.equals(parent.getParentOuCode())).collect(Collectors.toList());
                top.setNextDepthList(list);
            });

            model.addAttribute("knowledgeMapList", knowledgeMapList);
            model.addAttribute("knowledgeList", knowledgeList);
            model.addAttribute("isInterests", isInterests);
            model.addAttribute("excellenceUserList", excellenceUserList);
            model.addAttribute("excellenceOrgList", excellenceOrgList);
            model.addAttribute("topList", topList);
        } catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}
        return "/com/wkp/kno/EgovKnowledgeList";
    }

    /**
     * 지식백과 > 등록/수정 > 관련지식
     * @return JSON
     */
    @RequestMapping("/relateKnowledgeList.do")
    public ModelAndView relateKnowledgeList(@ModelAttribute("knowledgeVO") KnowledgeVO knowledgeVO, Model model) {

        ModelAndView mav = new ModelAndView("jsonView");
        try {
            knowledgeVO.setItemCountPerPage(knowledgeDAO.selectKnowledgeListCount(knowledgeVO));
            knowledgeVO.setItemOffset(0);
            List<KnowledgeVO> knowledgeList = knowledgeDAO.selectKnowledgeList(knowledgeVO);
            model.addAttribute("knowledgeList", knowledgeList);
        } catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}

        return mav;
    }

    /**
     * 지식백과 > 상세
     * @return View Page
     */
    @RequestMapping("/knowledgeDetail.do")
    public String knowledgeDetail(@ModelAttribute("knowledgeVO") KnowledgeVO knowledgeVO
            , @RequestParam(value = "knowledgeNo", required = false) Long knowledgeNo
            , @RequestParam(value = "cmmntyNo", required = false) Long cmmntyNo
            , @RequestParam(value = "title", required = false) String title
            , Model model
            , RedirectAttributes redirect) {

        UserVO user = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();

        if (title != null) {
            knowledgeVO.setTitle(title);
        }

        if (knowledgeNo != null) {
            knowledgeVO.setKnowlgNo(knowledgeNo);
        }

        if (cmmntyNo != null) {
            knowledgeVO.setCmmntyNo(cmmntyNo);
        }

        KnowledgeVO knowledgeDetail = knowledgeService.selectKnowledgeDetail(knowledgeVO);
        String referer = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest().getHeader("referer");

        if (knowledgeDetail == null) {
            redirect.addFlashAttribute("errMsg", "접근할 수 없는 지식입니다.");
            if (referer != null) {
                return "redirect:" + referer;
            }
            return "redirect:/kno/knowledgeList.do";
        }

        // 해당 지식의 공개범위가 전체(의회미포함)인 경우
        if ("B".equals(knowledgeDetail.getRlsYn())) {
            // 의회사무처 부서 코드 : 6410073 (임시 하드코딩, 의회사무처 부서 코드 변경 시 해당 값도 변경 필요함)
            OrgVO TopOrg = orgService.selectTopOrgByOuCode(user.getOuCode());
            if ("6410073".equals(TopOrg.getOuCode())) {
                redirect.addFlashAttribute("errMsg", "열람 권한이 없습니다.");
                if (referer != null) {
                    return "redirect:" + referer;
                }
                return "redirect:/kno/knowledgeList.do";
            }
        }

        // 해당 지식의 공개범위가 지정인 경우
        if (!user.getRoleCd().equals("ROLE_ADMIN") && !user.getSid().equals(knowledgeDetail.getRegisterId()) && knowledgeDetail.getRlsYn().equals("N")) {
            TargetVO targetVO = new TargetVO();
            targetVO.setTargetNo(knowledgeDetail.getTargetNo());
            List<TargetVO> targetList = commonService.selectTargetList(targetVO);

            String sid = user.getSid();
            String ouCode = user.getOuCode();
            Boolean result = false;
            int i = 0;
            while (i < targetList.size()) {
                if (targetList.get(i).getTargetTypeCd().equals("USER")) {
                    result = targetList.get(i).getTargetCode().equals(sid);
                }

                if (targetList.get(i).getTargetTypeCd().equals("ORG")) {
                    result = targetList.get(i).getTargetCode().equals(ouCode);
                }

                if (result) {
                    break;
                } else {
                    i++;
                }
            }

            if (!result) {
                redirect.addFlashAttribute("errMsg", "열람 권한이 없습니다.");
                if (referer != null) {
                    return "redirect:" + referer;
                }
                return "redirect:/kno/knowledgeList.do";
            }
        }

        /* 조회수 카운트 */
        KnowledgeVO knowledgeViewVO = new KnowledgeVO();
        knowledgeViewVO.setKnowlgNo(knowledgeDetail.getKnowlgNo());
        knowledgeViewVO.setTitle(knowledgeDetail.getTitle());
        knowledgeViewVO.setRegisterId(user.getSid());
        if (knowledgeService.countKnowledgeView(knowledgeViewVO) == 0) {
            knowledgeService.insertKnowledgeView(knowledgeViewVO);
        }

        if (knowledgeVO.getPage() != null) {
            knowledgeDetail.setPage(knowledgeVO.getPage());
        }

        if (knowledgeVO.getSearchText() != null) {
            knowledgeDetail.setSearchText(knowledgeVO.getSearchText());
        }

        FileVO fileVO = new FileVO();
        fileVO.setAtchFileNo(knowledgeDetail.getAtchFileNo());
        List<FileVO> fileList = fileMngService.selectFileInfs(fileVO);

        List<KnowledgeContentsVO> knowledgeContentsList = knowledgeService.selectKnowledgeContentsList(knowledgeDetail);

        List<String> relateKnowledgeList = knowledgeService.selectRelateKnowledgeList(knowledgeDetail.getRelateKnowlgNo());

        List<RelateKnowlgVO> relateKnowlgVO = knowledgeService.selectRelateKnowledgeListDelChk(knowledgeDetail.getRelateKnowlgNo());

        List<KnowledgeVO> knowledgeHistoryList = knowledgeService.selectKnowledgeHistoryList(knowledgeDetail);

        KnowledgeMapVO knowledgeMapVO = new KnowledgeMapVO();
        knowledgeMapVO.setKnowlgMapType(knowledgeDetail.getKnowlgMapType());
        List<KnowledgeMapVO> knowledgeMapList = knowledgeService.selectKnowledgeMapList(knowledgeMapVO);

        int recommendCount = knowledgeService.selectRecommendCount(knowledgeVO);

        Boolean isRecommend = false;
        knowledgeVO.setRegisterId(user.getSid());
        if (knowledgeService.selectRecommend(knowledgeVO) != null) {
            isRecommend = true;
        }

        if (knowledgeVO.getCmmntyNo() != 0) {
            model.addAttribute("cmmntyNo", knowledgeVO.getCmmntyNo());
        }

        List<ExcellenceOrgVO> excellenceOrgList = commonService.selectExcellenceOrgList(new ExcellenceOrgVO());
        List<ExcellenceUserVO> excellenceUserList = commonService.selectExcellenceUserList(new ExcellenceUserVO());

        // 담당자가 본인이고, 본인이 속한 부서의 지식 or 개인행정지식 탭의 지식
        boolean isOwner = (user.getSid().equals(knowledgeDetail.getOwnerId()) && user.getOuCode().equals(knowledgeDetail.getOuCode())) || "PERSONAL".equals(knowledgeDetail.getKnowlgMapType());

        model.addAttribute("relateKnowlgVO", relateKnowlgVO);
        model.addAttribute("knowledgeDetail", knowledgeDetail);
        model.addAttribute("knowledgeContentsList", knowledgeContentsList);
        model.addAttribute("relateKnowledgeList", relateKnowledgeList);
        model.addAttribute("fileList", fileList);
        model.addAttribute("knowledgeHistoryList", knowledgeHistoryList);
        model.addAttribute("knowledgeMapList", knowledgeMapList);
        model.addAttribute("recommendCount", recommendCount);
        model.addAttribute("isRecommend", isRecommend);
        model.addAttribute("excellenceUserList", excellenceUserList);
        model.addAttribute("excellenceOrgList", excellenceOrgList);
        model.addAttribute("user", user);
        model.addAttribute("lastUpdated", knowledgeService.selectKnowledgeLastUpdated(knowledgeDetail));
        model.addAttribute("knowlgMapNo", knowledgeVO.getKnowlgMapNo());
        model.addAttribute("isOwner", isOwner);

        return "/com/wkp/kno/EgovKnowledgeDetail";
    }

    /**
     * 지식백과 > 상세 > 지식이력
     * @return View Page
     */
    @RequestMapping("/knowledgeHistory.do")
    public String knowledgeHistory(@ModelAttribute("knowledgeVO") KnowledgeVO knowledgeVO, Model model) {
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

        return "/com/wkp/kno/EgovKnowledgeHistory";
    }

    /**
     * 지식백과 > 등록/수정 > 지식맵 조회
     * @return JSON
     */
    @RequestMapping("/knowledgeMap.do")
    public ModelAndView knowledgeMap(@ModelAttribute("knowledgeMapVO") KnowledgeMapVO knowledgeMapVO, Model model) {

        ModelAndView mav = new ModelAndView("jsonView");
        
        try {
            List<KnowledgeMapVO> knowledgeMapList = knowledgeService.selectKnowledgeMapList(knowledgeMapVO);
            mav.addObject("knowledgeMapList", knowledgeMapList);
        } catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}

        return mav;
    }

    /**
     * 지식백과 > 등록
     * @return View Page
     */
    @RequestMapping("/insertKnowledgeView.do")
    public String insertKnowledgeView(@ModelAttribute("knowledgeVO") KnowledgeVO knowledgeVO
            , @RequestParam(value = "cmmntyNo", required = false) Long cmmntyNo
    		, Model model) {

		try {
			if(cmmntyNo != null) {
				model.addAttribute("cmmntyNo", cmmntyNo);
			}			
			
			UserVO userVO = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();
			
			GroupVO groupVO = new GroupVO();
			groupVO.setRegisterId(userVO.getSid());
			List<GroupVO> groupList;
			groupList = commonService.selectGroupList(groupVO);
			
			List<ExcellenceOrgVO> excellenceOrgList = commonService.selectExcellenceOrgList(new ExcellenceOrgVO());
            List<ExcellenceUserVO> excellenceUserList = commonService.selectExcellenceUserList(new ExcellenceUserVO());
            
            OrgVO orgVO = new OrgVO();
            orgVO.setOuLevel(2);
            List<OrgVO> topList = orgService.selectOrgList(orgVO);
            
            orgVO.setOuLevel(3);
            List<OrgVO> parentList = orgService.selectOrgList(orgVO);
            
            orgVO.setOuLevel(4);
            List<OrgVO> childList = orgService.selectOrgList(orgVO);

            parentList.forEach(parent -> {
                String ouCode = parent.getOuCode();
                List<OrgVO> list = childList.stream().filter(child -> ouCode.equals(child.getParentOuCode())).collect(Collectors.toList());
                parent.setNextDepthList(list);
            });

            topList.forEach(top -> {
                String ouCode = top.getOuCode();
                List<OrgVO> list = parentList.stream().filter(parent -> ouCode.equals(parent.getParentOuCode())).collect(Collectors.toList());
                top.setNextDepthList(list);
            });
            
			/*
			 * knowledgeMapVO.setUpNo(knowledgeVO.getUpNo());
			 * knowledgeMapVO.setKnowlgMapNo(knowledgeVO.getKnowlgMapNo());
			 */
            
            if (knowledgeVO.getKnowlgMapNo() != 0) {
                model.addAttribute("knowlgMap", knowledgeService.selectKnowledgeMap(knowledgeVO.getKnowlgMapNo()));
            } else {
            	KnowledgeMapVO knowlgMap = new KnowledgeMapVO();
            	knowlgMap.setKnowlgMapNo(0);
                model.addAttribute("knowlgMap", knowlgMap);
            }

            // 의회사무처 부서 코드 : 6410073 (임시 하드코딩, 의회사무처 부서 코드 변경 시 해당 값도 변경 필요함)
            OrgVO TopOrg = orgService.selectTopOrgByOuCode(userVO.getOuCode());
            boolean isIgnoreOrg = "6410073".equals(TopOrg.getOuCode());
            
			model.addAttribute("groupList", groupList);
            model.addAttribute("excellenceUserList", excellenceUserList);
            model.addAttribute("excellenceOrgList", excellenceOrgList);
            model.addAttribute("topList", topList);
            model.addAttribute("knowledgeVO", knowledgeVO);
            model.addAttribute("isIgnoreOrg", isIgnoreOrg);

		} catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}
		
		//System.out.println("knowledgeVO insertKnowledgeView - " + knowledgeVO);
		
        return "/com/wkp/kno/EgovKnowledgeRegist";
    }

    /**
     * 지식백과 > 데이터 등록
     * @return Redirect
     */
    @RequestMapping("/insertKnowledge.do")
    public String insertKnowledge(final MultipartHttpServletRequest multiRequest
    		, @ModelAttribute("knowledgeVO") KnowledgeVO knowledgeVO
    		, RedirectAttributes redirectAttributes) {

        try {
			UserVO userVO = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();
			knowledgeVO.setRegisterId(userVO.getSid());
			knowledgeVO.setOwnerId(userVO.getSid());
			knowledgeVO.setOuCode(userVO.getOuCode());
            List<FileVO> file = new ArrayList<FileVO>();
            long atchFileNo = 0;
			final Map<String, MultipartFile> files = multiRequest.getFileMap();
            
            List<MultipartFile> mFiles = multiRequest.getFiles("atchFile");
            
            files.clear();
            
            if (!mFiles.isEmpty()) {
	            for(MultipartFile mFile : mFiles) {
	            	files.put(mFile.getOriginalFilename(), mFile);
	            }
	            
	            Iterator<String> mapIter = files.keySet().iterator();
	            while(mapIter.hasNext()){
	                String key = mapIter.next();
	                MultipartFile value = files.get(key);
	                //System.out.println(key+" : " + value);
	            }
	            file = fileUtil.parseFileInf(files, "KNO_", 0, "");
	            atchFileNo = fileMngService.insertFileInfs(file);
            }
            knowledgeVO.setAtchFileNo(atchFileNo);
            
			/*
			 * if (!files.isEmpty()) { file = fileUtil.parseFileInf(files, "KNO_", 0, "");
			 * atchFileNo = fileMngService.insertFileInfs(file); }
			 * knowledgeVO.setAtchFileNo(atchFileNo);
			 */

            if (knowledgeVO.getCopertnWritngYn() == null) {
                knowledgeVO.setCopertnWritngYn("N");
            }

            if (knowledgeVO.getRelateKnowledgeList() != null) {
                long relateKnowlgNo = knowledgeService.insertRelateKnowledge(knowledgeVO);
                knowledgeVO.setRelateKnowlgNo(relateKnowlgNo);
            }

            if (knowledgeVO.getRlsYn().equals("N")) {
            	//System.out.println("1");
                TargetVO targetVO = new TargetVO();
                
                targetVO.setOrgList(knowledgeVO.getOrgList());
                targetVO.setUserList(knowledgeVO.getUserList());

                //System.out.println("2");
    			GroupVO groupVO = new GroupVO();
    			groupVO.setRegisterId(userVO.getSid());
    			List<String> orgList = new ArrayList<>();
    			List<String> userList = new ArrayList<>();
    			//System.out.println("3");
    			
    			//System.out.println("knowledgeVO.getGroupList() - " + knowledgeVO.getGroupList());
    			if(knowledgeVO.getGroupList() != null) {
	                for(String s:knowledgeVO.getGroupList()){
	                	//System.out.println("s - " + s);
	                	groupVO.setGroupNo(Long.parseLong(s));
	                	List<GroupVO> group = commonService.selectGroupDetail(groupVO);
	                	for(GroupVO gv:group) {
	                		if(gv.getTargetTypeCd().equals("ORG")) {
	                			if(targetVO.getOrgList() != null) {
	                				targetVO.getOrgList().add(gv.getTargetCode());
	                			} else {
	                				orgList.add(gv.getTargetCode());
	                			}                			
	                		}
	                		
	                		if(gv.getTargetTypeCd().equals("USER")) {
	                			if(targetVO.getUserList() != null) {
	                				targetVO.getUserList().add(gv.getTargetCode());
	                			} else {
	                				userList.add(gv.getTargetCode());
	                			}
	                		}
	                	}
	                }
    			}
                //System.out.println("4");
                
                if(orgList.size() > 0) {
                	targetVO.setOrgList(orgList);
                }
                
                if(userList.size() > 0) {
                	targetVO.setUserList(userList);
                }

                long targetNo = commonService.insertTarget(targetVO);
                knowledgeVO.setTargetNo(targetNo);
            }

            int result = knowledgeService.insertKnowledge(knowledgeVO);

            if (result > 0) {
                KnowledgeContentsVO knowledgeContentsVO = new KnowledgeContentsVO();

                if (knowledgeVO.getCont() != null) {
                    int start = 0;
                    int end = 0;
                    int next = 0;
                    int sortOrdr = 0;
                    long upNo = 0;
                    String subTitle = "";
                    String cont = "";

                    while (start != -1) {
                        start = knowledgeVO.getCont().indexOf("[==", start);
                        if (start != -1) {
                            end = knowledgeVO.getCont().indexOf("==]", start);
                            subTitle = knowledgeVO.getCont().substring(start + 3, end);
                            sortOrdr += 1;
                        } else {
                            end = -3;
                            subTitle = "";
                            sortOrdr = 1;
                        }

                        next = knowledgeVO.getCont().indexOf("[==", end);

                        if (next != -1) {
                            cont = knowledgeVO.getCont().substring(end + 3, next);
                        } else {
                            cont = knowledgeVO.getCont().substring(end + 3, knowledgeVO.getCont().length());
                        }

                        // 목차 아래에 빈 줄이 생기는 현상 제거
                        if (knowledgeVO.getCont().indexOf("[==", start) != -1) {
                            int a = cont.indexOf("</p>");
                            int b = cont.indexOf("<br />");
                            if (a != -1 && b != -1) {
                                if (a > b) {
                                    cont = cont.replaceFirst("<br />", "");
                                }
                            }
                            cont = cont.replaceFirst("</p>", "");
                        }

                        knowledgeContentsVO.setKnowlgNo(knowledgeVO.getKnowlgNo());
                        knowledgeContentsVO.setTitle(knowledgeVO.getTitle());
                        knowledgeContentsVO.setSortOrdr(sortOrdr);
                        knowledgeContentsVO.setSubtitle(subTitle);
                        knowledgeContentsVO.setCont(cont);
                        knowledgeContentsVO.setUpNo(upNo);
                        knowledgeContentsVO.setRegisterId(knowledgeVO.getRegisterId());

                        knowledgeService.insertKnowledgeContents(knowledgeContentsVO);

                        start = next;
                    }
                }

                knowledgeVO.setMileageType("NEW");
                knowledgeVO.setMileageScore(2.0f);
                knowledgeService.insertUserMileage(knowledgeVO);
                knowledgeService.insertOrgMileage(knowledgeVO);

                /* 부서 지식 관리자 조회 후 존재하는 경우에 알림 전송 */
                if (!"PERSONAL".equals(knowledgeVO.getKnowlgMapType())) {
                    List<UserVO> orgKnowledgeManagerList = userService.selectOrgKnowledgeManager(userVO);
                    orgKnowledgeManagerList.forEach(item -> {
                        MessengerVO messengerVO = new MessengerVO();
                        messengerVO.setSndUser(userVO.getDisplayName());
                        messengerVO.setRecvId(item.getSid());
                        messengerVO.setDocTitle("[도정지식포털 알림]");
                        messengerVO.setDocDesc("[도정지식포털] 부서 지식이 등록 되었습니다.");
                        messengerVO.setDocUrl("http://105.0.1.229/adm/approvalDetail.do?knowlgNo=" + knowledgeVO.getKnowlgNo());
                        messengerService.insert(messengerVO);
                    });
                }

                redirectAttributes.addFlashAttribute("knowlgMapType", knowledgeVO.getKnowlgMapType());
            }
        } catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		} catch (IOException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		} catch (EgovComException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}

        return "redirect:/kno/knowledgeList.do";
    }

    /**
     * 지식백과 > 수정
     * @return View Page
     */
    @RequestMapping("/updateKnowledgeView.do")
    public String updateKnowledgeView(@ModelAttribute("knowledgeVO") KnowledgeVO knowledgeVO
    		, Model model) {
    	
        try {
        	KnowledgeVO knowledgeDetail = knowledgeService.selectKnowledgeDetail(knowledgeVO);

            FileVO fileVO = new FileVO();
            fileVO.setAtchFileNo(knowledgeDetail.getAtchFileNo());
            List<FileVO> fileList = fileMngService.selectFileInfs(fileVO);

            List<KnowledgeContentsVO> knowledgeContentsList;
            if (knowledgeVO.getRequestNo() != null) {
                knowledgeContentsList = knowledgeService.selectModificationRequestContentList(knowledgeVO);
            } else {
                knowledgeContentsList = knowledgeService.selectKnowledgeContentsList(knowledgeDetail);
            }

            List<String> relateKnowledgeList = knowledgeService.selectRelateKnowledgeList(knowledgeDetail.getRelateKnowlgNo());
            
            List<RelateKnowlgVO> relateKnowlgVo = knowledgeService.selectRelateKnowledgeListDelChk(knowledgeDetail.getRelateKnowlgNo());

            List<TargetVO> targetVOList = commonService.selectDisplayTargetList(knowledgeDetail.getTargetNo());
            
            knowledgeDetail.setRelateKnowledgeList(relateKnowledgeList);
            
            KnowledgeMapVO knowledgeMapVO = new KnowledgeMapVO();

            if (knowledgeVO.getKnowlgMapType() != null) {
                knowledgeMapVO.setKnowlgMapType(knowledgeVO.getKnowlgMapType());
                model.addAttribute("knowlgMapType", knowledgeVO.getKnowlgMapType());
            } else {
                knowledgeVO.setKnowlgMapType("REPORT");
                knowledgeMapVO.setKnowlgMapType("REPORT");
                model.addAttribute("knowlgMapType", "REPORT");
            }
            
            UserVO userVO = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();
			
			GroupVO groupVO = new GroupVO();
			groupVO.setRegisterId(userVO.getSid());
			List<GroupVO> groupList;
			groupList = commonService.selectGroupList(groupVO);

            
            List<KnowledgeMapVO> knowledgeMapList = knowledgeService.selectKnowledgeMapList(knowledgeMapVO);
			List<ExcellenceOrgVO> excellenceOrgList = commonService.selectExcellenceOrgList(new ExcellenceOrgVO());
            List<ExcellenceUserVO> excellenceUserList = commonService.selectExcellenceUserList(new ExcellenceUserVO());

            OrgVO orgVO = new OrgVO();
            orgVO.setOuLevel(2);
            List<OrgVO> topList = orgService.selectOrgList(orgVO);
            
            orgVO.setOuLevel(3);
            List<OrgVO> parentList = orgService.selectOrgList(orgVO);
            
            orgVO.setOuLevel(4);
            List<OrgVO> childList = orgService.selectOrgList(orgVO);

            parentList.forEach(parent -> {
                String ouCode = parent.getOuCode();
                List<OrgVO> list = childList.stream().filter(child -> ouCode.equals(child.getParentOuCode())).collect(Collectors.toList());
                parent.setNextDepthList(list);
            });

            topList.forEach(top -> {
                String ouCode = top.getOuCode();
                List<OrgVO> list = parentList.stream().filter(parent -> ouCode.equals(parent.getParentOuCode())).collect(Collectors.toList());
                top.setNextDepthList(list);
            });

            // 의회사무처 부서 코드 : 6410073 (임시 하드코딩, 의회사무처 부서 코드 변경 시 해당 값도 변경 필요함)
            OrgVO TopOrg = orgService.selectTopOrgByOuCode(userVO.getOuCode());
            boolean isIgnoreOrg = "6410073".equals(TopOrg.getOuCode());

            model.addAttribute("knowledgeDetail", knowledgeDetail);
            model.addAttribute("relateKnowlgVo", relateKnowlgVo);
            model.addAttribute("knowledgeContentsList", knowledgeContentsList);
            model.addAttribute("relateKnowledgeList", relateKnowledgeList);
            model.addAttribute("fileList", fileList);
            model.addAttribute("knowledgeMapList", knowledgeMapList);
            model.addAttribute("excellenceOrgList", excellenceOrgList);
            model.addAttribute("excellenceUserList", excellenceUserList);
            model.addAttribute("topList", topList);
            model.addAttribute("groupList", groupList);
            model.addAttribute("targetVOList", targetVOList);
            model.addAttribute("isOwner", true);
            model.addAttribute("isIgnoreOrg", isIgnoreOrg);

        } catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}
        
        return "/com/wkp/kno/EgovKnowledgeUpdate";
    }

    /**
     * 지식백과 > 수정
     * @return View Page
     */
    @RequestMapping("/updateKnowledgeRequestView.do")
    public String updateKnowledgeRequestView(@ModelAttribute("knowledgeVO") KnowledgeVO knowledgeVO
            , Model model) {

        try {
            KnowledgeVO knowledgeDetail = knowledgeService.selectKnowledgeDetail(knowledgeVO);

            FileVO fileVO = new FileVO();
            fileVO.setAtchFileNo(knowledgeDetail.getAtchFileNo());
            List<FileVO> fileList = fileMngService.selectFileInfs(fileVO);

            List<KnowledgeContentsVO> knowledgeContentsList = knowledgeService.selectKnowledgeContentsList(knowledgeDetail);

            List<String> relateKnowledgeList = knowledgeService.selectRelateKnowledgeList(knowledgeDetail.getRelateKnowlgNo());

            List<RelateKnowlgVO> relateKnowlgVo = knowledgeService.selectRelateKnowledgeListDelChk(knowledgeDetail.getRelateKnowlgNo());

            List<TargetVO> targetVOList = commonService.selectDisplayTargetList(knowledgeDetail.getTargetNo());

            knowledgeDetail.setRelateKnowledgeList(relateKnowledgeList);

            KnowledgeMapVO knowledgeMapVO = new KnowledgeMapVO();

            if (knowledgeVO.getKnowlgMapType() != null) {
                knowledgeMapVO.setKnowlgMapType(knowledgeVO.getKnowlgMapType());
                model.addAttribute("knowlgMapType", knowledgeVO.getKnowlgMapType());
            } else {
                knowledgeVO.setKnowlgMapType("REPORT");
                knowledgeMapVO.setKnowlgMapType("REPORT");
                model.addAttribute("knowlgMapType", "REPORT");
            }

            UserVO userVO = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();

            GroupVO groupVO = new GroupVO();
            groupVO.setRegisterId(userVO.getSid());
            List<GroupVO> groupList;
            groupList = commonService.selectGroupList(groupVO);


            List<KnowledgeMapVO> knowledgeMapList = knowledgeService.selectKnowledgeMapList(knowledgeMapVO);
            List<ExcellenceOrgVO> excellenceOrgList = commonService.selectExcellenceOrgList(new ExcellenceOrgVO());
            List<ExcellenceUserVO> excellenceUserList = commonService.selectExcellenceUserList(new ExcellenceUserVO());

            OrgVO orgVO = new OrgVO();
            orgVO.setOuLevel(2);
            List<OrgVO> topList = orgService.selectOrgList(orgVO);

            orgVO.setOuLevel(3);
            List<OrgVO> parentList = orgService.selectOrgList(orgVO);

            orgVO.setOuLevel(4);
            List<OrgVO> childList = orgService.selectOrgList(orgVO);

            parentList.forEach(parent -> {
                String ouCode = parent.getOuCode();
                List<OrgVO> list = childList.stream().filter(child -> ouCode.equals(child.getParentOuCode())).collect(Collectors.toList());
                parent.setNextDepthList(list);
            });

            topList.forEach(top -> {
                String ouCode = top.getOuCode();
                List<OrgVO> list = parentList.stream().filter(parent -> ouCode.equals(parent.getParentOuCode())).collect(Collectors.toList());
                top.setNextDepthList(list);
            });

            model.addAttribute("knowledgeDetail", knowledgeDetail);
            model.addAttribute("relateKnowlgVo", relateKnowlgVo);
            model.addAttribute("knowledgeContentsList", knowledgeContentsList);
            model.addAttribute("relateKnowledgeList", relateKnowledgeList);
            model.addAttribute("fileList", fileList);
            model.addAttribute("knowledgeMapList", knowledgeMapList);
            model.addAttribute("excellenceOrgList", excellenceOrgList);
            model.addAttribute("excellenceUserList", excellenceUserList);
            model.addAttribute("topList", topList);
            model.addAttribute("groupList", groupList);
            model.addAttribute("targetVOList", targetVOList);
            model.addAttribute("isOwner", false);
        } catch (NullPointerException e) {
            LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
        }

        return "/com/wkp/kno/EgovKnowledgeUpdate";
    }

    /**
     * 지식백과 > 데이터 수정
     * @return Redirect
     */
    @RequestMapping("/insertUpdateKnowledge.do")
    public String insertUpdateKnowledge(final MultipartHttpServletRequest multiRequest
    		, @ModelAttribute("knowledgeVO") KnowledgeVO knowledgeVO
    		, RedirectAttributes redirectAttributes) {

        try {
        	KnowledgeVO knowledgeDetail = knowledgeService.selectKnowledgeDetail(knowledgeVO);
        	
			UserVO userVO = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();
			
			knowledgeVO.setRegisterId(userVO.getSid());
            knowledgeVO.setOwnerId(userVO.getSid());
			knowledgeVO.setOuCode(userVO.getOuCode());

            List<FileVO> file = new ArrayList<FileVO>();
            
            long atchFileNo = 0;
			final Map<String, MultipartFile> files = multiRequest.getFileMap();
            
            List<MultipartFile> mFiles = multiRequest.getFiles("atchFile");
            files.clear();
            
            //System.out.println("mFiles.isEmpty() - " + mFiles.isEmpty());
            
            if (mFiles.isEmpty() != true) {
        		if((Long) knowledgeDetail.getAtchFileNo() != 0) {
        			//System.out.println("1111");
    	            for(MultipartFile mFile : mFiles) {
    	            	files.put(mFile.getOriginalFilename(), mFile);
    	            }
    	            
    	            Iterator<String> mapIter = files.keySet().iterator();
    	            while(mapIter.hasNext()){
    	                String key = mapIter.next();
    	                MultipartFile value = files.get(key);
    	            }	            
    	            
    	            file = fileUtil.parseFileInfs(knowledgeDetail.getAtchFileNo(), files, "KNO_", 0, "");
    	            fileMngService.updateFileInfs(file);
            	} else {
            		//System.out.println("2222");
            		for(MultipartFile mFile : mFiles) {
    	            	files.put(mFile.getOriginalFilename(), mFile);
    	            }
    	            
    	            Iterator<String> mapIter = files.keySet().iterator();
    	            while(mapIter.hasNext()){
    	                String key = mapIter.next();
    	                MultipartFile value = files.get(key);
    	                //System.out.println(key+" : " + value);
    	            }
    	            file = fileUtil.parseFileInf(files, "KNO_", 0, "");
    	            atchFileNo = fileMngService.insertFileInfs(file);
    	            //System.out.println("atchFileNo - " + atchFileNo);
    	            knowledgeVO.setAtchFileNo(atchFileNo);
            	}
            }

            if (knowledgeVO.getCopertnWritngYn() == null) {
                knowledgeVO.setCopertnWritngYn("N");
            }

            //System.out.println("knowledgeVO - " + knowledgeVO);
            //System.out.println("knowledgeDetail - " + knowledgeDetail);
            //System.out.println("knowledgeVO.getRelateKnowledgeList() - " + knowledgeVO.getRelateKnowledgeList());
            if (knowledgeVO.getRelateKnowledgeList() != null) {
                long relateKnowlgNo = knowledgeService.insertRelateKnowledge(knowledgeVO);
                knowledgeVO.setRelateKnowlgNo(relateKnowlgNo);
            }

            if (knowledgeVO.getRlsYn().equals("N")) {
            	//System.out.println("1");
                TargetVO targetVO = new TargetVO();
                
                targetVO.setOrgList(knowledgeVO.getOrgList());
                targetVO.setUserList(knowledgeVO.getUserList());

                //System.out.println("2");
    			GroupVO groupVO = new GroupVO();
    			groupVO.setRegisterId(userVO.getSid());
    			List<String> orgList = new ArrayList<>();
    			List<String> userList = new ArrayList<>();
    			//System.out.println("3");
    			
    			//System.out.println("knowledgeVO.getGroupList() - " + knowledgeVO.getGroupList());
    			if(knowledgeVO.getGroupList() != null) {
	                for(String s:knowledgeVO.getGroupList()){
	                	//System.out.println("s - " + s);
	                	groupVO.setGroupNo(Long.parseLong(s));
	                	List<GroupVO> group = commonService.selectGroupDetail(groupVO);
	                	for(GroupVO gv:group) {
	                		if(gv.getTargetTypeCd().equals("ORG")) {
	                			if(targetVO.getOrgList() != null) {
	                				targetVO.getOrgList().add(gv.getTargetCode());
	                			} else {
	                				orgList.add(gv.getTargetCode());
	                			}                			
	                		}
	                		
	                		if(gv.getTargetTypeCd().equals("USER")) {
	                			if(targetVO.getUserList() != null) {
	                				targetVO.getUserList().add(gv.getTargetCode());
	                			} else {
	                				userList.add(gv.getTargetCode());
	                			}
	                		}
	                	}
	                }
    			}
                //System.out.println("4");
                
                if(orgList.size() > 0) {
                	targetVO.setOrgList(orgList);
                }
                
                if(userList.size() > 0) {
                	targetVO.setUserList(userList);
                }

                long targetNo = commonService.insertTarget(targetVO);
                knowledgeVO.setTargetNo(targetNo);
            }

            int result = knowledgeService.insertKnowledge(knowledgeVO);

            if (result > 0) {
                KnowledgeContentsVO knowledgeContentsVO = new KnowledgeContentsVO();

                if (knowledgeVO.getCont() != null) {
                    int start = 0;
                    int end = 0;
                    int next = 0;
                    int sortOrdr = 0;
                    long upNo = 0;
                    String subTitle = "";
                    String cont = "";

                    while (start != -1) {
                        start = knowledgeVO.getCont().indexOf("[==", start);
                        if (start != -1) {
                            end = knowledgeVO.getCont().indexOf("==]", start);
                            subTitle = knowledgeVO.getCont().substring(start + 3, end);
                            sortOrdr += 1;
                        } else {
                            end = -3;
                            subTitle = "";
                            sortOrdr = 1;
                        }

                        next = knowledgeVO.getCont().indexOf("[==", end);

                        if (next != -1) {
                            cont = knowledgeVO.getCont().substring(end + 3, next);
                        } else {
                            cont = knowledgeVO.getCont().substring(end + 3, knowledgeVO.getCont().length());
                        }

                        // 목차 아래에 빈 줄이 생기는 현상 제거
                        if (knowledgeVO.getCont().indexOf("[==", start) != -1) {
                            int a = cont.indexOf("</p>");
                            int b = cont.indexOf("<br />");
                            if (a != -1 && b != -1) {
                                if (a > b) {
                                    cont = cont.replaceFirst("<br />", "");
                                }
                            }
                            cont = cont.replaceFirst("</p>", "");
                        }

                        knowledgeContentsVO.setKnowlgNo(knowledgeVO.getKnowlgNo());
                        knowledgeContentsVO.setTitle(knowledgeVO.getTitle());
                        knowledgeContentsVO.setSortOrdr(sortOrdr);
                        knowledgeContentsVO.setSubtitle(subTitle);
                        knowledgeContentsVO.setCont(cont);
                        knowledgeContentsVO.setUpNo(upNo);
                        knowledgeContentsVO.setRegisterId(knowledgeVO.getRegisterId());

                        knowledgeService.insertKnowledgeContents(knowledgeContentsVO);

                        start = next;
                    }
                }

                knowledgeVO.setMileageType("UPD");
                knowledgeVO.setMileageScore(1.0f);
                knowledgeService.insertUserMileage(knowledgeVO);
                knowledgeService.insertOrgMileage(knowledgeVO);

                /* 부서 지식 관리자 조회 후 존재하는 경우에 알림 전송 */
                if (!"PERSONAL".equals(knowledgeVO.getKnowlgMapType())) {
                    List<UserVO> orgKnowledgeManagerList = userService.selectOrgKnowledgeManager(userVO);
                    orgKnowledgeManagerList.forEach(item -> {
                        MessengerVO messengerVO = new MessengerVO();
                        messengerVO.setSndUser(userVO.getDisplayName());
                        messengerVO.setRecvId(item.getSid());
                        messengerVO.setDocTitle("[도정지식포털 알림]");
                        messengerVO.setDocDesc("[도정지식포털] 부서 지식이 수정 되었습니다.");
                        messengerVO.setDocUrl("http://105.0.1.229/adm/approvalDetail.do?knowlgNo=" + knowledgeVO.getKnowlgNo());
                        messengerService.insert(messengerVO);
                    });
                }

                redirectAttributes.addFlashAttribute("knowlgMapType", knowledgeVO.getKnowlgMapType());
            }
        } catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		} catch (IOException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		} catch (EgovComException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}

        return "redirect:/kno/knowledgeList.do";
    }

    /**
     * 지식백과 > 데이터 수정
     * @return Redirect
     */
    @RequestMapping("/insertUpdateKnowledgeRequest.do")
    public String insertUpdateKnowledgeRequest(final MultipartHttpServletRequest multiRequest, @ModelAttribute("knowledgeVO") KnowledgeVO knowledgeVO, RedirectAttributes redirectAttributes) {
        try {
            KnowledgeVO knowledgeDetail = knowledgeService.selectKnowledgeDetail(knowledgeVO);
            UserVO userVO = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();
            knowledgeVO.setRegisterId(userVO.getSid());

            List<FileVO> file = new ArrayList<FileVO>();

            long atchFileNo = 0;
            final Map<String, MultipartFile> files = multiRequest.getFileMap();

            List<MultipartFile> mFiles = multiRequest.getFiles("atchFile");
            files.clear();

            if (mFiles.isEmpty() != true) {
                if((Long) knowledgeDetail.getAtchFileNo() != 0) {
                    for(MultipartFile mFile : mFiles) {
                        files.put(mFile.getOriginalFilename(), mFile);
                    }

                    Iterator<String> mapIter = files.keySet().iterator();
                    while(mapIter.hasNext()){
                        String key = mapIter.next();
                        MultipartFile value = files.get(key);
                    }

                    file = fileUtil.parseFileInfs(knowledgeDetail.getAtchFileNo(), files, "KNO_", 0, "");
                    fileMngService.updateFileInfs(file);
                } else {
                    for(MultipartFile mFile : mFiles) {
                        files.put(mFile.getOriginalFilename(), mFile);
                    }

                    Iterator<String> mapIter = files.keySet().iterator();
                    while(mapIter.hasNext()){
                        String key = mapIter.next();
                        MultipartFile value = files.get(key);
                    }
                    file = fileUtil.parseFileInf(files, "KNO_", 0, "");
                    atchFileNo = fileMngService.insertFileInfs(file);
                    knowledgeVO.setAtchFileNo(atchFileNo);
                }
            }

            int result = knowledgeService.insertKnowledgeModificationRequest(knowledgeVO);

            if (result > 0) {
                KnowledgeContentsVO knowledgeContentsVO = new KnowledgeContentsVO();

                if (knowledgeVO.getCont() != null) {
                    int start = 0;
                    int end = 0;
                    int next = 0;
                    int sortOrdr = 0;
                    long upNo = 0;
                    String subTitle = "";
                    String cont = "";

                    while (start != -1) {
                        start = knowledgeVO.getCont().indexOf("[==", start);
                        if (start != -1) {
                            end = knowledgeVO.getCont().indexOf("==]", start);
                            subTitle = knowledgeVO.getCont().substring(start + 3, end);
                            sortOrdr += 1;
                        } else {
                            end = -3;
                            subTitle = "";
                            sortOrdr = 1;
                        }

                        next = knowledgeVO.getCont().indexOf("[==", end);

                        if (next != -1) {
                            cont = knowledgeVO.getCont().substring(end + 3, next);
                        } else {
                            cont = knowledgeVO.getCont().substring(end + 3, knowledgeVO.getCont().length());
                        }

                        // 목차 아래에 빈 줄이 생기는 현상 제거
                        if (knowledgeVO.getCont().indexOf("[==", start) != -1) {
                            int a = cont.indexOf("</p>");
                            int b = cont.indexOf("<br />");
                            if (a != -1 && b != -1) {
                                if (a > b) {
                                    cont = cont.replaceFirst("<br />", "");
                                }
                            }
                            cont = cont.replaceFirst("</p>", "");
                        }

                        knowledgeContentsVO.setRequestNo(knowledgeVO.getRequestNo());
                        knowledgeContentsVO.setSortOrdr(sortOrdr);
                        knowledgeContentsVO.setSubtitle(subTitle);
                        knowledgeContentsVO.setCont(cont);
                        knowledgeService.insertKnowledgeModificationRequestContent(knowledgeContentsVO);
                        start = next;
                    }
                }

                /* 메신저 알림 전송 */
                MessengerVO messengerVO = new MessengerVO();
                messengerVO.setSndUser(userVO.getDisplayName());
                messengerVO.setRecvId(knowledgeDetail.getOwnerId());
                messengerVO.setDocTitle("[도정지식포털 알림]");
                messengerVO.setDocDesc("[도정지식포털] 지식 수정요청이 접수되었습니다");
                messengerVO.setDocUrl("http://105.0.1.229/myp/modificationDetail.do?requestNo=" + knowledgeVO.getRequestNo());
                messengerService.insert(messengerVO);

                redirectAttributes.addFlashAttribute("knowlgMapType", knowledgeVO.getKnowlgMapType());
            }
        } catch (NullPointerException e) {
            LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
        } catch (IOException e) {
            LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
        } catch (EgovComException e) {
            LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
        }

        return "redirect:/kno/knowledgeList.do";
    }

    /**
     * 지식백과 > 편집
     * @return View Page
     */
    @RequestMapping("/modifyKnowledgeView.do")
    public String modifyKnowledgeView(@ModelAttribute("knowledgeVO") KnowledgeVO knowledgeVO
    		, Model model) {
    	
        try {
            KnowledgeVO knowledgeDetail = knowledgeService.selectKnowledgeDetail(knowledgeVO);
            KnowledgeContentsVO knowledgeContents = knowledgeService.selectKnowledgeContentsDetail(knowledgeVO);
            
			List<ExcellenceOrgVO> excellenceOrgList = commonService.selectExcellenceOrgList(new ExcellenceOrgVO());
            List<ExcellenceUserVO> excellenceUserList = commonService.selectExcellenceUserList(new ExcellenceUserVO());
           
            model.addAttribute("knowledgeDetail", knowledgeDetail);
            model.addAttribute("knowledgeContents", knowledgeContents);
            model.addAttribute("excellenceOrgList", excellenceOrgList);
            model.addAttribute("excellenceUserList", excellenceUserList);
            model.addAttribute("isOwner", true);
        } catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}
        
        return "/com/wkp/kno/EgovKnowledgeModify";
    }

    /**
     * 지식백과 > 편집
     * @return View Page
     */
    @RequestMapping("/modifyKnowledgeRequestView.do")
    public String modifyKnowledgeRequestView(@ModelAttribute("knowledgeVO") KnowledgeVO knowledgeVO
            , Model model) {

        try {
            KnowledgeVO knowledgeDetail = knowledgeService.selectKnowledgeDetail(knowledgeVO);
            KnowledgeContentsVO knowledgeContents = knowledgeService.selectKnowledgeContentsDetail(knowledgeVO);

            List<ExcellenceOrgVO> excellenceOrgList = commonService.selectExcellenceOrgList(new ExcellenceOrgVO());
            List<ExcellenceUserVO> excellenceUserList = commonService.selectExcellenceUserList(new ExcellenceUserVO());

            model.addAttribute("knowledgeDetail", knowledgeDetail);
            model.addAttribute("knowledgeContents", knowledgeContents);
            model.addAttribute("excellenceOrgList", excellenceOrgList);
            model.addAttribute("excellenceUserList", excellenceUserList);
            model.addAttribute("isOwner", false);
        } catch (NullPointerException e) {
            LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
        }

        return "/com/wkp/kno/EgovKnowledgeModify";
    }

    /**
     * 지식백과 > 데이터 편집
     * @return Redirect
     */
    @RequestMapping("/modifyKnowledge.do")
    public String modifyKnowledge(@ModelAttribute("knowledgeVO") KnowledgeVO knowledgeVO
    		, RedirectAttributes redirectAttributes) {
    	
		try {
            KnowledgeVO knowledgeDetail = knowledgeService.selectKnowledgeDetail(knowledgeVO);
        	List<KnowledgeContentsVO> knowledgeContentsList = knowledgeService.selectKnowledgeContentsList(knowledgeVO);
        	
			UserVO userVO = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();
			
			knowledgeDetail.setRegisterId(userVO.getSid());
			knowledgeDetail.setOuCode(userVO.getOuCode());
			knowledgeDetail.setAprvYn(knowledgeVO.getAprvYn());
			knowledgeDetail.setAprvCont(null);
			knowledgeDetail.setApproverId(knowledgeVO.getApproverId());
	
	        int result = knowledgeService.insertKnowledge(knowledgeDetail);
	
	        if (result > 0) {
	        	for(KnowledgeContentsVO knowledgeContents:knowledgeContentsList) {
	                knowledgeContents.setKnowlgNo(knowledgeDetail.getKnowlgNo());
	                knowledgeService.insertKnowledgeContents(knowledgeContents);
	        	}
	        }
	        
	        KnowledgeContentsVO knowledgeContentsVO = new KnowledgeContentsVO();
	        knowledgeContentsVO.setKnowlgNo(knowledgeDetail.getKnowlgNo());
	        knowledgeContentsVO.setSortOrdr(knowledgeVO.getSortOrdr());
	        knowledgeContentsVO.setCont(knowledgeVO.getCont());
	        
	        knowledgeService.updateKnowledgeContents(knowledgeContentsVO);
	        
	        knowledgeDetail.setMileageType("UPD");
	        knowledgeDetail.setMileageScore(1.0f);
	        knowledgeService.insertUserMileage(knowledgeDetail);
	        knowledgeService.insertOrgMileage(knowledgeDetail);

            /* 부서 지식 관리자 조회 후 존재하는 경우에 알림 전송 */
            if (!"PERSONAL".equals(knowledgeVO.getKnowlgMapType())) {
                List<UserVO> orgKnowledgeManagerList = userService.selectOrgKnowledgeManager(userVO);
                orgKnowledgeManagerList.forEach(item -> {
                    MessengerVO messengerVO = new MessengerVO();
                    messengerVO.setSndUser(userVO.getDisplayName());
                    messengerVO.setRecvId(item.getSid());
                    messengerVO.setDocTitle("[도정지식포털 알림]");
                    messengerVO.setDocDesc("[도정지식포털] 부서 지식이 수정 되었습니다.");
                    messengerVO.setDocUrl("http://105.0.1.229/adm/approvalDetail.do?knowlgNo=" + knowledgeVO.getKnowlgNo());
                    messengerService.insert(messengerVO);
                });
            }

	        redirectAttributes.addFlashAttribute("knowlgMapType", knowledgeDetail.getKnowlgMapType());
	    } catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}
		
	    return "redirect:/kno/knowledgeList.do";
    }

    /**
     * 지식백과 > 데이터 편집
     * @return Redirect
     */
    @RequestMapping("/modifyKnowledgeRequest.do")
    public String modifyKnowledgeRequest(@ModelAttribute("knowledgeVO") KnowledgeVO knowledgeVO, RedirectAttributes redirectAttributes) {
        try {
            KnowledgeVO knowledgeDetail = knowledgeService.selectKnowledgeDetail(knowledgeVO);
            List<KnowledgeContentsVO> knowledgeContentsList = knowledgeService.selectKnowledgeContentsList(knowledgeVO);
            UserVO userVO = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();

            knowledgeDetail.setRequestContent(knowledgeVO.getRequestContent());
            knowledgeDetail.setAtchFileNo(0);
            knowledgeDetail.setRegisterId(userVO.getSid());

            int result = knowledgeService.insertKnowledgeModificationRequest(knowledgeDetail);

            if (result > 0) {
                for (KnowledgeContentsVO knowledgeContents : knowledgeContentsList) {
                    knowledgeContents.setRequestNo(knowledgeDetail.getRequestNo());
                    knowledgeService.insertKnowledgeModificationRequestContent(knowledgeContents);
                }
            }

            KnowledgeContentsVO knowledgeContentsVO = new KnowledgeContentsVO();
            knowledgeContentsVO.setRequestNo(knowledgeDetail.getRequestNo());
            knowledgeContentsVO.setSortOrdr(knowledgeVO.getSortOrdr());
            knowledgeContentsVO.setCont(knowledgeVO.getCont());
            knowledgeService.updateKnowledgeModificationRequestContent(knowledgeContentsVO);

            /* 메신저 알림 전송 */
            MessengerVO messengerVO = new MessengerVO();
            messengerVO.setSndUser(userVO.getDisplayName());
            messengerVO.setRecvId(knowledgeDetail.getOwnerId());
            messengerVO.setDocTitle("[도정지식포털 알림]");
            messengerVO.setDocDesc("[도정지식포털] 지식 수정요청이 접수되었습니다");
            messengerVO.setDocUrl("http://105.0.1.229/myp/modificationDetail.do?requestNo=" + knowledgeDetail.getRequestNo());
            messengerService.insert(messengerVO);

            redirectAttributes.addFlashAttribute("knowlgMapType", knowledgeDetail.getKnowlgMapType());
        } catch (NullPointerException e) {
            LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
        }
        return "redirect:/kno/knowledgeList.do";
    }

    /**
     * 지식백과 > 데이터 삭제
     * @return Redirect
     */
    @RequestMapping(value = "/deleteKnowledge.do")
    public String deleteKnowledge(@ModelAttribute("knowledgeVO") KnowledgeVO knowledgeVO) {
        if ("PERSONAL".equals(knowledgeVO.getKnowlgMapType())) {
            // 개인별 지식인 경우 개별 삭제
            knowledgeService.deleteUserMileage(knowledgeVO);
            knowledgeService.deleteOrgMileage(knowledgeVO);
            knowledgeService.deleteKnowledge(knowledgeVO);
        } else {
            // 개인별 지식이 아닌 경우 일괄 삭제
            knowledgeService.deleteUserMileageByTitle(knowledgeVO);
            knowledgeService.deleteOrgMileageByTitle(knowledgeVO);
            knowledgeService.deleteKnowledgeByTitle(knowledgeVO);
        }
    	return "redirect:/kno/knowledgeList.do";
    }

    /**
     * 지식백과 > 등록/수정 > 미리보기
     * @return JSON
     */
    @RequestMapping("/insertPreview.do")
    public ModelAndView insertPreview(@ModelAttribute("knowledgeVO") KnowledgeVO knowledgeVO, Model model) {
    	ModelAndView mav = new ModelAndView("jsonView");

        try {
            List<KnowledgeContentsVO> knowledgeContentsList = new ArrayList<>();
            KnowledgeContentsVO knowledgeContentsVO = new KnowledgeContentsVO();
            UserVO userVO = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();

            if (knowledgeVO.getCont() != null) {
                int start = 0;
                int end = 0;
                int next = 0;
                int sortOrdr = 0;
                long upNo = 0;
                String subTitle = "";
                String cont = "";

                while (start != -1) {
                    start = knowledgeVO.getCont().indexOf("[==", start);
                    if (start != -1) {
                        end = knowledgeVO.getCont().indexOf("==]", start);
                        subTitle = knowledgeVO.getCont().substring(start + 3, end);
                        sortOrdr += 1;
                    } else {
                        end = -3;
                        subTitle = "";
                        sortOrdr = 1;
                    }

                    next = knowledgeVO.getCont().indexOf("[==", end);

                    if (next != -1) {
                        cont = knowledgeVO.getCont().substring(end + 3, next);
                    } else {
                        cont = knowledgeVO.getCont().substring(end + 3, knowledgeVO.getCont().length());
                    }

                    // 목차 아래에 빈 줄이 생기는 현상 제거
                    if (knowledgeVO.getCont().indexOf("[==", start) != -1) {
                        int a = cont.indexOf("</p>");
                        int b = cont.indexOf("<br />");
                        if (a != -1 && b != -1) {
                            if (a > b) {
                                cont = cont.replaceFirst("<br />", "");
                            }
                        }
                        cont = cont.replaceFirst("</p>", "");
                    }

                    knowledgeContentsVO.setSortOrdr(sortOrdr);
                    knowledgeContentsVO.setSubtitle(subTitle);
                    knowledgeContentsVO.setCont(cont);
                    knowledgeContentsList.add(knowledgeContentsVO);

                    start = next;
                }
            }

            for (int i = 0; i < knowledgeContentsList.size(); i++) {
                knowledgeContentsList.get(i).setCont(knowledgeContentsList.get(i).getCont().replace("&lt;", "<"));
                knowledgeContentsList.get(i).setCont(knowledgeContentsList.get(i).getCont().replace("&gt;", ">"));
                knowledgeContentsList.get(i).setCont(knowledgeContentsList.get(i).getCont().replace("&quot;", "\'"));
            }

            model.addAttribute("dateTime", LocalDate.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd")));
            model.addAttribute("userName", userVO.getDisplayName());
            model.addAttribute("knowledgeContentsList", knowledgeContentsList);
        } catch (NullPointerException e) {
            LOGGER.error("[" + e.getClass() + "] :" + e.getMessage());
        }

        return mav;
    }

    /**
     * 지식백과 > 상세 > 오류 신고
     * @return Redirect
     */
    @RequestMapping(value = "/insertErrorStatement.do")
    public String insertErrorStatement(@ModelAttribute("errorStatementVO") ErrorStatementVO errorStatementVO, ModelMap model) {
        
    	String title = "";
    	try {
    		UserVO userVO = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();
    		errorStatementVO.setRegisterId(userVO.getSid());
        	knowledgeService.insertErrorStatement(errorStatementVO);
        	title = URLEncoder.encode(errorStatementVO.getTitle(), "UTF-8");
        } catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		} catch (UnsupportedEncodingException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}
    	
		return "redirect:/kno/knowledgeDetail.do?title=" + title;
    }

    /**
     * 지식백과 > 상세 > 즐겨찾기
     * @return JSON
     */
    @RequestMapping(value = "/insertBookmark.do")
    public ModelAndView insertBookmark(@ModelAttribute("knowledgeVO") KnowledgeVO knowledgeVO, ModelMap model) {
    	
    	ModelAndView mav = new ModelAndView("jsonView");
    	
    	try {
    		UserVO userVO = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();
    		knowledgeVO.setRegisterId(userVO.getSid());
        	knowledgeService.insertBookmark(knowledgeVO);    		
    	} catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}
    	
        return mav;
    }

    /**
     * 지식백과 > 상세 > 추천
     * @return JSON
     */
    @RequestMapping(value = "/updateRecommend.do")
    public ModelAndView updateRecommend(@ModelAttribute("knowledgeVO") KnowledgeVO knowledgeVO, ModelMap model) {

        ModelAndView mav = new ModelAndView("jsonView");

        try {
            UserVO user = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();
            knowledgeVO.setRegisterId(user.getSid());
            knowledgeVO.setOuCode(user.getOuCode());            
            Boolean result = knowledgeService.updateRecommend(knowledgeVO);
            int recommendCount = knowledgeService.selectRecommendCount(knowledgeVO);
            
            Boolean isRecommend = false;
            if(knowledgeService.selectRecommend(knowledgeVO) != null) {
            	isRecommend = true;
    	        knowledgeVO.setMileageType("REC");
    	        knowledgeVO.setMileageScore(3.0f);
    	        knowledgeService.insertUserMileage(knowledgeVO);
    	        knowledgeService.insertOrgMileage(knowledgeVO);
            } else {
            	knowledgeVO.setMileageType("REC");
        		knowledgeService.deleteUserMileage(knowledgeVO);
        		knowledgeService.deleteOrgMileage(knowledgeVO);
            }
            
            mav.addObject("result", result ? true : false);
            mav.addObject("count", recommendCount);
            mav.addObject("isRecommend", isRecommend);
        } catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}
        
        return mav;
    }

    /**
     * 지식백과 > 목록 > 관심분야 등록
     * @return JSON
     */
    @RequestMapping(value = "/updateInterests.do")
    public ModelAndView updateInterests(@ModelAttribute("knowledgeVO") KnowledgeVO knowledgeVO, ModelMap model) {

        ModelAndView mav = new ModelAndView("jsonView");

        try {
            UserVO user = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();
            knowledgeVO.setRegisterId(user.getSid());
            Boolean result = knowledgeService.updateInterests(knowledgeVO);
            
            Boolean isInterest = false;
            if(knowledgeService.selectInterests(knowledgeVO) != null) {
            	isInterest = true;
            }
            
            mav.addObject("result", result ? true : false);
            mav.addObject("isInterest", isInterest);
        } catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}
        
        return mav;
    }

    /**
     * 지식백과 > 등록/수정 > 파일 변환
     * @return JSON
     */
    @RequestMapping(value = "/fileConvert.do")
    public ModelAndView fileConvert(MultipartHttpServletRequest multipartHttpServletRequest, ModelMap model) {

        ModelAndView mav = new ModelAndView("jsonView");

        StringBuffer sb = new StringBuffer();
        
        try {
            Iterator<String> iterator = multipartHttpServletRequest.getFileNames();
            MultipartFile multipartFile = null;
            while (iterator.hasNext()) {
                multipartFile = multipartHttpServletRequest.getFile(iterator.next());
            }
            
            int pos = multipartFile.getOriginalFilename().lastIndexOf('.');
            String ext =  multipartFile.getOriginalFilename().substring(pos + 1,  multipartFile.getOriginalFilename().length());
            
            if(ext != null && ext.equals("hwp")) {
                sb = hwpConvert(multipartFile, sb);
            } else if(ext != null && ext.equals("pdf")) {
            	sb = pdfConvert(multipartFile, sb);
            } else if(ext != null && ext.equals("xlsx")){
            	sb = xlsxConvert(multipartFile, sb);
            } else if(ext != null && ext.equals("docx")) {
            	sb = docxConvert(multipartFile, sb);
            } else {
            	sb.append("지원하지 않는 문서입니다.");
            }
            
            mav.addObject("text", sb);
        } catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}
            
        return mav;
    }
    
    public StringBuffer hwpConvert(MultipartFile multipartFile, StringBuffer sb) {
    	        
        try {
	    	HWPFile hwpFile = HWPReader.fromInputStream(multipartFile.getInputStream());
	
	        String storePathString = EgovProperties.getProperty("Globals.fileStorePath");
	
	        Date date = new Date();
	        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd", Locale.KOREA);
	        String subPath = sdf.format(date);
	
	        String fileName = multipartFile.getOriginalFilename();
	        int pos = fileName.lastIndexOf('.');
	        fileName = fileName.substring(0, pos);
	
	        String filePath = storePathString + subPath + "/" + fileName;
	
	        File saveFolder = new File(EgovWebUtil.filePathBlackList(storePathString + subPath + File.separator + fileName));
	
	        if (!saveFolder.exists() || saveFolder.isFile()) {
	            //2017.03.03 	조성원 	시큐어코딩(ES)-부적절한 예외 처리[CWE-253, CWE-440, CWE-754]
	            if (saveFolder.mkdirs()) {
	                LOGGER.debug("[file.mkdirs] saveFolder : Creation Success ");
	            } else {
	                LOGGER.error("[file.mkdirs] saveFolder : Creation Fail ");
	            }
	        }
	
	        Map<Integer, String> imgList = new HashMap<Integer, String>();
	
	        BufferedImage img;
	        for (EmbeddedBinaryData ebd : hwpFile.getBinData().getEmbeddedBinaryDataList()) {
	            img = ImageIO.read(new ByteArrayInputStream(ebd.getData()));
	            int imgPos = ebd.getName().lastIndexOf('.');
	            String ext = ebd.getName().substring(imgPos + 1, ebd.getName().length());
	            if (ext.equals("bmp") || ext.equals("BMP") || ext == null) {
	                ext = "jpg";
	            }
	            int number = Integer.parseInt(ebd.getName().substring(3, imgPos), 16);
	            if (img != null) {
	                ImageIO.write(img, ext, new File(saveFolder + File.separator + number + "." + ext));
	                imgList.put(number, ext);
	            }
	        }
	
	        for (Section section : hwpFile.getBodyText().getSectionList()) {
	            sb.append("<div>");
	            for (Paragraph paragraph : section) {
	                ParaShape ps = hwpFile.getDocInfo().getParaShapeList().get(paragraph.getHeader().getParaShapeId());
	                float margin = ps.getLeftMargin() / 100.0f;
	                float indent = -ps.getIndent() / 1000.0f;
	                float lineSpace = ps.getLineSpace() / 100.0f;
	                Alignment align = ps.getProperty1().getAlignment();
	                sb.append("<p style=\"margin: " + margin + "px; text-align: " + align + "; line-height: " + lineSpace + "; text-indent: " + indent + "px; display: block; -ms-word-wrap: break-word;\">");
	                paragraph(sb, paragraph, filePath, imgList, hwpFile);
	                sb.append("</p>");
	            }
	            sb.append("</div>");
	        }
        } catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		} catch (IOException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		} catch (Exception e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}
        
        return sb;
    }

    public void paragraph(StringBuffer sb, Paragraph paragraph, String filePath, Map<Integer, String> imgList, HWPFile hwpFile) {

        try {
			if (paragraph.getNormalString() != null && paragraph.getControlList() == null) {
			    normalString(sb, paragraph, hwpFile);
			} else if (paragraph.getNormalString() != null && paragraph.getControlList() != null) {
			    controList(sb, paragraph, filePath, imgList, hwpFile);
			    normalString(sb, paragraph, hwpFile);
			} else if (paragraph.getNormalString() == null && paragraph.getControlList() != null) {
			    controList(sb, paragraph, filePath, imgList, hwpFile);
			} else {
			    sb.append("Not Defined");
			}
		} catch (UnsupportedEncodingException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}
    }

    public void controList(StringBuffer sb, Paragraph paragraph, String filePath, Map<Integer, String> imgList, HWPFile hwpFile) {

        for (Control c : paragraph.getControlList()) {
            if (c.getType().equals(ControlType.Table)) {
                ControlTable table = (ControlTable) c;
                float tableWidth = table.getHeader().getWidth() / 72.0f;
                sb.append("<div style=\"margin: 0px; text-align: left; line-height: 0; display: block; -ms-word-wrap: break-word;\">");
                sb.append("<table style=\"width: " + tableWidth + "px; line-height: normal; vertical-align: text-bottom; display: inline-table; border-collapse: collapse; -ms-word-break: break-all;\">");
                for (Row row : table.getRowList()) {
                    sb.append("<tr>");
                    for (Cell cl : row.getCellList()) {
                        float height = cl.getListHeader().getHeight() / 72.0f;
                        float width = cl.getListHeader().getWidth() / 72.0f;
                        BorderFill bf = hwpFile.getDocInfo().getBorderFillList().get(cl.getListHeader().getBorderFillId() - 1);
                        int r = 255;
                        int g = 255;
                        int b = 255;
                        if (bf.getFillInfo().getType().hasPatternFill()) {
                            r = bf.getFillInfo().getPatternFill().getBackColor().getR();
                            g = bf.getFillInfo().getPatternFill().getBackColor().getG();
                            b = bf.getFillInfo().getPatternFill().getBackColor().getB();
                            if(r == 0 && g == 0 && b == 0) {
                                r = 255;
                                g = 255;
                                b = 255;
                            }
                        } else if (bf.getFillInfo().getType().hasGradientFill()) {
                            bf.getFillInfo().getGradientFill();
                        } else if (bf.getFillInfo().getType().hasImageFill()) {
                            String ext = imgList.get(bf.getFillInfo().getImageFill().getPictureInfo().getBinItemID());
                            sb.append("<img width=" + width + " height=" + height + " src=\"" + filePath + "/" + bf.getFillInfo().getImageFill().getPictureInfo().getBinItemID() + "." + ext + "\" alt=\""+bf.getFillInfo().getImageFill().getPictureInfo().getBinItemID()+"번째 이미지\">");
                        }
                        bf.getTopBorder().getThickness();

                        String colspan = "";
                        if (cl.getListHeader().getColSpan() > 1) {
                            colspan = " colspan=\"" + cl.getListHeader().getColSpan() + "\"";
                        }

                        String rowspan = "";
                        if (cl.getListHeader().getRowSpan() > 1) {
                            rowspan = " rowspan=\"" + cl.getListHeader().getRowSpan() + "\"";
                        }

                        String borderStyle = bf.getTopBorder().getType() + " " + bf.getRightBorder().getType() + " " + bf.getBottomBorder().getType() + " " + bf.getLeftBorder().getType();
                        String borderWidth = Float.parseFloat(bf.getTopBorder().getThickness().toString().substring(2).replace("_", ".")) * 5 + "px "
                                + Float.parseFloat(bf.getRightBorder().getThickness().toString().substring(2).replace("_", ".")) * 5 + "px "
                                + Float.parseFloat(bf.getBottomBorder().getThickness().toString().substring(2).replace("_", ".")) * 5 + "px "
                                + Float.parseFloat(bf.getLeftBorder().getThickness().toString().substring(2).replace("_", ".")) * 5 + "px";

                        sb.append("<td style=\"width : " + width + "px; border-style: " + borderStyle + "; border-width: " + borderWidth + ";  border-color: rgb(" + bf.getTopBorder().getColor().getR() + ", " + bf.getTopBorder().getColor().getG() + ", " + bf.getTopBorder().getColor().getB() + ") rgb(" + bf.getRightBorder().getColor().getR() + ", " + bf.getRightBorder().getColor().getG() + ", " + bf.getRightBorder().getColor().getB() + ") rgb(" + bf.getBottomBorder().getColor().getR() + ", " + bf.getBottomBorder().getColor().getG() + ", " + bf.getBottomBorder().getColor().getB() + ")  rgb(" + bf.getLeftBorder().getColor().getR() + ", " + bf.getLeftBorder().getColor().getG() + ", " + bf.getLeftBorder().getColor().getB() + "); padding: 1.88px; text-align: left; vertical-align: left; background-color: rgb(" + r + ", " + g + ", " + b + ");\"" + colspan + "" + rowspan + ">");

                        for (Paragraph clp : cl.getParagraphList()) {
                            paragraph(sb, clp, filePath, imgList, hwpFile);
                        }
                        sb.append("</td>");
                    }
                    sb.append("</tr>");
                }
                sb.append("</table>");
                sb.append("</div>");
            } else if (c.getType().equals(ControlType.Gso)) {
                GsoControl gso = (GsoControl) c;
                gsoControl(sb, gso, filePath, imgList, hwpFile);

            } else if (c.getType().equals(ControlType.SectionDefine)) {
                sb.append("<br>");
            }
        }
    }

    public void normalString(StringBuffer sb, Paragraph paragraph, HWPFile hwpFile) {
        try {
			if (paragraph.getNormalString() != null && !paragraph.getNormalString().trim().equals("")) {
			    int start = 0;
			    int end = 0;
			    int sum = 0;
			    for (int i = 0; i < paragraph.getCharShape().getPositonShapeIdPairList().size(); i++) {
			        int shapeId = (int) paragraph.getCharShape().getPositonShapeIdPairList().get(i).getShapeId();
			        CharShape cs = hwpFile.getDocInfo().getCharShapeList().get(shapeId);

			        float fontSize = cs.getBaseSize() / 100.0f;
			        String fontName = hwpFile.getDocInfo().getHangulFaceNameList().get(cs.getFaceNameIds().getHangul()).getName();

			        String bold = "";
			        if (cs.getProperty().isBold()) {
			            bold = " font-weight: bold;";
			        }

			        String italic = "";
			        if (cs.getProperty().isItalic()) {
			            italic = " font-style: italic;";
			        }

			        short r = cs.getCharColor().getR();
			        short g = cs.getCharColor().getG();
			        short b = cs.getCharColor().getB();
			        sb.append("<span style=\"color: rgb(" + r + "," + g + "," + b + "); letter-spacing: 0px; font-family: " + fontName + "; font-size: " + fontSize + "px;" + bold + "" + italic + "\">");

			        if (i + 1 < paragraph.getCharShape().getPositonShapeIdPairList().size()) {
			            end = (int) paragraph.getCharShape().getPositonShapeIdPairList().get(i + 1).getPosition() + sum;
			            for (int j = start; j < end; j++) {
			                HWPChar hc = paragraph.getText().getCharList().get(j);
			                if (hc.getType().equals(HWPCharType.ControlChar) && hc.getCode() != 13) {
			                    end -= 1;
			                    sum -= 1;
			                }

			                if (hc.getType().equals(HWPCharType.ControlInline)) {
			                    end -= 8;
			                    sum -= 8;
			                }

			                if (hc.getType().equals(HWPCharType.ControlExtend)) {
			                    end -= 8;
			                    sum -= 8;
			                }
			            }
			        } else {
			            end = paragraph.getNormalString().length();
			        }

			        if (end < 0 || end < start) {
			            end = start;
			        }

			        if (end > paragraph.getNormalString().length()) {
			            end = paragraph.getNormalString().length();
			        }

			        if (r == 0 && g == 0 && b == 255 && fontSize == 18.0f && paragraph.getNormalString().contains("○") && !paragraph.getNormalString().equals("")) {
			            sb.append("[==" + paragraph.getNormalString().replace("○ ", "") + "==]");
			        } else {
			            sb.append(paragraph.getNormalString().substring(start, end));
			        }

			        start = end;

			        sb.append("</span>");
			    }
			}
		} catch (UnsupportedEncodingException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}
    }

    public void gsoControl(StringBuffer sb, GsoControl gso, String filePath, Map<Integer, String> imgList, HWPFile hwpFile) {

        if (gso.getGsoType().equals(GsoControlType.Arc)) {
            sb.append("Arc");
            ControlArc arc = (ControlArc) gso;

            ShapeComponentNormal shape = (ShapeComponentNormal) arc.getShapeComponent();
            int r = 255;
            int g = 255;
            int b = 255;
            if (shape.getFillInfo().getType().hasPatternFill()) {
                r = shape.getFillInfo().getPatternFill().getBackColor().getR();
                g = shape.getFillInfo().getPatternFill().getBackColor().getG();
                b = shape.getFillInfo().getPatternFill().getBackColor().getB();
                if(r == 0 && g == 0 && b == 0) {
                    r = 255;
                    g = 255;
                    b = 255;
                }
            } else if (shape.getFillInfo().getType().hasGradientFill()) {
                shape.getFillInfo().getGradientFill();
            }
            shape.getLineInfo();

            float height = (float) arc.getShapeComponent().getHeightAtCurrent() / 72.0f;
            float width = (float) arc.getShapeComponent().getWidthAtCurrent() / 72.0f;

            arc.getShapeComponentArc();

            sb.append("<svg viewBox=\"0 0 " + width + " " + height + "\" width=\"" + width + "\" height=\"" + height + "\">");
            if (arc.getTextBox() != null) {
                sb.append("<text>");
                for (Paragraph crp : arc.getTextBox().getParagraphList()) {
                    paragraph(sb, crp, filePath, imgList, hwpFile);
                }
                sb.append("</text>");
            }
            sb.append("</svg>");
        } else if (gso.getGsoType().equals(GsoControlType.Curve)) {
            sb.append("Curve");
            ControlCurve curve = (ControlCurve) gso;

            ShapeComponentNormal shape = (ShapeComponentNormal) gso.getShapeComponent();
            int r = 255;
            int g = 255;
            int b = 255;
            if (shape.getFillInfo().getType().hasPatternFill()) {
                r = shape.getFillInfo().getPatternFill().getBackColor().getR();
                g = shape.getFillInfo().getPatternFill().getBackColor().getG();
                b = shape.getFillInfo().getPatternFill().getBackColor().getB();
                if(r == 0 && g == 0 && b == 0) {
                    r = 255;
                    g = 255;
                    b = 255;
                }
            } else if (shape.getFillInfo().getType().hasGradientFill()) {
                shape.getFillInfo().getGradientFill();
            }
            shape.getLineInfo();

            float height = (float) curve.getShapeComponent().getHeightAtCurrent() / 72.0f;
            float width = (float) curve.getShapeComponent().getWidthAtCurrent() / 72.0f;

            curve.getShapeComponentCurve();

            sb.append("<svg viewBox=\"0 0 " + width + " " + height + "\" width=\"" + width + "\" height=\"" + height + "\">");
            if (curve.getTextBox() != null) {
                sb.append("<text>");
                for (Paragraph crp : curve.getTextBox().getParagraphList()) {
                    paragraph(sb, crp, filePath, imgList, hwpFile);
                }
                sb.append("</text>");
            }
            sb.append("</svg>");
        } else if (gso.getGsoType().equals(GsoControlType.Ellipse)) {
            sb.append("ellipse");
            ControlEllipse ellipse = (ControlEllipse) gso;
            ShapeComponentNormal shape = (ShapeComponentNormal) ellipse.getShapeComponent();
            int r = 255;
            int g = 255;
            int b = 255;
            if (shape.getFillInfo().getType().hasPatternFill()) {
                r = shape.getFillInfo().getPatternFill().getBackColor().getR();
                g = shape.getFillInfo().getPatternFill().getBackColor().getG();
                b = shape.getFillInfo().getPatternFill().getBackColor().getB();
                if(r == 0 && g == 0 && b == 0) {
                    r = 255;
                    g = 255;
                    b = 255;
                }
            } else if (shape.getFillInfo().getType().hasGradientFill()) {
                shape.getFillInfo().getGradientFill();
            }
            int lineR = shape.getLineInfo().getColor().getR();
            int lineG = shape.getLineInfo().getColor().getG();
            int lineB = shape.getLineInfo().getColor().getB();

            float height = (float) ellipse.getShapeComponent().getHeightAtCurrent() / 72.0f;
            float width = (float) ellipse.getShapeComponent().getWidthAtCurrent() / 72.0f;

            float cx = ellipse.getShapeComponentEllipse().getCenterX() / 100.0f;
            float cy = ellipse.getShapeComponentEllipse().getCenterY() / 100.0f;
            float rx = ellipse.getShapeComponentEllipse().getAxis2X() / 100.0f - ellipse.getShapeComponentEllipse().getAxis1X() / 100.0f;
            float ry = ellipse.getShapeComponentEllipse().getAxis2Y() / 100.0f - ellipse.getShapeComponentEllipse().getAxis1Y() / 100.0f;
            sb.append("<svg viewBox=\"0 0 " + width + " " + height + "\" width=\"" + width + "\" height=\"" + height + "\">");
            sb.append("<ellipse cx=\"" + cx + "\" cy=\"" + cy + "\" rx=\"" + rx + "\" ry=\"" + ry + "\" stroke=\"rgb(" + lineR + "," + lineG + "," + lineB + ")\" stroke-width=\"1\" fill=\"rgb(" + r + "," + g + "," + b + ")\"/>");
            if (ellipse.getTextBox() != null) {
                sb.append("<text>");
                for (Paragraph crp : ellipse.getTextBox().getParagraphList()) {
                    paragraph(sb, crp, filePath, imgList, hwpFile);
                }
                sb.append("</text>");
            }
            sb.append("</svg>");
        } else if (gso.getGsoType().equals(GsoControlType.Line)) {
            sb.append("line");
            ControlLine line = (ControlLine) gso;

            ShapeComponentNormal shape = (ShapeComponentNormal) line.getShapeComponent();
            int r = 255;
            int g = 255;
            int b = 255;
            if (shape.getFillInfo().getType().hasPatternFill()) {
                r = shape.getFillInfo().getPatternFill().getBackColor().getR();
                g = shape.getFillInfo().getPatternFill().getBackColor().getG();
                b = shape.getFillInfo().getPatternFill().getBackColor().getB();
                if(r == 0 && g == 0 && b == 0) {
                    r = 255;
                    g = 255;
                    b = 255;
                }
            } else if (shape.getFillInfo().getType().hasGradientFill()) {
                shape.getFillInfo().getGradientFill();
            }
            int thick = shape.getLineInfo().getThickness();
            int lineR = shape.getLineInfo().getColor().getR();
            int lineG = shape.getLineInfo().getColor().getG();
            int lineB = shape.getLineInfo().getColor().getB();

            float height = (float) line.getShapeComponent().getHeightAtCurrent() / 72.0f;
            float width = (float) line.getShapeComponent().getWidthAtCurrent() / 72.0f;

            int x1 = line.getShapeComponentLine().getStartX();
            int x2 = line.getShapeComponentLine().getEndX();
            int y1 = line.getShapeComponentLine().getStartY();
            int y2 = line.getShapeComponentLine().getEndY();

            sb.append("<svg viewBox=\"0 0 " + width + " " + height + "\" width=\"" + width + "\" height=\"" + height + "\">");
            sb.append("<line x1='" + x1 + "' y1='" + y1 + "' x2='" + x2 + "' y2='" + y2 + "' stroke=\"rgb(" + lineR + "," + lineG + "," + lineG + ")\" stroke-width=\"1\"/>");
            sb.append("</svg>");
        } else if (gso.getGsoType().equals(GsoControlType.ObjectLinkLine)) {
            sb.append("ObjectLinkLine;");
            ControlObjectLinkLine linkLine = (ControlObjectLinkLine) gso;
            linkLine.getShapeComponentLine();
        } else if (gso.getGsoType().equals(GsoControlType.OLE)) {
            sb.append("OLE;");
            ControlOLE ole = (ControlOLE) gso;
            ole.getShapeComponentOLE();
        } else if (gso.getGsoType().equals(GsoControlType.Picture)) {
            ControlPicture picture = (ControlPicture) gso;
            float height = picture.getShapeComponent().getHeightAtCurrent() / 72.0f;
            float width = picture.getShapeComponent().getWidthAtCurrent() / 72.0f;
            String ext = imgList.get(picture.getShapeComponentPicture().getPictureInfo().getBinItemID());
            sb.append("<img width=" + width + " height=" + height + " src=\"" + filePath + "/" + picture.getShapeComponentPicture().getPictureInfo().getBinItemID() + "." + ext + "\">");
        } else if (gso.getGsoType().equals(GsoControlType.Polygon)) {
            ControlPolygon polygon = (ControlPolygon) gso;

            ShapeComponentNormal shape = (ShapeComponentNormal) polygon.getShapeComponent();
            int r = 255;
            int g = 255;
            int b = 255;
            if (shape.getFillInfo().getType().hasPatternFill()) {
                r = shape.getFillInfo().getPatternFill().getBackColor().getR();
                g = shape.getFillInfo().getPatternFill().getBackColor().getG();
                b = shape.getFillInfo().getPatternFill().getBackColor().getB();
                if(r == 0 && g == 0 && b == 0) {
                    r = 255;
                    g = 255;
                    b = 255;
                }
            } else if (shape.getFillInfo().getType().hasGradientFill()) {
                shape.getFillInfo().getGradientFill();
            }
            shape.getLineInfo();

            float height = 0;
            if (polygon.getShapeComponent().getHeightAtCurrent() < 0) {
                height = -polygon.getShapeComponent().getHeightAtCurrent() / 72.0f;
            } else {
                height = polygon.getShapeComponent().getHeightAtCurrent() / 72.0f;
            }

            float width = 0;
            if (polygon.getShapeComponent().getWidthAtCurrent() < 0) {
                width = -polygon.getShapeComponent().getWidthAtCurrent() / 72.0f;
            } else {
                width = polygon.getShapeComponent().getWidthAtCurrent() / 72.0f;
            }

            int reverse = 0;
            if (polygon.getShapeComponent().getWidthAtCurrent() < 0) {
                reverse = -1;
            } else {
                reverse = 1;
            }

            String points = "M ";
            for (PositionXY xy : polygon.getShapeComponentPolygon().getPositionList()) {
                points += xy.getX() / 72.0f + "," + xy.getY() / 72.0f + " L ";
            }
            points = points.substring(0, points.length() - 3) + " Z";

            sb.append("<p>");
            sb.append("<svg viewBox=\"0 0 " + width + " " + height * 3 + "\" width=\"" + width + "\" height=\"" + height + "\" preserveAspectRatio=\"none\" style=\"transform: matrix(" + reverse + ", 0, 0, 1, 0, 0);\">");
            sb.append("<g><path stroke-width=\"1\" d=\"" + points + " \" stroke=\"rgb(0, 0, 0)\" fill=\"rgb(" + r + "," + g + "," + b + ")\" vector-effect=\"non-scaling-stroke\"></path></g>");
            if (polygon.getTextBox() != null) {
                sb.append("<text>");
                for (Paragraph crp : polygon.getTextBox().getParagraphList()) {
                    paragraph(sb, crp, filePath, imgList, hwpFile);
                }
                sb.append("</text>");
            }
            sb.append("</svg>");
            sb.append("</p>");
        } else if (gso.getGsoType().equals(GsoControlType.Rectangle)) {
            ControlRectangle rectangle = (ControlRectangle) gso;

            ShapeComponentNormal shape = (ShapeComponentNormal) rectangle.getShapeComponent();
            int r = 255;
            int g = 255;
            int b = 255;
            if (shape.getFillInfo().getType().hasPatternFill()) {
                r = shape.getFillInfo().getPatternFill().getBackColor().getR();
                g = shape.getFillInfo().getPatternFill().getBackColor().getG();
                b = shape.getFillInfo().getPatternFill().getBackColor().getB();
                if(r == 0 && g == 0 && b == 0) {
                    r = 255;
                    g = 255;
                    b = 255;
                }
            } else if (shape.getFillInfo().getType().hasGradientFill()) {
                shape.getFillInfo().getGradientFill();
            }

            int lineR = shape.getLineInfo().getColor().getR();
            int lineG = shape.getLineInfo().getColor().getG();
            int lineB = shape.getLineInfo().getColor().getB();

            float height = (float) rectangle.getShapeComponent().getHeightAtCurrent() / 72.0f;
            float width = (float) rectangle.getShapeComponent().getWidthAtCurrent() / 72.0f;

            byte round = rectangle.getShapeComponentRectangle().getRoundRate();

            sb.append("<svg viewBox=\"0 0 " + width + " " + height + "\" width=\"" + width + "\" height=\"" + height + "\">");
            sb.append("<rect width=\"" + width + "\" height=\"" + height + "\" rx=\"" + round + "\" rx=\"" + round + "\" stroke=\"rgb(" + lineR + "," + lineG + "," + lineB + ")\" stroke-width=\"1\" fill=\"rgb(" + r + "," + g + "," + b + "\" />");
            if (rectangle.getTextBox() != null) {
                sb.append("<text>");
                for (Paragraph crp : rectangle.getTextBox().getParagraphList()) {
                    paragraph(sb, crp, filePath, imgList, hwpFile);
                }
                sb.append("</text>");
            }
            sb.append("</svg>");
        }/* else if(gso.getGsoType().equals(GsoControlType.Container)) {
		ControlContainer container = (ControlContainer) gso;
		for(GsoControl g:container.getChildControlList()) {
			gsoControl(sb, g, filePath, imgList, hwpFile);
		}
	}*/
    }
    
    public StringBuffer pdfConvert(MultipartFile multipartFile, StringBuffer sb) {
     	
    	try {
    		 PDDocument pdf = PDDocument.load(multipartFile.getInputStream());
    		 PDFDomTree tree = new PDFDomTree();
    		 sb.append(tree.getText(pdf)); 

        } catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		} catch (IOException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}
    	
    	return sb;
    }
       
    public StringBuffer xlsxConvert(MultipartFile multipartFile, StringBuffer sb) {
    	
    	try {
			XlsxConverter.convert(multipartFile, sb);
		} catch (InvalidFormatException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		} catch (IOException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		} catch (ParserConfigurationException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		} catch (TransformerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}
    	
    	return sb;
    }
    
    public StringBuffer docxConvert(MultipartFile multipartFile, StringBuffer sb) {
    	
    	DocumentConverter converter = new DocumentConverter();
    	Result<String> result = null;
		try {
			result = converter.convertToHtml(multipartFile.getInputStream());
		} catch (IOException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}
    	sb.append(result.getValue()); // The generated HTML 
    	Set<String> warnings = result.getWarnings();
    	
    	return sb;
    }

    @RequestMapping(value="/addKnowledge.do")
	public void addKnowledge(ModelMap model) {
		try {
			RecommendVO recommendVO = new RecommendVO();

			recommendVO.setKnowlgMapType("REPORT");
			commonService.deleteRecommend(recommendVO);
			List<RecommendVO> reportRecommendKnowledgeList = commonService.selectTopRecommendKnowledgeList(recommendVO);

			for(int i = 0; i < reportRecommendKnowledgeList.size(); i++) {
				reportRecommendKnowledgeList.get(i).setRki(i+1);
				reportRecommendKnowledgeList.get(i).setRegisterId("admin");
				commonService.insertRecommend(reportRecommendKnowledgeList.get(i));
			}

			recommendVO.setKnowlgMapType("REFERENCE");
			commonService.deleteRecommend(recommendVO);
			List<RecommendVO> referenceRecommendKnowledgeList = commonService.selectTopRecommendKnowledgeList(recommendVO);

			for(int i = 0; i < referenceRecommendKnowledgeList.size(); i++) {
				referenceRecommendKnowledgeList.get(i).setRki(i+1);
				referenceRecommendKnowledgeList.get(i).setRegisterId("admin");
				commonService.insertRecommend(referenceRecommendKnowledgeList.get(i));
			}

			recommendVO.setKnowlgMapType("PERSONAL");
			commonService.deleteRecommend(recommendVO);
			List<RecommendVO> pesonalRecommendKnowledgeList = commonService.selectTopRecommendKnowledgeList(recommendVO);

			for(int i = 0; i < pesonalRecommendKnowledgeList.size(); i++) {
				pesonalRecommendKnowledgeList.get(i).setRki(i+1);
				pesonalRecommendKnowledgeList.get(i).setRegisterId("admin");
				commonService.insertRecommend(pesonalRecommendKnowledgeList.get(i));
			}

			PersonalizeVO personalizeVO = new PersonalizeVO();

			List<OrgVO> orgList = orgService.selectOrgList(new OrgVO());

			for(int i = 0; i < orgList.size(); i++) {
	            OrgVO orgVO = new OrgVO();
	            orgVO.setOuCode(orgList.get(i).getOuCode());
	            String parentOuCode = orgService.selectParentOrg(orgVO).getParentOuCode();

	            if(parentOuCode.equals("6410000")){
	            	parentOuCode = orgList.get(i).getOuCode();
	            } else {
	            	String tmpCode = parentOuCode;
	            	while (!tmpCode.equals("6410000")) {
	            		orgVO.setOuCode(tmpCode);
	            		tmpCode = orgService.selectParentOrg(orgVO).getParentOuCode();
	            		if(!tmpCode.equals("6410000")) {
	            			parentOuCode = tmpCode;
	            		}
	            	}
	            }

				personalizeVO.setOuCode(orgList.get(i).getOuCode());
				personalizeVO.setKnowlgMapType("REPORT");
				commonService.deletePersonalize(personalizeVO);
				List<PersonalizeVO> reportPersonalizeKnowledgeList = commonService.selectTopPersonalizeKnowledgeList(personalizeVO);

				for(int j = 0; j < reportPersonalizeKnowledgeList.size(); j++) {
					reportPersonalizeKnowledgeList.get(j).setRki(j+1);
					reportPersonalizeKnowledgeList.get(j).setRegisterId("admin");
					reportPersonalizeKnowledgeList.get(j).setOuCode(parentOuCode);
					commonService.insertPersonalize(reportPersonalizeKnowledgeList.get(j));
				}

				personalizeVO.setOuCode(orgList.get(i).getOuCode());
				personalizeVO.setKnowlgMapType("REFERENCE");
				commonService.deletePersonalize(personalizeVO);
				List<PersonalizeVO> referencePersonalizeKnowledgeList = commonService.selectTopPersonalizeKnowledgeList(personalizeVO);

				for(int j = 0; j < referencePersonalizeKnowledgeList.size(); j++) {
					referencePersonalizeKnowledgeList.get(j).setRki(j+1);
					referencePersonalizeKnowledgeList.get(j).setRegisterId("admin");
					referencePersonalizeKnowledgeList.get(j).setOuCode(parentOuCode);
					commonService.insertPersonalize(referencePersonalizeKnowledgeList.get(j));
				}

				personalizeVO.setOuCode(orgList.get(i).getOuCode());
				personalizeVO.setKnowlgMapType("PERSONAL");
				commonService.deletePersonalize(personalizeVO);
				List<PersonalizeVO> pesonalPersonalizeKnowledgeList = commonService.selectTopPersonalizeKnowledgeList(personalizeVO);

				for(int j = 0; j < pesonalPersonalizeKnowledgeList.size(); j++) {
					pesonalPersonalizeKnowledgeList.get(j).setRki(j+1);
					pesonalPersonalizeKnowledgeList.get(j).setRegisterId("admin");
					pesonalPersonalizeKnowledgeList.get(j).setOuCode(parentOuCode);
					commonService.insertPersonalize(pesonalPersonalizeKnowledgeList.get(j));
				}

			}

		} catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}
	}

    @ResponseBody
    @RequestMapping(value="/checkDuplication.do")
    public int checkDuplication(@RequestBody KnowledgeVO knowledgeVO) {
        return knowledgeService.checkDuplication(knowledgeVO);
    }

    // ↓↓↓↓↓↓↓ 미사용 코드 주석 처리 ↓↓↓↓↓↓↓
    // ↓↓↓↓↓↓↓ 미사용 코드 주석 처리 ↓↓↓↓↓↓↓
    // ↓↓↓↓↓↓↓ 미사용 코드 주석 처리 ↓↓↓↓↓↓↓
    /*@RequestMapping("/deleteRelateKnowlg.do")
    public String deleteRelateKnowlg(@ModelAttribute("relateKnowlgVO") RelateKnowlgVO relateKnowlgVO,
    								 @RequestParam(value = "relateKnowlgNo", required = false) Long relateKnowlgNo,
    								 @RequestParam(value = "sortOrdr", required = false) int sortOrdr)  {

    	Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();

    	if (isAuthenticated) {
    		relateKnowlgVO.setRelateKnowlgNo(relateKnowlgNo);
    		relateKnowlgVO.setSortOrdr(sortOrdr);
    		knowledgeService.deleteRelateKnowlg(relateKnowlgVO);
    	}

    	return "redirect:/kno/knowledgeDetail.do";
    }

    @RequestMapping("/deleteknowlg.do")
    public String deleteknowlg(@ModelAttribute("knowledgeVO") KnowledgeVO knowledgeVO,
                               @RequestParam(value = "knowlgNo", required = false) int knowlgNo,
                               @RequestParam(value = "title", required = false) String title)  {

        Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();

        //System.out.println("222222222222");
        //System.out.println("knowledgeVO - " + knowledgeVO);
        if (isAuthenticated) {
            knowledgeVO.setTitle(title);
            knowledgeVO.setKnowlgNo(knowlgNo);
            knowledgeService.updateKnowlg(knowledgeVO);
        }

        return "redirect:/kno/knowledgeDetail.do";
    }

    @RequestMapping("/updateKnowledge.do")
    public String updateKnowledge(final MultipartHttpServletRequest multiRequest
            , @ModelAttribute("knowledgeVO") KnowledgeVO knowledgeVO
            , RedirectAttributes redirectAttributes) {

        try {
            UserVO userVO = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();

            knowledgeVO.setRegisterId(userVO.getSid());
            knowledgeVO.setOuCode(userVO.getOuCode());

            List<FileVO> file = new ArrayList<FileVO>();
            long atchFileNo = 0;
            final Map<String, MultipartFile> files = multiRequest.getFileMap();

            List<MultipartFile> mFiles = multiRequest.getFiles("atchFile");

            files.clear();

            if (!mFiles.isEmpty()) {
                for(MultipartFile mFile : mFiles) {
                    files.put(mFile.getOriginalFilename(), mFile);
                }

                Iterator<String> mapIter = files.keySet().iterator();
                while(mapIter.hasNext()){
                    String key = mapIter.next();
                    MultipartFile value = files.get(key);
                }
                file = fileUtil.parseFileInf(files, "KNO_", 0, "");
                atchFileNo = fileMngService.insertFileInfs(file);
            }
            knowledgeVO.setAtchFileNo(atchFileNo);

            if (knowledgeVO.getCopertnWritngYn() == null) {
                knowledgeVO.setCopertnWritngYn("N");
            }

            if (knowledgeVO.getRelateKnowledgeList() != null) {
                long relateKnowlgNo = knowledgeService.insertRelateKnowledge(knowledgeVO);
                knowledgeVO.setRelateKnowlgNo(relateKnowlgNo);
            }

            if (knowledgeVO.getRlsYn().equals("N")) {
                TargetVO targetVO = new TargetVO();

                targetVO.setOrgList(knowledgeVO.getOrgList());
                targetVO.setUserList(knowledgeVO.getUserList());

                GroupVO groupVO = new GroupVO();
                groupVO.setRegisterId(userVO.getSid());
                List<String> orgList = new ArrayList<>();
                List<String> userList = new ArrayList<>();
                for(String s:knowledgeVO.getGroupList()){
                    groupVO.setGroupNo(Long.parseLong(s));
                    List<GroupVO> group = commonService.selectGroupDetail(groupVO);
                    for(GroupVO gv:group) {
                        if(gv.getTargetTypeCd().equals("ORG")) {
                            if(targetVO.getOrgList() != null) {
                                targetVO.getOrgList().add(gv.getTargetCode());
                            } else {
                                orgList.add(gv.getTargetCode());
                            }
                        }

                        if(gv.getTargetTypeCd().equals("USER")) {
                            if(targetVO.getUserList() != null) {
                                targetVO.getUserList().add(gv.getTargetCode());
                            } else {
                                userList.add(gv.getTargetCode());
                            }
                        }
                    }
                }

                if(orgList.size() > 0) {
                    targetVO.setOrgList(orgList);
                }

                if(userList.size() > 0) {
                    targetVO.setUserList(userList);
                }

                long targetNo = commonService.insertTarget(targetVO);
                knowledgeVO.setTargetNo(targetNo);
            }

            int result = knowledgeService.insertKnowledge(knowledgeVO);

            if (result > 0) {
                KnowledgeContentsVO knowledgeContentsVO = new KnowledgeContentsVO();

                if (knowledgeVO.getCont() != null) {
                    int start = 0;
                    int end = 0;
                    int next = 0;
                    int sortOrdr = 0;
                    long upNo = 0;
                    String subTitle = "";
                    String cont = "";

                    while (start != -1) {
                        start = knowledgeVO.getCont().indexOf("[==", start);
                        if (start != -1) {
                            end = knowledgeVO.getCont().indexOf("==]", start);
                            subTitle = knowledgeVO.getCont().substring(start + 3, end);
                            sortOrdr += 1;
                        } else {
                            end = -3;
                            subTitle = "";
                            sortOrdr = 1;
                        }

                        next = knowledgeVO.getCont().indexOf("[==", end);

                        if (next != -1) {
                            cont = knowledgeVO.getCont().substring(end + 3, next);
                        } else {
                            cont = knowledgeVO.getCont().substring(end + 3, knowledgeVO.getCont().length());
                        }

                        // 목차 아래에 빈 줄이 생기는 현상 제거
                        if (knowledgeVO.getCont().indexOf("[==", start) != -1) {
                            int a = cont.indexOf("</p>");
                            int b = cont.indexOf("<br />");
                            if (a != -1 && b != -1) {
                                if (a > b) {
                                    cont = cont.replaceFirst("<br />", "");
                                }
                            }
                            cont = cont.replaceFirst("</p>", "");
                        }

                        knowledgeContentsVO.setKnowlgNo(knowledgeVO.getKnowlgNo());
                        knowledgeContentsVO.setTitle(knowledgeVO.getTitle());
                        knowledgeContentsVO.setSortOrdr(sortOrdr);
                        knowledgeContentsVO.setSubtitle(subTitle);
                        knowledgeContentsVO.setCont(cont);
                        knowledgeContentsVO.setUpNo(upNo);
                        knowledgeContentsVO.setRegisterId(knowledgeVO.getRegisterId());

                        knowledgeService.insertKnowledgeContents(knowledgeContentsVO);

                        start = next;
                    }
                }

                knowledgeVO.setMileageType("UPD");
                knowledgeVO.setMileageScore(1.0f);
                knowledgeService.insertUserMileage(knowledgeVO);
                knowledgeService.insertOrgMileage(knowledgeVO);

                redirectAttributes.addFlashAttribute("knowlgMapType", knowledgeVO.getKnowlgMapType());
            }
        } catch (NullPointerException e) {
            LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
        } catch (IOException e) {
            LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
        } catch (EgovComException e) {
            LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
        }

        return "redirect:/kno/knowledgeList.do";
    }

    @RequestMapping(value = "/updateKnowledgeLink.do")
    public void updateKnowledgeLink() {
        try {
            List<String> titleList = knowledgeService.selectKnowledgeTitle();

            KnowledgeVO knowledgeVO = new KnowledgeVO();
            for(String title:titleList) {
                knowledgeVO.setTitle(title);
                knowledgeService.updateKnowledgeLink(knowledgeVO);
            }
        } catch (NullPointerException e) {
            LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
        }
    }*/
}
