package egovframework.com.cmm.service.impl;

import egovframework.com.cmm.service.MessengerService;
import egovframework.com.cmm.service.MessengerVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

@Service("messengerService")
public class MessengerServiceImpl extends EgovAbstractServiceImpl implements MessengerService {

    @Resource(name = "messengerDAO")
    private MessengerDAO messengerDAO;

    @Override
    public int insert(MessengerVO messengerVO) {
		return messengerDAO.insert("MessengerDAO.insert", messengerVO);
    }
}
