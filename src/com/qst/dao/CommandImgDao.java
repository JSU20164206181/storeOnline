package com.qst.dao;

import com.qst.pojo.GoodsCommandImg;

import java.util.List;

/**
 * @Auther: CGL
 * @Date: 2019/8/15 19:31
 * @Description:   评论图片数据库交互方法定义接口
 */
public interface CommandImgDao {

    /**
     * 增加方法
     * @param v
     * @return
     */
    int add(GoodsCommandImg v);

    /**
     * 批量添加
     * @param list
     * @return
     */
    int batchAdd(List<GoodsCommandImg> list);

    /**
     * 根据id删除
     * @param id
     */
    void deleteById(Integer id);


}
