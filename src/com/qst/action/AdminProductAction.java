/**
 * 
 */
package com.qst.action;

import java.io.File;
import java.io.IOException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.FileUtils;
import org.apache.struts2.ServletActionContext;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.opensymphony.xwork2.ActionContext;
import com.qst.dao.AdminCategoryDao;
import com.qst.dao.AdminProductDao;
import com.qst.dao.AdminProductimageDao;
import com.qst.pojo.GoodsCategory;
import com.qst.pojo.GoodsProduct;
import com.qst.pojo.GoodsProductimage;

/**
 * @ClassName:AdminProductAction.java
 * @version:v1.0.0
 * @author:mwy
 * @date:2019年8月7日 下午9:02:28
 * @Description:管理员对商品的操作
 */
@Transactional
@Controller
public class AdminProductAction implements FinalConst{
	@Resource(name = "adminProductDaoImp")
	private AdminProductDao gpdao;
	@Resource(name = "adminCategoryDaoImp")
	private AdminCategoryDao gcdao;
	@Resource(name = "adminProductimageDaoImp")
	private AdminProductimageDao gpidao;
	private List<GoodsProduct> productList;
	private List<GoodsCategory> categoryList;
	private List<GoodsProductimage> productimageList;
	private int productListLength;
	private GoodsProduct product;
	private int gpId;
	private int nowPage = 1;
	private int allPage;
	private int pageSize = 5;
	private int productimageListSize;//某商品图片总数
	private int maxFileNumLimit = 6;//允许上传的图片最大数量
	private int fileNumLimit;//允许上传的图片数量限制
	private String gpiType;//图片类型
	private int[] productimageIdList;//图片id集合
	private String keyword;//模糊搜索关键字
	private File titleImg; //file控件名
	private String imgPath;//获取图片地址
	public String test() {

		return "success";
	}
	
	/**
	 * @return 审核商品页面模糊搜索商品列表
	 */
	public String findAuditProductListByFuzzy() {
		categoryList = gcdao.findAll();
		
		int minStatus = 2;
		int maxStatus = 3;
		allPage = gpdao.totalPagesByFuzzy(pageSize, minStatus, maxStatus,keyword);
		if ((nowPage) > allPage) {
			nowPage = allPage;
		}
		if (nowPage < 1) {
			nowPage = 1;
		}

		setProductList(gpdao.findPagesByFuzzy(nowPage, pageSize, minStatus, maxStatus,keyword));
		productListLength = gpdao.getCountByFuzzy(minStatus, maxStatus,keyword);
		return "success";
	}
	/**
	 * @return 商品列表页面模糊搜索商品列表
	 */
	public String findProductListByFuzzy() {
		categoryList = gcdao.findAll();
		
		int minStatus = 0;
		int maxStatus = 1;
		allPage = gpdao.totalPagesByFuzzy(pageSize, minStatus, maxStatus,keyword);
		if ((nowPage) > allPage) {
			nowPage = allPage;
		}
		if (nowPage < 1) {
			nowPage = 1;
		}

		setProductList(gpdao.findPagesByFuzzy(nowPage, pageSize, minStatus, maxStatus,keyword));
		productListLength = gpdao.getCountByFuzzy(minStatus, maxStatus,keyword);
		return "success";
	}
	/**
	 * @return 根据id查询商品跳转商品修改页面
	 */
	public String findProductById() {
		categoryList = gcdao.findAll();
		product = gpdao.findById(gpId);
		return "success";
	}

	/**
	 * @return 分页获取审核商品列表
	 */
	public String findAuditProductList() {
		int minStatus = 2;
		int maxStatus = 3;
		allPage = gpdao.totalPages(pageSize, minStatus, maxStatus);
		if ((nowPage) > allPage) {
			nowPage = allPage;
		}
		if (nowPage < 1) {
			nowPage = 1;
		}
		categoryList = gcdao.findAll();
		setProductList(gpdao.findPages(nowPage, pageSize, minStatus, maxStatus));
		productListLength = gpdao.getCount(minStatus, maxStatus);

		return "success";
	}

	/**
	 * @return 分页获取修改商品列表
	 */
	public String findProductList() {
		int minStatus = 0;
		int maxStatus = 1;
		allPage = gpdao.totalPages(pageSize, minStatus, maxStatus);
		if ((nowPage) > allPage) {
			nowPage = allPage;
		}
		if (nowPage < 1) {
			nowPage = 1;
		}
		categoryList = gcdao.findAll();
		setProductList(gpdao.findPages(nowPage, pageSize, minStatus, maxStatus));
		productListLength = gpdao.getCount(minStatus, maxStatus);

		return "success";
	}

