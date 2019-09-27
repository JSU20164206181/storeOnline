/**
 * 
 */
package com.qst.action;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;

import com.qst.dao.GoodsDao;
import com.qst.dao.OrderDao;
import com.qst.dao.OrderItemDao;
import com.qst.dao.ReceiveAddressDao;
import com.qst.dao.ShopCarDao;
import com.qst.dao.UserDao;
import com.qst.pojo.GoodsOrder;
import com.qst.pojo.GoodsOrderitem;
import com.qst.pojo.GoodsProduct;
import com.qst.pojo.ReceiveAddress;
import com.qst.pojo.ShopCar;
import com.sun.org.apache.regexp.internal.recompile;

/**
 * @ClassName: OrderAction.java
 * @version: v1.0.0
 * @author: ZYL
 * @date: 2019年8月13日 上午9:10:21
 * @Description: 该类的功能描述
 */
@Transactional
@Controller("orderAction")
public class OrderAction {
	@Autowired
	private OrderDao od;
	@Autowired
	private OrderItemDao oid;
	@Autowired
	private GoodsDao gd;
	@Autowired
	private ReceiveAddressDao rad;
	@Autowired
	private ShopCarDao scd;
	@Autowired
	private UserDao ud;

	private String OcList;
	private double totalPrice;
	private String sId;

	private int page = 1;
	private int pageSize = 5;
	private int totalPage;
	private int status;
	private int userId;

