package com.qst.action;

import com.opensymphony.xwork2.ActionSupport;
import com.qst.tools.RandomValidateCode;

import java.awt.image.BufferedImage;
import java.io.IOException;
import java.io.InputStream;
import java.util.Map;

/**
 * @Auther: CGL
 * @Date: 2019/7/29 20:54
 * @Description: 产生图片验证码 并存入session
 */
public class ImageValidate extends BaseSession implements FinalConst{
    /**
     *
     */
    private static final long serialVersionUID = 1L;
    private InputStream inputStream;

    public String createValidate() {
        try {
            Map<String, BufferedImage> map = RandomValidateCode.getRandcode();
            String key = map.keySet().iterator().next();
            session.put(SESSION_LOGIN_VALIDATECODE,key);
            System.out.println(key);
            BufferedImage image = map.get(key);
            inputStream = RandomValidateCode.getInputStream(image);
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

        return "success";
    }

    public InputStream getInputStream() {
        return inputStream;
    }

    public void setInputStream(InputStream inputStream) {
        this.inputStream = inputStream;
    }
}
