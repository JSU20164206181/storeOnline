package com.qst.daoImp;

import com.qst.dao.CommandImgDao;
import com.qst.pojo.GoodsCommandImg;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.sql.SQLException;
import java.util.List;

/**
 * @Auther: CGL
 * @Date: 2019/8/15 19:35
 * @Description:
 */
@Transactional
@Component
public class CommandImgDaoImp extends HibernateDaoSupport implements CommandImgDao {

    @Resource
    public void setSF(SessionFactory sessionFactory){
        super.setSessionFactory(sessionFactory);
    }

    @Override
    public int add(GoodsCommandImg v) {
        return (Integer) getHibernateTemplate().save(v);
    }

    @Override
    public int batchAdd(List<GoodsCommandImg> list) {
        int affect = (Integer) getHibernateTemplate().execute(new HibernateCallback() {
            @Override
            public Object doInHibernate(Session session) throws HibernateException, SQLException {
                for(int i=0;i<list.size();i++){
                    session.save(list.get(i));
                }
                session.flush();
                session.close();
                return list.size();
            }
        });
        return affect;
    }

    @Override
    public void deleteById(Integer id) {
        GoodsCommandImg commandImg = new GoodsCommandImg();
        commandImg.setGciId(id);
        getHibernateTemplate().delete(commandImg);
    }
}
