package com.qst.dao;

import com.qst.pojo.GoodsProduct;

import java.util.List;

/**
 * @Auther: CGL
 * @Date: 2019/8/7 17:23
 * @Description: 商品类dao层接口定义
 */
public interface GoodsDao {

	/**
	 * 查询新增的商品
	 *
	 * @return
	 */
	List<GoodsProduct> findNewProducts();

	/**
	 * 根据商品ID查询
	 * 
	 * @return
	 */
	GoodsProduct findOneById(int id);

	/**
	 * 根据类型分页查找
	 *
	 * @param type
	 * @param page
	 * @param pageSize
	 * @return
	 */
	List<GoodsProduct> findByType(int type, int page, int pageSize);

	/**
	 * 分类查找时的分页查找
	 *
	 * @param type
	 * @param pageSize
	 * @return
	 */
	int totalPageType(int type, int pageSize);

	/**
	 * 根据上传用户id分页查找 用于用户查看自己上传到的商品
	 *
	 * @param userId
	 * @param page
	 * @param pageSize
	 * @return
	 */
	List<GoodsProduct> findByUserId(int userId, int page, int pageSize);

	/**
	 * 根据用户id分页查找时查找总页数
	 *
	 * @param userId
	 * @param pageSize
	 * @return
	 */
	int totalPageByUserId(int userId, int pageSize);

	/**
	 * 分局商品名称模糊分页查询
	 *
	 * @param key
	 * @param page
	 * @param pageSize
	 * @return
	 */
	List<GoodsProduct> fuzzySearch(String key, int page, int pageSize);

	/**
	 * 模糊分页查找数据的总页数
	 *
	 * @param key
	 * @param pageSize
	 * @return
	 */
	int totalPageByFS(String key, int pageSize);

	/**
	 * 通过商品id查询商品信息
	 *
	 * @param id
	 * @return
	 */
	GoodsProduct findById(int id);

	/**
	 * 添加商品
	 *
	 * @param v
	 * @return 返回增加商品的主键id
	 */
	int addGoods(GoodsProduct v);

	/**
	 * 更新商品信息
	 *
	 * @param v
	 */
	void updateGoods(GoodsProduct v);

	/**
	 * 删除商品
	 *
	 * @param id
	 */
	void delete(int id);

}
