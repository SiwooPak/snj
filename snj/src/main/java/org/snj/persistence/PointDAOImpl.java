package org.snj.persistence;

import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class PointDAOImpl implements PointDAO {

  @Inject
  private SqlSessionTemplate mybatis;
  
  public void setMybatis(SqlSessionTemplate mybatis) {
	this.mybatis = mybatis;
}

@Override
  public void updatePoint(String uid, int point) throws Exception {

    Map<String, Object> paramMap = new HashMap<String, Object>();
    System.out.println(uid);
    paramMap.put("uid", uid);
    paramMap.put("point", point);

    mybatis.update("point.updatePoint", paramMap);

  }

}