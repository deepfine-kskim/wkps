/**
 * 媛쒖슂
 * - 濡쒓렇�씤�젙梨낆뿉 ���븳 VO �겢�옒�뒪瑜� �젙�쓽�븳�떎.
 * <p>
 * �긽�꽭�궡�슜
 * - 濡쒓렇�씤�젙梨낆젙蹂댁쓽 紐⑸줉 �빆紐⑹쓣 愿�由ы븳�떎.
 *
 * @author lee.m.j
 * @version 1.0
 * @created 03-8-2009 �삤�썑 2:08:55
 * <pre>
 * == 媛쒖젙�씠�젰(Modification Information) ==
 *
 *   �닔�젙�씪       �닔�젙�옄           �닔�젙�궡�슜
 *  -------     --------    ---------------------------
 *  2009.8.3    �씠臾몄�     理쒖큹 �깮�꽦
 * </pre>
 */

package egovframework.com.wkp.cal.service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;


public class CalendarVO {

	
    static SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd", Locale.KOREA);
    static SimpleDateFormat sdfTime = new SimpleDateFormat("HH:mm", Locale.KOREA);
    private Long calendarNo;

    private String calendarTypeCd;
    private String calendarRepeatCd;
    private String repeatNum;
    private String title;
    private String cont;
    private Date bngnDtm;
    private Date endDtm;
    private String plc;
    private String attendess;
    private String cnfdntYn;
    private String registerId;
    private Date registDtm;
    private Long cmmntyNo;
    private String updaterId;
    private Date updDtm;
    private String delYn;
    private Long targetNo;

    public Long getCalendarNo() {
        return calendarNo;
    }

    public void setCalendarNo(Long calendarNo) {
        this.calendarNo = calendarNo;
    }

    public String getCalendarTypeCd() {
        return calendarTypeCd;
    }

    public void setCalendarTypeCd(String calendarTypeCd) {
        this.calendarTypeCd = calendarTypeCd;
    }

    public String getCalendarRepeatCd() {
		return calendarRepeatCd;
	}

	public void setCalendarRepeatCd(String calendarRepeatCd) {
		this.calendarRepeatCd = calendarRepeatCd;
	}

	public String getRepeatNum() {
		return repeatNum;
	}

	public void setRepeatNum(String repeatNum) {
		this.repeatNum = repeatNum;
	}

	public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getCont() {
        return cont;
    }

    public void setCont(String cont) {
        this.cont = cont;
    }

    public Date getBngnDtm() {
        return bngnDtm;
    }

    public void setBngnDtm(Date bngnDtm) {
        this.bngnDtm = bngnDtm;
    }

    public Date getEndDtm() {
        return endDtm;
    }

    public void setEndDtm(Date endDtm) {
        this.endDtm = endDtm;
    }

    public String getPlc() {
        return plc;
    }

    public void setPlc(String plc) {
        this.plc = plc;
    }

    public String getAttendess() {
        return attendess;
    }

    public void setAttendess(String attendess) {
        this.attendess = attendess;
    }

    public String getCnfdntYn() {
        return cnfdntYn;
    }

    public void setCnfdntYn(String cnfdntYn) {
        this.cnfdntYn = cnfdntYn;
    }

    public String getRegisterId() {
        return registerId;
    }

    public void setRegisterId(String registerId) {
        this.registerId = registerId;
    }

    public Date getRegistDtm() {
        return registDtm;
    }

    public void setRegistDtm(Date registDtm) {
        this.registDtm = registDtm;
    }

    public Long getCmmntyNo() {
        return cmmntyNo;
    }

    public void setCmmntyNo(Long cmmntyNo) {
        this.cmmntyNo = cmmntyNo;
    }

    public String getUpdaterId() {
        return updaterId;
    }

    public void setUpdaterId(String updaterId) {
        this.updaterId = updaterId;
    }

    public Date getUpdDtm() {
        return updDtm;
    }

    public void setUpdDtm(Date updDtm) {
        this.updDtm = updDtm;
    }

    public String getDelYn() {
        return delYn;
    }

    public void setDelYn(String delYn) {
        this.delYn = delYn;
    }

    public Long getTargetNo() {
        return targetNo;
    }

    public void setTargetNo(Long targetNo) {
        this.targetNo = targetNo;
    }

    public String getBeginDate() {
        if (sdf == null) {
            sdf = new SimpleDateFormat("yyyy-MM-dd", Locale.KOREA);
        }
        if (bngnDtm != null) {
            return sdf.format(bngnDtm);
        }
        return null;
    }

    public String getEndDate() {
        if (sdf == null) {
            sdf = new SimpleDateFormat("yyyy-MM-dd", Locale.KOREA);
        }
        if (endDtm != null) {
            return sdf.format(endDtm);
        }

        return null;
    }

    public String getBeginTime() {
        if (sdfTime == null) {
            sdfTime = new SimpleDateFormat("HH:mm", Locale.KOREA);
        }
        if (bngnDtm != null) {
            return sdfTime.format(bngnDtm);
        }
        return null;
    }

    public String getEndTime() {
        if (sdfTime == null) {
            sdfTime = new SimpleDateFormat("HH:mm", Locale.KOREA);
        }
        if (endDtm != null) {
            return sdfTime.format(endDtm);
        }
        return null;
    }

}
