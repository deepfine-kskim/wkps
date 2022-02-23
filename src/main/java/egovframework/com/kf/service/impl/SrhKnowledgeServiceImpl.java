package egovframework.com.kf.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.com.kf.dao.SrhKnowledgeDAO;
import egovframework.com.kf.data.ParameterVO;
import egovframework.com.kf.data.RestResultVO;
import egovframework.com.kf.service.SrhKnowledgeService;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.property.EgovPropertyService;

@Service("srhKnowledgeService")
public class SrhKnowledgeServiceImpl extends EgovAbstractServiceImpl implements SrhKnowledgeService {
	
	/** SrhKnowledgeDAO */
	@Resource(name = "srhKnowledgeDAO")
	private SrhKnowledgeDAO knowledgeDAO;
	
	/** EgovPropertyService */
	@Resource(name = "konanPropertiesService")
	protected EgovPropertyService konanPropertiesService;
	
	@Override
	public RestResultVO KnowledgeSearch(ParameterVO paramVO) throws Exception {
		RestResultVO resultVO = knowledgeDAO.KnowledgeSearch(paramVO);
		if (resultVO == null)
			throw processException("info.nodata.msg");
		return resultVO;
	}

}
