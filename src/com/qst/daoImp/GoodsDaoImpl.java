package com.qst.daoImp;

import com.qst.dao.GoodsDao;
import com.qst.pojo.GoodsProduct;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;
import java.sql.SQLException;
import java.text.DecimalFormat;
import java.util.Date;
import java.util.List;

/**
 * @Auther: CGL
 * @Date: 2019/8/7 19:40
 * @Description: 商品类dao层接口实现
 */
@Component
public class GoodsDaoImpl extends HibernateDaoSupport implements GoodsDao {

	@Resource
	public void setSF(SessionFactory sessionFactory) {
		super.setSessionFactory(sessionFactory);
	}

	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Override
	public List<GoodsProduct> findNewProducts() {
		return getHibernateTemplate().executeFind(new HibernateCallback() {
			@Override
			public Object doInHibernate(Session session) throws HibernateException, SQLException {
				String hql = "from GoodsProduct gp where gp.gpStatus=1 order by gp.gpCreateDate desc";
				Query query = session.createQuery(hql);
				query.setFirstResult(0);
				query.setMaxResults(4);
				return query.list();
			}
		});
	}

	@SuppressWarnings("unchecked")
	@Override
	public GoodsProduct findOneById(int id) {
		List<GoodsProduct> list = getHibernateTemplate().find("from GoodsProduct gp where gp.gpId= ?", id);
		if (!list.isEmpty())
			return list.get(0);
		return null;
	}

	@Override
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public List<GoodsProduct> findByType(int type, int page, int pageSize) {
		return getHibernateTemplate().executeFind(new HibernateCallback() {
			@Override
			public Object doInHibernate(Session session) throws HibernateException, SQLException {
				String hql = "from GoodsProduct gp where gp.gpCid = " + type+" and gp.gpStatus=1";
				Query query = session.createQuery(hql);
				query.setFirstResult((page - 1) * pageSize);
				query.setMaxResults(pageSize);
				return query.list();
			}
		});
	}

	@SuppressWarnings("unchecked")
	@Override
	public int totalPageType(int type, int pageSize) {
		List<Object> list = getHibernateTemplate().find("select  count(*) from GoodsProduct gp where gp.gpCid = ?",
				type);
		if (!list.isEmpty()) {
			int records = Integer.valueOf(list.get(0).toString());
			return records % pageSize == 0 ? records / pageSize : records / pageSize + 1;
		}
		return 0;
	}

	@Override
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public List<GoodsProduct> findByUserId(int userId, int page, int pageSize) {
		return getHibernateTemplate().executeFind(new HibernateCallback() {
			@Override
			public Object doInHibernate(Session session) throws HibernateException, SQLException {
				String hql = "from GoodsProduct gp where gp.gpUid = " + userId;
				Query query = session.createQuery(hql);
				query.setFirstResult((page - 1) * pageSize);
				query.setMaxResults(pageSize);
				return query.list();
			}
		});
	}

	@SuppressWarnings("unchecked")
	@Override
	public int totalPageByUserId(int userId, int pageSize) {
		List<Object> list = getHibernateTemplate().find("select  count(*) from GoodsProduct gp where gp.gpUid = ?",
				userId);
		if (!list.isEmpty()) {
			int records = Integer.parseInt(list.get(0).toString());
			return records % pageSize == 0 ? records / pageSize : records / pageSize + 1;
		}
		return 0;
	}

	@Override
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public List<GoodsProduct> fuzzySearch(String key, int page, int pageSize) {
		return getHibernateTemplate().executeFind(new HibernateCallback() {
			@Override
			public Object doInHibernate(Session session) throws HibernateException, SQLException {
				String hql = "from GoodsProduct gp where gp.gpName like '%" + key + "%'" + " order by gp.gpUid";
				Query query = session.createQuery(hql);
				query.setFirstResult((page - 1) * pageSize);
				query.setMaxResults(pageSize);
				return query.list();
			}
		});
	}

	@SuppressWarnings("unchecked")
	@Override
	public int totalPageByFS(String key, int pageSize) {
		String hql = "select count(*) from GoodsProduct gp where gp.gpName like '%" + key + "%'";
		List<Object> list = getHibernateTemplate().find(hql);
		if (!list.isEmpty()) {
			int records = Integer.parseInt(list.get(0).toString());
			return records % pageSize == 0 ? records / pageSize : records / pageSize + 1;
		}
		return 0;
	}

    @Override
    public GoodsProduct findById(int id) {
        String hql = "from GoodsProduct gp left outer join fetch gp.goodsProductimages gim where gim.gpiStatus = 1 and gim.gpiPid ="+id;
        List<GoodsProduct> list = getHibernateTemplate().find(hql);
        if(!list.isEmpty())
            return list.get(0);
        return null;
    }

	@Override
	public int addGoods(GoodsProduct v) {
		v.setGpStatus(2);
		v.setGpCreateDate(new Date());
		v.setGpStar(4.0);
		DecimalFormat df = new DecimalFormat("0.00");
		v.setGpPromotePrice(Double.parseDouble(df.format(v.getGpPromotePrice())));
		v.setGpOriginalPrice(Double.parseDouble(df.format(v.getGpPromotePrice() / 0.8)));
		return (int) getHibernateTemplate().save(v);
	}

	@Override
	public void updateGoods(GoodsProduct v) {
		getHibernateTemplate().update(v);
	}

	@Override
	public void delete(int id) {
		GoodsProduct gp = new GoodsProduct();
		gp.setGpCid(id);
		getHibernateTemplate().delete(gp);
	}

}
