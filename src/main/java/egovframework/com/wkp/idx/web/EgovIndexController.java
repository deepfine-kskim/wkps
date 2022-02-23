package egovframework.com.wkp.idx.web;

import java.util.LinkedHashMap;
import java.util.List;
import javax.annotation.Resource;

import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.com.kf.service.KsfService;
import egovframework.com.utl.wed.enums.LogSubjectType;
import egovframework.com.utl.wed.enums.LogType;
import egovframework.mgt.wkp.log.service.EgovLogService;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.com.wkp.bbs.service.NoticeVO;
import egovframework.com.wkp.bbs.service.impl.BbsDAO;
import egovframework.com.wkp.cmm.service.ExcellenceOrgVO;
import egovframework.com.wkp.cmm.service.ExcellenceUserVO;
import egovframework.com.wkp.cmm.service.PersonalizeVO;
import egovframework.com.wkp.cmm.service.RecommendVO;
import egovframework.com.wkp.cmm.service.impl.CommonDAO;
import egovframework.com.wkp.kno.service.KnowledgeVO;
import egovframework.com.wkp.kno.service.impl.KnowledgeDAO;
import egovframework.com.wkp.usr.service.EgovOrgService;
import egovframework.com.wkp.usr.service.OrgVO;
import egovframework.com.wkp.usr.service.UserVO;

@Controller
@RequestMapping("/idx")
public class EgovIndexController {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(EgovIndexController.class);
	
    @Resource(name="bbsDAO")
    private BbsDAO bbsDAO;
    
    @Resource(name="commonDAO")
    private CommonDAO commonDAO;

    @Resource(name = "logService")
    EgovLogService egovLogService;
    
    @Resource(name = "ksfService")
    KsfService ksfService;
    
    @Resource(name = "knowledgeDAO")
    private KnowledgeDAO knowledgeDAO;
    
	@Resource(name = "orgService")
	private EgovOrgService orgService;
	
	@RequestMapping("/index.do")
	public String index(Model model) {
		
		try {			
            UserVO user = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();
            egovLogService.insert(LogType.SELECT_LIST, LogSubjectType.MAIN, null);
			
			int offset = 0;
			int limit = 3;
			
			NoticeVO noticeVO = new NoticeVO();
			noticeVO.setItemCountPerPage(limit);
			noticeVO.setItemOffset(offset);
			List<NoticeVO> noticeList = bbsDAO.selectNoticeList(noticeVO);
			
            List<ExcellenceOrgVO> excellenceOrgList = commonDAO.selectExcellenceOrgList(new ExcellenceOrgVO());
            
            List<ExcellenceUserVO> excellenceUserList = commonDAO.selectExcellenceUserList(new ExcellenceUserVO());
            
            KnowledgeVO knowledgeVO = new KnowledgeVO();
            knowledgeVO.setKnowlgMapType("REPORT");
            knowledgeVO.setItemCountPerPage(2);
            knowledgeVO.setItemOffset(0);
            List<KnowledgeVO> newReportList = knowledgeDAO.selectKnowledgeList(knowledgeVO);
            
            knowledgeVO.setKnowlgMapType("REFERENCE");
            knowledgeVO.setItemCountPerPage(2);
            knowledgeVO.setItemOffset(0);
            List<KnowledgeVO> newReferenceList = knowledgeDAO.selectKnowledgeList(knowledgeVO);
            
            knowledgeVO.setKnowlgMapType("PERSONAL");
            knowledgeVO.setItemCountPerPage(2);
            knowledgeVO.setItemOffset(0);
            List<KnowledgeVO> newPersonalList = knowledgeDAO.selectKnowledgeList(knowledgeVO);
            
            RecommendVO recommendVO = new RecommendVO();
            recommendVO.setKnowlgMapType("REPORT");
            List<RecommendVO> recommendReportList = commonDAO.selectRecommendList(recommendVO);
            
            recommendVO.setKnowlgMapType("REFERENCE");
            List<RecommendVO> recommendReferenceList = commonDAO.selectRecommendList(recommendVO);
            
            recommendVO.setKnowlgMapType("PERSONAL");
            List<RecommendVO> recommendPersonalList = commonDAO.selectRecommendList(recommendVO);
            
            PersonalizeVO personalizeVO = new PersonalizeVO();
            OrgVO orgVO = new OrgVO();
            orgVO.setOuCode(user.getOuCode());
            String parentOuCode = orgService.selectParentOrg(orgVO).getParentOuCode();
            
            if(parentOuCode.equals("6410000")){
            	personalizeVO.setOuCode(user.getOuCode());
            } else {
            	String tmpCode = parentOuCode;
            	while (!tmpCode.equals("6410000")) {
            		orgVO.setOuCode(tmpCode);
            		tmpCode = orgService.selectParentOrg(orgVO).getParentOuCode();
            		if(!tmpCode.equals("6410000")) {
            			parentOuCode = tmpCode;
            		}            			
            	}
            	personalizeVO.setOuCode(parentOuCode);
            }
            
            personalizeVO.setKnowlgMapType("REPORT");
            List<PersonalizeVO> personalizeReportList = commonDAO.selectPersonalizeList(personalizeVO);
            
            personalizeVO.setKnowlgMapType("REFERENCE");
            List<PersonalizeVO> personalizeReferenceList = commonDAO.selectPersonalizeList(personalizeVO);
            
            personalizeVO.setKnowlgMapType("PERSONAL");
            List<PersonalizeVO> personalizePersonalList = commonDAO.selectPersonalizeList(personalizeVO);
            
    		List<LinkedHashMap<String, String>> ppkList = ksfService.getPopularKwd(0, 5);
            
            model.addAttribute("noticeList", noticeList);
            model.addAttribute("excellenceOrgList", excellenceOrgList);
            model.addAttribute("excellenceUserList", excellenceUserList);
            model.addAttribute("newReportList", newReportList);
            model.addAttribute("newReferenceList", newReferenceList);
            model.addAttribute("newPersonalList", newPersonalList);
            model.addAttribute("recommendReportList", recommendReportList);
            model.addAttribute("recommendReferenceList", recommendReferenceList);
            model.addAttribute("recommendPersonalList", recommendPersonalList);
            model.addAttribute("personalizeReportList", personalizeReportList);
            model.addAttribute("personalizeReferenceList", personalizeReferenceList);
            model.addAttribute("personalizePersonalList", personalizePersonalList);
            model.addAttribute("ppkList", ppkList);
		} catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}
		
		return "/com/wkp/idx/EgovIndex";
	}

}
