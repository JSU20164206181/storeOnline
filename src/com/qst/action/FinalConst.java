package com.qst.action;

/**
 * @Auther: CGL
 * @Date: 2019/7/30 10:27
 * @Description: 常量控制器 常用常量都在此接口中定义
 */
public interface FinalConst {
    /**
     * 用户登录时存在session中的随机验证码
     */
    String SESSION_LOGIN_VALIDATECODE = "validateCode";

    /**
     *   记录登录报错类型
     */
    String LOGIN_ERROR = "error";

    /**
     * 存放于客户端的用户id
     */
    String CLIENT_USER_ID = "userId";

    /**
     * 存放于服务端中用户名，用于判断是否登录
     */
    String SESSION_USER_NAME = "userName";

    /**
     * 存放于服务端的管理员用户名，用于判断管理员登录
     */
    String SESSION_ADMIN_NAME = "adminName";

    /**
     * 服务器存放图片路径
     */
    String SERVER_IMAGE_PATH = "../../storeUpload/";
    /**
     * 存放导出表格路径
     * 路径不存在则创建
     */
    String EXCEL_PATH = "C:/excel_Date/";
    /**
     * 邮箱发件人账号
     */
    String SEND_EMAUL_COUNT="hdq8888888@163.com";
    /**
     * 邮箱发件人密码
     */
    String SEND_EMAUL_PASSWORD="hdq123456";
    
}
