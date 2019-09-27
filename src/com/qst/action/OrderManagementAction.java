package com.qst.action;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;

import com.qst.dao.GoodsDao;
import com.qst.dao.OrderDao;
import com.qst.dao.OrderItemDao;
import com.qst.pojo.GoodsOrder;
import com.qst.pojo.GoodsOrderitem;
import com.qst.tools.ExportExcel;

@Transactional
@Controller("orderManagementAction")
public class OrderManagementAction extends BaseSession implements FinalConst {
	@Autowired
	/** 订单Dao*/
	private OrderDao orderDao;	
	@Autowired
	/** 订单商品Dao*/
	private OrderItemDao orderItemDao;	
	@Autowired
	/** 商品Dao*/
	private GoodsDao goodsDao;	
	
	/** 订单商品列表*/
	private List<GoodsOrderitem> orderItemList;
	/**单个 订单*/
	private GoodsOrder order;	
	/**订单列表*/
	private List<GoodsOrder> orderList;
	/** 页面数据量 */
	private int pageSize = 10;
	/** 总页数 */
	private int allPage;
	/** 当前页数 */
	private int nowPage = 1;
	/** 数据条数 */
	private int allNumber;
	/** 订单id */
	private String orderId;
	/** 导出选项  onePage当前页    allPage全部 */
	private String importChose = "0";
	/** 消费记录 */
	private Map<String, Double> costCount;
	/** 用户列表选项 1全部列表2模糊查询列表 */
	private int listChose=1;
	/** 查询的关键字 */
	private String findKey;
	/**查询的类型*/
	private int strChose;

	/**
	 * 总消费统计
	 * @return
	 */
	public String allCostCount() {
        
       
        costCount=orderDao.findUserCostByMonth(-1); 
        System.out.println("++++总消费数据+++");          
		return "success";
	}
	/**
	 * 获取订单列表
	 * 
	 * @return
	 */
	public String orderListManagement() { 
		if(listChose==1){
			System.out.println("+++用户列表++");
		allPage = orderDao.findAllOrderPage(pageSize);
		if ((nowPage) > allPage) {
			nowPage = allPage;
		}
		if (nowPage < 1) {
			nowPage = 1;
		}
		orderList = orderDao.findAllOrderByPage(nowPage, pageSize);
		allNumber = orderDao.findAllOrderNumber();
		}
		else if(listChose==2){
			System.out.println("+++模糊查找++");
			allPage = orderDao.findFuzzyOrderPage(pageSize, strChose, findKey);
			if ((nowPage) > allPage) {
				nowPage = allPage;
			}
			if (nowPage < 1) {
				nowPage = 1;
			}
			orderList = orderDao.findFuzzyOrderByPage(nowPage, pageSize,strChose, findKey);
			allNumber = orderDao.findAllOrderNumber();
			}
		return "success";

	}
	/**
	 * 获取订单详情
	 * 
	 * @return
	 */
	public String manageShowOrder() {
		
		order= orderDao.findOrderById(order.getGoId());
		orderItemList=orderItemDao.findOrderItemByOid(order.getGoId());
		return "success";

	}

