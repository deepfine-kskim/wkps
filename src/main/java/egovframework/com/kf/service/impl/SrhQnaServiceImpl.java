package egovframework.com.kf.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.com.kf.dao.SrhQnaDAO;
import egovframework.com.kf.data.ParameterVO;
import egovframework.com.kf.data.RestResultVO;
import egovframework.com.kf.service.SrhQnaService;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.property.EgovPropertyService;

@Service("srhQnaService")
public class SrhQnaServiceImpl extends EgovAbstractServiceImpl implements SrhQnaService {
	
	/** SrhQnaDAO */
	@Resource(name = "srhQnaDAO")
	private SrhQnaDAO qnaDAO;
	
	/** EgovPropertyService */
	@Resource(name = "konanPropertiesService")
	protected EgovPropertyService konanPropertiesService;
	
	@Override
	public RestResultVO QnaSearch(ParameterVO paramVO) throws Exception {
		RestResultVO resultVO = qnaDAO.QnaSearch(paramVO);
		if (resultVO == null)
			throw processException("info.nodata.msg");
		return resultVO;
	}

}
