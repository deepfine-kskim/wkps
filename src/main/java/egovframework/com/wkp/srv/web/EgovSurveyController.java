package egovframework.com.wkp.srv.web;

import egovframework.com.cmm.service.EgovProperties;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.com.utl.fcc.service.EgovFileUploadUtil;
import egovframework.com.utl.wed.comm.ListWithPageNavigation;
import egovframework.com.utl.wed.enums.SurveySearchKey;
import egovframework.com.utl.wed.enums.SurveyStateType;
import egovframework.com.utl.wed.enums.SurveyType;
import egovframework.com.utl.wed.enums.YnEnum;
import egovframework.com.wkp.cmm.service.*;
import egovframework.com.wkp.srv.service.*;
import egovframework.com.wkp.usr.service.EgovOrgService;
import egovframework.com.wkp.usr.service.OrgVO;
import egovframework.com.wkp.usr.service.UserVO;
import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.io.File;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/srv")
public class EgovSurveyController {

    private static final Logger LOGGER = LoggerFactory.getLogger(EgovSurveyController.class);

    @Resource(name = "surveyService")
    private EgovSurveyService surveyService;

    @Resource(name = "commonService")
    private EgovCommonService commonService;
    
    @Resource(name = "orgService")
	private EgovOrgService orgService;

    @RequestMapping("/list.do")
    public String index(Model model
            , @RequestParam(value = "type", required = false) SurveyType type
            , @RequestParam(value = "searchText", required = false) String searchText
            , @RequestParam(value = "searchKey", required = false, defaultValue = "TITLE") SurveySearchKey searchKey
            , @RequestParam(value = "page", required = false, defaultValue = "1") int page) {
        try {

            ListWithPageNavigation<SurveyVO> surveyList = null;

            UserVO user = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();

            SurveyVO param = new SurveyVO();
            param.setPage(page);
            param.setRegisterId(user.getSid());
            param.setOuCode(user.getOuCode());
            param.setIsFront("Y");

            SurveyType paramType = type;

            if (SurveyType.DOING == paramType) {
                param.setAprvState(SurveyStateType.DOING);
            } else if (SurveyType.DONE == paramType) {
                param.setAprvState(SurveyStateType.DONE);
            } else if (SurveyType.MINE == paramType) {
            	param.setAprvState(SurveyStateType.MINE);
            } else if (SurveyType.WRITE == paramType) {
            	param.setAprvState(SurveyStateType.WRITE);
            } else {
                paramType = SurveyType.ALL;
            }

            if (searchKey != null && StringUtils.isNotBlank(searchText)) {
                if (SurveySearchKey.TITLE == searchKey || SurveySearchKey.REGISTER_ID == searchKey) {
                    param.setSearchKey(searchKey);
                    param.setSearchText(searchText);
                }
            }
            //배치 전 데이터 업데이트
            surveyService.updateSurveyDoingState();

            param.setSid(user.getSid());
            param.setRoleCd(user.getRoleCd());

            surveyList = surveyService.selectSurveyList(param);

            model.addAttribute("surveyList", surveyList);
            model.addAttribute("mySurveyList", surveyService.selectSurveyListByMine(param));
            model.addAttribute("surveyTypes", SurveyType.values());
            model.addAttribute("surveyState", SurveyStateType.values());
            model.addAttribute("searchKeyTypes", SurveySearchKey.values());
            model.addAttribute("type", paramType);
            model.addAttribute("page", page);
            model.addAttribute("myList", "");
            model.addAttribute("searchText", searchText);
            model.addAttribute("searchKey", searchKey);

            model.addAttribute("user", user);
            model.addAttribute("now", new Date());

        } catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}
        
