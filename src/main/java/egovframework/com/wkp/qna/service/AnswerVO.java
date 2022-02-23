/**
 * 개요
 * - 로그인정책에 대한 VO 클래스를 정의한다.
 * <p>
 * 상세내용
 * - 로그인정책정보의 목록 항목을 관리한다.
 *
 * @author lee.m.j
 * @version 1.0
 * @created 03-8-2009 오후 2:08:55
 * <pre>
 * == 개정이력(Modification Information) ==
 *
 *   수정일       수정자           수정내용
 *  -------     --------    ---------------------------
 *  2009.8.3    이문준     최초 생성
 * </pre>
 */

package egovframework.com.wkp.qna.service;

import lombok.Data;

import java.util.Date;

@Data
public class AnswerVO {

    /**
     * serialVersionUID
     */
    private static final long serialVersionUID = 1L;

    private Long answerNo;
    private Long questionNo;
    private String cont;
    private String slctnYn;
    private String registerId;
    private Date registDtm;
    private String updaterId;
    private Date updDtm;
    private String delYn;
    private String registerName;
    private String updaterName;

    private int recommendCount;
    private boolean mine;

    private Long atchFileNo;
    private String fileSn;
    private String fileStreCours;
    private String streFileNm;
    private String orignlFileNm;
    private String fileExtSn;
    private Long fileSize;

}
