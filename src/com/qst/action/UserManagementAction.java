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

import com.qst.dao.OrderDao;
import com.qst.dao.UserDao;
import com.qst.pojo.GoodsOrder;
import com.qst.pojo.GoodsUser;
import com.qst.tools.ExportExcel;
import com.qst.tools.SendMail;

/**
 * @ClassName: UserManagementAction.java
 * @version: v1.0.0
 * @author: hdq
 * @date: 2019年8月8日 下午2:22:43
 * @Description:
 */
@Transactional
@Controller("userManagementAction")
public class UserManagementAction extends BaseSession implements FinalConst {
	@Autowired
	/**用户Dao*/
	private UserDao userDao;
	@Autowired
	/** 订单Dao*/
	private OrderDao orderDao;
	/**单个用户 */
	private GoodsUser user;
	/** 用户列表 */
	private List<GoodsUser> userList;
	/** 用户列表选项 1全部列表2模糊查询列表 */
	private int listChose=1;
	/** 查询的关键字 */
	private String findKey;
	/** 页面数据量 */
	private int pageSize = 10;
	/** 总页数 */
	private int allPage;
	/** 当前页数 */
	private int nowPage = 1;
	/** 数据条数 */
	private int allNumber;
	/** 用户id列表 */
	private String usersId;
	/** 用户id */
	private String userId;
	/** 导出选项 onePage当前页 allPage全部 */
	private String importChose = "0";
	/** 所在地 */
	private String[] city;
	/** 详细地址 */
	private String userAdress;
	/** 收货地址 */
	private List<String[]> shopAddress;
	/** 性别统计 */
	private Map<String, Integer> sexCount;
	/** 年龄统计 */
	private Map<String, Integer> ageCount;
	/** 消费记录 */
	private Map<String, Double> costCount;
	

	/**
	 * 获取用户列表
	 * 
	 * @return
	 */
	public String userList() {
		if(listChose==1){
			System.out.println("+++用户列表++");
		allPage = userDao.totalPages(pageSize);
		if ((nowPage) > allPage) {
			nowPage = allPage;
		}
		if (nowPage < 1) {
			nowPage = 1;
		}

		userList = userDao.findPages(nowPage, pageSize);
		allNumber = userDao.userNumber();
		}
		else if(listChose==2){
			System.out.println("+++模糊查找++");
			allPage = userDao.fuzzyPageNumber(findKey, pageSize);
			if ((nowPage) > allPage) {
				nowPage = allPage;
			}
			if (nowPage < 1) {
				nowPage = 1;
			}

			userList = userDao.fuzzyFindUser(findKey,nowPage, pageSize);
			allNumber = userDao.fuzzyAllNumber(findKey);
			}

		return "success";
	}
     
	/**
	 * 用户消费显示
	 * 
	 * @return
	 */
	public String userCostCount() {
        
         user=userDao.findUserById(Integer.parseInt(userId));
         costCount=orderDao.findUserCostByMonth(Integer.parseInt(userId)); 
         System.out.println("++++消费数据+++"+user.getGuName());  
        
           
		return "success";
	}

	/**
	 * 用户男女比例显示
	 * 
	 * @return
	 */
	public String userShowSexCount() {

		sexCount = userDao.userSexCount();

		System.out.println("性别统计:" + sexCount.keySet() + sexCount.get("女") + sexCount.get("男") + sexCount.get("all"));
		return "success";
	}

