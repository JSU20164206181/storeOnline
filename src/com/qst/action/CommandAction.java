package com.qst.action;

import com.qst.dao.CommandDao;
import com.qst.dao.CommandImgDao;
import com.qst.pojo.GoodsReview;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * @Auther: CGL
 * @Date: 2019/8/15 19:44
 * @Description:  评论action
 */

@Transactional
@Controller
public class CommandAction {

    @Autowired
    private CommandImgDao commandImgDao;

    @Autowired
    private CommandDao commandDao;

    /**
     * 根据Id加载评论
     * @return
     */
    public String findById(){
        List<GoodsReview> reviewList = commandDao.findByGoodsId(1);
        for(GoodsReview gr:reviewList){
            System.out.println(gr);
        }

        return  "success";
    }


}
