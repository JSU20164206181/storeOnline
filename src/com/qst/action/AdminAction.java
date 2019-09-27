/**
 * 
 */
package com.qst.action;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;

import com.qst.dao.AdminDao;
import com.qst.pojo.GoodsAdmin;

/**
 * @ClassName:AdminAction.java
 * @version:v1.0.0
 * @author:mwy
 * @date:2019年8月6日 下午3:15:57
 * @Description:管理员的action
 */
@Transactional
@Controller("adminAction")
public class AdminAction extends BaseSession implements FinalConst {
	@Autowired
	private AdminDao adminDao;
	private GoodsAdmin goodsAdmin;

	/**
	 * 管理员登录接口 对应adminLogin.action
	 * 
	 * @return
	 */
	public String adminLogin() {
		
		if (goodsAdmin == null)
			return "error";
		System.out.println(goodsAdmin);

		HttpServletRequest request = ServletActionContext.getRequest();
		String clientCode = request.getParameter(SESSION_LOGIN_VALIDATECODE);
		String sessionCode = (String) session.get(SESSION_LOGIN_VALIDATECODE);
		// System.out.println(sessionCode);
		if (!clientCode.equalsIgnoreCase(sessionCode)) {
			request.setAttribute(LOGIN_ERROR, "验证码错误");
			return "error";
		}
		GoodsAdmin admin1 = adminDao.findByName(goodsAdmin.getGaName());
		if (admin1 == null) {
			request.setAttribute(LOGIN_ERROR, "账号不存在");
			return "error";
		}
		if (admin1.getGaStatus() == 0) {
			request.setAttribute(LOGIN_ERROR, "该用户已禁用");
			return "error";
		}else if (admin1.getGaStatus() == 2) {
			request.setAttribute(LOGIN_ERROR, "该用户已删除");
			return "error";
		}
		if (admin1.getGaPassword().equalsIgnoreCase(goodsAdmin.getGaPassword())) {
			session.put(SESSION_ADMIN_NAME, admin1.getGaName());   
			return "success";
		} else {
			ServletActionContext.getRequest().setAttribute(LOGIN_ERROR, "密码错误");
			return "error";
		}
	}

	/**
	 * 管理员退出接口 对应adminLogOut.action
	 * 
	 * @return
	 */
	public String adminLogOut() {
		session.remove(SESSION_ADMIN_NAME);
		return "success";
	}

	public GoodsAdmin getGoodsAdmin() {
		return goodsAdmin;
	}

	public void setGoodsAdmin(GoodsAdmin goodsAdmin) {
		this.goodsAdmin = goodsAdmin;
	}

}
