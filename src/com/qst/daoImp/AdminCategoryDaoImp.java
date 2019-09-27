/**
 * 
 */
package com.qst.daoImp;

import java.util.List;

import javax.annotation.Resource;

import org.hibernate.SessionFactory;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;
import org.springframework.stereotype.Repository;

import com.qst.dao.AdminCategoryDao;
import com.qst.pojo.GoodsCategory;
import com.qst.pojo.GoodsProduct;


/**
 * @ClassName:AdminCategoryDaoImp.java
 * @version:v1.0.0
 * @author:mwy
 * @date:2019年8月8日 下午5:24:18
 * @Description:管理员商品分类Dao实现类
 */
@Repository
public class AdminCategoryDaoImp extends HibernateDaoSupport implements AdminCategoryDao {

	@Resource
	public void setSF(SessionFactory sessionFactory) {
		super.setSessionFactory(sessionFactory);
	}
	/**
	 * 获取所有
	 */
	@Override
	public List<GoodsCategory> findAll() {
		@SuppressWarnings("unchecked")
		List<GoodsCategory> list=getHibernateTemplate().find("from GoodsCategory where gcStatus<2");
		return list;
	}
	/**
	 * 模糊查询商品分类
	 * @param id
	 * @return
	 */
	@Override
	public List<GoodsCategory> findAllByFuzzy(String keyword){
		@SuppressWarnings("unchecked")
		String hql = "from GoodsCategory where gcStatus<2";
		hql+="  and (gcName LIKE '%"+keyword+"%') ";
		
		List<GoodsCategory> list=getHibernateTemplate().find(hql);
		return list;
	}
	/**
	 * 根据id获取
	 */
	@Override
	public GoodsCategory findById(int id) {
		GoodsCategory category = (GoodsCategory) getHibernateTemplate().get(GoodsCategory.class, id);
		return category;
	}


	/**
	 * 根据名称获取
	 */
	@Override
	public GoodsCategory findByName(String name) {
		@SuppressWarnings("unchecked")
		List<GoodsCategory> list=getHibernateTemplate().find("from GoodsCategory where gcName=? and gcStatus<2",name);
		return list.get(0);
	}

	/**
	 * 添加商品分类
	 */
	@Override
	public void addCategory(GoodsCategory category) {
		
		getHibernateTemplate().save(category);
	}

	/**
	 * 更新商品分类
	 */
	@Override
	public void updateCategory(GoodsCategory category) {
		// TODO Auto-generated method stub
		getHibernateTemplate().update(category);
	}

	/**
	 * 删除商品分类
	 */
	@Override
	public void deleteCategory(int id) {
		// TODO Auto-generated method stub
		GoodsCategory category = (GoodsCategory) getHibernateTemplate().get(GoodsCategory.class, id);
		getHibernateTemplate().delete(category);
	}

}
