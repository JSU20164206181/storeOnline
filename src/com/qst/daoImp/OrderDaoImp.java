/**
 * 
 */
package com.qst.daoImp;

import java.sql.SQLException;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Date;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;
import org.springframework.stereotype.Component;

import com.qst.dao.OrderDao;
import com.qst.pojo.GoodsOrder;

/**
 * @ClassName: OrderDaoImp.java
 * @version: v1.0.0
 * @author: ZYL
 * @date: 2019年8月13日 上午10:27:46
 * @Description: 订单Dao实现类
 */
@Component
public class OrderDaoImp extends HibernateDaoSupport implements OrderDao {
	@Resource
	public void setSF(SessionFactory sessionFactory) {
		super.setSessionFactory(sessionFactory);
	}

	@Override
	public int addOrder(GoodsOrder go) {
		go.setGoCreateDate(new Date());
		go.setGoStatus(1);
		return (Integer) getHibernateTemplate().save(go);
	}

	@Override
	public void deleteOrder(int id) {
		GoodsOrder go = (GoodsOrder) getHibernateTemplate().get(GoodsOrder.class, id);
		getHibernateTemplate().delete(go);
	}

	@Override
	public void updateOrder(GoodsOrder go) {
		getHibernateTemplate().update(go);
	}

	@SuppressWarnings("unchecked")
	@Override
	public GoodsOrder findOrderById(int id) {
		List<GoodsOrder> list = getHibernateTemplate().find("from GoodsOrder go where go.goId = ?", id);
		if (!list.isEmpty())
			return list.get(0);
		return null;
	}

	@Override
	public GoodsOrder findByOrderCode(String orderCode) {
		List<GoodsOrder> list = getHibernateTemplate().find("from GoodsOrder go where go.goOrderCode = ?", orderCode);
		if (!list.isEmpty())
			return list.get(0);
		return null;
	}

	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Override
	public List<GoodsOrder> fuzzySearchOrderItemByOrderCode(String orderCode, int page, int pageSize) {
		return getHibernateTemplate().executeFind(new HibernateCallback() {
			@Override
			public Object doInHibernate(Session session) throws HibernateException, SQLException {
				String hql = "from GoodsOrder go where go.goOrderCode like '%" + orderCode + "%'"
						+ " order by go.goCreateDate desc";
				Query query = session.createQuery(hql);
				query.setFirstResult((page - 1) * pageSize);
				query.setMaxResults(pageSize);
				return query.list();
			}
		});
	}

	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Override
	public List<GoodsOrder> findOrderByUserId(int id, int page, int pageSize) {
		return getHibernateTemplate().executeFind(new HibernateCallback() {
			@Override
			public Object doInHibernate(Session session) throws HibernateException, SQLException {
				String hql = "from GoodsOrder go where go.goUid = " + id + " and go.goStatus!=4 order by go.goCreateDate desc";
				Query query = session.createQuery(hql);
				query.setFirstResult((page - 1) * pageSize);
				query.setMaxResults(pageSize);
				return query.list();
			}
		});
	}

	@SuppressWarnings("unchecked")
	@Override
	public GoodsOrder findOrderByOrderCode(String code) {
		List<GoodsOrder> list = getHibernateTemplate().find("from GoodsOrder go where go.goOrderCode = ?", code);
		if (!list.isEmpty())
			return list.get(0);
		return null;
	}

	@SuppressWarnings("unchecked")
	@Override
	public boolean findStatusByOrderCode(String code) {
		List<GoodsOrder> list = getHibernateTemplate().find("from GoodsOrder go where go.goOrderCode = ?", code);
		if (!list.isEmpty())
			return true;
		return false;
	}

	@SuppressWarnings("unchecked")
	@Override
	public int totalPages(int userId, int pageSize) {
		String hql = "select count(*)from GoodsOrder go where go.goUid = " + userId;
		List<Object> objs = getHibernateTemplate().find(hql);
		int records = Integer.parseInt(objs.get(0).toString());
		if (records % pageSize == 0) {
			return records / pageSize;
		} else {
			return records / pageSize + 1;
		}
	}

	// ---------后台管理
	@SuppressWarnings("unchecked")
	@Override
	public Map<String, String> findPayListByMonth() {
		// TODO Auto-generated method stub
		String hql = "select year(r.goPayDate),month(r.goPayDate), r.goId from GoodsOrder  as r where  goStatus>1";

		List<Object> objs = getHibernateTemplate().find(hql);
		Calendar cal = Calendar.getInstance();
		int year = cal.get(Calendar.YEAR);
		int month = cal.get(Calendar.MONTH) + 1;
		System.out.println("++++长度++++：" + objs.size() + year + "年" + month + "月");
		Map<String, String> count = new HashMap<String, String>();
		Object[] obj;
		for (int j = 0; j < objs.size(); j++) {
			obj = (Object[]) objs.get(j);
			// System.out.print("\nselect:"+obj[0]+"|"+obj[1]+"|"+obj[2]+" ");
			if (year == Integer.parseInt(String.valueOf(obj[0]))) {// 判断是否为当年
				if (Integer.parseInt(String.valueOf(obj[1])) <= month) {// 判断月份是否小于当前月份
					String list = count.get(obj[1] + "月");// 获取已有订单id
					list = list + "," + String.valueOf(obj[2]);// 添加当前订单id
					count.put(obj[1] + "月", list); // 放入map
					// System.out.print("\nput:"+obj[0]+"|"+obj[1]+"|"+obj[2]+"
					// "+list);
				}
			}
		}
		System.out.println("\n map:" + count.keySet());
		return count;
	}