	/**
	 * 导出订单
	 * 
	 * @return
	 */
	public String importOrder() {
		//
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setCharacterEncoding("utf-8");
		System.out.println("导出选项：" + importChose);
		GoodsOrder order;
		List<GoodsOrder> orderList2;
		if (importChose.equals("allPage")) {
			orderList2 = orderDao.findAllOrder();
		} else {
			orderList2 = orderList;
		}
		String title = "Order";
		String[] rowsName = new String[] { "序号", "订单Id", "订单号", "收货地址", "收货人", "收货人电话", "订单总价", "创建时间", "付款时间", "收货时间",
				"确认收货时间", "下单用户ID", "状态" };
		// 把导出数据存入Sting数组
		List<Object[]> dataList = new ArrayList<Object[]>();
		Object[] objs = null;
		for (int i = 0; i < orderList2.size(); i++) {
			order = new GoodsOrder();
			order = orderList2.get(i);
			objs = new Object[rowsName.length];
			objs[0] = i;
			objs[1] = order.getGoId();
			objs[2] = order.getGoOrderCode();
			objs[3] = order.getGoAddress();
			objs[4] = order.getGoReceiver();
			objs[5] = order.getGoPhone();
			objs[6] = order.getGoTotalPrice();
			objs[7] = order.getGoCreateDate();
			objs[8] = order.getGoPayDate();
			objs[9] = order.getGoDeliveryDate();
			objs[10] = order.getGoConfirmDate();
			objs[11] = order.getGoUid();
			//订单状态 0取消 1待付款 2发货 3待收货 4待确认收货 5待评论 6已完成 7删除
			if (order.getGoId() == 0) {
				objs[12] = "取消";
			} else if(order.getGoId() == 1) {
				objs[12] = "待付款";
			}  else if(order.getGoId() == 2) {
				objs[12] = "发货";
			} else if(order.getGoId() == 3) {
				objs[12] = "待收货";
			}  else if(order.getGoId() == 4) {
				objs[12] = "待确认收货";
			} else if(order.getGoId() == 5) {
				objs[12] = "待评论";
			}  else if(order.getGoId() == 7) {
				objs[12] = "已完成";
			}   else {
				objs[12] = "删除";
			}   
			dataList.add(objs);
		}
		String fPath = null;
		try {
			try {
				fPath = ExportExcel.export(title, rowsName, dataList);
			} catch (Exception e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			if (fPath != null) {
				response.getWriter().print(fPath);
			}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return null;
	}
		
	/**
	 * 按月分类统计
	 * @return
	 */
/*	public String typeCount() {
		JSONArray json = new JSONArray();	
		Map<String, String> monthList=orderDao.findPayListByMonth(); 
		for(int i=1;i<=12;i++){
			if(monthList.get(i+"月")!=null){ 
				System.out.println(i+"月:"+monthList.get(i+"月")); 
				TypeCount t=new TypeCount();
				t.setMonth(monthList.get(i+"月"));
				String[] orID=monthList.get(i+"月").split(",");
						for(int j=1;j<orID.length;j++){
							List<GoodsOrderitem> orItem=orderItemDao.findOrderItemByOid(6);
							for(int k=0;k<orItem.size();k++){
								int pId=orItem.get(k).getGoiPid();
								int type=goodsDao.findById(pId).getGpCid();  
								Double cost=t.getCostCount();
								cost=cost+orItem.get(k).getGoiPrice()*orItem.get(k).getGoiNumber();
								t.setCostCount(cost);
								t.setType(type+"");														
							}					
						}
						JSONObject jo = new JSONObject();
						jo.put("costCount",t); 
						json.put(jo);
			}
			
		}
		
        System.out.println("++++分类统计数据+++");          
		return "success";
	}
	*/

	/**
	 * get set 方法
	 */

	public GoodsOrder getOrder() {
		return order;
	}

	public void setOrder(GoodsOrder order) {
		this.order = order;
	}

	public List<GoodsOrder> getOrderList() {
		return orderList;
	}

	public void setOrderList(List<GoodsOrder> orderList) {
		this.orderList = orderList;
	}

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	public int getAllPage() {
		return allPage;
	}

	public void setAllPage(int allPage) {
		this.allPage = allPage;
	}

	public int getNowPage() {
		return nowPage;
	}

	public void setNowPage(int nowPage) {
		this.nowPage = nowPage;
	}

	public int getAllNumber() {
		return allNumber;
	}

	public void setAllNumber(int allNumber) {
		this.allNumber = allNumber;
	}

	public String getOrderId() {
		return orderId;
	}

	public void setOrderId(String orderId) {
		this.orderId = orderId;
	}

	public String getImportChose() {
		return importChose;
	}

	public void setImportChose(String importChose) {
		this.importChose = importChose;
	}
	public Map<String, Double> getCostCount() {
		return costCount;
	}
	public void setCostCount(Map<String, Double> costCount) {
		this.costCount = costCount;
	}
	public List<GoodsOrderitem> getOrderItemList() {
		return orderItemList;
	}
	public void setOrderItemList(List<GoodsOrderitem> orderItemList) {
		this.orderItemList = orderItemList;
	}
	public OrderItemDao getOrderItemDao() {
		return orderItemDao;
	}
	public void setOrderItemDao(OrderItemDao orderItemDao) {
		this.orderItemDao = orderItemDao;
	}
	public int getListChose() {
		return listChose;
	}
	public void setListChose(int listChose) {
		this.listChose = listChose;
	}
	public String getFindKey() {
		return findKey;
	}
	public void setFindKey(String findKey) {
		this.findKey = findKey;
	}
	public int getStrChose() {
		return strChose;
	}
	public void setStrChose(int strChose) {
		this.strChose = strChose;
	}
	

}