/**
 * 
 */
package com.qst.daoImp;

import java.sql.SQLException;
import java.util.List;

import javax.annotation.Resource;

import org.apache.poi.ss.formula.functions.T;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;
import org.springframework.stereotype.Repository;

import com.qst.dao.AdminProductimageDao;
import com.qst.pojo.GoodsProduct;
import com.qst.pojo.GoodsProductimage;
import org.springframework.transaction.annotation.Transactional;

/**
 * @ClassName:AdminProductimageDaoImp.java
 * @version:v1.0.0
 * @author:mwy
 * @date:2019年8月9日 下午4:49:54
 * @Description:管理员商品图片dao实体类
 */
@Transactional
@Repository
public class AdminProductimageDaoImp extends HibernateDaoSupport implements AdminProductimageDao {

	@Resource
	public void setSF(SessionFactory sessionFactory) {
		super.setSessionFactory(sessionFactory);
	}
	
	/**
	 * 根据id获取
	 */
	@Override
	public GoodsProductimage findById(int id) {
		GoodsProductimage productimage = (GoodsProductimage) getHibernateTemplate().get(GoodsProductimage.class, id);
		return productimage;
	}

	/**
	 * 根据名称获取
	 */
	@Override
	public List<GoodsProductimage> findByType(String type,int pid,int minStatus, int maxStatus) {
		@SuppressWarnings("unchecked")
		List<GoodsProductimage> list=getHibernateTemplate().find("from GoodsProductimage where gpiType=? and gpiPid=? and gpiStatus>=? and gpiStatus<=? ",type,pid,minStatus,maxStatus);
		return list;
	}

	/**
	 * 添加商品
	 */
	@Override
	public void addProductimage(GoodsProductimage productimage) {
		// TODO Auto-generated method stub
		getHibernateTemplate().save(productimage);
	}

	/**
	 * 更新商品
	 */
	@Override
	public void updateProductimage(GoodsProductimage productimage) {
		// TODO Auto-generated method stub
		getHibernateTemplate().update(productimage);
	}

	/**
	 * 删除商品
	 */
	@Override
	public void deleteProductimage(int id) {
		// TODO Auto-generated method stub
		GoodsProductimage productimage = (GoodsProductimage) getHibernateTemplate().get(GoodsProductimage.class, id);
		getHibernateTemplate().delete(productimage);
	}

	/**
	 * 获取商品总数
	 * @return
	 */
	@Override
	public int getCount(int minStatus, int maxStatus) {
		String hql = "select count(*)from GoodsProductimage where gpiStatus>=? and gpiStatus<=?";
		List<Object> objs = getHibernateTemplate().find(hql,minStatus,maxStatus);
		int records = Integer.parseInt(objs.get(0).toString());
		
		return records; 
	}
	
	/**
	 * 分页查询商品
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Override
	public List<GoodsProductimage> findPages(int page, int pageSize,int minStatus,int maxStatus) {
		return getHibernateTemplate().executeFind(new HibernateCallback() {
			public Object doInHibernate(Session session) throws HibernateException, SQLException {
				String hql = "from GoodsProductimage where gpiStatus>="+minStatus+" and gpiStatus<="+maxStatus+"order by gpiId desc";
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
		String hql = "select count(*)from GoodsProductimage where gpiStatus>=? and gpiStatus<=?";
		List<Object> objs = getHibernateTemplate().find(hql,minStatus,maxStatus);
		int records = Integer.parseInt(objs.get(0).toString());
		if (records % pageSize == 0) {

			return records / pageSize;
		} else {
			return records / pageSize + 1;
		}
	}
	

	/**
	 * 根据商品id获取商品图片
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List<GoodsProductimage> findListByProductId(int gpId,int minStatus,int maxStatus) {
		String hql = "from GoodsProductimage where gpiPid=? and gpiStatus>=? and gpiStatus<=?";
		List<GoodsProductimage> list = getHibernateTemplate().find(hql,gpId,minStatus,maxStatus);
		return list;
		
	}
	/**
	 * 商品图片模糊搜索
	 * @param id
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List<GoodsProductimage> findPagesByFuzzy(int page,int pageSize,int minStatus,int maxStatus,String keyword){
		return getHibernateTemplate().executeFind(new HibernateCallback() {
			public Object doInHibernate(Session session) throws HibernateException, SQLException {
				String hql = "from GoodsProductimage where gpiStatus>="+minStatus+" and gpiStatus<="+maxStatus;
				hql+="  and (gpiId LIKE '%"+keyword+"%' ";
				hql+="  or gpiPid LIKE '%"+keyword+"%' )";
				
				
				hql+="order by gpiId desc";
				Query query = session.createQuery(hql);
				query.setFirstResult((page - 1) * pageSize);
				query.setMaxResults(pageSize);
				List<GoodsProductimage> productimageList = query.list();
				return productimageList;
			}
		});
	}
	/**
	 * 模糊搜索总页数
	 */
	@Override
	public int totalPagesByFuzzy(int pageSize,int minStatus,int maxStatus,String keyword) {
		String hql = "select count(*)from GoodsProductimage where gpiStatus>=? and gpiStatus<=?";
		hql+="  and (gpiId LIKE '%"+keyword+"%' ";
		hql+="  or gpiPid LIKE '%"+keyword+"%' )";
		
		
		List<Object> objs = getHibernateTemplate().find(hql,minStatus,maxStatus);
		int records = Integer.parseInt(objs.get(0).toString());
		if (records % pageSize == 0) {


			return records / pageSize;
		} else {
			return records / pageSize + 1;
		}
	}
	/**
	 * 模糊搜索获取商品图片总数
	 * @return
	 */
	@Override
	@SuppressWarnings("unchecked")
	public int getCountByFuzzy(int minStatus,int maxStatus,String keyword) {
		
		String hql = "select count(*)from GoodsProductimage where gpiStatus>=? and gpiStatus<=?";
		hql+="  and (gpiId LIKE '%"+keyword+"%' ";
		hql+="  or gpiPid LIKE '%"+keyword+"%' )";
		
		List<Object> objs = getHibernateTemplate().find(hql,minStatus,maxStatus);
		int records = Integer.parseInt(objs.get(0).toString());
		
		return records; 
			
	}

	@Override
	public int batchAdd(List<GoodsProductimage> list) {
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


}
