package egovframework.com.kf.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.com.kf.dao.SrhSurveyDAO;
import egovframework.com.kf.data.ParameterVO;
import egovframework.com.kf.data.RestResultVO;
import egovframework.com.kf.service.SrhSurveyService;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.property.EgovPropertyService;

@Service("srhSurveyService")
public class SrhSurveyServiceImpl extends EgovAbstractServiceImpl implements SrhSurveyService {
	
	/** SrhSurveyDAO */
	@Resource(name = "srhSurveyDAO")
	private SrhSurveyDAO surveyDAO;
	
	/** EgovPropertyService */
	@Resource(name = "konanPropertiesService")
	protected EgovPropertyService konanPropertiesService;
	
	@Override
	public RestResultVO SurveySearch(ParameterVO paramVO) throws Exception {
		RestResultVO resultVO = surveyDAO.SurveySearch(paramVO);
		if (resultVO == null)
			throw processException("info.nodata.msg");
		return resultVO;
	}

}