        return "/com/wkp/srv/EgovSurveyList";
    }

    @RequestMapping("/detail.do")
    public String detail(Model model
            , @RequestParam Long surveyNo
            , @RequestParam(value = "type", required = false) SurveyType type
            , @RequestParam(value = "searchText", required = false) String searchText
            , @RequestParam(value = "page", required = false, defaultValue = "1") int page) {
        try {

            UserVO user = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();

            SurveyVO param = new SurveyVO();
            param.setSurveyNo(surveyNo);
            param.setRegisterId(user.getSid());
            param.setSearchText(searchText);
            param.setPage(page);

            SurveyType paramType = type;

            if (SurveyType.DOING != paramType && SurveyType.DONE != paramType) {
                paramType = SurveyType.ALL;
            }

            //배치 전 데이터 업데이트
            surveyService.updateSurveyDoingState();

            SurveyVO detail = surveyService.selectDetail(param);

            if (detail != null) {
//                그룹으로 대상자를 지정한 경우 상세페이지로 안넘어가져서 그룹도 체크하게 하였으나 운영에 반영하였을때 운영에선 알수없는 이유로 안되어서 우선
//                대상이 아닌 설문조사건은 리스트에서 안보이기때문에 detail 화면에 들어갈때 검증하지 않도록 수정
                /*
                if ("Y".equals(detail.getTargetYn()) && !user.getRoleCd().equals("ROLE_ADMIN") && !user.getSid().equals(detail.getRegisterId())) {
                    TargetVO targetVO = new TargetVO();
                    targetVO.setTargetNo(detail.getTargetNo());
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

                        if (targetList.get(i).getTargetTypeCd().equals("GROUP")) {
                            List<TargetVO> groupList = commonService.selectGroupListForDetail(targetList.get(i));
                            if (groupList.get(i).getTargetTypeCd().equals("USER")) {
                                result = groupList.get(i).getTargetCode().equals(sid);
                            }

                            if (groupList.get(i).getTargetTypeCd().equals("ORG")) {
                                result = groupList.get(i).getTargetCode().equals(ouCode);
                            }
                        }

                        if (result) {
                            break;
                        } else {
                            i++;
                        }
                    }

                    if (!result) {
                        return "redirect:/srv/list.do";
                    }
                }
*/

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

                model.addAttribute("topList", topList);

                model.addAttribute("isAnswer", surveyService.selectAnswerJoinCount(surveyNo, user.getSid()));

                String str = detail.getSurveyDesc();
                detail.setSurveyDesc(str);
                model.addAttribute("detail", detail);
                model.addAttribute("joinCount", surveyService.selectSurveyJoinCount(param));
            } else {
                return "redirect:/srv/list.do";
            }

            model.addAttribute("type", paramType);
            model.addAttribute("page", page);
            model.addAttribute("searchText", searchText);
            model.addAttribute("user", user);
            model.addAttribute("now", new Date());

        } catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}

        return "/com/wkp/srv/EgovSurveyDetail";
    }

    @RequestMapping("/detailPopup.do")
    public String detailPopup(Model model
            , @RequestParam Long surveyNo) {
        try {
            SurveyVO param = new SurveyVO();
            param.setSurveyNo(surveyNo);

            SurveyVO detail = surveyService.selectDetail(param);

            String str = detail.getSurveyDesc();
            detail.setSurveyDesc(str);
            model.addAttribute("detail", detail);
        } catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}
        return "/com/cmm/surveyPopup";
    }


    @RequestMapping("/write.do")
    public String insertView(Model model
            , @RequestParam(value = "surveyNo", required = false) Long surveyNo
            , @RequestParam(value = "isNew", required = false) boolean isNew
    ) {
        try {

            UserVO user = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();

            SurveyVO detail = new SurveyVO();
            if (surveyNo != null) {
                detail.setSurveyNo(surveyNo);
                detail = surveyService.selectDetail(detail);
                if (isNew) {
                    detail.setSurveyNo(null);
                }
            } else {
                detail.setBngnDtm(new Date());
                detail.setEndDtm(new Date());
                detail.setResltRlsYn(YnEnum.Y.name());
                detail.setTargetYn(YnEnum.N.name());
                detail.setAprvState(SurveyStateType.TEMPORARY);
                detail.setRlsYn(YnEnum.Y.name());
                detail.setTargetRlsYn(YnEnum.Y.name());
            }

            model.addAttribute("detail", detail);
            
            List<ExcellenceOrgVO> excellenceOrgList = commonService.selectExcellenceOrgList(new ExcellenceOrgVO());
            List<ExcellenceUserVO> excellenceUserList = commonService.selectExcellenceUserList(new ExcellenceUserVO());

            GroupVO groupVO = new GroupVO();
            groupVO.setRegisterId(user.getSid());
            List<GroupVO> groupList;
            groupList = commonService.selectGroupList(groupVO);
            model.addAttribute("groupList", groupList);

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

            model.addAttribute("excellenceUserList", excellenceUserList);
            model.addAttribute("excellenceOrgList", excellenceOrgList);
            model.addAttribute("topList", topList);

        } catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}

        return "/com/wkp/srv/EgovSurveyRegist";
    }

    @RequestMapping(value = "/writeProc.do", method = RequestMethod.POST)
    @ResponseBody
    public ModelAndView insert(@RequestBody SurveyDTO surveyVO
    ) {
        boolean result = false;
        ModelAndView mav = new ModelAndView("jsonView");
        try {


            SurveyVO param = new SurveyVO();


            UserVO user = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();

            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm", Locale.KOREA);
            Date dateStart = sdf.parse(surveyVO.getBngnDtm());
            Date dateEnd = sdf.parse(surveyVO.getEndDtm());

            param.setBngnDtm(dateStart);
            param.setEndDtm(dateEnd);
            param.setResltRlsYn(surveyVO.getResltRlsYn());
            param.setTitle(surveyVO.getTitle());
            param.setSurveyDesc(surveyVO.getSurveyDesc());
            param.setAprvState(surveyVO.getAprvState());
            param.setRegisterId(user.getSid());
            param.setUpdaterId(user.getSid());
            param.setTargetYn(surveyVO.getTargetYn());
            param.setRlsYn(surveyVO.getRlsYn());
            param.setTargetRlsYn(surveyVO.getTargetRlsYn());

            //그룹 타켓 지정
            if ("Y".equals(param.getTargetYn())) {
                TargetVO targetVO = new TargetVO();
                targetVO.setOrgList(surveyVO.getOrgList());
                targetVO.setUserList(surveyVO.getUserList());
                targetVO.setGroupList(surveyVO.getGroupList());
                //System.out.println("surveyVO - " + surveyVO);
                long targetNo = commonService.insertTarget(targetVO);
                param.setTargetNo(targetNo);
            }

            param.setQuestionList(surveyVO.getQuestionList());

            SurveyVO survey = surveyService.insert(param);
            mav.addObject("data", survey);
            
            //System.out.println("param - " + param);

            if (survey.getSurveyNo() != null) {
                result = true;
            }
        } catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		} catch (ParseException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}

        mav.addObject("result", result);

        return mav;
    }

    @RequestMapping("/surveyUpdate.do")
    public String updateSurveyView(Model model
            , @RequestParam Long surveyNo
    ) {
        try {

            UserVO userVO = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();

            SurveyVO detail = new SurveyVO();
            detail.setSurveyNo(surveyNo);
            if (surveyNo != null) {
                detail.setSurveyNo(surveyNo);
                detail = surveyService.selectDetail(detail);
            } else {
                return "redirect:/srv/list.do";
            }

            if (detail != null) {
                model.addAttribute("detail", detail);

                List<TargetVO> targetVOList = commonService.selectDisplayTargetList(detail.getTargetNo());

                GroupVO groupVO = new GroupVO();
                groupVO.setRegisterId(userVO.getSid());
                List<GroupVO> groupList;
                groupList = commonService.selectGroupList(groupVO);

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
                
                model.addAttribute("groupList", groupList);
                model.addAttribute("topList", topList);
                model.addAttribute("targetVOList", targetVOList);

            } else {
                return "redirect:/srv/list.do";
            }

        } catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}

        return "/com/wkp/srv/EgovSurveyRegist";
    }

    @RequestMapping(value = "/updateProc.do", method = RequestMethod.POST)
    @ResponseBody
    public ModelAndView updateSurvey(
            @RequestBody SurveyDTO surveyVO
    ) {
        boolean result = false;
        ModelAndView mav = new ModelAndView("jsonView");
        try {


            UserVO user = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();

            SurveyVO param = new SurveyVO();

            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm", Locale.KOREA);
            Date dateStart = sdf.parse(surveyVO.getBngnDtm());
            Date dateEnd = sdf.parse(surveyVO.getEndDtm());

            param.setBngnDtm(dateStart);
            param.setEndDtm(dateEnd);
            param.setResltRlsYn(surveyVO.getResltRlsYn());
            param.setTitle(surveyVO.getTitle());
            param.setSurveyDesc(surveyVO.getSurveyDesc());
            param.setAprvState(surveyVO.getAprvState());
            param.setRegisterId(user.getSid());
            param.setUpdaterId(user.getSid());
            param.setTargetYn(surveyVO.getTargetYn());
            param.setSurveyNo(surveyVO.getSurveyNo());
            param.setRlsYn(surveyVO.getRlsYn());
            param.setTargetRlsYn(surveyVO.getTargetRlsYn());

            param.setQuestionList(surveyVO.getQuestionList());

            //그룹 타켓 지정
            if ("Y".equals(param.getTargetYn())) {
                TargetVO targetVO = new TargetVO();
                targetVO.setOrgList(surveyVO.getOrgList());
                targetVO.setUserList(surveyVO.getUserList());
                targetVO.setGroupList(surveyVO.getGroupList());
                long targetNo = commonService.insertTarget(targetVO);
                param.setTargetNo(targetNo);
            }

            result = surveyService.update(param);
            mav.addObject("data", param);

        } catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		} catch (ParseException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}
        
        mav.addObject("result", result);

        return mav;
    }

    @RequestMapping(value = "/surveyDelete.do", method = RequestMethod.POST)
    public String deleteSurvey(@RequestParam Long surveyNo

    ) {
        try {

            UserVO user = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();

            SurveyVO param = new SurveyVO();
            param.setSurveyNo(surveyNo);
            param.setRegisterId(user.getSid());
            param.setUpdaterId(user.getSid());
            surveyService.delete(param);
        } catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}
        
        return "redirect:/srv/list.do";
    }

    @RequestMapping(value = "/surveyAnswer.do", method = RequestMethod.POST)
    @ResponseBody
    public ModelAndView surveyAnswer(@RequestBody List<SurveyAnswerVO> answer
    ) {
        boolean result = false;
        ModelAndView mav = new ModelAndView("jsonView");
        try {

            UserVO user = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();

            int count = 0;
            for (SurveyAnswerVO vo : answer) {
                vo.setRegisterId(user.getSid());
                count = count + surveyService.insertAnswer(vo);
            }
            if (count > 0) {
                result = true;
            }
        } catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}
        
        mav.addObject("result", result);

        return mav;
    }

    @RequestMapping("/surveyResult.do")
    public String surveyResult(Model model
            , @RequestParam(value = "surveyNo") Long surveyNo
    ) {
        try {
            UserVO user = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();

            SurveyVO detail = new SurveyVO();
            detail.setSurveyNo(surveyNo);
            detail = surveyService.selectDetail(detail);

            if (detail == null) {
                return "redirect:/srv/list.do";
            }

            List<SurveyStatisticsDTO> list = surveyService.selectResultList(surveyNo, user.getSid());

            model.addAttribute("detail", detail);
            model.addAttribute("joinCount", surveyService.selectSurveyJoinCount(detail));
            model.addAttribute("list", list);
            model.addAttribute("user", user);
        } catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}
        
        return "/com/wkp/srv/EgovSurveyResult";
    }

    @RequestMapping("/answerJoinUser.do")
    public ModelAndView answerJoinUser(Model model
            , @RequestParam(value = "surveyExampleNo") Long surveyExampleNo
    ) {
        ModelAndView mav = new ModelAndView("jsonView");
        boolean result = false;
        try {

            List<SurveyAnswerVO> list = surveyService.selectAnswerUser(surveyExampleNo);
            if (list != null) {
                result = true;
            }

            mav.addObject("list", list);
        } catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}

        mav.addObject("result", result);
        return mav;
    }

    @RequestMapping("/updateSurveyEndDate.do")
    @ResponseBody
    public ModelAndView updateSurveyEndDate(
            @RequestParam(value = "surveyNo") Long surveyNo
            , @RequestParam(value = "endDtm") String endDtm
    ) {
        ModelAndView mav = new ModelAndView("jsonView");
        boolean result = false;
        try {

            SurveyVO vo = new SurveyVO();
            vo.setSurveyNo(surveyNo);

            UserVO user = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();

            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm", Locale.KOREA);
            vo.setEndDtm(sdf.parse(endDtm));
            vo.setUpdaterId(user.getSid());
            result = surveyService.updateSurveyEndDate(vo) > 0;
        } catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		} catch (ParseException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}
        
        mav.addObject("result", result);

        return mav;
    }

    //리포트 엑셀 다운로드
    @RequestMapping(value = "/surveyExcelDownload.do", method = {RequestMethod.POST})
    public ModelAndView surveyExcelDownload(
            @RequestParam(value = "surveyNo") Long surveyNo) throws IOException {
        Map<String, Object> downloadData = new HashMap<String, Object>();
		String today = new SimpleDateFormat("yyyy_MM_dd_hh_mm_ss", Locale.KOREA).format(new Date());
        String filename = "surveyExcelDown" + "_" + today + ".csv";
        SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.KOREA);

        List<String[]> data = new ArrayList<String[]>();
        
        UserVO user = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();
        
        try {	        
	        List<String> question = new ArrayList<String>();
	        
	        question.add("참여순서");
	        /*if(user.getRoleCd().equals("ROLE_ADMIN") || user.getRoleCd().equals("ROLE_SURVEY")) {
	        	question.add("아이디");
		        question.add("성명");
	        }*/
	        if(user.getRoleCd().equals("ROLE_ADMIN")) {
                question.add("전체소속명");
                question.add("성명");
                question.add("직책");
            }
	        question.add("참여일");
	        
	        SurveyQuestionVO surveyQuestionVO = new SurveyQuestionVO();
	        surveyQuestionVO.setSurveyNo(surveyNo);
	        List<SurveyQuestionVO> questionList = surveyService.selectQuestionList(surveyQuestionVO);
	        
	        for(int i = 0; i < questionList.size(); i++) {
	        	question.add(questionList.get(i).getCont());
	        }
	        
	        String[] title = question.toArray(new String[question.size()]);	        

	        data.add(title);
	        
	        List<String> answer = new ArrayList<String>();
	        
	        SurveyAnswerVO surveyAnswerVO = new SurveyAnswerVO();
	        surveyAnswerVO.setSurveyNo(surveyNo);
	        List<SurveyAnswerVO> answerUserList = surveyService.selectAnswerUserList(surveyAnswerVO);
	        List<SurveyQuestionVO> questionNumberList = surveyService.selectQuestionNumberList(surveyQuestionVO);
	        
	        for(int i = 0; i < answerUserList.size(); i++) {
	        	answer.add(""+(i+1));
		        /*
	        	if(user.getRoleCd().equals("ROLE_ADMIN") || user.getRoleCd().equals("ROLE_SURVEY")) {
		        	answer.add(answerUserList.get(i).getRegisterId());
	        		answer.add(answerUserList.get(i).getDisplayName());
		        }
		        */
                if(user.getRoleCd().equals("ROLE_ADMIN")) {
	        	    answer.add(answerUserList.get(i).getOrgFullName());
	        	    answer.add(answerUserList.get(i).getDisplayName());
	        	    answer.add(answerUserList.get(i).getPosition());
                }
	        	answer.add(transFormat.format(answerUserList.get(i).getRegistDtm()));
        		surveyAnswerVO.setRegisterId(answerUserList.get(i).getRegisterId());
	        	for(int j = 0; j < questionNumberList.size(); j++) {
	        		surveyAnswerVO.setSurveyQusNo(questionNumberList.get(j).getSurveyQusNo());
	        		List<SurveyAnswerVO> answerContList = surveyService.selectAnswer(surveyAnswerVO);
	        		if(answerContList.size() > 1) {
	        			String str = "";
	        			for(int k = 0 ; k < answerContList.size(); k++) {
	        				str += answerContList.get(k).getQusAnswerCont() + " ";
	        			}
	        			answer.add(str);	
	        		} else {
	        			if(answerContList.size() > 0) {
	        				answer.add(answerContList.get(0).getQusAnswerCont());
	        			} else {
	        				answer.add("");
	        			}
	        		}	        		
	        	}
		        String[] cont = answer.toArray(new String[answer.size()]);    
	            data.add(cont);
	            answer.clear();
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

}
