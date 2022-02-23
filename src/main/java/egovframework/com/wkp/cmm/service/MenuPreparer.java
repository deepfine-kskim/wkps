package egovframework.com.wkp.cmm.service;

import java.util.List;

import javax.annotation.Resource;

import org.apache.tiles.Attribute;
import org.apache.tiles.AttributeContext;
import org.apache.tiles.preparer.PreparerException;
import org.apache.tiles.preparer.ViewPreparer;
import org.apache.tiles.request.Request;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.com.utl.wed.enums.SurveyStateType;
import egovframework.com.wkp.bbs.service.EgovBbsService;
import egovframework.com.wkp.bbs.service.RequestVO;
import egovframework.com.wkp.cmu.service.EgovCommunityService;
import egovframework.com.wkp.kno.service.EgovKnowledgeService;
import egovframework.com.wkp.kno.service.ErrorStatementVO;
import egovframework.com.wkp.srv.service.EgovSurveyService;
import egovframework.com.wkp.srv.service.SurveyVO;
import egovframework.com.wkp.usr.service.UserVO;
import egovframework.mgt.wkp.mnu.service.EgovMenuService;
import egovframework.mgt.wkp.mnu.service.MenuVO;

public class MenuPreparer implements ViewPreparer {
	
    private static final Logger LOGGER = LoggerFactory.getLogger(MenuPreparer.class);
	
	@Resource(name="menuService")
	EgovMenuService menuService;
	
    @Resource(name = "surveyService")
    EgovSurveyService surveyService;
    
    @Resource(name = "communityService")
    EgovCommunityService communityService;
    
    @Resource(name = "knowledgeService")
    private EgovKnowledgeService knowledgeService;
    
	@Resource(name="bbsService")
	EgovBbsService bbsService;

	@Override
	public void execute(Request tilesContext, AttributeContext attributeContext) throws PreparerException {

		try {			
            UserVO user = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();
            
			MenuVO menuVO = new MenuVO();
			menuVO.setDelYn('Y');
			List<MenuVO> menuList = menuService.selectMenuList(menuVO);
			
			SurveyVO surveyVO = new SurveyVO();
			surveyVO.setAprvState(SurveyStateType.WAIT);
			int surveyCnt = surveyService.selectSurveyListCount(surveyVO);
			
			surveyVO.setRegisterId(user.getSid());			
			int mySurveyCnt = surveyService.selectSurveyListCountByMine(surveyVO);
			
			int communityCnt = communityService.selectCommunityCount("");
			
			int myCommunityCnt = communityService.selectCommunityCount(user.getSid());
			
			ErrorStatementVO errorStatementVO = new ErrorStatementVO();
			errorStatementVO.setAnswerYn("N");
			int errorCnt = knowledgeService.selectErrorStatementListCount(errorStatementVO);

			errorStatementVO.setRegisterId(user.getSid());
			int myErrorCnt = knowledgeService.selectErrorStatementListCount(errorStatementVO);
			
			RequestVO requestVO = new RequestVO();
			requestVO.setAnswerYn("N");
			requestVO.setRegisterId(user.getSid());
			int myRequestCnt = bbsService.selectRequestListCountByMine(requestVO);
			
			attributeContext.putAttribute("menuList", new Attribute(menuList), true);
			attributeContext.putAttribute("surveyCnt", new Attribute(surveyCnt), true);
			attributeContext.putAttribute("communityCnt", new Attribute(communityCnt), true);
			attributeContext.putAttribute("errorCnt", new Attribute(errorCnt), true);
			attributeContext.putAttribute("myErrorCnt", new Attribute(myErrorCnt), true);
			attributeContext.putAttribute("mySurveyCnt", new Attribute(mySurveyCnt), true);
			attributeContext.putAttribute("myCommunityCnt", new Attribute(myCommunityCnt), true);
			attributeContext.putAttribute("myRequestCnt", new Attribute(myRequestCnt), true);
			
		} catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}	
	}	

}