	/**
	 * 审核后修改商品状态
	 * 
	 * @return
	 */
	public String updateProductStatus() {
		HttpServletRequest request = ServletActionContext.getRequest();
		int productID = Integer.parseInt(request.getParameter("productID"));
		int status = Integer.parseInt(request.getParameter("status"));
		GoodsProduct product = gpdao.findById(productID);
		product.setGpStatus(status);
		gpdao.updateProduct(product);

		return "success";
	}

	/**
	 * 修改商品
	 * 
	 * @return
	 */
	public String updateProduct() {
		int minStatus = 1;
		int maxStatus = 1;
		HttpServletRequest request = ServletActionContext.getRequest();
		GoodsProduct product = gpdao.findById(Integer.parseInt(request.getParameter("gpId")));
		
		product.setGpName(request.getParameter("gpName"));
		product.setGpIntroduce(request.getParameter("gpIntroduce"));
		product.setGpOriginalPrice(Double.valueOf(request.getParameter("gpOriginalPrice")));
		product.setGpPromotePrice(Double.valueOf(request.getParameter("gpPromotePrice")));
		product.setGpStock(Integer.parseInt(request.getParameter("gpStock")));
		product.setGpCid(Integer.parseInt(request.getParameter("gpCid")));
		String fileFileName = request.getParameter("imgPath");//图片路径
		
		if(!product.getTitleImg().equals(imgPath)){
			String picPath = uploadImg(product.getGpUid()+"/"+product.getGpId()+"/",titleImg,fileFileName);
			product.setTitleImg(picPath);
			List<GoodsProductimage> oldimage = gpidao.findByType("封面",gpId,minStatus,maxStatus);
			GoodsProductimage productimage;
			if(oldimage!=null&&oldimage.size()>0){
				for(int i = 0 ; i < oldimage.size(); i++){
					productimage = oldimage.get(i);
					productimage.setGpiType("介绍");
					gpidao.updateProductimage(productimage);
				}
				productimage = oldimage.get(0);
				productimage.setGpiType("封面");
				productimage.setGpiUrl(picPath);
				gpidao.updateProductimage(productimage);
			}else{
				productimage = new GoodsProductimage(product.getGpId(),"封面",picPath,1);
				gpidao.addProductimage(productimage);
			}
			
		}
		gpdao.updateProduct(product);
		
		return "success";
	}
	/**
	 * 封面图片上传
	 */
	public String uploadImg(String id,File uploadFile,String fileFileName) {
		HttpServletRequest request = ServletActionContext.getRequest();
		String root = request.getSession().getServletContext().getRealPath("/");// 图片要上传到的服务器路径
		
		String storeUpload = (new File(root)).getParent() + "/storeUpload/" + id;
		
		String names[] = fileFileName.split("\\.");
		String fileName = "";
		if (names.length >= 1) {
			fileName = getRandomString(20) + "." + names[names.length - 1];
		}
		String picPath = SERVER_IMAGE_PATH+ id + fileName;// 图片保存到数据库的路径
		System.out.println(storeUpload);
		File file1 = new File(storeUpload);
		
		if(!file1.exists()){
			file1.mkdirs();  //创建目录
        }
		
		
		try {
			FileUtils.copyFile(uploadFile, new File(file1, fileName));
		} catch (IOException e) {
			e.printStackTrace();
		}
		return picPath;
	}
	/*获取一条随机字符串*/
    public String getRandomString(int length) { //length表示生成字符串的长度  
        String base = "abcdefghijklmnopqrstuvwxyz0123456789";     
        Random random = new Random();     
        StringBuffer sb = new StringBuffer();     
        for (int i = 0; i < length; i++) {     
            int number = random.nextInt(base.length());     
            sb.append(base.charAt(number));     
        }     
        return sb.toString();     
     }    
    /**
	 * @return 展示商品详情(包含商品图片)
	 */
	public String showProduct() {
		int minStatus = 1;
		int maxStatus = 1;
		productimageList = gpidao.findListByProductId(gpId,minStatus,maxStatus);
		product = gpdao.findById(gpId);
		
		return "success";
	}
	/**
	 * @return 展示商品图片库
	 */
	public String showProductimageUpdate() {
		int minStatus = 1;
		int maxStatus = 1;
		productimageList = gpidao.findListByProductId(gpId,minStatus,maxStatus);
		product = gpdao.findById(gpId);
		
		return "success";
	}
	/**
	 * @return 展示添加商品图片界面
	 */
	public String showProductimageAdd() {
		int minStatus = 1;
		int maxStatus = 1;
		productimageList = gpidao.findListByProductId(gpId,minStatus,maxStatus);
		productimageListSize = productimageList.size();
		fileNumLimit = maxFileNumLimit - productimageListSize;
		if(fileNumLimit<0){
			fileNumLimit = 0;
		}
		product = gpdao.findById(gpId);
		
		return "success";
	}
	/**
	 * @return 上传商品图片
	 */
	public String uploadProductimage() {
		ActionContext context = ActionContext.getContext();
		Map params = context.getParameters(); 
		String[] fileNameList = (String[])params.get("fileFileName");
		File[] fileList = (File[]) params.get("file"); //file数组
		product = gpdao.findById(gpId);
		for(int i = 0; i < fileList.length; i++){
			String picPath = uploadImg(product.getGpUid()+"/"+product.getGpId()+"/",fileList[i],fileNameList[i]);
			
			GoodsProductimage image = new GoodsProductimage(product.getGpId(),"介绍",picPath,1);
			gpidao.addProductimage(image);
		}
		
		
		return null;
	}
	
