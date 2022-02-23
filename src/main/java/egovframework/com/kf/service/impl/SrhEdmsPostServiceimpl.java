package egovframework.com.kf.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import egovframework.com.cmm.EgovComException;
import egovframework.com.kf.dao.SrhEdmsPostDAO;
import egovframework.com.kf.data.ParameterVO;
import egovframework.com.kf.data.RestResultVO;
import egovframework.com.kf.service.SrhEdmsPostService;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.property.EgovPropertyService;

@Service("srhEdmsPostService")
public class SrhEdmsPostServiceimpl extends EgovAbstractServiceImpl implements SrhEdmsPostService{

	/** SrhEdmsPostDAO */
	@Resource(name = "srhEdmsPostDAO")
	private SrhEdmsPostDAO srhEdmsPostDAO;
	
	/** EgovPropertyService */
	@Resource(name = "konanPropertiesService")
	protected EgovPropertyService konanPropertiesService;
	
	@Override
	public int PostSearch(ParameterVO paramVO,Model model) throws Exception {
		int a = srhEdmsPostDAO.SrhPost(paramVO,model);
		if (a < 0)
			throw processException("info.nodata.msg");
		return a;
	}
}
