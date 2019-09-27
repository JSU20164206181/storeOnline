
package com.qst.dao;

import java.util.List;
import java.util.Map;

import com.qst.pojo.GoodsUser;

/**
 * @ClassName: UserInterface.java
 * @version: v1.0.0
 * @author: ZYL
 * @date: 2019年7月30日 上午9:20:53
 * @Description: 用户接口
 */
public interface UserDao {
	/**
	 * 增加用户
	 * 
	 * @param user
	 *            用户实体类
	 */
	public void addUser(GoodsUser user);

	/**
	 * 根据用户id删除用户
	 * 
	 * @param id
	 *            用户id
	 */
	public void deleteUser(int id);

	/**
	 * 修改用户
	 * 
	 * @param user
	 *            用户实体类
	 */
	public void updateUser(GoodsUser user);

	/**
	 * 查询所有用户
	 * 
	 * @return 用户集合
	 */
	public List<GoodsUser> findAllUser();

	/**
	 * 根据用户id查询用户
	 * 
	 * @param id
	 *            用户id
	 * @return 一个用户的信息
	 */
	public GoodsUser findUserById(int id);

	/**
	 * 根据用户名称查询用户
	 * 
	 * @param userName
	 *            用户名称
	 * @return 一个用户的信息
	 */
	public GoodsUser findUserByName(String userName);

	/**
	 * 一字段匹配多条件模糊查找用户
	 * 
	 * @param str
	 * @return 用户集合
	 */
	public List<GoodsUser> fuzzyFindUser(String str, int page, int pageSize);

	/**
	 * 模糊查找用户总页数
	 * 
	 * @param str
	 * @return 总页数
	 */
	public int fuzzyPageNumber(String str,int pageSize);

	/**
	 * 模糊查找用户总数量
	 * 
	 * @param str
	 * @return 总数量
	 */
	public int fuzzyAllNumber(String str);

	/**
	 * 分页查询用户
	 * 
	 * @param page
	 *            起始页
	 * @param pageSize
	 *            每页显示的数量
	 * @return 指定的多个用户信息
	 */
	public List<GoodsUser> findPages(int page, int pageSize);

	/**
	 * 统计所有的页数
	 * 
	 * @param pageSize
	 *            每页显示的数量
	 * @return 总页数
	 */
	public int totalPages(int pageSize);

	/**
	 * 用户总数量
	 * 
	 * @return 用户数量
	 */
	public int userNumber();

	/**
	 * 统计男女数量
	 * 
	 * @return
	 * 
	 */
	public Map<String, Integer> userSexCount();

	/**
	 * 统计年龄分布
	 * 
	 * @return
	 */
	public Map<String, Integer> userAgeCount();
}
