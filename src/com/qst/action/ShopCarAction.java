package com.qst.action;

import com.qst.dao.GoodsDao;
import com.qst.dao.ReceiveAddressDao;
import com.qst.dao.ShopCarDao;
import com.qst.pojo.GoodsProduct;
import com.qst.pojo.GoodsUser;
import com.qst.pojo.ReceiveAddress;
import com.qst.pojo.ShopCar;

import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

/**
 * @Auther: CGL
 * @Date: 2019/8/7 15:44
 * @Description:
 */
@Transactional
@Controller("shopCarAction")
public class ShopCarAction {
	@Autowired
	private ShopCarDao scd;
	@Autowired
	private GoodsDao gd;
	@Autowired
	private ReceiveAddressDao rad;
	private ShopCar sc;
	private GoodsUser user;

	/**
	 * 加载购物车商品
	 *
	 * @return
	 */
	public String searchShopCar() {
		HttpServletRequest request = ServletActionContext.getRequest();
		int userId = Integer.parseInt(request.getParameter("userId"));
		List<ShopCar> shopCarList = scd.findAllByUserId(userId);
		if(shopCarList==null){
			return "success";
		}
		request.setAttribute("shopCarList", shopCarList);
		List<GoodsProduct> gpList=new ArrayList<>();
		for(int i=0;i<shopCarList.size();i++) {
			gpList.add(shopCarList.get(i).getGoodsProduct());
		}
		request.setAttribute("gpList", gpList);
		System.out.println(gpList);
		System.out.println(shopCarList);
		List<GoodsProduct> GoodsProductList = gd.findNewProducts();
		System.out.println(GoodsProductList);
		request.setAttribute("GoodsProductList", GoodsProductList);
		return "success";
	}

	/* 添加商品到购物车 */
	public String addShopCar() throws IOException {
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		ShopCar sc=new ShopCar();
		int goodsId = Integer.parseInt(request.getParameter("goodsId"));

		int userId = Integer.parseInt(request.getParameter("userId"));
		if ((sc = scd.isExist(userId, goodsId)) != null) {
			System.out.println("-------------------");
			sc.setGoodsNum(sc.getGoodsNum() + 1);
			response.getWriter().print("ok");
		} else {
			String s;
			int goodsNum = 1;
			if ((s = request.getParameter("goodsNum")) != null && !s.equals("")) {
				goodsNum = Integer.parseInt(s);
			}
			sc = new ShopCar(userId, goodsId, goodsNum);
			System.out.println(sc);
			int i;
			if ((i = scd.addShopCar(sc)) > 0)
				response.getWriter().print("ok");
			else
				response.getWriter().print("error");
		}
		return null;
	}

	/**
	 * 删除购物车商品
	 *
	 * @return
	 */
	public String deleteShopCar() {
		HttpServletRequest request = ServletActionContext.getRequest();
		int id = Integer.parseInt(request.getParameter("id"));
		scd.deleteById(id);
		return "success";
	}

	/**
	 * 修改购物车商品数量
	 *
	 * @return
	 */
	public String updateShopCar() {
		HttpServletRequest request = ServletActionContext.getRequest();
		int id = Integer.parseInt(request.getParameter("id"));
		int goodsNum = Integer.parseInt(request.getParameter("goodsNum"));
		setSc(scd.findById(id));
		sc.setGoodsNum(goodsNum);
		scd.updateById(sc);
		return "success";
	}

	/**
	 * 生成订单
	 *
	 * @return
	 */
	public String createOrder() {
		HttpServletRequest request = ServletActionContext.getRequest();
		int userId = Integer.parseInt(request.getParameter("userId"));
		List<ReceiveAddress> receiveAddressList = rad.findAllRaByUserId(userId);
		request.setAttribute("receiveAddressList", receiveAddressList);
		List<ShopCar> orderGoodsList = new ArrayList<ShopCar>();
		String[] idList = request.getParameterValues("idList");
		double subtotal = Double.valueOf(request.getParameter("subtotal"));
		double freight = Double.valueOf(request.getParameter("freight"));
		double aggregate = Double.valueOf(request.getParameter("aggregate"));
		String str = null;
		for (int i = 0; i < idList.length; i++) {
			str = idList[i];
		}
		String[] scIdList = str.split(",");
		List<Integer> scidList=new ArrayList<>();//购物车里的商品的sc_id
		List<Integer> gidList = new ArrayList<>();//商品列表里的商品gp_id
		for (int i = 0; i < scIdList.length; i++) {
			System.out.println("~~~~~~~~~~IdList:"+scIdList[i]);
			scidList.add(Integer.parseInt(scIdList[i]));
			ShopCar sc=new ShopCar();
			sc = scd.findById(Integer.parseInt(scIdList[i]));
			System.out.println("------------:"+sc);
			orderGoodsList.add(sc);
			gidList.add(sc.getGoodsId());
		}
		request.setAttribute("scidList", scidList);
		request.setAttribute("gidList", gidList);
		request.setAttribute("orderGoodsList", orderGoodsList);
		request.setAttribute("subtotal", subtotal);
		request.setAttribute("freight", freight);
		request.setAttribute("aggregate", aggregate);
		List<GoodsProduct> GoodsProductList = gd.findNewProducts();
		request.setAttribute("GoodsProductList", GoodsProductList);
		return "success";
	}

	/**
	 * @return the sc
	 */
	public ShopCar getSc() {
		return sc;
	}

	/**
	 * @param sc the sc to set
	 */
	public void setSc(ShopCar sc) {
		this.sc = sc;
	}

	/**
	 * @return the user
	 */
	public GoodsUser getUser() {
		return user;
	}

	/**
	 * @param user the user to set
	 */
	public void setUser(GoodsUser user) {
		this.user = user;
	}
}
