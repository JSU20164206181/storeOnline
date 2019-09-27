/**
 * 
 */
package com.qst.dao;

import java.util.List;

import com.qst.pojo.GoodsOrder;
import com.qst.pojo.GoodsOrderitem;

/**
 * @ClassName: OderItemDao.java
 * @version: v1.0.0
 * @author: ZYL
 * @date: 2019年8月13日 上午9:22:26
 * @Description: 订单商品Dao
 */
public interface OrderItemDao {
	/**
	 * 增加订单商品
	 * 
	 * @param goi
	 */
	public int addOderItem(GoodsOrderitem goi);

	/**
	 * 删除订单商品
	 * 
	 * @param id
	 */
	public void deleteOderItem(int id);

	/**
	 * 修改订单商品
	 * 
	 * @param goi
	 */
	public void updateOrderItem(GoodsOrderitem goi);

	/**
	 * 根据订单ID查询订单商品
	 * 
	 * @param id
	 * @return
	 */
	public List<GoodsOrderitem> findOrderItemByOid(int id);

	/**
	 * 根据商品名称查询订单ID
	 * 
	 * @param name
	 * @return
	 */
	public List<String> findOidByPname(String name);

	/**
	 * 根据订单商品ID查询订单商品
	 * 
	 * @param code
	 * @return
	 */
	public GoodsOrderitem findGoiById(int id);

	/**
	 * 根据订单号查询订单商品
	 * 
	 * @param code
	 * @return
	 */
	public List<GoodsOrderitem> findGoiByOrderCode(String code);

	/**
	 * 根据订单商品状态查询订单
	 * 
	 * @param id
	 * @param status
	 * @param page
	 * @param pageSize
	 * @return
	 */
	public List<GoodsOrderitem> findOrderByStatus(int id, int status, int page, int pageSize);
}
