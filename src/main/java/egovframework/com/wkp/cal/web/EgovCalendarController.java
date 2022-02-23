package egovframework.com.wkp.cal.web;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.com.utl.wed.enums.LogSubjectType;
import egovframework.com.utl.wed.enums.LogType;
import egovframework.com.wkp.cal.service.CalendarVO;
import egovframework.com.wkp.cal.service.EgovCalendarService;
import egovframework.com.wkp.cmm.service.EgovCommonService;
import egovframework.com.wkp.cmm.service.GroupVO;
import egovframework.com.wkp.cmm.service.TargetVO;
import egovframework.com.wkp.cmu.service.EgovCommunityService;
import egovframework.com.wkp.usr.service.EgovOrgService;
import egovframework.com.wkp.usr.service.OrgVO;
import egovframework.com.wkp.usr.service.UserVO;
import egovframework.mgt.wkp.log.service.EgovLogService;
import egovframework.mgt.wkp.mnu.service.EgovMenuService;

@Controller
@RequestMapping("/cal")
public class EgovCalendarController {

	private static final Logger LOGGER = LoggerFactory.getLogger(EgovCalendarController.class);

    @Resource(name = "calendarService")
    EgovCalendarService calendarService;

    @Resource(name = "menuService")
    EgovMenuService menuService;

    @Resource(name = "communityService")
    EgovCommunityService communityService;


    @Resource(name = "commonService")
    private EgovCommonService commonService;

    @Resource(name = "logService")
    EgovLogService egovLogService;
    
    @Resource(name = "orgService")
	private EgovOrgService orgService;

    @RequestMapping("/calendar.do")
    public String calendar(Model model) {

        egovLogService.insert(LogType.SELECT_LIST, LogSubjectType.CALENDAR, null);

        try {
            UserVO user = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();//사용자 session
            model.addAttribute("user", user);
        } catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}

