package com.qst.daoImp;

import com.qst.dao.CommandDao;
import com.qst.dao.CommandImgDao;
import com.qst.pojo.GoodsReview;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;
import java.sql.SQLException;
import java.util.List;

/**
 * @Auther: CGL
 * @Date: 2019/8/15 19:53
 * @Description:  评论dao层方法实现类
 */
@Component
public class CommandDaoImp extends HibernateDaoSupport implements CommandDao {

    @Resource
    public void setSF(SessionFactory sessionFactory){
        super.setSessionFactory(sessionFactory);
    }

    @Override
    public int add(GoodsReview v) {
        return (Integer) getHibernateTemplate().save(v);
    }

    @Override
    public void deleteById(int id) {
        GoodsReview goodsReview = new GoodsReview();
        goodsReview.setGrId(id);
        getHibernateTemplate().delete(goodsReview);
    }

    @Override
    public List<GoodsReview> findByGoodsId(int id) {
        List<GoodsReview> list = getHibernateTemplate().find("from GoodsReview gr where  gr.grPid = ? order by gr.grStar desc ",id);
        return list;
    }

    @SuppressWarnings("unchecked")
    @Override
    public List<GoodsReview> findByPage(int id, int page, int pageSize) {
        return getHibernateTemplate().executeFind(new HibernateCallback() {
            @Override
            public Object doInHibernate(Session session) throws HibernateException, SQLException {
                String hql = "from GoodsReview gr where  gr.grPid = "+ id+ "order by gr.grStar";
                Query query = session.createQuery(hql);
                query.setFirstResult((page-1)*pageSize);
                query.setMaxResults(pageSize);
                return query.list();
            }
        });
    }

    @Override
    public int totalNum(int id) {
       List<Object> list = getHibernateTemplate().find("select count(*) from GoodsReview gr where  gr.grPid = ?",id);
       if (!list.isEmpty())
           return  Integer.parseInt(list.get(0).toString());

       return 0;
    }
}
