package com.qst.action;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;

import com.opensymphony.xwork2.ActionContext;
import com.qst.dao.AdminDao;
import com.qst.pojo.GoodsAdmin;
import com.qst.pojo.GoodsUser;
import com.qst.tools.ExportExcel;
/**
 * @ClassName: UserManagementAction.java
 * @version: v1.0.0
 * @author: hdq
 * @date: 2019年8月8日 下午2:22:43
 * @Description:
 */
@Transactional
@Controller("adminManagementAction")
public class AdminManagementAction extends BaseSession implements FinalConst {
	@Autowired
	private AdminDao adminDao;
	private GoodsAdmin admin;
	private List<GoodsAdmin> adminList;
	/** 页面数据量 */
	private int pageSize = 10;
	/** 总页数 */
	private int allPage;
	/** 当前页数 */
	private int nowPage = 1;
	/** 数据条数 */
	private int allNumber;
	/** 管理员id列表 */
	private String adminsId;
	/** 管理员id */
	private String adminId;
	/** 管理员名字*/
	private String adminName;
	/** 导出选项 onePage当前页 allPage全部 */
	private String importChose= "0";
	/**
	 * 获取管理员列表
	 * 
	 * @return
	 */
	public String adminList() {
		Map<String,Object> session = ActionContext.getContext().getSession();
		adminName=(String) session.get(SESSION_ADMIN_NAME); 	 
		if(adminName!=null){
			 admin=adminDao.findByName(adminName); 
		}
         int srank=admin.getGaRank();
         if(srank==1){
        	 return "false";
         }
         else{
		// 获取总页数 
		allPage = adminDao.totalPages(pageSize);
		if ((nowPage) > allPage) {
			nowPage = allPage;
		}
		if (nowPage < 1) {
			nowPage = 1;
		}
		adminList = adminDao.findPages(nowPage, pageSize);
		allNumber = adminDao.adminNumber();

		return "success";
		}
	}
	/**
	 * 管理员账号验证
	 * @return
	 */
	public String adminCheckName() { 
		//
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setCharacterEncoding("utf-8");
		System.out.println("+++ 验证Admin+++++" + admin.getGaName());	
		try {
			if(adminDao.findByName(admin.getGaName())==null){
				response.getWriter().print("success"); 
			}
			else {
				response.getWriter().print("hava");
			}					
		} catch (IOException e) {			
			e.printStackTrace();
		}        
		return null;
	}
	/**
	 * 添加管理员
	 * 
	 * @return
	 */
	public String addAdmin() {
		//
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setCharacterEncoding("utf-8");
		
		admin.setGaStatus(1); 	
		try {
			adminDao.addAdmin(admin);
			System.out.println("+++添加管理员+++++" + admin);
			response.getWriter().print("Sucess");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
         
		return null;
	}
	/**
	 * 管理员个人信息  
	 * @return
	 */
	public String showAdminInformation() { 	
			Map<String,Object> session = ActionContext.getContext().getSession();
			adminName=(String) session.get(SESSION_ADMIN_NAME); 		
		    admin=adminDao.findByName(adminName); 
		return "success";
	}
	/**
	 * 跳转修改管理员密码  
	 * @return
	 */
	public String changeAdminPassword() { 
		if(adminId.equals("loginAdmin")){
			  Map<String,Object> session = ActionContext.getContext().getSession();
			  adminName=(String) session.get(SESSION_ADMIN_NAME); 		
		    admin=adminDao.findByName(adminName); 
		    System.out.println("+++ 服务器Admin+++++" +adminName);   
		    return "success";
		}
		else{
			System.out.println("+++ 获取Admin+++++" + adminId);  
			admin=adminDao.findAdminById(Integer.parseInt(adminId)); 
			return "success2";
		}
			  
		
	}
	/**
	 * 修改管理员信息
	 * 
	 * @return
	 */
	public String updataAdmin() { 
		//
		 Map<String,Object> session = ActionContext.getContext().getSession();
		  adminName=(String) session.get(SESSION_ADMIN_NAME); 		
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setCharacterEncoding("utf-8");
		  	
		try {
			adminDao.updateAdmin(admin);
			if(adminName.equals(admin.getGaName())&&adminName!=null){			
				System.out.println("+++ 更新1Admin+++++" + admin);  
			    response.getWriter().print("sucess1");
			}else{	
			System.out.println("+++ 更新2Admin+++++" + admin);
			response.getWriter().print("sucess2");
			}
			
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return null;
	}
	
	/**
	 * 批量删除管理员
	 * 
	 * @return
	 */
	public String deleteAdmins() {
		//
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setCharacterEncoding("utf-8");
		String[] ID = adminsId.split(",");
		try {
			for (int i = 0; i < ID.length; i++) {// 状态改为删除状态
				GoodsAdmin u = adminDao.findAdminById(Integer.parseInt(ID[i]));
				u.setGaStatus(2);
				adminDao.updateAdmin(u);
				System.out.println("删除管理员"+u.getGaName());
			}
			response.getWriter().print("delSucess");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return null;
	}
	/**
	 * 管理员停用与禁用
	 * 
	 * @return
	 */
	public String stopAdmin() {
		//
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setCharacterEncoding("utf-8");		
			GoodsAdmin u = adminDao.findAdminById(Integer.parseInt(adminId));
			if(u.getGaStatus()==1){
				u.setGaStatus(0);
				System.out.println("停用Admin"+adminId);
				
			} 
			else if(u.getGaStatus()==0){
				u.setGaStatus(1);	
				System.out.println("1启用Admin"+adminId);
				
			}
			
		try {
			adminDao.updateAdmin(u);
			response.getWriter().print("ssSucess");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return null;
	}
	/**
	 * 管理员提升权限与降低权限
	 * 
	 * @return
	 */
	public String upAndDownAdmin() {
		//
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setCharacterEncoding("utf-8");		
			GoodsAdmin u = adminDao.findAdminById(Integer.parseInt(adminId));
			if(u.getGaRank()==1){
				u.setGaRank(9);
				System.out.println("升级Admin"+adminId+"->"+u.getGaRank());
				
			} 
			else if(u.getGaRank()==9){
				u.setGaRank(1);	
				System.out.println("降低Admin"+adminId+"->"+u.getGaRank());
				
			}
			
		try {
			adminDao.updateAdmin(u);
			response.getWriter().print("ssSucess");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return null;
	}
	/**
	 * 导出管理员
	 * 
	 * @return
	 */
	public String importAdmins() {
		//
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setCharacterEncoding("utf-8");
		System.out.println("导出选项：" + importChose);
		GoodsAdmin admin;
		
		List<GoodsAdmin> list2;
		if (importChose.equals("allPage")) {
			list2 = adminDao.findAllAdmin();
		} else {
			list2 = adminList;
		}
		String title = "Admin";
		String[] rowsName = new String[] { "序号", "id", "名称", "密码", "状态", "权限" };
		// 把导出数据存入Sting数组
		List<Object[]> dataList = new ArrayList<Object[]>();
		Object[] objs = null; 
		for (int i = 0; i < list2.size(); i++) {
			admin = new GoodsAdmin(); 
			admin = list2.get(i);
			objs = new Object[rowsName.length];
			objs[0] = i;
			objs[1] = admin.getGaId(); 
			objs[2] = admin.getGaName();
			objs[3] = admin.getGaPassword();
			if(admin.getGaStatus()==0){
				objs[4]="已停用";
			}
			else if(admin.getGaStatus()==1){
				objs[4]="正常";
			}else{
				objs[4]="已删除";
			}
			if(admin.getGaRank()==1){
				objs[5]="普通管理员";
			}
			else if(admin.getGaRank()==9){
				objs[5]="超级管理员";
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
	 * Get Set 方法
	 * 
	 * @return
	 */
	public GoodsAdmin getAdmin() {
		return admin;
	}

	public void setAdmin(GoodsAdmin admin) {
		this.admin = admin;
	}

	public List<GoodsAdmin> getAdminList() {
		return adminList;
	}

	public void setAdminList(List<GoodsAdmin> adminList) {
		this.adminList = adminList;
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

	public String getAdminsId() {
		return adminsId;
	}

	public void setAdminsId(String adminsId) {
		this.adminsId = adminsId;
	}

	public String getAdminId() {
		return adminId;
	}

	public void setAdminId(String adminId) {
		this.adminId = adminId;
	}

	public String getImportChose() {
		return importChose;
	}

	public void setImportChose(String importChose) {
		this.importChose = importChose;
	}
	public String getAdminName() {
		return adminName;
	}
	public void setAdminName(String adminName) {
		this.adminName = adminName;
	}		
}