/**
 * 
 */
package com.qst.action;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;

import com.qst.dao.AdminCategoryDao;
import com.qst.dao.AdminProductDao;
import com.qst.dao.AdminProductimageDao;
import com.qst.pojo.GoodsCategory;
import com.qst.pojo.GoodsProduct;
import com.qst.pojo.GoodsProductimage;

/**
 * @ClassName:AdminProductimageAction.java
 * @version:v1.0.0
 * @author:mwy
 * @date:2019年8月13日 上午10:34:18
 * @Description:管理员对图片的操作
 */
@Transactional
@Controller
public class AdminProductimageAction implements FinalConst{
	@Resource(name = "adminProductDaoImp")
	private AdminProductDao gpdao;
	@Resource(name = "adminCategoryDaoImp")
	private AdminCategoryDao gcdao;
	@Resource(name = "adminProductimageDaoImp")
	private AdminProductimageDao gpidao;
	private List<GoodsProduct> productList;
	private List<GoodsProductimage> productimageList;
	private GoodsProductimage productimage;
	private GoodsProduct product;
	private int gpiId;
	private int productimageListLength;
	private String keyword;
	private int nowPage = 1;
	private int allPage;
	private int pageSize = 5;
	
	/**
	 * @return 根据id查询商品图片跳转商品图片修改页面
	 */
	public String findProductimageById() {
		
		productimage = gpidao.findById(gpiId);
		return "success";
	}

	

	/**
	 * @return 分页获取商品图片列表
	 */
	public String findProductimageList() {
		int minStatus = 0;
		int maxStatus = 1;
		allPage = gpidao.totalPages(pageSize, minStatus, maxStatus);
		if ((nowPage) > allPage) {
			nowPage = allPage;
		}
		if (nowPage < 1) {
			nowPage = 1;
		}

		setProductimageList(gpidao.findPages(nowPage, pageSize, minStatus, maxStatus));
		productimageListLength = gpidao.getCount(minStatus, maxStatus);
		
		productList = new ArrayList<GoodsProduct>();
		productList.clear();
		for(int i = 0; i < productimageList.size();i++){
			GoodsProduct product = gpdao.findById(productimageList.get(i).getGpiPid());
			productList.add(product);
		}
		
		return "success";
	}
	
	/**
	 * @return 模糊搜索分页获取商品图片列表
	 */
	public String findProductimageListByFuzzy() {
		int minStatus = 0;
		int maxStatus = 1;
		allPage = gpidao.totalPagesByFuzzy(pageSize, minStatus, maxStatus,keyword);
		if ((nowPage) > allPage) {
			nowPage = allPage;
		}
		if (nowPage < 1) {
			nowPage = 1;
		}

		setProductimageList(gpidao.findPagesByFuzzy(nowPage, pageSize, minStatus, maxStatus,keyword));
		productimageListLength = gpidao.getCountByFuzzy(minStatus, maxStatus,keyword);
		
		productList = new ArrayList<GoodsProduct>();
		productList.clear();
		for(int i = 0; i < productimageList.size();i++){
			GoodsProduct product = gpdao.findById(productimageList.get(i).getGpiPid());
			productList.add(product);
		}
		
		return "success";
	}


	/**
	 * 修改商品图片状态
	 * 
	 * @return
	 */
	public String updateProductimageStatus() {
		HttpServletRequest request = ServletActionContext.getRequest();
		int gpiId = Integer.parseInt(request.getParameter("gpiId"));
		int status = Integer.parseInt(request.getParameter("status"));
		GoodsProductimage productimage = gpidao.findById(gpiId);
		productimage.setGpiStatus(status);
		gpidao.updateProductimage(productimage);
		return "success";
	}



	
	
	
	public String getKeyword() {
		return keyword;
	}



	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}



	public List<GoodsProduct> getProductList() {
		return productList;
	}



	public void setProductList(List<GoodsProduct> productList) {
		this.productList = productList;
	}



	public List<GoodsProductimage> getProductimageList() {
		return productimageList;
	}



	public void setProductimageList(List<GoodsProductimage> productimageList) {
		this.productimageList = productimageList;
	}



	public GoodsProductimage getProductimage() {
		return productimage;
	}



	public void setProductimage(GoodsProductimage productimage) {
		this.productimage = productimage;
	}



	public GoodsProduct getProduct() {
		return product;
	}



	public void setProduct(GoodsProduct product) {
		this.product = product;
	}



	public int getGpiId() {
		return gpiId;
	}



	public void setGpiId(int gpiId) {
		this.gpiId = gpiId;
	}



	public int getProductimageListLength() {
		return productimageListLength;
	}



	public void setProductimageListLength(int productimageListLength) {
		this.productimageListLength = productimageListLength;
	}



	public int getNowPage() {
		return nowPage;
	}



	public void setNowPage(int nowPage) {
		this.nowPage = nowPage;
	}



	public int getAllPage() {
		return allPage;
	}



	public void setAllPage(int allPage) {
		this.allPage = allPage;
	}



	public int getPageSize() {
		return pageSize;
	}



	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}
	
	
}
