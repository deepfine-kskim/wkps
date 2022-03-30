/**
 *
 */
package egovframework.com.cmm.service.impl;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;
import org.apache.ibatis.session.SqlSessionFactory;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import javax.annotation.Resource;

@Repository("messengerDAO")
public class MessengerDAO extends EgovAbstractMapper {

    private final Logger LOGGER = LoggerFactory.getLogger(this.getClass());

    @Resource(name = "egov.sqlSession2")
    public void setSqlSessionFactory(SqlSessionFactory sqlSession) {
        super.setSqlSessionFactory(sqlSession);
    }

    @Override
    public int insert(String queryId, Object parameterObject) {
        return getSqlSession().insert(queryId, parameterObject);
    }
}
