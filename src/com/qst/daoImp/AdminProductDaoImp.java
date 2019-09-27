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
import org.springframework.stereotype.Repository;

import com.qst.dao.AdminProductDao;
import com.qst.pojo.GoodsProduct;



/**
 * @ClassName:ProductDaoImp.java
 * @version:v1.0.0
 * @author:mwy
 * @date:2019年8月7日 下午8:48:50
 * @Description:管理员商品dao实现类
 */
@Repository
public class AdminProductDaoImp extends HibernateDaoSupport implements AdminProductDao {
	@Resource
	public void setSF(SessionFactory sessionFactory) {
		super.setSessionFactory(sessionFactory);
	}
	/**
	 * 商品模糊搜索
	 * @param id
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List<GoodsProduct> findPagesByFuzzy(int page,int pageSize,int minStatus,int maxStatus,String keyword){
		return getHibernateTemplate().executeFind(new HibernateCallback() {
			public Object doInHibernate(Session session) throws HibernateException, SQLException {
				String hql = "from GoodsProduct where gpStatus>="+minStatus+" and gpStatus<="+maxStatus;
				hql+="  and (gpId LIKE '%"+keyword+"%' ";
				hql+="  or gpName LIKE '%"+keyword+"%' )";
				
				hql+="order by gpId desc";
				Query query = session.createQuery(hql);
				query.setFirstResult((page - 1) * pageSize);
				query.setMaxResults(pageSize);
				List<GoodsProduct> productList = query.list();
				return productList;
			}
		});
	}
	/**
	 * 模糊搜索总页数
	 */
	@Override
	public int totalPagesByFuzzy(int pageSize,int minStatus,int maxStatus,String keyword) {
		String hql = "select count(*)from GoodsProduct where gpStatus>=? and gpStatus<=?";
		hql+="  and (gpId LIKE '%"+keyword+"%' ";
		hql+="  or gpName LIKE '%"+keyword+"%' )";
		
		List<Object> objs = getHibernateTemplate().find(hql,minStatus,maxStatus);
		int records = Integer.parseInt(objs.get(0).toString());
		if (records % pageSize == 0) {

			return records / pageSize;
		} else {
			return records / pageSize + 1;
		}
	}
	/**
	 * 模糊搜索获取商品总数
	 * @return
	 */
	@Override
	@SuppressWarnings("unchecked")
	public int getCountByFuzzy(int minStatus,int maxStatus,String keyword) {
		
		String hql = "select count(*)from GoodsProduct where gpStatus>=? and gpStatus<=?";
		hql+="  and (gpId LIKE '%"+keyword+"%' ";
		hql+="  or gpName LIKE '%"+keyword+"%' )";
		List<Object> objs = getHibernateTemplate().find(hql,minStatus,maxStatus);
		int records = Integer.parseInt(objs.get(0).toString());
		
		return records; 
			
	}
	/**
	 * 根据id获取
	 */
	@Override
	public GoodsProduct findById(int id) {
		GoodsProduct product = (GoodsProduct) getHibernateTemplate().get(GoodsProduct.class, id);
		return product;
	}
	/**
	 * 查询该分类是否有商品
	 * @param id
	 * @return
	 */
	@Override
	public boolean categoryIsUsing(int id){
		@SuppressWarnings("unchecked")
		List<GoodsProduct> list=getHibernateTemplate().find("from GoodsProduct where gpCid=?",id);
		if(list!=null && list.size()>0){
			return true;
		}
		return false;
	}
	/**
	 * 根据名称获取
	 */
	@Override
	public GoodsProduct findByName(String name,int minStatus,int maxStatus) {
		@SuppressWarnings("unchecked")
		List<GoodsProduct> list=getHibernateTemplate().find("from GoodsProduct where gpName=?and gpStatus>=? and gpStatus<=?",name,minStatus,maxStatus);
		return list.get(0);
	}
	/**
	 * 根据分类获取
	 */
	@Override
	public GoodsProduct findByCategoryId(int gpCid,int minStatus,int maxStatus) {
		@SuppressWarnings("unchecked")
		List<GoodsProduct> list=getHibernateTemplate().find("from GoodsProduct where gpCid=? and gpStatus>=? and gpStatus<=?",gpCid,minStatus,maxStatus);
		return list.get(0);
	}
	/**
	 * 根据状态获取
	 */
	@Override
	public GoodsProduct findByStatus(int gpStatus) {
		@SuppressWarnings("unchecked")
		List<GoodsProduct> list=getHibernateTemplate().find("from GoodsProduct where gpStatus=?",gpStatus);
		return list.get(0);
	}
	/**
	 * 根据用户名称获取
	 */
	@Override
	public GoodsProduct findByUserId(int gpUid,int minStatus,int maxStatus) {
		@SuppressWarnings("unchecked")
		List<GoodsProduct> list=getHibernateTemplate().find("from GoodsProduct where gpUid=? and ",gpUid, minStatus, maxStatus);
		return list.get(0);
	}
	/**
	 * 添加商品
	 */
	@Override
	public void addProduct(GoodsProduct product) {
		// TODO Auto-generated method stub
		getHibernateTemplate().save(product);
	}

