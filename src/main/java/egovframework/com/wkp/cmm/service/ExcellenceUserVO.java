package egovframework.com.wkp.cmm.service;

import java.sql.Date;
import java.util.List;

import lombok.Data;

@Data
public class ExcellenceUserVO {

	/**
	 * serialVersionUID
	 */
	private static final long serialVersionUID = 1L;
	
	private String sid;
	
	private String displayName;

	private String position;
	
	private String ou;
	
	private int rki;
	
	private float mileageScore;
	
	private String registerId;
	
	private Date registDtm;
	
	private String updaterId;
	
	private Date updDtm;
	
	List<ExcellenceUserVO> excellenceUserList;
	
}