	/**
	 * 用户年龄分布显示
	 * 
	 * @return
	 */
	public String userShowAgeCount() {
		ageCount = userDao.userAgeCount();
		System.out.println("年龄统计:" + ageCount.keySet());
		return "success";
	}
	/**
	 * 跳转增加用户 
	 * 
	 * @return
	 */
	public String toAddUser() {
		return "success";
	}
	/**
	 * 增加用户
	 * 
	 * @return
	 */
	public String addUser() {
		//
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setCharacterEncoding("utf-8");
		// 拼接地址
		String aalAdress = "";
		for (int i = 0; i < city.length; i++) {
			if (city[i] != "请选择") {
				if (i == 2) {
					aalAdress = aalAdress + city[i];
				} else
					aalAdress = aalAdress + city[i] + "-";
			}
		}
		if (userAdress != "" && userAdress != null) {
			aalAdress = aalAdress + "-" + userAdress;
		}
		user.setGuAddress(aalAdress);
		user.setGuStatus(1);
		try {
			userDao.addUser(user);
			System.out.println("+++添加用户+++++" + user);
			response.getWriter().print("Sucess");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return null;
	}

	/**
	 * 修改用户信息
	 * 
	 * @return
	 */
	public String updataUser() {
		//
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setCharacterEncoding("utf-8");
		// 拼接地址
		String aalAdress = "";
		for (int i = 0; i < city.length; i++) {
			if (city[i] != "请选择") {
				if (i == 2) {
					aalAdress = aalAdress + city[i];
				} else
					aalAdress = aalAdress + city[i] + "-";
			}
		}
		if (userAdress != "" && userAdress != null) {
			aalAdress = aalAdress + "-" + userAdress;
		}
		user.setGuAddress(aalAdress);
		try {
			userDao.updateUser(user);
			System.out.println("+++ 更新+++++" + user);
			response.getWriter().print("Sucess");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return null;
	}

	/**
	 * 用户详情
	 * 
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public String showUser() {
		//
		shopAddress = new ArrayList();
		user = userDao.findUserById(user.getGuId());
		System.out.println(user);
		/*
		 * if(user.getGuShopAddress()!=null){ String
		 * data=user.getGuShopAddress();//全部地址 String[]
		 * data2=data.split(",");//一个地址 String[] data3;//地址 的多个信息 for(int
		 * i=0;i<data2.length;i++){ data3=data2[i].split("-");
		 * shopAddress.add(data3); }}
		 */
		String[] udr = user.getGuAddress().split("-");
		city = udr;

		// userAdress=udr[3];

		return "success";
	}

	/**
	 * 批量删除用户
	 * 
	 * @return
	 */
	public String deleteUsers() {
		//
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setCharacterEncoding("utf-8");
		String[] ID = usersId.split(",");

		try {
			for (int i = 0; i < ID.length; i++) {// 状态改为删除状态
				GoodsUser u = userDao.findUserById(Integer.parseInt(ID[i]));
				u.setGuStatus(2);
				userDao.updateUser(u);
			}
			response.getWriter().print("delSucess");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return null;
	}

	/**
	 * 用户停用与禁用
	 * 
	 * @return
	 */
	public String stopUser() {
		//
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setCharacterEncoding("utf-8");
		GoodsUser u = userDao.findUserById(Integer.parseInt(userId));
		if (u.getGuStatus() == 1) {
			u.setGuStatus(0);
			System.out.println("停用" + userId);

		} else if (u.getGuStatus() == 0) {
			u.setGuStatus(1);
			System.out.println("1启用" + userId);

		}

		try {
			userDao.updateUser(u);
			response.getWriter().print("ssSucess");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return null;
	}

	/**
	 * 重置密码
	 * 
	 * @return
	 */
	public String rePassword() {
		//
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setCharacterEncoding("utf-8");
		GoodsUser u = userDao.findUserById(Integer.parseInt(userId));
		try {
			if (u.getGuEmail() != null) {
				u.setGuPassword(SendMail.RandomPws()); // 生成密码
				userDao.updateUser(u);
				SendMail.sendMails(u.getGuEmail(), u.getGuName(), u.getGuPassword()); // 发送邮件
			}
			response.getWriter().print("Sucess");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return null;
	}

	/**
	 * 导出用户
	 * 
	 * @return
	 */
	public String importUsers() {
		//
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setCharacterEncoding("utf-8");
		System.out.println("导出选项：" + importChose);

		GoodsUser user;
		List<GoodsUser> list2;
		if (importChose.equals("allPage")) {
			list2 = userDao.findAllUser();
		} else {
			list2 = userList;
		}
		String title = "User";
		String[] rowsName = new String[] { "序号", "id", "名称", "密码", "状态", "性别", "年龄", "电话", "地址" };
		// 把导出数据存入Sting数组
		List<Object[]> dataList = new ArrayList<Object[]>();
		Object[] objs = null;
		for (int i = 0; i < list2.size(); i++) {
			user = new GoodsUser();
			user = list2.get(i);
			objs = new Object[rowsName.length];
			objs[0] = i;
			objs[1] = user.getGuId();
			objs[2] = user.getGuName();
			objs[3] = user.getGuPassword();
			if (user.getGuStatus() == 0) {
				objs[4] = "已停用";
			} else if (user.getGuStatus() == 1) {
				objs[4] = "正常";
			} else {
				objs[4] = "已删除";
			}
			objs[5] = user.getGuSex();
			objs[6] = user.getGuAge();
			objs[7] = user.getGuName();
			objs[8] = user.getGuAddress();
			//System.out.println("++"+i);  
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
	 * Get Set 方法
	 * 
	 * @return
	 */
	public GoodsUser getUser() {
		return user;
	}

	public void setUser(GoodsUser user) {
		this.user = user;
	}

	public List<GoodsUser> getUserList() {
		return userList;
	}

	public void setUserList(List<GoodsUser> userList) {
		this.userList = userList;
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

	public String getUsersId() {
		return usersId;
	}

	public void setUsersId(String usersId) {
		this.usersId = usersId;
	}

	public String getImportChose() {
		return importChose;
	}

	public void setImportChose(String importChose) {
		this.importChose = importChose;
	}

	public String[] getCity() {
		return city;
	}

	public void setCity(String[] city) {
		this.city = city;
	}

	public String getUserAdress() {
		return userAdress;
	}

	public void setUserAdress(String userAdress) {
		this.userAdress = userAdress;
	}

	public List<String[]> getShopAddress() {
		return shopAddress;
	}

	public void setShopAddress(List<String[]> shopAddress) {
		this.shopAddress = shopAddress;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public Map<String, Integer> getSexCount() {
		return sexCount;
	}

	public void setSexCount(Map<String, Integer> sexCount) {
		this.sexCount = sexCount;
	}

	public Map<String, Integer> getAgeCount() {
		return ageCount;
	}

	public void setAgeCount(Map<String, Integer> ageCount) {
		this.ageCount = ageCount;
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

	public Map<String, Double> getCostCount() {
		return costCount;
	}

	public void setCostCount(Map<String, Double> costCount) {
		this.costCount = costCount;
	}

	

	
	

	
	

}