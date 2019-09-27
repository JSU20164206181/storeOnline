
package com.qst.action;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.hibernate.criterion.Order;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;
import com.opensymphony.xwork2.util.ValueStack;
import com.qst.dao.UserInterface;
import com.qst.pojo.GoodsOrder;
import com.qst.pojo.GoodsProduct;
import com.qst.pojo.GoodsUser;
import com.qst.pojo.ReceiveAddress;




/**
 * @ClassName: UserAction.java
 * @version: v1.0.0
 * @author: 隆森
 * @date: 2019年8月5日 下午5:04:27
 * @Description: 该类的功能描述
 */
@Transactional
@Controller
public class UserAction extends ActionSupport implements ModelDriven<GoodsUser>, ServletRequestAware, FinalConst {

	private static final long serialVersionUID = 1L;
	// UserDao的接口实现类
	@Resource(name = "userdao")
	private UserInterface userDao;
	// 封装用户在jsp上面显示
	private GoodsUser user = new GoodsUser();

	// 收货地址的对象
	private ReceiveAddress receiveAddress;
	// request
	private HttpServletRequest request;
    //user的list集合
	private List<GoodsUser> ulist;
	//订单表
	private List<GoodsOrder> myOrder;

	public List<GoodsOrder> getMyOrder() {
		return myOrder;
	}


	public void setMyOrder(List<GoodsOrder> myOrder) {
		this.myOrder = myOrder;
	}


	// 商品总页数
	private int totalPage;

	// 商品列表的当前页数
	private int page = 1;

	// 每页显示的数据
	private int pageSize = 2;

	// ajax判断用户是否已经存在
	public void judgeUser() throws IOException {

		HttpServletResponse ron = ServletActionContext.getResponse();
		ron.setContentType("text/html;charset=UTF-8");

		String uname = request.getParameter("uname");
		System.out.println("uname" + uname);

		if (uname.equals(userDao.findUser(uname))) {
			// 根据用户名去判断是否存在
			ron.getWriter().write("用户已经存在");
		}
	}

	
	// 注册添加一个新用户
	public String addUser() throws IOException {

		// 初始化状态为1 1代表可以用
		user.setGuStatus(1);
		userDao.addUser(user);
		return LOGIN;

	}

	// 实现登录
	public String login() {
        System.out.println(1133);
		HttpSession session = request.getSession();
		HttpServletResponse res = ServletActionContext.getResponse();
		GoodsUser user = new GoodsUser();
		// 先进行验证码的判断
		if (request.getParameter("code").equals(session.getAttribute("code"))) {

			String name = request.getParameter("name");
			String password = request.getParameter("loginPassword");
			user = userDao.findUserId(name, password);
			System.out.println(user);
			//user为null表示数据库里面没有对应的账号
			if(user==null){
			   session.setAttribute(LOGIN_ERROR, "账号密码错误");
			   return LOGIN;
			}
			// 下面if是进行用户状态 和密码的判断 0禁用 1可用 2删除
			if (user.getGuStatus()==0) {
				System.out.println(1111);
				session.setAttribute(LOGIN_ERROR, "您已经被禁用,请联系管理员");
				return LOGIN;
			}else if(user.getGuStatus()==2){
				session.setAttribute(LOGIN_ERROR, "该账号已被注销");
				return LOGIN;
			}else{
				if(!user.getGuPassword().equals(password)){
					session.setAttribute(LOGIN_ERROR, "账号密码错误");
					return LOGIN;
				}
			}
			Cookie cookie = new Cookie(CLIENT_USER_ID, user.getGuId() + "");
			res.addCookie(cookie);
			session.setAttribute(SESSION_USER_NAME, user.getGuName());

		} else {
			session.setAttribute(LOGIN_ERROR, "验证码错误");
			System.out.println(22222);
			return LOGIN;
		}

		return "index";
	}

	// 用户个人信息展示
	public String showUser() throws IOException {
		  
		HttpSession session = request.getSession();
		System.out.println(session.getId());
		 System.out.println(session.getAttribute("userName"));
		if(session.getAttribute("userName")==null){
			return LOGIN;
		}else{
			GoodsUser guser = new GoodsUser();
			String name =(String)session.getAttribute("userName");
			guser = userDao.findUserByName(name);
			if(guser==null){
				return LOGIN;
			}
			// 查询用户的所有个人信息
			user = userDao.findUserMsg(guser.getGuId());
			System.out.println("***guser***" + guser);
			if (user == null) {
				return "show";
			}
			// 找用户的收货地址
			List<ReceiveAddress> list = userDao.findReceiveById(guser.getGuId());
			ValueStack vs = ActionContext.getContext().getValueStack();
			vs.set("user", user);
			request.setAttribute("listAddress", list);
			// 商品总页数totalPage
			totalPage = userDao.totalPageByUserId(guser.getGuId(), pageSize);
			List<GoodsProduct> goodList = new ArrayList<>();
			// 找用户自己的商品
			if (page < 1) {
				page = 1;
			} else if (page > totalPage) {
				page = totalPage;
			}
			System.out.println("当前页数"+page);
			System.out.println("总页数"+totalPage);
			// 判断有没有进行模糊查询商品
			
			
				// 按商品的状态查询商品
				goodList = userDao.findByUserId(guser.getGuId(), page, pageSize);
				System.out.println("goodList"+goodList.size());
			

			request.setAttribute("next", request.getParameter("next"));
		
			request.setAttribute("goodList", goodList);
			
			myOrder = userDao.findOrderByid(guser.getGuId());
			request.setAttribute("myOrder", myOrder);
			
			return "show";
		}
		
	}