	/**
	 * 提交订单：跳转到支付宝支付总计，并根据不同的卖家生成多个订单，计算每个订单商品的总价
	 * 
	 * @return
	 */
	public String submitOrder() {
		HttpServletRequest request = ServletActionContext.getRequest();
		int userId = Integer.parseInt(request.getParameter("userId"));// 买家ID（用户的userId）
		int graId = Integer.parseInt(request.getParameter("graId"));// 收货地址的graId
		String scid = request.getParameter("scidList");
		String[] scidList = scid.split(",");// 购物车的id
		String gid = request.getParameter("gidList");
		String[] gidList = gid.split(",");// 商品的gpId
		sId = request.getParameter("sid");
		String[] sIdList = sId.split(",");// 卖家ID（商品的gpUid）
		String note = request.getParameter("notes");
		String[] notesList = note.split(",");// 订单商品的备注
		totalPrice = Double.valueOf(request.getParameter("totalPrice"));// 订单商品的总计

		System.out.println(userId + "~" + graId + "~" + gidList + "~" + sIdList + "~" + notesList + "~" + totalPrice);

		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
		List list = Arrays.asList(sIdList);
		Set set = new HashSet(list);
		String[] sidList = (String[]) set.toArray(new String[0]);// 卖家ID（去重）
		List<GoodsProduct> gpList = new ArrayList<>();// 商品List
		List<ShopCar> spList = new ArrayList<>();// 购物车List
		for (int i = 0; i < gidList.length; i++) {
			gpList.add(gd.findOneById(Integer.parseInt(gidList[i])));
			spList.add(scd.findById(Integer.parseInt(scidList[i])));
		}
		List<String> orderCodeList = new ArrayList<>();// 订单号List（未去重）
		List<GoodsOrderitem> goiList = new ArrayList<>();// 本次交易生成的订单商品List
		List<GoodsOrder> goList = new ArrayList<>();// 本次交易生成的订单List
		/* 写入订单表和订单商品表 */
		for (int i = 0; i < sidList.length; i++) {
			for (int j = 0; j < gpList.size(); j++) {
				if (Integer.parseInt(sidList[i]) == gpList.get(j).getGpUid()) {// 判断是否是同一卖家
					String orderCode;
					orderCode = sdf.format(date) + sidList[i] + userId + graId;// 生成订单号
					orderCodeList.add(orderCode);
					System.out.println("orderCode---" + orderCode);
					ReceiveAddress ra = rad.findRaById(graId);// 查询收货地址
					/* 写入订单表 */
					GoodsOrder go = new GoodsOrder();
					go.setGoOrderCode(orderCode);
					go.setGoAddress(ra.getGraProvince() + ra.getGraCity() + ra.getGraDistrict() + ra.getGraStreet());
					go.setGoReceiver(ra.getGraName());
					go.setGoPhone(ra.getGraPhone());
					go.setGoTotalPrice(0);
					go.setGoCreateDate(date);
					go.setGoUid(userId);
					go.setGoStatus(1);
					go.setGoSid(Integer.parseInt(sidList[i]));
					go.setGoSname(ud.findUserById(Integer.parseInt(sidList[i])).getGuName());
					System.out.println("go~~~~" + go);
					if (od.findStatusByOrderCode(orderCode) == false) {// 订单号已存在时不写入订单表
						System.out.println("订单表写入成功！");
						goList.add(go);// 将订单加入到订单List
						od.addOrder(go);// 写入订单表
					}
					/* 写入订单商品表 */
					GoodsOrderitem goi = new GoodsOrderitem();
					goi.setGoiPid(gpList.get(j).getGpId());
					goi.setGoiOid(od.findOrderByOrderCode(orderCode).getGoId());
					goi.setGoiUid(userId);
					goi.setGoiNumber(spList.get(j).getGoodsNum());
					goi.setGoiStatus(1);
					if (notesList.length != 0) {
						if (notesList.length >= j + 1)
							goi.setGoiNote(notesList[j]);
					}
					goi.setGoiSid(gpList.get(j).getGpUid());
					goi.setGoiPname(gpList.get(j).getGpName());
					goi.setGoiOrderCode(orderCode);
					goi.setGoiPrice(gd.findOneById(gpList.get(j).getGpId()).getGpPromotePrice());
					goiList.add(goi);// 将订单商品加入到订单商品List
					System.out.println("goi---" + goi);
					oid.addOderItem(goi);// 写入订单商品表
				}
			}
		}

		List<Double> totalPriceList = new ArrayList<>();
		Set set1 = new HashSet(orderCodeList);
		String[] ocList = (String[]) set1.toArray(new String[0]);// 本次交易生成的订单号List（去重）
		OcList = String.join(",", ocList);// 字符数组转字符串
		/* 根据订单号生成订单总价List */
		for (int i = 0; i < ocList.length; i++) {
			totalPriceList.add(0.00);
		}
		Double[] tpList = totalPriceList.toArray(new Double[totalPriceList.size()]);// 订单总价List
		/* 计算每个订单的总价 */
		for (int i = 0; i < goList.size(); i++) {
			for (int j = 0; j < goiList.size(); j++) {
				if (goList.get(i).getGoOrderCode().equals(goiList.get(j).getGoiOrderCode())) {// 判断订单表和订单商品表的订单号是否相同
					tpList[i] += goiList.get(j).getGoiPrice() * goiList.get(j).getGoiNumber();// 相同则累加价格得到订单总价格
				}
			}
		}
		/* 将每个订单的总价写入数据库表 */
		for (int i = 0; i < tpList.length; i++) {
			goList.get(i).setGoTotalPrice(tpList[i]);
		}
		
		/* 清空购物车 */
		for (int i = 0; i < scidList.length; i++) {
			scd.deleteById(Integer.parseInt(scidList[i]));
		}


		System.out.println("~~~~~~~~~~~~~~~~" + OcList + "~" + totalPrice + "~" + sId);

		return "success";
	}

	public String searchAllOrder() {
		HttpServletRequest request = ServletActionContext.getRequest();
		userId = Integer.parseInt(request.getParameter("userId"));
		totalPage = od.totalPages(userId, pageSize);
		List<GoodsOrder> goList = new ArrayList<>();
		List<GoodsOrderitem> goiList = new ArrayList<>();
		List<GoodsProduct> GoodsProductList = gd.findNewProducts();
		if (page > totalPage) {
			page = totalPage;
		} else if (page < 1) {
			page = 1;
		}
		goList.addAll(od.findOrderByUserId(userId, page, pageSize));
		for (int i = 0; i < goList.size(); i++) {
			System.out.println("~~~~~~~~~~~~" + goList.get(i).getGoId());
			goiList.addAll(oid.findGoiByOrderCode(goList.get(i).getGoOrderCode()));
		}
		for (int i = 0; i < goiList.size(); i++) {
			System.out.println("------------" + goiList.get(i).getGoiId());
		}
		request.setAttribute("GoodsProductList", GoodsProductList);
		request.setAttribute("goiList", goiList);
		request.setAttribute("goList", goList);
		return "success";
	}

