/**
 * 
 */
package com.qst.daoImp;

import java.sql.SQLException;
import java.util.List;

import javax.annotation.Resource;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;
import org.springframework.stereotype.Component;

import com.qst.dao.OrderItemDao;
import com.qst.pojo.GoodsOrder;
import com.qst.pojo.GoodsOrderitem;
import com.qst.pojo.ReceiveAddress;

/**
 * @ClassName: OrderItemDaoImp.java
 * @version: v1.0.0
 * @author: ZYL
 * @date: 2019年8月13日 上午11:09:40
 * @Description: 订单商品Dao实现类
 */
@Component
public class OrderItemDaoImp extends HibernateDaoSupport implements OrderItemDao {
	@Resource
	public void setSF(SessionFactory sessionFactory) {
		super.setSessionFactory(sessionFactory);
	}

	@Override
	public int addOderItem(GoodsOrderitem goi) {
		int id = (int) getHibernateTemplate().save(goi);
		return id;
	}

	@Override
	public void deleteOderItem(int id) {
		GoodsOrderitem goi = (GoodsOrderitem) getHibernateTemplate().get(GoodsOrderitem.class, id);
		getHibernateTemplate().delete(goi);
	}

	@Override
	public void updateOrderItem(GoodsOrderitem goi) {
		getHibernateTemplate().update(goi);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<GoodsOrderitem> findOrderItemByOid(int id) {
		List<GoodsOrderitem> orderItemList = getHibernateTemplate().find("from GoodsOrderitem goi where goi.goiOid = ?",
				id);
		if (!orderItemList.isEmpty())
			return orderItemList;
		return null;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<String> findOidByPname(String name) {
		List<String> oidList = getHibernateTemplate().find("from GoodsOrderitem goi where goi.goiPname = ?", name);
		if (!oidList.isEmpty())
			return oidList;
		return null;
	}

	@SuppressWarnings("unchecked")
	@Override
	public GoodsOrderitem findGoiById(int id) {
		List<GoodsOrderitem> list = getHibernateTemplate().find("from GoodsOrderitem goi where goi.goiId = ?", id);
		if (!list.isEmpty())
			return list.get(0);
		return null;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<GoodsOrderitem> findGoiByOrderCode(String code) {
		List<GoodsOrderitem> orderItemList = getHibernateTemplate()
				.find("from GoodsOrderitem goi where goi.goiOrderCode = ?", code);
		if (!orderItemList.isEmpty())
			return orderItemList;
		return null;
	}

	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Override
	public List<GoodsOrderitem> findOrderByStatus(int id, int status, int page, int pageSize) {
		return getHibernateTemplate().executeFind(new HibernateCallback() {
			@Override
			public Object doInHibernate(Session session) throws HibernateException, SQLException {
				String hql = "from GoodsOrderitem goi where goi.goiUid = " + id + " and goi.goiStatus=" + status
						+ " order by goi.goiId desc";
				Query query = session.createQuery(hql);
				query.setFirstResult((page - 1) * pageSize);
				query.setMaxResults(pageSize);
				return query.list();
			}
		});
	}
}
