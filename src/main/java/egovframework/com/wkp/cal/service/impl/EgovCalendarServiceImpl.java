package egovframework.com.wkp.cal.service.impl;

import java.util.List;
import javax.annotation.Resource;

import egovframework.com.utl.wed.enums.LogSubjectType;
import egovframework.com.utl.wed.enums.LogType;
import egovframework.mgt.wkp.log.service.EgovLogService;
import org.springframework.stereotype.Service;

import egovframework.com.wkp.cal.service.CalendarVO;
import egovframework.com.wkp.cal.service.EgovCalendarService;
import egovframework.com.wkp.cmu.service.CommunityVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * 일반 로그인, 인증서 로그인을 처리하는 비즈니스 구현 클래스
 * @author 공통서비스 개발팀 박지욱
 * @since 2009.03.06
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2009.03.06  박지욱          최초 생성
 *  2011.08.26  서준식          EsntlId를 이용한 로그인 추가
 *  2014.12.08	이기하			암호화방식 변경(EgovFileScrty.encryptPassword)
 *  2017.07.21  장동한 			로그인인증제한 작업
 *  </pre>
 */


@Service("calendarService")
public class EgovCalendarServiceImpl extends EgovAbstractServiceImpl implements EgovCalendarService {

    @Resource(name="calendarDAO")
    private CalendarDAO calendarDAO;

	@Resource(name = "logService")
	EgovLogService egovLogService;

	@Override
	public List<CalendarVO> selectCalendarListMonth(int year, int month,String userSid,String ouCode) {
		return calendarDAO.selectCalendarListMonth(year, month,userSid,ouCode);
	}

	@Override
	public List<CalendarVO> selectCalendarListDay(int year, int month, int day,String userSid,String ouCode) {
		return calendarDAO.selectCalendarListDay(year, month, day,userSid,ouCode);
	}
	@Override
	public List<CalendarVO> selectCalendarListDayFromCommunity(int year, int month,int day,Long cmmntyNo){
		return calendarDAO.selectCalendarListDayFromCommunity(year, month, day,cmmntyNo);
	}
	@Override
	public CalendarVO getCalendar(Long calendarNo){
		egovLogService.insert(LogType.SELECT_DETAIL, LogSubjectType.CALENDAR, calendarNo);
		return calendarDAO.getCalendar(calendarNo);
	}
	@Override
	public List<CommunityVO> getCalendarCommunity(Long calendarNo){
		return calendarDAO.getCalendarCommunity(calendarNo);
	}
	@Override
	public int insertCalendar(CalendarVO calendarVO,Long [] cmmntyNo) {

		calendarDAO.insertCalendar(calendarVO);

		egovLogService.insert(LogType.INSERT, LogSubjectType.CALENDAR, calendarVO);
		
		if(calendarVO.getCalendarTypeCd().equals("05")) {
			for(Long no : cmmntyNo) {
				calendarDAO.insertCommunityCalendar(calendarVO.getCalendarNo(),no);
			}
		}
		
		return 1;
	}

	@Override
	public int updateCalendar(CalendarVO calendarVO,Long [] cmmntyNo) {
		calendarDAO.updateCalendar(calendarVO);

		egovLogService.insert(LogType.UPDATE, LogSubjectType.CALENDAR, calendarVO);

		if(calendarVO.getCalendarTypeCd().equals("05")) {
			calendarDAO.deleteCommunityCalendar(calendarVO.getCalendarNo());
			for(Long no : cmmntyNo) {
				calendarDAO.insertCommunityCalendar(calendarVO.getCalendarNo(),no);
			}
		}
		return 1;
	}

	@Override
	public int deleteCalendar(Long calendarNo) {

		egovLogService.insert(LogType.DELETE, LogSubjectType.CALENDAR, calendarNo);

		return calendarDAO.deleteCalendar(calendarNo);
	}


}
