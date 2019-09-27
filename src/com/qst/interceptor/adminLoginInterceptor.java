package com.qst.interceptor;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.Interceptor;
import com.qst.action.FinalConst;

import java.util.Map;

/**
 * @Auther: CGL
 * @Date: 2019/7/31 15:33
 * @Description: 管理员拦截器 用于拦截一些需要管理员登录才能进行的请求和操作
 */
public class adminLoginInterceptor implements Interceptor, FinalConst {
    @Override
    public void destroy() {

    }

    @Override
    public void init() {

    }

    /**
     * 对一些请求进行拦截，判断管理员是否登录
     * @param actionInvocation
     * @return
     * @throws Exception
     */
    @Override
    public String intercept(ActionInvocation actionInvocation) throws Exception {
        Map<String,Object> session = ActionContext.getContext().getSession();
        System.out.println("进入后台管理员拦截器拦截请求-------------");
        if(session.get(SESSION_ADMIN_NAME)!= null){
            actionInvocation.invoke();
        }else {
            return "login";
        }
        return "login";
    }
}
