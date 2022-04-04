package egovframework.com.wkp.qna.service.impl;

import egovframework.com.utl.wed.comm.ListWithPageNavigation;
import egovframework.com.utl.wed.comm.PageNavigation;
import egovframework.com.wkp.qna.service.ImprovementService;
import egovframework.com.wkp.qna.service.ImprovementVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service("improvementService")
public class ImprovementServiceImpl extends EgovAbstractServiceImpl implements ImprovementService {
	
    @Resource(name = "improvementDAO")
    private ImprovementDAO improvementDAO;

    @Override
    public ListWithPageNavigation<ImprovementVO> listWithPageNavigation(ImprovementVO param) {
        ListWithPageNavigation<ImprovementVO> listWithPageNavigation = new ListWithPageNavigation<>();
        PageNavigation pageNavigation = new PageNavigation(count(param), param.getPage(), null, null);
        param.setItemCountPerPage(pageNavigation.getItemCountPerPage());
        param.setItemOffset(pageNavigation.getItemCountPerPage() * (param.getPage() - 1));
        listWithPageNavigation.setList(improvementDAO.selectList(param));
        listWithPageNavigation.setPageNavigation(pageNavigation);
        return listWithPageNavigation;
    }

    @Override
    public int count(ImprovementVO param) {
        return improvementDAO.count(param);
    }

    @Override
    public ImprovementVO detail(ImprovementVO param) {
        return improvementDAO.selectOne(param);
    }

    @Override
    public void insert(ImprovementVO param) {
        improvementDAO.insert(param);
    }

    @Override
    public void update(ImprovementVO param) {
        improvementDAO.update(param);
    }

    @Override
    public void delete(ImprovementVO param) {
        improvementDAO.delete(param);
    }

    @Override
    public List<ImprovementVO> findAnswer(ImprovementVO param) {
        return improvementDAO.selectListAnswer(param);
    }

    @Override
    public void insertAnswer(ImprovementVO param) {
        improvementDAO.insertAnswer(param);
    }

    @Override
    public void updateAnswer(ImprovementVO param) {
        improvementDAO.updateAnswer(param);
    }

    @Override
    public void deleteAnswer(ImprovementVO param) {
        improvementDAO.deleteAnswer(param);
    }

    @Override
    public ImprovementVO detailPrev(ImprovementVO param) {
        return improvementDAO.selectOnePrev(param);
    }

    @Override
    public ImprovementVO detailNext(ImprovementVO param) {
        return improvementDAO.selectOneNext(param);
    }
}
