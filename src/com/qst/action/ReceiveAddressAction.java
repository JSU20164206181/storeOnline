/**
 * 
 */
package com.qst.action;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;

import com.qst.dao.ReceiveAddressDao;
import com.qst.pojo.ReceiveAddress;

/**
 * @ClassName: ReceiveAddressAction.java
 * @version: v1.0.0
 * @author: ZYL
 * @date: 2019年8月9日 下午10:15:40
 * @Description: 收货地址action
 */
@Transactional
@Controller("receiveAddressAction")
public class ReceiveAddressAction {

	@Autowired
	private ReceiveAddressDao rad;
	private ReceiveAddress ra;

	public String searchRaById() {
		setRa(rad.findRaById(1));
		System.out.println(ra.getGraId());
		return "success";
	}

	/**
	 * 修改收货地址
	 * 
	 * @return
	 */
	public String updateRaById() {
		HttpServletRequest request = ServletActionContext.getRequest();
		rad.updateRA(ra);
		setRa(rad.findRaById(ra.getGraId()));
		request.setAttribute("ra", ra);
		System.out.println(ra.getGraId());
		return "success";
	}

	/**
	 * 添加收货地址
	 * 
	 * @return
	 */
	public String addRa() {
		HttpServletRequest request = ServletActionContext.getRequest();
		rad.addRA(ra);
		setRa(rad.findRaById(ra.getGraId()));
		request.setAttribute("ra", ra);
		System.out.println(ra.getGraId());
		return "success";
	}

	/**
	 * 删除收货地址
	 * 
	 * @return
	 */
	public String deleteRaById() {
		HttpServletRequest request = ServletActionContext.getRequest();
		int id = Integer.parseInt(request.getParameter("graId"));
		rad.deleteRA(id);
		request.setAttribute("id", id);
		System.out.println(id);
		return "success";
	}

	/**
	 * @return the ra
	 */
	public ReceiveAddress getRa() {
		return ra;
	}

	/**
	 * @param ra the ra to set
	 */
	public void setRa(ReceiveAddress ra) {
		this.ra = ra;
	}

}
