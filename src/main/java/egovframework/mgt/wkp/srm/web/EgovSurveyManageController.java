package egovframework.mgt.wkp.srm.web;

import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.com.utl.wed.comm.ListWithPageNavigation;
import egovframework.com.utl.wed.enums.SurveySearchKey;
import egovframework.com.utl.wed.enums.SurveyStateType;
import egovframework.com.utl.wed.enums.SurveyType;
import egovframework.com.wkp.srv.service.EgovSurveyService;
import egovframework.com.wkp.srv.service.SurveyVO;
import egovframework.com.wkp.usr.service.UserVO;
import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.util.Date;

@Controller
@RequestMapping("/adm/")
public class EgovSurveyManageController {

    private static final Logger LOGGER = LoggerFactory.getLogger(EgovSurveyManageController.class);

    @Resource(name = "surveyService")
    EgovSurveyService surveyService;

    @RequestMapping("/surveySetup.do")
    public String selectSurveyList(
            Model model
            , @RequestParam(value = "type", required = false) SurveyStateType type
            , @RequestParam(value = "searchText", required = false) String searchText
            , @RequestParam(value = "searchKey", required = false, defaultValue = "TITLE") SurveySearchKey searchKey
            , @RequestParam(value = "page", required = false, defaultValue = "1") int page) {
        try {

            ListWithPageNavigation<SurveyVO> surveyList = null;

            UserVO user = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();

            SurveyVO param = new SurveyVO();
            param.setPage(page);

            SurveyStateType paramType = type;

            if (SurveyStateType.DOING == paramType) {
                param.setAprvState(SurveyStateType.DOING);
            } else if (SurveyStateType.DONE == paramType) {
                param.setAprvState(SurveyStateType.DONE);
            } else if (SurveyStateType.TEMPORARY == paramType) {
                param.setAprvState(SurveyStateType.TEMPORARY);
            } else if (SurveyStateType.CANCEL == paramType) {
                param.setAprvState(SurveyStateType.CANCEL);
            } else if (SurveyStateType.WAIT == paramType) {
                param.setAprvState(SurveyStateType.WAIT);
            } else {
                paramType = SurveyStateType.ALL;
            }

            if (searchKey != null && StringUtils.isNotBlank(searchText)) {
                if (SurveySearchKey.TITLE == searchKey || SurveySearchKey.REGISTER_ID == searchKey) {
                    param.setSearchKey(searchKey);
                    param.setSearchText(searchText);
                }
            }

            surveyList = surveyService.selectSurveyList(param);

            model.addAttribute("surveyList", surveyList);
            model.addAttribute("surveyTypes", SurveyType.values());
            model.addAttribute("surveyState", SurveyStateType.values());
            model.addAttribute("searchKeyTypes", SurveySearchKey.values());
            model.addAttribute("type", paramType);
            model.addAttribute("page", page);
            model.addAttribute("searchText", searchText);
            model.addAttribute("searchKey", searchKey);
            model.addAttribute("user", user);

            model.addAttribute("now", new Date());

        } catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}

        return "/mgt/wkp/srv/EgovSurveyList";
    }

    @RequestMapping("/surveySetupView.do")
    public String detail(Model model
            , @RequestParam Long surveyNo) {
        try {

            SurveyVO param = new SurveyVO();
            param.setSurveyNo(surveyNo);

            UserVO user = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();

            //배치 전 데이터 업데이트
            surveyService.updateSurveyDoingState();

            SurveyVO detail = surveyService.selectDetail(param);

            if (detail != null) {
                String str = detail.getSurveyDesc();
                str = str.replaceAll("&lt;", "<");
                str = str.replaceAll("&gt;", ">");
                str = str.replaceAll("&quot;", "\"");
                detail.setSurveyDesc(str);
                model.addAttribute("detail", detail);
                model.addAttribute("joinCount", surveyService.selectSurveyJoinCount(param));
                model.addAttribute("user", user);
            } else {
                return "redirect:/adm/surveySetup.do";
            }

        } catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}

        return "/mgt/wkp/srv/EgovSurveyDetail";
    }

    @RequestMapping("/updateSurveyState.do")
    @ResponseBody
    public ModelAndView updateSurveyState(
            @RequestParam(value = "surveyNo") Long surveyNo
            , @RequestParam(value = "type") SurveyStateType type
            , @RequestParam(value = "checkCont", required = false) String checkCont
    ) {
        ModelAndView mav = new ModelAndView("jsonView");
        boolean result = false;
        try {
            UserVO user = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();
            SurveyVO vo = new SurveyVO();
            vo.setSurveyNo(surveyNo);
            vo.setAprvState(type);
            vo.setCheckRegisterId(user.getSid());
            vo.setCheckCont(checkCont);
            result = surveyService.updateSurveyState(vo);
        } catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}
        
        mav.addObject("result", result);

        return mav;
    }
    
    @RequestMapping("/updateSurveyRelease.do")
    @ResponseBody
    public ModelAndView updateSurveyRelease(
            @RequestParam(value = "surveyNo") Long surveyNo
            , @RequestParam(value = "rlsYn") String rlsYn
    ) {
        ModelAndView mav = new ModelAndView("jsonView");
        boolean result = false;
        try {
            UserVO user = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();
            SurveyVO vo = new SurveyVO();
            vo.setSurveyNo(surveyNo);
            vo.setRlsYn(rlsYn);
            result = surveyService.updateSurveyRelease(vo);
        } catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}
        
        mav.addObject("result", result);

        return mav;
    }

}
