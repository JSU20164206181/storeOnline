package com.qst.action;

import org.apache.struts2.interceptor.SessionAware;

import java.util.Map;

/**
 * @Auther: CGL
 * @Date: 2019/7/29 20:55
 * @Description: struts容器自动填充一个session对象
 */
public class BaseSession implements SessionAware {
    Map<String,Object> session;
    public void setSession(Map<String, Object> session) {
        this.session = session;
    }
}
