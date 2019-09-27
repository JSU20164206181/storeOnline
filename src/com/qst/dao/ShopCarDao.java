package com.qst.dao;

import com.qst.pojo.ShopCar;

import java.util.List;

/**
 * @Auther: CGL
 * @Date: 2019/8/7 11:05
 * @Description:购物车dao层接口 定义数据库交互方法
 */
public interface ShopCarDao {

	/**
	 * 根据id查询具体数据
	 *
	 * @param id
	 * @return
	 */
	ShopCar findById(int id);

	/**
	 * 根据商品id查询
	 *
	 * @param id
	 * @return
	 */
	ShopCar findByGoodsId(int id);

	/**
	 * 根据用户id分页查询用户购物车
	 *
	 * @param id
	 * @return
	 */
	List<ShopCar> findByUserId(int id, int page, int pageSize);

    /**
     *  监测新添加商品在用户购物车是否已经存在
     * @param userId
     * @param goodsId
     * @return
     */
    ShopCar isExist(int userId,int goodsId);
	/**
	 * 根据用户id查询购物车里的所有商品
	 *
	 * @param id
	 * @return
	 */
	List<ShopCar> findAllByUserId(int id);

    /**
     * 根据用户id查询时分页的总页数
     * @param id
     * @param pageSize
     * @return
     */
    int totalPage(int id,int pageSize);

    /**
     * 添加商品到购物车
     * @param sc
     * @return
     */
    int addShopCar(ShopCar sc);


    /**
     * 删除购物车数据
     * @param id
     */
    void deleteById(int id);

	/**
	 * 更改购物车数据
	 *
	 * @param sc
	 */
	void updateById(ShopCar sc);

}
