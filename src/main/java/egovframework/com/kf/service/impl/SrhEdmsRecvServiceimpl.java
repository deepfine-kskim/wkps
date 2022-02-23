package egovframework.com.kf.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import egovframework.com.kf.dao.SrhEdmsRecvDAO;
import egovframework.com.kf.data.ParameterVO;
import egovframework.com.kf.service.SrhEdmsRecvService;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.property.EgovPropertyService;

@Service("srhEdmsRecvService")
public class SrhEdmsRecvServiceimpl extends EgovAbstractServiceImpl implements SrhEdmsRecvService{

	/** SrhEdmsRecvDAO */
	@Resource(name = "srhEdmsRecvDAO")
	private SrhEdmsRecvDAO srhEdmsRecvDAO;
	
	/** EgovPropertyService */
	@Resource(name = "konanPropertiesService")
	protected EgovPropertyService konanPropertiesService;
	
	@Override
	public int RecvSearch(ParameterVO paramVO,Model model) throws Exception {
		int a = srhEdmsRecvDAO.SrhRecv(paramVO,model);
		if (a < 0)
			throw processException("info.nodata.msg");
		return a;
	}
}
