/**
 * 
 */
package com.qst.dao;

import java.util.List;

import com.qst.pojo.ReceiveAddress;

/**
 * @ClassName: ReceiveAddressDao.java
 * @version: v1.0.0
 * @author: ZYL
 * @date: 2019年8月9日 下午10:00:33
 * @Description: 收货地址Dao
 */
public interface ReceiveAddressDao {

	/**
	 * 根据收货地址ID查询
	 * 
	 * @param id
	 * @return
	 */
	public ReceiveAddress findRaById(int id);

	/**
	 * 根据用户ID查询该用户所有收货地址
	 * 
	 * @param id
	 * @return
	 */
	public List<ReceiveAddress> findAllRaByUserId(int id);

	/**
	 * 增加收货地址
	 * 
	 * @param ra
	 */
	public void addRA(ReceiveAddress ra);

	/**
	 * 删除收货地址
	 * 
	 * @param id
	 */
	public void deleteRA(int id);

	/**
	 * 修改收货地址
	 * 
	 * @param ra
	 */
	public void updateRA(ReceiveAddress ra);

}