	/**
	 * 更新商品
	 */
	@Override
	public void updateProduct(GoodsProduct product) {
		// TODO Auto-generated method stub
		getHibernateTemplate().update(product);
	}

	/**
	 * 删除商品
	 */
	@Override
	public void deleteProduct(int id) {
		// TODO Auto-generated method stub
		GoodsProduct product = (GoodsProduct) getHibernateTemplate().get(GoodsProduct.class, id);
		getHibernateTemplate().delete(product);
	}

	/**
	 * 分页查询商品
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Override
	public List<GoodsProduct> findPages(int page, int pageSize,int minStatus,int maxStatus) {
		return getHibernateTemplate().executeFind(new HibernateCallback() {
			public Object doInHibernate(Session session) throws HibernateException, SQLException {
				String hql = "from GoodsProduct where gpStatus>="+minStatus+" and gpStatus<="+maxStatus+"order by gpId desc";
				Query query = session.createQuery(hql);
				query.setFirstResult((page - 1) * pageSize);
				query.setMaxResults(pageSize);
				List<GoodsProduct> productList = query.list();
				return productList;
			}
		});
	}
	
	

	/**
	 * 总页数
	 */
	@Override
	public int totalPages(int pageSize,int minStatus,int maxStatus) {
		String hql = "select count(*)from GoodsProduct where gpStatus>=? and gpStatus<=?";
		List<Object> objs = getHibernateTemplate().find(hql,minStatus,maxStatus);
		int records = Integer.parseInt(objs.get(0).toString());
		if (records % pageSize == 0) {

			return records / pageSize;
		} else {
			return records / pageSize + 1;
		}
	}
	/**
	 * 获取商品总数
	 * @return
	 */

	@Override
	@SuppressWarnings("unchecked")

	public int getCount(int minStatus,int maxStatus) {
		
		String hql = "select count(*)from GoodsProduct where gpStatus>=? and gpStatus<=?";
		List<Object> objs = getHibernateTemplate().find(hql,minStatus,maxStatus);
		int records = Integer.parseInt(objs.get(0).toString());
		
		return records; 
			
	}
	/**
	 * 重载分页查询商品
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	
	public List<GoodsProduct> findPages(String hql,int page, int pageSize,int minStatus,int maxStatus) {
		return getHibernateTemplate().executeFind(new HibernateCallback() {
			public Object doInHibernate(Session session) throws HibernateException, SQLException {
				
				Query query = session.createQuery(hql);
				query.setFirstResult((page - 1) * pageSize);
				query.setMaxResults(pageSize);
				List<GoodsProduct> productList = query.list();
				return productList;
			}
		});
	}
	/**
	 * 重载总页数
	 */
	
	public int totalPages(String hql,int pageSize,int minStatus,int maxStatus) {
		
		List<Object> objs = getHibernateTemplate().find(hql,minStatus,maxStatus);
		int records = Integer.parseInt(objs.get(0).toString());
		if (records % pageSize == 0) {

			return records / pageSize;
		} else {
			return records / pageSize + 1;
		}
	}
	/**
	 * 重载获取商品总数
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public int getCount(String hql,int minStatus,int maxStatus) {
		
		
		List<Object> objs = getHibernateTemplate().find(hql,minStatus,maxStatus);
		int records = Integer.parseInt(objs.get(0).toString());
		
		return records; 
			
	}
}
