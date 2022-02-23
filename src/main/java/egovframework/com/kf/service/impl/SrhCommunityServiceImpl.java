package egovframework.com.kf.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.com.kf.dao.SrhCommunityDAO;
import egovframework.com.kf.data.ParameterVO;
import egovframework.com.kf.data.RestResultVO;
import egovframework.com.kf.service.SrhCommunityService;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.property.EgovPropertyService;

@Service("srhCommunityService")
public class SrhCommunityServiceImpl extends EgovAbstractServiceImpl implements SrhCommunityService {
	
	/** SrhCommunityDAO */
	@Resource(name = "srhCommunityDAO")
	private SrhCommunityDAO communityDAO;
	
	/** EgovPropertyService */
	@Resource(name = "konanPropertiesService")
	protected EgovPropertyService konanPropertiesService;
	
	@Override
	public RestResultVO CommunitySearch(ParameterVO paramVO) throws Exception {
		RestResultVO resultVO = communityDAO.CommunitySearch(paramVO);
		if (resultVO == null)
			throw processException("info.nodata.msg");
		return resultVO;
	}
	
}
