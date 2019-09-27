
package com.qst.daoImp;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;
import org.springframework.stereotype.Repository;
import com.qst.dao.UserDao;
import com.qst.pojo.GoodsUser;

/**
* @ClassName: UserDaoImp.java
* @version: v1.0.0
* @author: hdq
* @date: 2019年8月13日 下午9:19:38 
* @Description: 用户Dao实现类
 */
@Repository
public class UserDaoImp extends HibernateDaoSupport implements UserDao {
	@Resource
	public void setSF(SessionFactory sessionFactory) {
		super.setSessionFactory(sessionFactory);
	}
	@Override
	public void addUser(GoodsUser user) {
		getHibernateTemplate().save(user);
	}
	@Override
	public void deleteUser(int id) {
		GoodsUser user = (GoodsUser) getHibernateTemplate().get(GoodsUser.class, id);
		getHibernateTemplate().delete(user);
	}

	@Override
	public void updateUser(GoodsUser user) {
		getHibernateTemplate().update(user);
	}

	@SuppressWarnings("unchecked") 
	@Override
	public List<GoodsUser> findAllUser() {
		String hql = "from GoodsUser";
		List<GoodsUser> userList = getHibernateTemplate().find(hql);
		return userList;
	}

	@Override
	public GoodsUser findUserById(int id) {
		GoodsUser user = (GoodsUser) getHibernateTemplate().get(GoodsUser.class, id);
		return user;
	}

	@SuppressWarnings("unchecked")
	@Override
	public GoodsUser findUserByName(String userName) {
		List<GoodsUser> list = getHibernateTemplate().find("from GoodsUser u where u.guName=?", userName);
		if (!list.isEmpty())
			return list.get(0);
		return null;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<GoodsUser> fuzzyFindUser(String str,int page, int pageSize) {
		
		return getHibernateTemplate().executeFind(new HibernateCallback<Object>() {
			public Object doInHibernate(Session session) throws HibernateException, SQLException {
				String hql = "from GoodsUser where (guName like '%" + str + "%' or guPhone like '%" + str + "%' or guEmail like '%"
						+ str + "%'or guAddress like '%" + str + "%') and guStatus!=2";
				Query query = session.createQuery(hql);   
				query.setFirstResult((page - 1) * pageSize);
				query.setMaxResults(pageSize); 
				List<GoodsUser> userList = query.list();
				return userList;
			}
		});
	} 
	@Override
	public int fuzzyPageNumber(String str, int pageSize) {
		String hql = "select count(*)from GoodsUser where (guName like '%" + str + "%' or guPhone like '%" + str + "%' or guEmail like '%"
						+ str + "%'or guAddress like '%" + str + "%') and guStatus!=2";
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
	public int fuzzyAllNumber(String str) {
		String hql = "select count(*) from GoodsUser where (guName like '%" + str + "%' or guPhone like '%" + str + "%' or guEmail like '%"
						+ str + "%'or guAddress like '%" + str + "%') and guStatus!=2";
		@SuppressWarnings("unchecked")
		List<Object> objs = getHibernateTemplate().find(hql);
		return Integer.parseInt(objs.get(0).toString());
	}
	@SuppressWarnings("unchecked")
	@Override
	public List<GoodsUser> findPages(int page, int pageSize) {
		return getHibernateTemplate().executeFind(new HibernateCallback<Object>() {
			public Object doInHibernate(Session session) throws HibernateException, SQLException {
				String hql = "from GoodsUser where guStatus!=2 order by guId desc";
				Query query = session.createQuery(hql);
				query.setFirstResult((page - 1) * pageSize);
				query.setMaxResults(pageSize);
				List<GoodsUser> users = query.list();
				return users;
			}
		});
	}

	@SuppressWarnings("unchecked")
	@Override
	public int totalPages(int pageSize) {
		String hql = "select count(*)from GoodsUser where guStatus!=2";
		List<Object> objs = getHibernateTemplate().find(hql);
		int records = Integer.parseInt(objs.get(0).toString());
		if (records % pageSize == 0) {
			return records / pageSize;
		} else {
			return records / pageSize + 1;
		}
	}
	@Override
	public int userNumber() {
		// TODO Auto-generated method stub
		String hql = "select count(*)from GoodsUser where guStatus!=2";
		@SuppressWarnings("unchecked")
		List<Object> objs = getHibernateTemplate().find(hql);
		return Integer.parseInt(objs.get(0).toString());
	}

	@SuppressWarnings("unchecked")
	@Override
	public Map<String, Integer> userSexCount() {

		String hql = "select guSex ,count(guSex)from GoodsUser where guStatus!=2 group by guSex";
		System.out.println("~~~~~~~" + getHibernateTemplate().find(hql).get(0));
		List<Object> objs = getHibernateTemplate().find(hql);

		Object[] obj;
		Integer all = (int) this.userNumber();
		Map<String, Integer> count = new HashMap<String, Integer>();
		count.put("all", all);
		for (int i = 0; i < objs.size(); i++) {
			obj = (Object[]) objs.get(i);
			count.put((String) obj[0], Integer.parseInt(String.valueOf(obj[1])));
		}
		System.out.println(all + "~~~~~~~");

		return count;

	}

	@SuppressWarnings("unchecked")
	@Override
	public Map<String, Integer> userAgeCount() {
		String hql = "select case when guAge>=1 and guAge<6 then '童年' when guAge>= 7 and guAge<17 then '少年' when guAge>=18 and guAge<40 then '青年'when guAge>=41 and guAge<65 then '中年'when guAge>=66 then '老年'end as temp from GoodsUser where guStatus!=2 ";

		System.out.println("~~~~~~~" + getHibernateTemplate());
		List<Object> objs = getHibernateTemplate().find(hql);
		Integer all = (int) this.userNumber();
		Map<String, Integer> count = new HashMap<String, Integer>();
		count.put("all", all);
		count.put("童年", 0);
		count.put("少年", 0);
		count.put("青年", 0);
		count.put("中年", 0);
		count.put("老年", 0);
		int num;
		for (int i = 0; i < objs.size(); i++) {
			System.out.println("++"+String.valueOf(objs.get(i))+((String.valueOf(objs.get(i)))!="null"));
			if(String.valueOf(objs.get(i))!="null"){ 		  
			num = count.get(String.valueOf(objs.get(i)));
			num++;
			count.put(String.valueOf(objs.get(i)), num);
			}
		}

		System.out.println(all + "~~~~~~~" + count.keySet());

		return count; 

	}
	

}
