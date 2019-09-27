/**
 * 
 */
package com.qst.dao;

import java.util.List;
import java.util.Map;

import com.mysql.fabric.xmlrpc.base.Param;
import com.qst.pojo.GoodsOrder;

/**
 * @ClassName: OrderDao.java
 * @version: v1.0.0
 * @author: ZYL
 * @date: 2019年8月13日 上午9:12:05
 * @Description: 订单Dao
 */
/**
 * @ClassName: OrderDao.java
 * @version: v1.0.0
 * @author: ZYL
 * @date: 2019年8月13日 上午10:04:30
 * @Description: 该类的功能描述
 */
public interface OrderDao {
	/**
	 * 增加订单
	 * 
	 * @param go
	 */
	public int addOrder(GoodsOrder go);

	/**
	 * 删除订单
	 * 
	 * @param id
	 */
	public void deleteOrder(int id);

	/**
	 * 修改订单
	 * 
	 * @param go
	 */
	public void updateOrder(GoodsOrder go);

	/**
	 * 根据订单ID查询订单
	 * 
	 * @param id
	 * @return
	 */
	public GoodsOrder findOrderById(int id);

	/**
	 * 根据订单号查询订单
	 * 
	 * @param code
	 * @return
	 */
	public GoodsOrder findOrderByOrderCode(String code);

	/**
	 * 根据订单号查询判断订单号是否存在
	 * 
	 * @param code
	 * @return
	 */
	public boolean findStatusByOrderCode(String code);

	/**
	 * 
	 * 根据订单编号查找订单对象
	 * 
	 * @param orderCode
	 * @return
	 */
	public GoodsOrder findByOrderCode(String orderCode);

	/**
	 * 查询总页数
	 * 
	 * @param pageSize
	 * @return
	 */
	public int totalPages(int userId, int pageSize);

	/**
	 * 根据订单号分页模糊查询订单
	 * 
	 * @param orderCode
	 * @param page
	 * @param pageSize
	 * @return
	 */
	public List<GoodsOrder> fuzzySearchOrderItemByOrderCode(String orderCode, int page, int pageSize);

	/**
	 * 根据用户ID分页查询订单
	 * 
	 * @param id
	 * @param page
	 * @param pageSize
	 * @return
	 */
	public List<GoodsOrder> findOrderByUserId(int id, int page, int pageSize);
	
	//---------后台管理
	/**
	 * 查询全部订单
	 * @return 所有订单
	 */
	public List<GoodsOrder> findAllOrder();
	/**
	 * 分页查询全部订单
	 ** @param page 起始页
	 * @param pageSize 分页长度
	 * @return
	 */
	public List<GoodsOrder> findAllOrderByPage(int page, int pageSize);
	/**
	 * 全部订单总页数
	 * @param pageSize 分页长度
	 * @return 总页数
	 */
	public int findAllOrderPage( int pageSize);
	/**
	 * 全部订单总数量 
	 * @return 总数量
	 */
	public int findAllOrderNumber( );
	
	/**
	 * 根据用户按月份统计消费
	 @param id
	 @return Map<月份,存储内容>  
	 */
	public Map<String, Double> findUserCostByMonth(int id);
	/**
	 * 获取每月支付订单
	 @param id
	 @return Map<月份,订单列表>  
	 */
	Map<String, String> findPayListByMonth();
	/**
	 * 后台模糊查找总数量
	 * @return
	 */
	int findFuzzyOrderNumber(int chose,String str);
	/**
	 * 后台模糊查找页数
	 * @return
	 */

	int findFuzzyOrderPage(int pageSize,int chose,String str);
	/**
	 *后台 模糊查找数据列表
	 *
	 * @return
	 */
	List<GoodsOrder> findFuzzyOrderByPage(int page, int pageSize,int chose,String str);
	//---------后台管理
	

	
}