	// 退出登录
	public String logout() {
		HttpSession session = request.getSession();
		Cookie[] cookie = request.getCookies();
		for (Cookie co : cookie) {
			if (co.getName().equals("userId")) {
				co.setMaxAge(0);
				HttpServletResponse res = ServletActionContext.getResponse();
				res.addCookie(co);
			}

		}
		session.invalidate();
		/*session.removeAttribute("userName");
		session.removeAttribute("error");*/
		return LOGIN;
	}

	// 修改个人信息
	public String updateUser() {
		System.out.println(11);
		System.out.println(user);
		userDao.updateUser(user);
		ValueStack vs = ActionContext.getContext().getValueStack();
		vs.set("user", user);
		return "showUser";
	}

	// 新增或者修改收货地址
	public String addAddress() {
		System.out.println("$$$$$$$" + receiveAddress);
		String index = request.getParameter("index");
		if (index.equals("")) {
			receiveAddress.setGraId(0);
		}
		// 如果index不是空的话 说明是要进行修改操作
		if (!index.equals("")) {
			System.out.println(11111);
			List<ReceiveAddress> list = new ArrayList<ReceiveAddress>();
			// 先查询该用户有多少条收货地址 index对应的就是修改的第几条
			list = userDao.findReceiveById(receiveAddress.getGraUid());
			// 找到该条记录的id
			int graId = list.get(Integer.parseInt(index)).getGraId();
			// 查询到该条收货记录的id 放到对象里面
			receiveAddress.setGraId(graId);
		}
		System.out.println(222222);
		userDao.SaveorUpdateReceiveAddress(receiveAddress);
		return "showUser";
	}

	// 删除收货地址
	public void deleteShopAddress() throws IOException {
		receiveAddress = new ReceiveAddress();
		HttpServletResponse res = ServletActionContext.getResponse();
		int id = 0;
		// 要删除用户的第几个收货地址
		int index = 0;
		res.setContentType("text/html;charset=UTF-8");
		Cookie[] cookie = request.getCookies();
		for (Cookie co : cookie) {
			if (co.getName().equals("userId")) {
				String uid = co.getValue();
				id = Integer.parseInt(uid);
			}

		}
		index = Integer.parseInt(request.getParameter("index"));
		List<ReceiveAddress> list = userDao.findReceiveById(id);
		receiveAddress.setGraId(list.get(index).getGraId());
		userDao.deleteReceiceAddress(receiveAddress);
		res.getWriter().write("删除成功");
	}

	// 删除自己的商品
	public void deleteMyGoods() throws IOException {

		System.out.println(request.getParameter("productId"));
		int pid;
		if (request.getParameter("productId") != null) {
			pid = Integer.parseInt(request.getParameter("productId"));
			userDao.deleteGoods(pid);
			HttpServletResponse res = ServletActionContext.getResponse();
			res.setContentType("text/html;charset=UTF-8");
			res.getWriter().write("删除成功");
		}

	}

	// 下架自己的商品 将状态改为0
	public void changeStatus() throws IOException {

		System.out.println(request.getParameter("*****" + "productId"));
		int pid;
		if (request.getParameter("productId") != null) {
			pid = Integer.parseInt(request.getParameter("productId"));
			GoodsProduct goods = userDao.findProductById(pid);
			goods.setGpStatus(0);
			System.out.println(goods);
			userDao.updateProduct(goods);
			HttpServletResponse res = ServletActionContext.getResponse();
			res.setContentType("text/html;charset=UTF-8");
			res.getWriter().write("下架成功");
		}

	}
	
	public void cityShow() throws IOException{
		HttpServletResponse res = ServletActionContext.getResponse();
		res.setContentType("text/html;charset=UTF-8");
		ulist = userDao.cityShow();
		
		JSONArray json = new JSONArray();
		for(GoodsUser go:ulist){
			JSONObject jo = new JSONObject();
			jo.put("city",go.getGuAddress());
			json.put(jo);
		}
		System.out.println(json.toString());
		res.getWriter().print(json.toString());
		
	}
	
	

	public void setUserDao(UserInterface userDao) {
		this.userDao = userDao;
	}

	@Override
	public GoodsUser getModel() {

		return user;
	}

	@Override
	public void setServletRequest(HttpServletRequest request) {
		this.request = request;

	}

	public GoodsUser getUser() {
		return user;
	}

	public void setUser(GoodsUser user) {
		this.user = user;
	}

	public HttpServletRequest getRequest() {
		return request;
	}

	public void setRequest(HttpServletRequest request) {
		this.request = request;
	}

	public ReceiveAddress getReceiveAddress() {
		return receiveAddress;
	}

	public void setReceiveAddress(ReceiveAddress receiveAddress) {
		this.receiveAddress = receiveAddress;
	}

	public int getTotalPage() {
		return totalPage;
	}

	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}

	public int getPage() {
		return page;
	}

	public void setPage(int page) {
		this.page = page;
	}

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}
	public List<GoodsUser> getUlist() {
		return ulist;
	}


	public void setUlist(List<GoodsUser> ulist) {
		this.ulist = ulist;
	}
}
