/**
 * 
 */
package com.qst.dao;

import java.util.List;

import com.qst.pojo.GoodsProduct;


/**
 * @ClassName:ProductDao.java
 * @version:v1.0.0
 * @author:mwy
 * @date:2019年8月7日 下午5:47:49
 * @Description:管理员商品dao接口
 */
public interface AdminProductDao {
	/**
	 * 商品模糊搜索
	 * @param id
	 * @return
	 */
	public List<GoodsProduct> findPagesByFuzzy(int page,int pageSize,int minStatus,int maxStatu,String keyword);
	/**
	 * 模糊搜索总页数
	 */
	
	public int totalPagesByFuzzy(int pageSize,int minStatus,int maxStatus,String keyword) ;
	/**
	 * 模糊搜索获取商品总数
	 * @return
	 */
	
	public int getCountByFuzzy(int minStatus,int maxStatus,String keyword) ;
	/**
	 * 根据Id获取商品
	 * @param id
	 * @return
	 */
	public GoodsProduct findById(int id);
	/**
	 * 查询该分类是否有商品
	 * @param id
	 * @return
	 */
	public boolean categoryIsUsing(int id);
	/**
	 * 根据名称获取商品
	 * @param id
	 * @return
	 */
	public GoodsProduct findByName(String name,int minStatus,int maxStatus);
	/**
	 * 添加商品
	 * @param 
	 */
	public void addProduct(GoodsProduct product);
	/**
	 * 更新商品
	 * @param 
	 */
	public void updateProduct(GoodsProduct product);
	/**
	 * 删除商品
	 * @param id
	 */
	public void deleteProduct(int id);
	/**
	 * 获取商品总数
	 * @return
	 */
	public int getCount(int minStatus,int maxStatus);
	/**
	 * 分页获取商品
	 * @param page 起始页
	 * @param pageSize 长度
	 * @return
	 */
	public List<GoodsProduct> findPages(int page,int pageSize,int minStatus,int maxStatus);
	/**
	 * 获取总页数
	 * @param pageSize 长度
	 * @return
	 */
    public int totalPages(int pageSize,int minStatus,int maxStatus);
	/**
	 * 根据状态获取
	 * @param gpStatus
	 * @return
	 */
    public GoodsProduct findByStatus(int gpStatus);
	/**
	 * 根据分类id获取
	 * @param gpCid
	 * @param minStatus
	 * @param maxStatus
	 * @return
	 */
    public GoodsProduct findByCategoryId(int gpCid, int minStatus, int maxStatus);
	/**
	 * 根据用户id获取
	 * @param gpUid
	 * @param minStatus
	 * @param maxStatus
	 * @return
	 */
    public GoodsProduct findByUserId(int gpUid, int minStatus, int maxStatus);
    
}
