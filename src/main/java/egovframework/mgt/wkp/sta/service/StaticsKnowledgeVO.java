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

package egovframework.mgt.wkp.sta.service;

import lombok.Data;

import java.sql.Date;

@Data
public class StaticsKnowledgeVO {

    private static final long serialVersionUID = 1L;

    private String dt;

    private long knowledgeCount; //작성수
    private long knowledgeCreateCount; //입력수
    private long knowledgeUpdateCount; //갱신수
    private long preKnowledgeCount; //전일 작성수

    private Integer year;    
    private Integer month;

    private Integer page = 1;
    private Integer itemCountPerPage = 10;
    private Integer itemOffset = 0;

    private String title;
    private Long inqCnt;
    private Long recCnt;
    private Long regCnt;
    private Long reportCnt;
    private Long referenceCnt;
    private Long personalCnt;
    private Date registDtm;
    private String ou;
    private String ownerName;
    private String ownerOu;
    private String displayName;
    private Long newCnt;
    private Long updCnt;
    private Long viewCnt;
    private Long newMileage;
    private Long updMileage;
    private Long recMileage;
    private Long viewMileage;
    private Long totalMileage;

    private String startDate;
    private String endDate;

    private String searchType;

    private String type;
}
