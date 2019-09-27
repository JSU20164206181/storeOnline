/**
 * 
 */
package com.qst.dao;

import java.util.List;

import com.qst.pojo.GoodsCategory;
import com.qst.pojo.GoodsProduct;

/**
 * @ClassName:AdminCategoryDao.java
 * @version:v1.0.0
 * @author:mwy
 * @date:2019年8月8日 下午5:21:07
 * @Description:管理员商品分类dao接口
 */
public interface AdminCategoryDao {
	/**
	 * 获取所有商品分类
	 * @param id
	 * @return
	 */
	public List<GoodsCategory> findAll();
	/**
	 * 模糊查询商品分类
	 * @param id
	 * @return
	 */
	public List<GoodsCategory> findAllByFuzzy(String keyword);
	/**
	 * 根据Id获取商品分类
	 * @param id
	 * @return
	 */
	public GoodsCategory findById(int id);
	/**
	 * 根据名称获取商品分类
	 * @param id
	 * @return
	 */
	public GoodsCategory findByName(String name);
	/**
	 * 添加商品分类
	 * @param 
	 */
	public void addCategory(GoodsCategory category);
	/**
	 * 更新商品分类
	 * @param 
	 */
	public void updateCategory(GoodsCategory category);
	/**
	 * 删除商品分类
	 * @param id
	 */
	public void deleteCategory(int id);
	
}
