package com.qst.interceptor;

import java.util.Map;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.Interceptor;
import com.qst.action.FinalConst;

/**
 * @Auther: CGL
 * @Date: 2019/7/31 15:33
 * @Description: 拦截器 用于拦截一些需要用户登录才能进行的请求和操作
 */
public class LoginInterceptor implements Interceptor, FinalConst {

	@Override
    public void destroy() {

    }

    @Override
    public void init() {

    }

    /**
     * 对一些请求进行拦截，判断用户是否登录
     * @param invocation
     * @return
     * @throws Exception
     */

    @Override
    public String intercept(ActionInvocation actionInvocation) throws Exception {
        Map<String,Object> session = ActionContext.getContext().getSession();
        System.out.println("进入拦截器拦截请求-------------");
        
        if(session.get(SESSION_USER_NAME)!= null){
        	System.out.println(1111);
            actionInvocation.invoke();
        }else {
        	System.out.println(222);
            return "login";
        }
		return "login";

    }
	
}