	/**
	 * @return 设置图片为封面
	 */
	public String setToCover() {
		int minStatus = 1;
		int maxStatus = 1;
		List<GoodsProductimage> oldimage = gpidao.findByType("封面",gpId,minStatus,maxStatus);
		GoodsProductimage productimage;
		if(oldimage!=null&&oldimage.size()>0){
			for(int i = 0 ; i < oldimage.size(); i++){
				productimage = oldimage.get(i);
				productimage.setGpiType("介绍");
				gpidao.updateProductimage(productimage);
			}
		}
		
		productimage = gpidao.findById(productimageIdList[0]);
		productimage.setGpiType("封面");
		gpidao.updateProductimage(productimage);
		product = gpdao.findById(gpId);
		product.setTitleImg(productimage.getGpiUrl());
		gpdao.updateProduct(product);
		productimageList = gpidao.findListByProductId(gpId,minStatus,maxStatus);
		
		
		return "success";
	}
	
	/**
	 * @return 批量删除图片
	 */
	public String deleteProductimage() {
		int minStatus = 1;
		int maxStatus = 1;
		GoodsProductimage productimage;
		for(int i = 0; i < productimageIdList.length; i++){
			productimage = gpidao.findById(productimageIdList[i]);
			productimage.setGpiStatus(2);
			gpidao.updateProductimage(productimage);
		}
		
		productimageList = gpidao.findListByProductId(gpId,minStatus,maxStatus);
		product = gpdao.findById(gpId);
		return "success";
	}

	

	public int[] getProductimageIdList() {
		return productimageIdList;
	}

	public void setProductimageIdList(int[] productimageIdList) {
		this.productimageIdList = productimageIdList;
	}

	public String getGpiType() {
		return gpiType;
	}

	public void setGpiType(String gpiType) {
		this.gpiType = gpiType;
	}

	public int getMaxFileNumLimit() {
		return maxFileNumLimit;
	}

	public void setMaxFileNumLimit(int maxFileNumLimit) {
		this.maxFileNumLimit = maxFileNumLimit;
	}

	public int getFileNumLimit() {
		return fileNumLimit;
	}

	public void setFileNumLimit(int fileNumLimit) {
		this.fileNumLimit = fileNumLimit;
	}

	public int getProductimageListSize() {
		return productimageListSize;
	}

	public void setProductimageListSize(int productimageListSize) {
		this.productimageListSize = productimageListSize;
	}

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	public String getImgPath() {
		return imgPath;
	}

	public void setImgPath(String imgPath) {
		this.imgPath = imgPath;
	}

	public File getTitleImg() {
		return titleImg;
	}

	public void setTitleImg(File titleImg) {
		this.titleImg = titleImg;
	}

	public List<GoodsCategory> getCategoryList() {
		return categoryList;
	}

	public void setCategoryList(List<GoodsCategory> categoryList) {
		this.categoryList = categoryList;
	}

	public int getGpId() {
		return gpId;
	}

	public void setGpId(int gpId) {
		this.gpId = gpId;
	}

	public GoodsProduct getProduct() {
		return product;
	}

	public void setProduct(GoodsProduct product) {
		this.product = product;
	}

	public List<GoodsProduct> getProductList() {
		return productList;
	}

	public void setProductList(List<GoodsProduct> productList) {
		this.productList = productList;
	}

	public int getProductListLength() {
		return productListLength;
	}

	public void setProductListLength(int productListLength) {
		this.productListLength = productListLength;
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

	public List<GoodsProductimage> getProductimageList() {
		return productimageList;
	}

	public void setProductimageList(List<GoodsProductimage> productimageList) {
		this.productimageList = productimageList;
	}

	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
}
