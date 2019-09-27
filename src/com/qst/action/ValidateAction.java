/**
 * 
 */
package com.qst.action;

import java.awt.image.BufferedImage;
import java.io.InputStream;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.interceptor.ServletRequestAware;

import com.opensymphony.xwork2.ActionSupport;



/**
* @ClassName: ValidateAction.java
* @version: v1.0.0
* @author: 隆森
* @date: 2019年8月6日 上午11:48:20 
* @Description: 获取验证码的Action
 */

//获取验证码的Action
public class ValidateAction extends ActionSupport implements ServletRequestAware{

	
	private static final long serialVersionUID = 1L;

	
	
	 private InputStream yzm;
		


		public String execute(){
	
			  HttpSession session = request.getSession();
			  Map<String,BufferedImage> map = Validate.createImage();
			  Set<String> set=map.keySet();
			  String key = "";
			  for(Object e :set){
				  key =(String)e;
			  }
			  BufferedImage img=map.get(key);
			  try {
				 yzm = Validate.getInputStream(img);
				
				 session.setAttribute("code",key);
			} catch (Exception e1) {
				
				e1.printStackTrace();
			}
			   
			  return LOGIN;
		  }


		public InputStream getYzm() {
			return yzm;
		}


		public void setYzm(InputStream yzm) {
			this.yzm = yzm;
		}

	    public HttpServletRequest getRequest() {
			return request;
		}


		public void setRequest(HttpServletRequest request) {
			this.request = request;
		}

		private HttpServletRequest request;
		@Override
		public void setServletRequest(HttpServletRequest request) {
			this.request = request;
			
		}
		 
	

}
