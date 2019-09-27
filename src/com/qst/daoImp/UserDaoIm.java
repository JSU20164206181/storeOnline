package com.qst.daoImp;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Restrictions;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;
import org.springframework.stereotype.Component;

import com.qst.dao.UserInterface;
import com.qst.pojo.GoodsOrder;
import com.qst.pojo.GoodsProduct;
import com.qst.pojo.GoodsUser;
import com.qst.pojo.ReceiveAddress;


/**
* @ClassName: UserDaoImp.java
* @version: v1.0.0
* @author: 隆森
* @date: 2019年8月5日 下午7:08:22 
* @Description: 用户信息类的操作
 */
@Component("userdao")
public class UserDaoIm extends HibernateDaoSupport implements UserInterface{

	@Resource
	public void setSF(SessionFactory sessionFactory) {
		super.setSessionFactory(sessionFactory);
	}

	@SuppressWarnings("unchecked")
	@Override
	//ajxa判断用户是否存在
	public String findUser(String name) {
	  String  uname ="";
	  System.out.println(name);
	  List<GoodsUser> list = 	getHibernateTemplate().find("from GoodsUser where guName = ?",name);
	  System.out.println(list);
	  if(list.size()>0){
		  uname   = list.get(0).getGuName();
	  }
	  
		return uname;
	}
	
	//通过用户名获取user
	@SuppressWarnings("unchecked")
	@Override
	public GoodsUser findUserByName(String name) {
		  List<GoodsUser>  goodUser = null;
		  GoodsUser guser = null;
		  goodUser = 	getHibernateTemplate().find("from GoodsUser where guName = ?",name);
		  
		  if(goodUser.size()>0){
			  guser = goodUser.get(0);
		  }
		  
		 return guser;
	}

	
	@Override
	//添加用户到数据库
	public void addUser(GoodsUser user) {
		getHibernateTemplate().save(user);
	}


	@SuppressWarnings("unchecked")
	@Override
	//登录时根据name查询是否存在该用户 以及密码是否正确 然后将id返回 保存在cookie中
	public GoodsUser findUserId(String name,String password) {
		
		GoodsUser user = null;
		List<GoodsUser> list ;
	    list = getHibernateTemplate().find("from GoodsUser where guName = ?",name);
		if(list.size()>0){
			user = list.get(0);
			return user;
		}
		return user;		
	}


	
	@Override
	//查询一个用户的个人信息 显示其信息
	public GoodsUser findUserMsg(int id) {
		GoodsUser user = new GoodsUser();
		user = getHibernateTemplate().get(GoodsUser.class,id);
		return user;
	}

	//修改用户信息
	@Override
	public void updateUser(GoodsUser user) {
		 getHibernateTemplate().update(user);	
	}

	//根据id查询对应的收货地址
	@SuppressWarnings("unchecked")
	@Override
	public List<ReceiveAddress> findReceiveById(int id) {
		
		List<ReceiveAddress> list = new ArrayList<>();
		list = getHibernateTemplate().find("from ReceiveAddress where graUid = ?",id);
		if(list.size()==0){
			list = null;
		}
		return list;
	}

	
	//修改或者保存收货地址
	@Override
	public void SaveorUpdateReceiveAddress(ReceiveAddress receiveAddress) {
		/*
		 * saveOrUpdate()这个方法是更新或者插入，
		 * 有主键就执行更新，
		 * 如果没有主键就执行插入。
		 */
		getHibernateTemplate().getSessionFactory().getCurrentSession().clear();
		getHibernateTemplate().saveOrUpdate(receiveAddress);
		
	}

	//删除收货地址
	@Override
	public void deleteReceiceAddress(ReceiveAddress receiveAddress) {
		ReceiveAddress ra = new ReceiveAddress();
		ra = getHibernateTemplate().get(ReceiveAddress.class, receiveAddress.getGraId());
		getHibernateTemplate().delete(ra);
		
	}

	//查询我的商品(分页)
	@Override
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public List<GoodsProduct> findByUserId(int userId, int page, int pageSize) {
		
		
		return getHibernateTemplate().executeFind(new HibernateCallback() {
			@Override
			public Object doInHibernate(Session session) throws HibernateException, SQLException {
				String hql = "from GoodsProduct  where gpUid = ? and gpStatus < 4";
				
				Query query = session.createQuery(hql);
				query.setParameter(0, userId);
				query.setFirstResult((page - 1) * pageSize);
				query.setMaxResults(pageSize);				
				return query.list();
			}
		});
	}
	
	//查询总页数
	@SuppressWarnings("unchecked")
	@Override
	public int totalPageByUserId(int userId, int pageSize) {
		List<Object> list = getHibernateTemplate().find("select  count(*) from GoodsProduct gp where gp.gpUid = ? "
				+ "and gpStatus < 4",
				userId);
		if (!list.isEmpty()) {
			int records = Integer.parseInt(list.get(0).toString());
			return records % pageSize == 0 ? records / pageSize : records / pageSize + 1;
		}
		return 0;
	}

	
	@Override
	public void deleteGoods(int id) {
	    GoodsProduct goods = getHibernateTemplate().get(GoodsProduct.class, id);
		getHibernateTemplate().delete(goods);
	}

	
	@Override
	public GoodsProduct findProductById(int id) {
		GoodsProduct goods = getHibernateTemplate().get(GoodsProduct.class, id);
		
		return goods;
		
	}

	/* (non-Javadoc)
	 * @see com.qst.dao.UserInterface#updateProduct(com.qst.pojo.GoodsProduct)
	 */
	@Override
	public void updateProduct(GoodsProduct goodsProduct) {
		
		getHibernateTemplate().update(goodsProduct);
	}

	/* (non-Javadoc)
	 * @see com.qst.dao.UserInterface#findByFuzzy(java.lang.String, int, int)
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Override
	public List<GoodsProduct> findByFuzzy(String mohu, int page, int pageSize) {
		
		return getHibernateTemplate().executeFind(new HibernateCallback() {
			@Override
			public Object doInHibernate(Session session) throws HibernateException, SQLException {
				
				Criteria criteria = session.createCriteria(GoodsProduct.class);
				criteria.add(Restrictions.like("gpName", mohu,MatchMode.ANYWHERE));
				criteria.setFirstResult((page - 1) * pageSize);
				criteria.setMaxResults(pageSize);			
				
				return criteria.list();
			}
		});
		
	}
	
	//模糊查询商品总页数
		@SuppressWarnings("unchecked")
		@Override
		public int totalPageByFuzzy(String mohu, int pageSize) {
			List<Object> list = getHibernateTemplate().find(""
					+ "from GoodsProduct where gpName like '%"+mohu+"%' ");
			
			if (!list.isEmpty()) {

				return list.size() % pageSize == 0 ? list.size() / pageSize : list.size() / pageSize + 1;
			}
			return 0;
		}

		
		@Override
		public List<GoodsUser> cityShow() {
			@SuppressWarnings("unchecked")
			List<GoodsUser> list = getHibernateTemplate().find("from GoodsUser");
			
			return list;
		}

		//查询我的所有的订单
		@SuppressWarnings({ "unchecked", "rawtypes" })
		@Override
		public List<GoodsOrder> findOrderByid(int id) {
			
			
		    List<GoodsOrder> list  = getHibernateTemplate().find("from GoodsOrder where goSid = ?" ,id);
		    return list;
					
			
			
		}
		
		
		
		
	
}
