package com.qst.pojo;

import java.io.Serializable;

/**
 * @Auther: CGL
 * @Date: 2019/8/15 19:23
 * @Description:  商品评论图片表
 */

public class GoodsCommandImg implements Serializable {
    private static final long serialVersionUID = 1941749462913583467L;

    private int gciId;   //主键id

    private int gciCId;   //对应评论id

    private String url;    //图片对应url

    public GoodsCommandImg(int gciCId, String url) {
        this.gciCId = gciCId;
        this.url = url;
    }

    public GoodsCommandImg() {
    }

    public int getGciId() {
        return gciId;
    }

    public void setGciId(int gciId) {
        this.gciId = gciId;
    }

    public int getGciCId() {
        return gciCId;
    }

    public void setGciCId(int gciCId) {
        this.gciCId = gciCId;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    @Override
    public String toString() {
        return "GoodsCommandImg{" +
                "gciId=" + gciId +
                ", gciCId=" + gciCId +
                ", url='" + url + '\'' +
                '}';
    }
}
