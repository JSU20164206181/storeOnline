package com.qst.daoImp;

import com.qst.dao.ShopCarDao;
import com.qst.pojo.GoodsCategory;
import com.qst.pojo.ShopCar;
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
 * @Date: 2019/8/7 11:06
 * @Description:
 */
@Component
public class ShopCarDaoImpl extends HibernateDaoSupport implements ShopCarDao {

    @Resource
    public void setSF(SessionFactory sessionFactory) {
        super.setSessionFactory(sessionFactory);
    }

	@SuppressWarnings("unchecked")
	@Override
	public ShopCar findById(int id) {
		List<ShopCar> list = getHibernateTemplate().find("from ShopCar s where s.id = ?", id);
		if (!list.isEmpty())
			return list.get(0);
		return null;
	}

	@SuppressWarnings("unchecked")
	@Override
	public ShopCar findByGoodsId(int id) {
		List<ShopCar> list = getHibernateTemplate().find("from ShopCar s where s.goodsId = ?", id);
		if (!list.isEmpty())
			return list.get(0);
		return null;
	}

	@Override
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public List<ShopCar> findByUserId(int id, int page, int pageSize) {
		return getHibernateTemplate().executeFind(new HibernateCallback() {
			public Object doInHibernate(Session session) throws HibernateException, SQLException {
				String hql = "from ShopCar s where s.userId = " + id;
				Query query = session.createQuery(hql);
				query.setFirstResult((page - 1) * pageSize);
				query.setMaxResults(pageSize);
				List<ShopCar> shopCarList = query.list();
				return shopCarList;
			}
		});
	}

    @Override
    public ShopCar isExist(int userId, int goodsId) {
        Object[] obj = {goodsId,userId};
        List<ShopCar> sc = getHibernateTemplate().find("from ShopCar sc where sc.goodsId = ? and sc.userId = ?",obj);
        if (!sc.isEmpty())
            return sc.get(0);
        return null;
    }
	@SuppressWarnings("unchecked")
	@Override
	public List<ShopCar> findAllByUserId(int id) {
		List<ShopCar> shopCarList = getHibernateTemplate().find("from ShopCar s where s.userId = ?", id);
		if (!shopCarList.isEmpty())
			return shopCarList;
		return null;
	}

    @Override
    public int totalPage(int id, int pageSize) {
        List<Integer> list = getHibernateTemplate().find("select count(*) from ShopCar sc where sc.id = ?",id);
        if(!list.isEmpty()){
             int records = list.get(0);
             return records%pageSize==0?records/pageSize:records/pageSize+1;
        }

        return 0;
    }


    @Override
    public int addShopCar(ShopCar sc) {
        System.out.println(sc);
       int id = (int) getHibernateTemplate().save(sc);
        return id;
    }

    @Override
    public void deleteById(int id) {
    	ShopCar sc = (ShopCar) getHibernateTemplate().get(ShopCar.class, id);
        getHibernateTemplate().delete(sc);
    }

    @Override
    public void updateById(ShopCar sc) {
        getHibernateTemplate().update(sc);
    }
}
