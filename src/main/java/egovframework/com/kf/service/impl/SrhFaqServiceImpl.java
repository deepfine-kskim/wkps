package egovframework.com.kf.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.com.kf.dao.SrhFaqDAO;
import egovframework.com.kf.data.ParameterVO;
import egovframework.com.kf.data.RestResultVO;
import egovframework.com.kf.service.SrhFaqService;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.property.EgovPropertyService;

@Service("srhFaqService")
public class SrhFaqServiceImpl extends EgovAbstractServiceImpl implements SrhFaqService {
	
	/** SrhFaqDAO */
	@Resource(name = "srhFaqDAO")
	private SrhFaqDAO faqDAO;
	
	/** EgovPropertyService */
	@Resource(name = "konanPropertiesService")
	protected EgovPropertyService konanPropertiesService;
	
	@Override
	public RestResultVO FaqSearch(ParameterVO paramVO) throws Exception {
		RestResultVO resultVO = faqDAO.FaqSearch(paramVO);
		if (resultVO == null)
			throw processException("info.nodata.msg");
		return resultVO;
	}

}