	public String searchOrderByStatus() {
		HttpServletRequest request = ServletActionContext.getRequest();
		int userId = Integer.parseInt(request.getParameter("userId"));
		totalPage = od.totalPages(userId, pageSize);
		List<GoodsOrder> goList = new ArrayList<>();
		List<GoodsOrderitem> goiList = new ArrayList<>();
		List<GoodsProduct> GoodsProductList = gd.findNewProducts();
		if (page > totalPage) {
			page = totalPage;
		} else if (page < 1) {
			page = 1;
		}
		goiList.addAll(oid.findOrderByStatus(userId, status, page, pageSize));
		List<String> goIdList = new ArrayList<>();
		for (int i = 0; i < goiList.size(); i++) {
			System.out.println("~~~~~~~~~~~~" + goiList.get(i).getGoiId());
			goIdList.add(goiList.get(i).getGoiOid().toString());
		}
		Set set = new HashSet(goIdList);
		String[] goIDList = (String[]) set.toArray(new String[0]);
		for (int i = 0; i < goIDList.length; i++) {
			goList.add(od.findOrderById(Integer.parseInt(goIDList[i])));
			System.out.println("------------" + goList.get(i).getGoId());
		}

		request.setAttribute("GoodsProductList", GoodsProductList);
		request.setAttribute("goiList", goiList);
		request.setAttribute("goList", goList);
		return "success" + status;
	}

	public String deleteOrder() {
		HttpServletRequest request = ServletActionContext.getRequest();
		int goid = Integer.parseInt(request.getParameter("goid"));
		GoodsOrder go = new GoodsOrder();
		go = od.findOrderById(goid);
		go.setGoStatus(4);
		List<GoodsOrderitem> goiList = new ArrayList<>();
		goiList.addAll(oid.findOrderItemByOid(goid));
		GoodsOrderitem goi = new GoodsOrderitem();
		for (int i = 0; i < goiList.size(); i++) {
			goiList.get(i).setGoiStatus(6);
		}
		return "success" + status;
	}

	public String showOrderInfo() {
		
		return "success";
	}
	
	/**
	 * @return the gd
	 */
	public GoodsDao getGd() {
		return gd;
	}

	/**
	 * @param gd the gd to set
	 */
	public void setGd(GoodsDao gd) {
		this.gd = gd;
	}

	/**
	 * @return the totalPrice
	 */
	public double getTotalPrice() {
		return totalPrice;
	}

	/**
	 * @param totalPrice the totalPrice to set
	 */
	public void setTotalPrice(double totalPrice) {
		this.totalPrice = totalPrice;
	}

	/**
	 * @return the sId
	 */
	public String getsId() {
		return sId;
	}

	/**
	 * @param sId the sId to set
	 */
	public void setsId(String sId) {
		this.sId = sId;
	}

	/**
	 * @return the ocList
	 */
	public String getOcList() {
		return OcList;
	}

	/**
	 * @param ocList the ocList to set
	 */
	public void setOcList(String ocList) {
		OcList = ocList;
	}

	/**
	 * @return the page
	 */
	public int getPage() {
		return page;
	}

	/**
	 * @param page the page to set
	 */
	public void setPage(int page) {
		this.page = page;
	}

	/**
	 * @return the pageSize
	 */
	public int getPageSize() {
		return pageSize;
	}

	/**
	 * @param pageSize the pageSize to set
	 */
	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	/**
	 * @return the totalPage
	 */
	public int getTotalPage() {
		return totalPage;
	}

	/**
	 * @param totalPage the totalPage to set
	 */
	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}

	/**
	 * @return the status
	 */
	public int getStatus() {
		return status;
	}

	/**
	 * @param status the status to set
	 */
	public void setStatus(int status) {
		this.status = status;
	}

	/**
	 * @return the userId
	 */
	public int getUserId() {
		return userId;
	}

	/**
	 * @param userId the userId to set
	 */
	public void setUserId(int userId) {
		this.userId = userId;
	}

}
