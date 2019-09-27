package com.qst.dao;

import com.qst.pojo.GoodsReview;

import java.util.List;

/**
 * @Auther: CGL
 * @Date: 2019/8/15 19:47
 * @Description: 评论数据库交互方法定义
 */
public interface CommandDao {

    /**
     * 增加评论
     * @param v
     * @return
     */
    int add(GoodsReview v);

    /**
     * 根据id删除评论
     * @param id
     */
    void deleteById(int id);

    /**
     * 根据商品id加载出评论id
     * @param id
     * @return
     */
    List<GoodsReview> findByGoodsId(int id);

    /**
     * 分页加载
     * @param id
     * @param page
     * @param pageSize
     * @return
     */
    List<GoodsReview> findByPage(int id,int page,int pageSize);

    /**
     * 根据商品id获取所有评论数量
     * @param id
     * @return
     */
    int totalNum(int id);
}
