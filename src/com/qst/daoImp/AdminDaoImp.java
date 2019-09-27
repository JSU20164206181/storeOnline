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
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.qst.dao.AdminDao;

import com.qst.pojo.GoodsAdmin;
import com.qst.pojo.GoodsUser;


/**
* @ClassName: AdminDaoImp.java
* @version: v1.0.0
* @author: hdq
* @date: 2019年8月12日 下午5:02:21 
* @Description: 管理员实现类
 */
@Repository
public class AdminDaoImp extends HibernateDaoSupport implements AdminDao {
	@Resource
	public void setSF(SessionFactory sessionFactory) {
		super.setSessionFactory(sessionFactory);
	}
	
	@Override
	public GoodsAdmin findByName(String name) {
		@SuppressWarnings("unchecked")
		List<GoodsAdmin> list = (List<GoodsAdmin>) getHibernateTemplate().find("from GoodsAdmin  where gaName = ?", name); 
		if (!list.isEmpty())
			return list.get(0);
		return null;
	}

	@Override
	public void updateAdmin(GoodsAdmin admin) {
		getHibernateTemplate().update(admin);
	}
	
	
	@Override
	public GoodsAdmin findAdminById(int id) {
		GoodsAdmin admin = (GoodsAdmin) getHibernateTemplate().get(GoodsAdmin.class, id);
		return admin;
	}
	@Override
	public void addAdmin(GoodsAdmin admin) {
		getHibernateTemplate().save(admin);
		
	}
	@Override
	public void deleteAdmin(int id) {
		GoodsAdmin admin = (GoodsAdmin) getHibernateTemplate().get(GoodsAdmin.class, id);
		getHibernateTemplate().delete(admin);
	}
	@SuppressWarnings("unchecked")
	@Override
	public List<GoodsAdmin> findPages(int page, int pageSize) { 
		return getHibernateTemplate().executeFind(new HibernateCallback<Object>() {
			public Object doInHibernate(Session session) throws HibernateException, SQLException {
				String hql = "from GoodsAdmin where gaStatus!=2 order by gaId desc";
				Query query = session.createQuery(hql);
				query.setFirstResult((page - 1) * pageSize);
				query.setMaxResults(pageSize);
				List<GoodsUser> users = query.list();
				return users;
			}
		});
	}
	@Override
	public int totalPages(int pageSize) {
		String hql = "select count(*) from GoodsAdmin where gaStatus!=2";
		@SuppressWarnings("unchecked")
		List<Object> objs = getHibernateTemplate().find(hql);
		int records = Integer.parseInt(objs.get(0).toString());
		if (records % pageSize == 0) {
			return records / pageSize;
		} else {
			return records / pageSize + 1;
		}
	}
	@Override
	public int adminNumber() {
		String hql = "select count(*) from GoodsAdmin where gaStatus!=2";
		@SuppressWarnings("unchecked")
		List<Object> objs = getHibernateTemplate().find(hql);
		return Integer.parseInt(objs.get(0).toString());
	}
	@Override
	public List<GoodsAdmin> findAllAdmin() {
		String hql = "from GoodsAdmin";
		List<GoodsAdmin> userAdmin = getHibernateTemplate().find(hql);
		return userAdmin;
	}


}
