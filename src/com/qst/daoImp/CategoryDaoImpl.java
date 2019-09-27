package com.qst.daoImp;

import com.qst.dao.CategoryDao;
import com.qst.pojo.GoodsCategory;
import org.hibernate.SessionFactory;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;
import java.util.List;

/**
 * @Auther: CGL
 * @Date: 2019/8/9 20:01
 * @Description:
 */
@Component
public class CategoryDaoImpl extends HibernateDaoSupport implements CategoryDao {

    @Resource
    public void setSF(SessionFactory sessionFactory){
        super.setSessionFactory(sessionFactory);
    }

    @Override
    public List<GoodsCategory> findAll() {
        List<GoodsCategory> list = getHibernateTemplate().find("from GoodsCategory");
        return list;
    }

    @Override
    public int addCategory(GoodsCategory v) {
        return 0;
    }
}
