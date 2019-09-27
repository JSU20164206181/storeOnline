/**
 * 
 */
package com.qst.dao;


import java.util.List;

import com.qst.pojo.GoodsOrder;
import com.qst.pojo.GoodsProduct;
import com.qst.pojo.GoodsUser;
import com.qst.pojo.ReceiveAddress;

/**
* @ClassName: UserDao.java
* @version: v1.0.0
* @author: ls
* @date: 2019年7月30日 上午9:20:53
* @Description: 操作个人信息的接口
*/

public interface UserInterface {
	//ajxa判断用户是否存在
    public String findUser(String name);
    //通过name查用户
  	public GoodsUser findUserByName(String name);
    //注册一个用户
    public void addUser(GoodsUser user);
    //登录的时传入账号密码进行判断
    public GoodsUser findUserId(String name,String password);
    //根据id查询用户的信息
    public GoodsUser findUserMsg(int id);
    //修改用户的个人信息
    public void updateUser(GoodsUser user);
    //根据id查询用户的收货地址
    public List<ReceiveAddress> findReceiveById(int id);
    //新增收货地址
    public void SaveorUpdateReceiveAddress(ReceiveAddress receiveAddress);
    //删除收货地址
    public void deleteReceiceAddress(ReceiveAddress receiveAddress);
    //查询商品
    public List<GoodsProduct> findByUserId(int userId, int page, int pageSize);
    //查询总页数
    public int totalPageByUserId(int userId, int pageSize);
    //删除自己的商品
    public void deleteGoods(int id);
    //下架自己的商品
    public GoodsProduct findProductById(int id);
    //更新商品状态
    public void updateProduct(GoodsProduct goodsProduct);
    //模糊查找商品
    public List<GoodsProduct> findByFuzzy(String mohu,int page,int pageSize);
    //模糊查找总页数
	public int totalPageByFuzzy(String mohu, int pageSize);
	//查询所有的用户
	public List<GoodsUser> cityShow();
	//查询所有的订单
	public List<GoodsOrder> findOrderByid(int id);
	
}
