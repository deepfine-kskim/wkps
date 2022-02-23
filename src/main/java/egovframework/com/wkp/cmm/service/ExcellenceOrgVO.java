package egovframework.com.wkp.cmm.service;

import java.sql.Date;
import java.util.List;

import lombok.Data;

@Data
public class ExcellenceOrgVO {

	/**
	 * serialVersionUID
	 */
	private static final long serialVersionUID = 1L;
	
	private String ou;
	
	private String ouCode;
	
	private int rki;
	
	private float mileageScore;
	
	private String registerId;
	
	private Date registDtm;
	
	private String updaterId;
	
	private Date updDtm;
	
	private List<ExcellenceOrgVO> excellenceOrgList;
	
}
