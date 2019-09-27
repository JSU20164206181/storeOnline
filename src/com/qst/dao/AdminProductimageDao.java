/**
 * 
 */
package com.qst.dao;

import java.util.List;

import com.qst.pojo.GoodsProduct;
import com.qst.pojo.GoodsProductimage;

/**
 * @ClassName:AdminProductimageDao.java
 * @version:v1.0.0
 * @author:mwy
 * @date:2019年8月9日 下午4:34:56
 * @Description:管理员商品图片dao接口
 */
public interface AdminProductimageDao {
	/**
	 * 根据Id获取商品图片
	 * @param id
	 * @return
	 */
	public GoodsProductimage findById(int id);

	/**
	 * 根据类型获取商品图片
	 * @param id
	 * @return
	 */
	public List<GoodsProductimage> findByType(String type,int pid,int minStatus,int maxStatus);

	/**
	 * 添加商品图片
	 * @param 
	 */
	public void addProductimage(GoodsProductimage productimage);
	/**
	 * 更新商品图片
	 * @param 
	 */
	public void updateProductimage(GoodsProductimage productimage);

	/**
	 * 删除商品图片
	 * @param id
	 */
	public void deleteProductimage(int id);

	/**
	 * 获取商品图片总数
	 * @param minStatus
	 * @param maxStatus
	 * @return
	 */
	public int getCount(int minStatus,int maxStatus);

	/**
	 * 根据商品id获取商品图片
	 * @return
	 */
	public List<GoodsProductimage> findListByProductId(int gpId,int minStatus,int maxStatus);
	/**
	 * 分页获取商品图片
	 * @param page 起始页
	 * @param pageSize 长度
	 * @return
	 */
	public List<GoodsProductimage> findPages(int page,int pageSize,int minStatus,int maxStatus);
	/**
	 * 获取总页数
	 * @param pageSize 长度
	 * @return
	 */
    public int totalPages(int pageSize,int minStatus,int maxStatus);
    /**
	 * 商品图片模糊搜索
	 * @param id
	 * @return
	 */
	public List<GoodsProductimage> findPagesByFuzzy(int page,int pageSize,int minStatus,int maxStatu,String keyword);
	/**
	 * 模糊搜索总页数
	 */
	
	public int totalPagesByFuzzy(int pageSize,int minStatus,int maxStatus,String keyword) ;
	/**
	 * 模糊搜索获取商品图片总数
	 * @return
	 */
	
	public int getCountByFuzzy(int minStatus,int maxStatus,String keyword) ;

	/**
	 * 批量增加商品图片
	 * @param list 商品图片集合
	 * @return
	 */
	public int batchAdd(List<GoodsProductimage> list);
}
