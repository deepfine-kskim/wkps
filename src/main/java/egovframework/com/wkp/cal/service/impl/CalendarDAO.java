package egovframework.com.wkp.cal.service.impl;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;

import org.springframework.stereotype.Repository;

import com.ibm.icu.util.Calendar;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import egovframework.com.wkp.cal.service.CalendarVO;
import egovframework.com.wkp.cmu.service.CommunityVO;

/**
 * 일반 로그인, 인증서 로그인을 처리하는 DAO 클래스
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
 *  2017.07.21  장동한 			로그인인증제한 작업
 *  </pre>
 */
@Repository("calendarDAO")
public class CalendarDAO extends EgovComAbstractDAO {
	
	public List<CalendarVO> findCalendar(Long cmmntyNo, int limit, int startIndex) {
		HashMap<String,Object> param = new HashMap<String, Object>();
		param.put("cmmntyNo",cmmntyNo);
		param.put("limit", limit);
		param.put("startIndex", startIndex);
		return selectList("CalendarDAO.findCalendar", param);
	}
	
	public int findCalendarTotalCount(Long cmmntyNo) {
		HashMap<String,Object> param = new HashMap<String, Object>();
		param.put("cmmntyNo",cmmntyNo);
		
		return selectOne("CalendarDAO.findCalendarTotalCount", param);
	}
    
	public List<CalendarVO> selectCalendarListMonth(int year, int month,String userSid,String ouCode) {
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd", Locale.KOREA);
		
		Calendar calStartDate = Calendar.getInstance();
		calStartDate.set(year, month-1, 1, 0, 0, 0);
		Date startDate = calStartDate.getTime();
		calStartDate.add(Calendar.MONTH, 1);
		Date endDate = calStartDate.getTime();
		
		
		
		HashMap<String,Object> param = new HashMap<String, Object>();
		param.put("start_date", sdf.format(startDate));
		param.put("end_date", sdf.format(endDate));
		param.put("USER_SID",userSid);
		param.put("OU_CODE",ouCode);
    	return selectList("CalendarDAO.selectCalendarList", param);
    }
	
	public List<CalendarVO> selectCalendarListDay(int year, int month,int day,String userSid,String ouCode) {
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd", Locale.KOREA);
		
		Calendar calStartDate = Calendar.getInstance();
		calStartDate.set(year, month-1, day, 0, 0, 0);
		Date startDate = calStartDate.getTime();
		calStartDate.add(Calendar.DATE, 1);
		Date endDate = calStartDate.getTime();
		
		HashMap<String,Object> param = new HashMap<String, Object>();
		param.put("start_date", sdf.format(startDate));
		param.put("end_date", sdf.format(endDate));
		param.put("USER_SID",userSid);
		param.put("OU_CODE",ouCode);
    	return selectList("CalendarDAO.selectCalendarList", param);
    }
	public List<CalendarVO> selectCalendarListDayFromCommunity(int year, int month,int day,Long cmmntyNo) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd", Locale.KOREA);
		
		Calendar calStartDate = Calendar.getInstance();
		calStartDate.set(year, month-1, day, 0, 0, 0);
		Date startDate = calStartDate.getTime();
		calStartDate.add(Calendar.DATE, 1);
		Date endDate = calStartDate.getTime();
		
		HashMap<String,Object> param = new HashMap<String, Object>();
		param.put("start_date", sdf.format(startDate));
		param.put("end_date", sdf.format(endDate));
		param.put("cmmntyNo", cmmntyNo);
    	return selectList("CalendarDAO.selectCalendarListDayFromCommunity", param);
		
	}
	public CalendarVO getCalendar(Long calendarNo) {
		HashMap<String,Object> param = new HashMap<String, Object>();
		param.put("calendarNo", calendarNo);
    	return selectOne("CalendarDAO.getCalendar", param);
	}
	public List<CommunityVO> getCalendarCommunity(Long calendarNo) {
		HashMap<String,Object> param = new HashMap<String, Object>();
		param.put("calendarNo", calendarNo);
    	return selectList("CalendarDAO.getCalendarCommunity", param);
	}
    public int insertCalendar(CalendarVO calendarVO) {
    	return insert("CalendarDAO.insertCalendar", calendarVO);
    }
    
    public int updateCalendar(CalendarVO calendarVO) {
    	return update("CalendarDAO.updateCalendar", calendarVO);
    }
    
    public int deleteCalendar(Long calendarNo) {

		HashMap<String,Object> param = new HashMap<String, Object>();
		param.put("calendarNo", calendarNo);
    	return update("CalendarDAO.deleteCalendar", param);
    }
    public void insertCommunityCalendar(Long calendarNo,Long cmmntyNo) {
    	HashMap<String,Object> param = new HashMap<String, Object>();
		param.put("calendarNo", calendarNo);
		param.put("cmmntyNo", cmmntyNo);
		insert("CalendarDAO.insertCommunityCalendar", param);
    }
    public void deleteCommunityCalendar(Long calendarNo) {
    	HashMap<String,Object> param = new HashMap<String, Object>();
		param.put("calendarNo", calendarNo);
		
		insert("CalendarDAO.deleteCommunityCalendar", param);
    }
}
