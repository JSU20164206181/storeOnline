package com.qst.dao;

import java.util.List;

import com.qst.pojo.GoodsAdmin;
import com.qst.pojo.GoodsUser;

/**
 * @ClassName: AdminDao.java
 * @version: v1.0.0
 * @author: hdq
 * @date: 2019年8月12日 下午5:01:56
 * @Description: 管理员接口
 */
public interface AdminDao {
	/**
	 * 根据名字查找管理员信息
	 * 
	 * @param name
	 * @return
	 */
	public GoodsAdmin findByName(String name);

	/**
	 * 根据id查找管理员信息
	 * 
	 * @param name
	 * @return
	 */
	public GoodsAdmin findAdminById(int id);

	/**
	 * 更新管理员信息
	 * 
	 * @param v
	 * @return
	 */
	public void updateAdmin(GoodsAdmin admin);

	/**
	 * 增加管理员
	 * 
	 * @param user
	 * 管理员实体类
	 */
	public void addAdmin(GoodsAdmin admin);

	/**
	 * 根据管理员id删除管理员
	 * 
	 * @param id
	 *  用户id
	 */
	public void deleteAdmin(int id);

	/**
	 * 分页查询管理员
	 * 
	 * @param page
	 *            起始页
	 * @param pageSize
	 *            每页显示的数量
	 * @return 指定的多个管理员信息
	 */
	public List<GoodsAdmin> findPages(int page, int pageSize);

	/**
	 * 管理员总数量
	 * 
	 * @return 用户数量
	 */
	public int adminNumber();
	/**
	 * 管理员总页数
	 * 
	 * @return 用户数量
	 */
	public int totalPages(int pageSize);
	/**
	 *全部 管理员
	 * 
	 * @return 
	 */
	List<GoodsAdmin> findAllAdmin();

}
