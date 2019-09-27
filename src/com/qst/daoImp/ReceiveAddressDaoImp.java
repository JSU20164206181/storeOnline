/**
 * 
 */
package com.qst.daoImp;

import java.util.List;

import javax.annotation.Resource;

import org.hibernate.SessionFactory;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;
import org.springframework.stereotype.Component;

import com.qst.dao.ReceiveAddressDao;
import com.qst.pojo.ReceiveAddress;

/**
 * @ClassName: ReceiveAddressDaoImp.java
 * @version: v1.0.0
 * @author: ZYL
 * @date: 2019年8月9日 下午10:08:56
 * @Description: 收货地址Dao实现类
 */
@Component
public class ReceiveAddressDaoImp extends HibernateDaoSupport implements ReceiveAddressDao {
	
	@Resource
	public void setSF(SessionFactory sessionFactory) {
		super.setSessionFactory(sessionFactory);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public ReceiveAddress findRaById(int id) {
		List<ReceiveAddress> list = getHibernateTemplate().find("from ReceiveAddress r where r.graId = ?", id);
		if (!list.isEmpty())
			return list.get(0);
		return null;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<ReceiveAddress> findAllRaByUserId(int id) {
		List<ReceiveAddress> receiveAddressList = getHibernateTemplate()
				.find("from ReceiveAddress r where r.graUid = ?", id);
		if (!receiveAddressList.isEmpty())
			return receiveAddressList;
		return null;
	}

	@Override
	public void addRA(ReceiveAddress ra) {
		getHibernateTemplate().save(ra);
	}

	@Override
	public void deleteRA(int id) {
		ReceiveAddress ra = (ReceiveAddress) getHibernateTemplate().get(ReceiveAddress.class, id);
		getHibernateTemplate().delete(ra);
	}

	@Override
	public void updateRA(ReceiveAddress ra) {
		getHibernateTemplate().update(ra);
	}

}