	@SuppressWarnings("unchecked")
	@Override
	public Map<String, Double> findUserCostByMonth(int id) {
		// TODO Auto-generated method stub
		String hql;
		if (id == -1) {
			hql = "select year(r.goPayDate),month(r.goPayDate), sum(r.goTotalPrice) from GoodsOrder  as r where  goStatus>1  group by year(r.goPayDate),month(r.goPayDate)";
		} else {
			hql = "select year(r.goPayDate),month(r.goPayDate), sum(r.goTotalPrice) from GoodsOrder  as r where goUid ="
					+ id + " and goStatus>1  group by year(r.goPayDate),month(r.goPayDate)";
		}
		List<Object> objs = getHibernateTemplate().find(hql);

		Calendar cal = Calendar.getInstance();
		int year = cal.get(Calendar.YEAR);
		int month = cal.get(Calendar.MONTH) + 1;
		System.out.println("++++长度++++：" + objs.size() + year + "年" + month + "月");
		Map<String, Double> count = new HashMap<String, Double>();
		Object[] obj;
		for (int j = 0; j < objs.size(); j++) {
			obj = (Object[]) objs.get(j);
			System.out.print("\nselect:" + obj[0] + "|" + obj[1] + "|" + obj[2] + "  ");
			if (year == Integer.parseInt(String.valueOf(obj[0]))) {// 判断是否为当年
				if (Integer.parseInt(String.valueOf(obj[1])) <= month) {// 判断月份是否小于当前月份
					count.put(obj[1] + "月", Double.parseDouble(String.valueOf(obj[2])));

				}

			}
		}
		System.out.println("\n map:" + count.keySet());
		return count;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<GoodsOrder> findAllOrder() {
		List<GoodsOrder> list = getHibernateTemplate().find("from GoodsOrder");
		return list;
	}

	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Override
	public List<GoodsOrder> findAllOrderByPage(int page, int pageSize) {
		return getHibernateTemplate().executeFind(new HibernateCallback() {
			@Override
			public Object doInHibernate(Session session) throws HibernateException, SQLException {
				String hql = "from GoodsOrder";
				Query query = session.createQuery(hql);
				query.setFirstResult((page - 1) * pageSize);
				query.setMaxResults(pageSize);
				return query.list();
			}
		});

	}

	@Override
	public int findAllOrderPage(int pageSize) {
		String hql = "select count(*)from  GoodsOrder";
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
	public int findAllOrderNumber() {
		// TODO Auto-generated method stub
		String hql = "select count(*) from GoodsOrder";
		@SuppressWarnings("unchecked")
		List<Object> objs = getHibernateTemplate().find(hql);
		return Integer.parseInt(objs.get(0).toString());
	}

	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Override
	public List<GoodsOrder> findFuzzyOrderByPage(int page, int pageSize, int chose, String str) {
		return getHibernateTemplate().executeFind(new HibernateCallback() {
			@Override
			public Object doInHibernate(Session session) throws HibernateException, SQLException {
				String choseStr = null;
				if (chose == 1) {
					choseStr = "goOrderCode";

				} else if (chose == 2) {
					choseStr = "goUid";

				} else if (chose == 3) {
					choseStr = "goReceiver";

				} else if (chose == 4) {
					choseStr = "goAddress";

				} else if (chose == 5) {
					choseStr = "goPhone";

				}
				String hql = "from GoodsOrder where ("+choseStr+" like '%" + str + "%')";
				Query query = session.createQuery(hql);
				query.setFirstResult((page - 1) * pageSize);
				query.setMaxResults(pageSize);
				return query.list();
			}
		});

	}

	@Override
	public int findFuzzyOrderPage(int pageSize, int chose, String str) {
		String choseStr = null;
		if (chose == 1) {
			choseStr = "goOrderCode";

		} else if (chose == 2) {
			choseStr = "goUid";

		} else if (chose == 3) {
			choseStr = "goReceiver";

		} else if (chose == 4) {
			choseStr = "goAddress";

		} else if (chose == 5) {
			choseStr = "goPhone";

		}
		String hql = "select count(*)from GoodsOrder where ("+choseStr+" like '%" + str + "%')";
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
	public int findFuzzyOrderNumber(int chose, String str) {
		// TODO Auto-generated method stub
		String choseStr = null;
		if (chose == 1) {
			choseStr = "goOrderCode";

		} else if (chose == 2) {
			choseStr = "goUid";

		} else if (chose == 3) {
			choseStr = "goReceiver";

		} else if (chose == 4) {
			choseStr = "goAddress";

		} else if (chose == 5) {
			choseStr = "goPhone";

		}
		String hql = "select count(*) from GoodsOrder where ("+choseStr+" like '%" + str + "%')"; 
		@SuppressWarnings("unchecked")
		List<Object> objs = getHibernateTemplate().find(hql);
		return Integer.parseInt(objs.get(0).toString());
	}
	// ——————后台管理
}