        return "/com/wkp/cal/EgovCalendarList";
    }

    @RequestMapping("/calendarRegist.do")
    public String calendarRegist(Model model) {

        try {

            model.addAttribute("community", communityService.findCommunity(null, null, 1000, 0));

            
            UserVO userVO = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();
			
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
            
			model.addAttribute("groupList", groupList);
            model.addAttribute("topList", topList);
            model.addAttribute("parentList", parentList);
            model.addAttribute("childList", childList);
        } catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}

        return "/com/wkp/cal/EgovCalendarRegist";
    }

    @RequestMapping("/calendarModify.do")
    public String calendarModify(Model model,
                                 @RequestParam(value = "calendarNo", required = true) Long calendarNo) {

        try {

            model.addAttribute("community", communityService.findCommunity(null, null, 1000, 0));

            CalendarVO cal = calendarService.getCalendar(calendarNo);

            model.addAttribute("cal", cal);
            model.addAttribute("cal_community", calendarService.getCalendarCommunity(calendarNo));
            model.addAttribute("cal_target", commonService.selectDisplayTargetList(cal.getTargetNo()));

            

            UserVO userVO = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();
			
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
			
            model.addAttribute("groupList", groupList);
            model.addAttribute("topList", topList);
            model.addAttribute("parentList", parentList);
            model.addAttribute("childList", childList);
        } catch (NullPointerException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}

        return "/com/wkp/cal/EgovCalendarModify";
    }

    @RequestMapping(value = "/listCalendarMonth.do", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE)
    public ModelAndView listCalendarMonth(
            @RequestParam(value = "year", required = true) int year,
            @RequestParam(value = "month", required = true) int month
    )  {

        UserVO user = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();//사용자 session

        List<CalendarVO> list = calendarService.selectCalendarListMonth(year, month, user.getSid(), user.getOuCode());

        ModelAndView mav = new ModelAndView("jsonView");
        mav.addObject("success", true);
        mav.addObject("list", list);
        return mav;
    }

    @RequestMapping(value = "/listCalendarDay.do", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE)
    public ModelAndView listCalendarDay(
            @RequestParam(value = "year", required = true) int year,
            @RequestParam(value = "month", required = true) int month,
            @RequestParam(value = "day", required = true) int day
    )  {
        UserVO user = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();//사용자 session
        List<CalendarVO> list = calendarService.selectCalendarListDay(year, month, day, user.getSid(), user.getOuCode());

        ModelAndView mav = new ModelAndView("jsonView");
        mav.addObject("success", true);
        mav.addObject("list", list);
        return mav;
    }
    
    @RequestMapping(value = "/listCalendarOne.do", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE)
    public ModelAndView listCalendarOne(
            @RequestParam(value = "calendarNo", required = true) long calendarNo
    )  {
        
        CalendarVO calendar = calendarService.getCalendar(calendarNo);

        ModelAndView mav = new ModelAndView("jsonView");
        mav.addObject("success", true);
        mav.addObject("calendar", calendar);
        return mav;
    }

    
    
    
    @RequestMapping(value = "/addCalendar.do", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE)
    public ModelAndView addCalendar(
    		@RequestParam(value = "CALENDAR_REPEAT_CD", required = true) String calendarRepeatCd,
            @RequestParam(value = "CALENDAR_TYPE_CD", required = true) String calendarTypeCd,
            @RequestParam(value = "REPEAT_NUM", required = true) String repeatNum,
            //@RequestParam(value = "REPEAT_NUM1", required = true) String repeatNum1,
            //@RequestParam(value = "REPEAT_NUM2", required = true) String repeatNum2,
            //@RequestParam(value = "REPEAT_WEEK", required = true) String repeatWeek,
            //@RequestParam(value = "REPEAT_DAY", required = true) String repeatDay,
            @RequestParam(value = "TITLE", required = true) String title,
            @RequestParam(value = "CONT", required = true) String cont,
            @RequestParam(value = "BNGN_DTM", required = true) String bngnDtm,
            @RequestParam(value = "END_DTM", required = true) String endDtm,
            @RequestParam(value = "PLC", required = false) String plc,
            @RequestParam(value = "ATTENDESS", required = false) String attendess,
            @RequestParam(value = "CNFDNT_YN", required = true) String cnfdntYn,
            @RequestParam(value = "CMMNTY_ARR[]", required = false) Long[] cmmntyArr,
            @RequestParam(value = "orgList[]", required = false) String[] orgList,
            @RequestParam(value = "userList[]", required = false) String[] userList,
            @RequestParam(value = "groupList[]", required = false) String[] groupList
    ) throws Exception  {

        UserVO user = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();//사용자 session
        long targetNo = 0;
        System.out.println(""+orgList);
        System.out.println(""+userList);
        System.out.println(""+groupList);
        if ((userList != null && userList.length > 0) || (orgList != null && orgList.length > 0) || (groupList != null && groupList.length > 0)) {
            TargetVO targetVO = new TargetVO();
            if (orgList != null) {
                targetVO.setOrgList(new ArrayList<String>(Arrays.asList(orgList)));
            }
            if (userList != null) {
                targetVO.setUserList(new ArrayList<String>(Arrays.asList(userList)));
            }
            if (groupList != null) {
                targetVO.setGroupList(new ArrayList<String>(Arrays.asList(groupList)));
            }
            targetNo = commonService.insertTarget(targetVO);
        }

        CalendarVO calendarVO = new CalendarVO();
        calendarVO.setCalendarRepeatCd(calendarRepeatCd);
        calendarVO.setCalendarTypeCd(calendarTypeCd);
        calendarVO.setTitle(title);
        calendarVO.setCont(cont);
        calendarVO.setTargetNo(targetNo);

        //System.out.println("bngnDtm - " + bngnDtm);
        //System.out.println("endDtm - " + endDtm);
        //System.out.println("calendarRepeatCd - " + calendarRepeatCd);
        
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm", Locale.KOREA);
        Date dateStart = null;
        Date dateEnd = null;

        if(calendarRepeatCd.equals("01")) {
    		try {
    			dateStart = sdf.parse(bngnDtm);
    	        dateEnd = sdf.parse(endDtm);
    		} catch (ParseException e) {
            	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
    		}

            calendarVO.setBngnDtm(dateStart);
            calendarVO.setEndDtm(dateEnd);
            calendarVO.setPlc(plc);
            calendarVO.setAttendess(attendess);
            calendarVO.setCnfdntYn(cnfdntYn);
            calendarVO.setRegisterId(user.getSid());
            calendarService.insertCalendar(calendarVO, cmmntyArr);
        } else if (calendarRepeatCd.equals("02")) {
        	//System.out.println(bngnDtm.substring(0, 4) + bngnDtm.substring(5, 7) + bngnDtm.substring(8, 10) + bngnDtm.substring(11, 13) + bngnDtm.substring(14, 16));
            String stDt = bngnDtm.substring(0, 4) + bngnDtm.substring(5, 7) + bngnDtm.substring(8, 10);
            String endDt = endDtm.substring(0, 4) + endDtm.substring(5, 7) + endDtm.substring(8, 10);
            
            //for(int i = 0; i < Integer.parseInt(repeatNum1); i++) {
            for(int i = 0; i < Integer.parseInt(repeatNum); i++) {
            	String addStDay = AddDate(stDt, 0, 0, (7*i));
                String addEndDay = AddDate(endDt, 0, 0, (7*i));
                
                try {
        			dateStart = sdf.parse(addStDay.substring(0, 4) + "-" + addStDay.substring(4, 6) + "-" + addStDay.substring(6, 8) + " " + bngnDtm.substring(11, 13) + ":" + bngnDtm.substring(14, 16));
        	        dateEnd = sdf.parse(addEndDay.substring(0, 4) + "-" + addEndDay.substring(4, 6) + "-" + addEndDay.substring(6, 8) + " " + endDtm.substring(11,13) + ":" + endDtm.substring(14, 16));
        		} catch (ParseException e) {
                	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
        		}
                
				calendarVO.setBngnDtm(dateStart); 
				calendarVO.setEndDtm(dateEnd);
				calendarVO.setPlc(plc); 
				calendarVO.setAttendess(attendess);
				calendarVO.setCnfdntYn(cnfdntYn); 
				calendarVO.setRegisterId(user.getSid());
				calendarService.insertCalendar(calendarVO, cmmntyArr);
            }

        } else if (calendarRepeatCd.equals("03")) {
        	//System.out.println(bngnDtm.substring(0, 4) + bngnDtm.substring(5, 7) + bngnDtm.substring(8, 10) + bngnDtm.substring(11, 13) + bngnDtm.substring(14, 16));
            String stDt = bngnDtm.substring(0, 4) + bngnDtm.substring(5, 7) + bngnDtm.substring(8, 10);
            String endDt = endDtm.substring(0, 4) + endDtm.substring(5, 7) + endDtm.substring(8, 10);
            
            //for(int i = 0; i < Integer.parseInt(repeatNum1); i++) {
            for(int i = 0; i < Integer.parseInt(repeatNum); i++) {
            	String addStDay;
            	String addEndDay;
            	if(i == 0) {
            		addStDay = AddDate(stDt, 0, 0, (7*i));
                    addEndDay = AddDate(endDt, 0, 0, (7*i));
            	} else {
            		addStDay = AddDate(stDt, 0, 0, (7*(i * 2)));
                    addEndDay = AddDate(endDt, 0, 0, (7*(i * 2)));
            	}
            	
                try {
        			dateStart = sdf.parse(addStDay.substring(0, 4) + "-" + addStDay.substring(4, 6) + "-" + addStDay.substring(6, 8) + " " + bngnDtm.substring(11, 13) + ":" + bngnDtm.substring(14, 16));
        	        dateEnd = sdf.parse(addEndDay.substring(0, 4) + "-" + addEndDay.substring(4, 6) + "-" + addEndDay.substring(6, 8) + " " + endDtm.substring(11,13) + ":" + endDtm.substring(14, 16));
        		} catch (ParseException e) {
                	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
        		}
                
				calendarVO.setBngnDtm(dateStart); 
				calendarVO.setEndDtm(dateEnd);
				calendarVO.setPlc(plc); 
				calendarVO.setAttendess(attendess);
				calendarVO.setCnfdntYn(cnfdntYn); 
				calendarVO.setRegisterId(user.getSid());
				calendarService.insertCalendar(calendarVO, cmmntyArr);
            }

        } else if(calendarRepeatCd.equals("04")){
        	//String stDt = bngnDtm.substring(0, 4) + bngnDtm.substring(5, 7) + bngnDtm.substring(8, 10);
            //String endDt = endDtm.substring(0, 4) + endDtm.substring(5, 7) + endDtm.substring(8, 10);
            
            Calendar calStd = Calendar.getInstance();
            Calendar calEnd = Calendar.getInstance();

            String stdWeek = null;
            String stdDay = null;
            String endWeek = null;
            String endDay = null;
            //for(int i = 0; i < Integer.parseInt(repeatNum2); i++) {
            for(int i = 0; i < Integer.parseInt(repeatNum); i++) {
            	//String addStDay = AddDate(stDt, 0, (1*i), 0);
            	//String addEndDay = AddDate(endDt, 0, (1*i), 0);

            	// 시작일
            	calStd.set(Calendar.MONTH, Integer.parseInt(bngnDtm.substring(5, 7)) - 1 + i); /** 월(month)를 설정한다. 1월은 0부터 시작한다.**/ 
                if(i == 0) {
                	calStd.set(Calendar.DATE, Integer.parseInt(bngnDtm.substring(8, 10)));
                	stdWeek = String.valueOf(calStd.get(Calendar.WEEK_OF_MONTH));
             		//(1:일요일 ~ 7:토요알)
                	stdDay = String.valueOf(calStd.get(Calendar.DAY_OF_WEEK));
                } else {
                	calStd.set(Calendar.WEEK_OF_MONTH, Integer.parseInt(stdWeek)); /** 주 셋팅 **/
                	calStd.set(Calendar.DAY_OF_WEEK, Integer.parseInt(stdDay)); /** 요일 셋팅 **/
                }
                //System.out.println("시작 주 - " + stdWeek + ", 요일 - " + stdDay + ", " + calStd.getTime());
                //System.out.println(sdf.format(calStd.getTime()));
            	
                // 종료일
                calEnd.set(Calendar.MONTH, Integer.parseInt(endDtm.substring(5, 7)) - 1 + i); /** 월(month)를 설정한다. 1월은 0부터 시작한다.**/ 
                if(i == 0) {
                    calEnd.set(Calendar.DATE, Integer.parseInt(endDtm.substring(8, 10)));
                    endWeek = String.valueOf(calEnd.get(Calendar.WEEK_OF_MONTH));
             		//(1:일요일 ~ 7:토요알)
                    endDay = String.valueOf(calEnd.get(Calendar.DAY_OF_WEEK));
                } else {
                    calEnd.set(Calendar.WEEK_OF_MONTH, Integer.parseInt(endWeek)); /** 주 셋팅 **/
                    calEnd.set(Calendar.DAY_OF_WEEK, Integer.parseInt(endDay)); /** 요일 셋팅 **/
                }
                //System.out.println("종료 주 - " + endWeek + ", 요일 - " + endDay + ", " + calEnd.getTime());
                //System.out.println(sdf.format(calEnd.getTime()));
                
                //c.set(Calendar.MONTH, Integer.parseInt(bngnDtm.substring(5, 7)) - 1 + i); /** 월(month)를 설정한다. 1월은 0부터 시작한다.**/ 
                //c.set(Calendar.DATE, Integer.parseInt(bngnDtm.substring(8, 10)));
                //c.set(Calendar.WEEK_OF_MONTH, Integer.parseInt(week)); /** 주 셋팅 **/
                //c.set(Calendar.DAY_OF_WEEK, Integer.parseInt(day)); /** 요일 셋팅 **/ 
                
                try {
        			//dateStart = sdf.parse(addStDay.substring(0, 4) + "-" + addStDay.substring(4, 6) + "-" + addStDay.substring(6, 8) + " " + bngnDtm.substring(11, 13) + ":" + bngnDtm.substring(14, 16));
        	        //dateEnd = sdf.parse(addEndDay.substring(0, 4) + "-" + addEndDay.substring(4, 6) + "-" + addEndDay.substring(6, 8) + " " + endDtm.substring(11,13) + ":" + endDtm.substring(14, 16));
        	        dateStart = sdf.parse(sdf.format(calStd.getTime()));
        	        dateEnd = sdf.parse(sdf.format(calEnd.getTime()));
        		} catch (ParseException e) {
                	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
        		}
                
				calendarVO.setBngnDtm(dateStart); 
				calendarVO.setEndDtm(dateEnd);
				calendarVO.setPlc(plc); 
				calendarVO.setAttendess(attendess);
				calendarVO.setCnfdntYn(cnfdntYn); 
				calendarVO.setRegisterId(user.getSid());
				calendarService.insertCalendar(calendarVO, cmmntyArr);
            }
        }

        ModelAndView mav = new ModelAndView("jsonView");
        mav.addObject("success", true);
        return mav;
    }
    
    public static String AddDate(String strDate, int year, int month, int day) throws Exception { 
    	SimpleDateFormat dtFormat = new SimpleDateFormat("yyyyMMdd"); 
    	Calendar cal = Calendar.getInstance(); 
    	Date dt = dtFormat.parse(strDate); 
    	cal.setTime(dt); 
    	cal.add(Calendar.YEAR, year); 
    	cal.add(Calendar.MONTH, month); 
    	cal.add(Calendar.DATE, day); 
    	return dtFormat.format(cal.getTime()); 
    }


    @RequestMapping(value = "/updateCalendar.do", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE)
    public ModelAndView updateCalendar(
            @RequestParam(value = "CALENDAR_NO", required = true) Long calendarNo,
            @RequestParam(value = "CALENDAR_TYPE_CD", required = true) String calendarTypeCd,
            @RequestParam(value = "TITLE", required = true) String title,
            @RequestParam(value = "CONT", required = true) String cont,
            @RequestParam(value = "BNGN_DTM", required = true) String bngnDtm,
            @RequestParam(value = "END_DTM", required = true) String endDtm,
            @RequestParam(value = "PLC", required = false) String plc,
            @RequestParam(value = "ATTENDESS", required = false) String attendess,
            @RequestParam(value = "CNFDNT_YN", required = true) String cnfdntYn,
            @RequestParam(value = "CMMNTY_ARR[]", required = false) Long[] cmmntyArr,
            @RequestParam(value = "orgList[]", required = false) String[] orgList,
            @RequestParam(value = "userList[]", required = false) String[] userList,
            @RequestParam(value = "groupList[]", required = false) String[] groupList
    )  {

        UserVO user = (UserVO) EgovUserDetailsHelper.getAuthenticatedUser();//사용자 session


        CalendarVO calendarVO = calendarService.getCalendar(calendarNo);

        long targetNo = 0;

        if ((userList != null && userList.length > 0) || (orgList != null && orgList.length > 0) || (groupList != null && groupList.length > 0)) {
            TargetVO targetVO = new TargetVO();
            if (orgList != null) {
                targetVO.setOrgList(new ArrayList<String>(Arrays.asList(orgList)));
            }
            if (userList != null) {
                targetVO.setUserList(new ArrayList<String>(Arrays.asList(userList)));
            }
            if (groupList != null) {
                targetVO.setGroupList(new ArrayList<String>(Arrays.asList(groupList)));
            }
            targetNo = commonService.insertTarget(targetVO);
        }

        calendarVO.setTargetNo(targetNo);
        calendarVO.setCalendarTypeCd(calendarTypeCd);
        calendarVO.setTitle(title);
        calendarVO.setCont(cont);

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm", Locale.KOREA);
        Date dateStart = null;
        Date dateEnd = null;
		try {
			dateStart = sdf.parse(bngnDtm);
	        dateEnd = sdf.parse(endDtm);
		} catch (ParseException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
		}

        calendarVO.setBngnDtm(dateStart);
        calendarVO.setEndDtm(dateEnd);
        calendarVO.setPlc(plc);
        calendarVO.setAttendess(attendess);
        calendarVO.setCnfdntYn(cnfdntYn);
        calendarVO.setUpdaterId(user.getSid());
        calendarService.updateCalendar(calendarVO, cmmntyArr);

        ModelAndView mav = new ModelAndView("jsonView");
        mav.addObject("success", true);
        return mav;
    }

    @RequestMapping(value = "/delCalendar.do", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE)
    public ModelAndView delCalendar(
            @RequestParam(value = "calendarNo", required = true) Long calendarNo
    )  {


        calendarService.deleteCalendar(calendarNo);

        ModelAndView mav = new ModelAndView("jsonView");
        mav.addObject("success", true);
        return mav;
    }

}
