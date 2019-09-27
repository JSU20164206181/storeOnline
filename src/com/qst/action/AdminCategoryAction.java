/**
 * 
 */
package com.qst.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;

import com.qst.dao.AdminCategoryDao;
import com.qst.dao.AdminProductDao;
import com.qst.pojo.GoodsCategory;
import com.qst.pojo.GoodsProduct;
import com.qst.pojo.GoodsProductimage;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

/**
 * @ClassName:AdminCategoryAction.java
 * @version:v1.0.0
 * @author:mwy
 * @date:2019年8月14日 上午10:21:47
 * @Description:管理员商品分类管理
 */
@Transactional
@Controller
public class AdminCategoryAction extends BaseSession implements FinalConst{
	@Resource(name = "adminProductDaoImp")
	private AdminProductDao gpdao;
	@Resource(name = "adminCategoryDaoImp")
	private AdminCategoryDao gcdao;
	private List<GoodsCategory> categoryList;
	private GoodsCategory category;
	private int gcId;
	private int categoryListLength;
	private String keyword;
	private int[] gcIdList;
	/**
	 * @return 根据id查询商品分类跳转商品分类修改页面
	 */
	public String findCategoryById() {
		
		category = gcdao.findById(gcId);
		categoryList = gcdao.findAll();
		JSONArray list;
		list = JSONArray.fromObject(categoryList);
		ServletActionContext.getRequest().setAttribute("list", list);
		return "success";
	}

	

	/**
	 * @return 获取所有商品分类
	 */
	public String findCategoryList() {
		categoryList = gcdao.findAll();
		categoryListLength = categoryList.size();
		return "success";
	}
	/**
	 * @return 模糊查询商品分类
	 */
	public String findCategoryListByFuzzy() {
		categoryList = gcdao.findAllByFuzzy(keyword);
		categoryListLength = categoryList.size();
		return "success";
	}
	/**
	 * 修改商品分类
	 * 
	 * @return
	 */
	public String updateCategory() {
		GoodsCategory old = gcdao.findById(category.getGcId());
		old.setGcName(category.getGcName());
		gcdao.updateCategory(old);
		return "success";
	}
	
	/**
	 * ajax删除商品分类
	 * 
	 * @return
	 */
	public String deleteCategoryList() {
		HttpServletResponse response = ServletActionContext.getResponse();
		//response.setContentType("text/html; charset=UTF-8");
		List<GoodsCategory> categoryList = new ArrayList<>();
		for(int i = 0; i < gcIdList.length; i++){
			if(!gpdao.categoryIsUsing(gcIdList[i])){
				gcdao.deleteCategory(gcIdList[i]);
			}else{
				
				categoryList.add(gcdao.findById(gcIdList[i]));
			}
		}
		JSONArray list;
		list = JSONArray.fromObject(categoryList);
		
		PrintWriter out ;
		
		try {
			out = response.getWriter();
			out.print(list);
			out.flush();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}


	/**
	 * 添加商品分类
	 * 
	 * @return
	 */
	public String addCategory() {
		category.setGcStatus(1);
		gcdao.addCategory(category);
		return "success";
	}
	
	
	/**
	 * 跳转添加商品分类界面
	 * 
	 * @return
	 */
	public String showCategoryAdd() {
		
		categoryList = gcdao.findAll();
		JSONArray list;
		list = JSONArray.fromObject(categoryList);
		ServletActionContext.getRequest().setAttribute("list", list);
		return "success";
	}
	
	
	


	public String getKeyword() {
		return keyword;
	}



	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}



	public int getCategoryListLength() {
		return categoryListLength;
	}



	public void setCategoryListLength(int categoryListLength) {
		this.categoryListLength = categoryListLength;
	}



	public List<GoodsCategory> getCategoryList() {
		return categoryList;
	}



	public void setCategoryList(List<GoodsCategory> categoryList) {
		this.categoryList = categoryList;
	}



	public GoodsCategory getCategory() {
		return category;
	}



	public void setCategory(GoodsCategory category) {
		this.category = category;
	}



	public int getGcId() {
		return gcId;
	}



	public void setGcId(int gcId) {
		this.gcId = gcId;
	}



	public int[] getGcIdList() {
		return gcIdList;
	}



	public void setGcIdList(int[] gcIdList) {
		this.gcIdList = gcIdList;
	}
	
	
}
