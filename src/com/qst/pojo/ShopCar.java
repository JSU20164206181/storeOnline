package com.qst.pojo;

import org.springframework.stereotype.Repository;

import java.io.Serializable;
import java.util.List;

/**
 * @Auther: CGL
 * @Date: 2019/8/7 10:18
 * @Description: 购物车实体类
 */
@Repository
public class ShopCar implements Serializable {

    private static final long serialVersionUID = 2331053774404634146L;

    /*对应数据库主键*/
    private int id;

    /*购物车用户id*/
    private int userId;

    /*购物车商品id*/
    private int goodsId;

    /*商品数量*/
    private int goodsNum;

    /*商品信息 该数据不存于数据库中*/
    private GoodsProduct goodsProduct;

    public ShopCar(int id, int userId, int goodsId, int goodsNum) {
        this.id = id;
        this.userId = userId;
        this.goodsId = goodsId;
        this.goodsNum = goodsNum;
    }

    public ShopCar(int userId, int goodsId, int goodsNum) {
        this.userId = userId;
        this.goodsId = goodsId;
        this.goodsNum = goodsNum;
    }

    public ShopCar(){};

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getGoodsId() {
        return goodsId;
    }

    public void setGoodsId(int goodsId) {
        this.goodsId = goodsId;
    }

    public int getGoodsNum() {
        return goodsNum;
    }

    public void setGoodsNum(int goodsNum) {
        this.goodsNum = goodsNum;
    }

    public GoodsProduct getGoodsProduct() {
        return goodsProduct;
    }

    public void setGoodsProduct(GoodsProduct goodsProduct) {
        this.goodsProduct = goodsProduct;
    }

    @Override
    public String toString() {
        return "ShopCar{" +
                "id=" + id +
                ", userId=" + userId +
                ", goodsId=" + goodsId +
                ", goodsNum=" + goodsNum +
                ", goodsProduct=" + goodsProduct +
                '}';
    }
}
