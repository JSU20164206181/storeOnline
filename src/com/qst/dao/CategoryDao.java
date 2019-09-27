package com.qst.dao;

import com.qst.pojo.GoodsCategory;

import java.util.List;
import java.util.Locale;

/**
 * @Auther: CGL
 * @Date: 2019/8/9 19:57
 * @Description:  数据字典类数据库交互基本方法声明
 */
public interface CategoryDao {

    /**
     * 查询所有类型数据字典
     * @return
     */
    List<GoodsCategory>  findAll();

    /**
     * 增加类型
     * @param v
     * @return
     */
    int addCategory(GoodsCategory v);
}
