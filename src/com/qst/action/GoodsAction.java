package com.qst.action;

import com.qst.dao.*;
import com.qst.pojo.*;
import net.sf.json.JSONArray;
import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * @Auther: CGL
 * @Date: 2019/8/7 20:21
 * @Description:
 */
@Transactional
@Controller("goodsAction")
public class GoodsAction {

    private static final int pageSize = 12;

    @Autowired
    private GoodsDao dao;
    @Autowired
    private CategoryDao categoryDao;

    @Autowired
    private ReceiveAddressDao receiveAddressDao;

    @Autowired
    private AdminProductimageDao ImgDao;

    @Autowired
    private UserDao userDao;
    @Autowired
    private OrderItemDao orderItemDao;

    @Autowired
    private OrderDao orderDao;

    @Autowired
    private CommandDao commandDao;

    private File file[];

    /**
     * 上传图片 如果用户上传之后修改删除上一次上传的图片
     */
    private String oldFile;

    private GoodsProduct goods;

    private int userId;        //买家id

    private int goodsId;      //商品id
    private int addressId;     //收货地址id
    private String note;      //商品备注
    private int goodsUid;    //商品所属用户id

    private int orderId;      //订单id 用于传下一个action
    /**
     * 确认购买商品
     * @return  跳转支付页面
     */
    public String submitBuyGoods(){
        HttpServletRequest request = ServletActionContext.getRequest();
        double totalPrice = Double.parseDouble(request.getParameter("totalPrice"));
        System.out.println(userId+"商品id: "+goodsId+"收获地址id："+addressId+"订单总价："+totalPrice);
        if(userId==0||goodsId==0||addressId==0)
            return "error";
        if(note!=null)
            System.out.println(note);
        int goodsNum = Integer.parseInt(request.getParameter("goodsNum"));
        GoodsUser goodsUser = userDao.findUserById(userId);                           //获取用户信息
        GoodsUser sUser = userDao.findUserById(goodsUid);                              //获取卖家信息
        GoodsProduct goodsProduct = dao.findById(goodsId);
        ReceiveAddress receiveAddress = receiveAddressDao.findRaById(addressId);   //获取完整收货地址
        String orderCode = System.currentTimeMillis()+""+(int) Math.random() * 1000000+userId;
        System.out.println("订单编号："+orderCode);
        GoodsOrder order = new GoodsOrder();       //创建订单
        order.setGoAddress(receiveAddress.getCompleteAddress());
        order.setGoTotalPrice(totalPrice);
        order.setGoOrderCode(orderCode);
        order.setGoReceiver(goodsUser.getGuName());
        order.setGoPhone(goodsUser.getGuPhone());
        order.setGoUid(userId);
        order.setGoSid(goodsUid);
        order.setGoSname(sUser.getGuName());
        System.out.println(order);
        orderId = orderDao.addOrder(order);              //获取新增订单的主键id
        GoodsOrderitem goodsOrderitem = new GoodsOrderitem(goodsId,orderId,userId,goodsNum,1,note,goodsUid,orderCode,goodsProduct.getGpName(),goodsProduct.getGpPromotePrice());

        orderItemDao.addOderItem(goodsOrderitem);
        System.out.println(goodsOrderitem);
       // request.setAttribute("orderId",orderId);
        setOrderId(orderId);

        return "success";
    }

    /**
     * 购买商品
     * @return 跳转生成订单页面
     */
    public String purchaseGoods(){
        HttpServletRequest request = ServletActionContext.getRequest();
        String s =  request.getParameter("userId");
        String s1 = request.getParameter("goodsId");
        if(s==null||s.equals("")||s1==null||s1.equals(""))
            return "error";
        int goodsNumber = Integer.valueOf(request.getParameter("goodsNumber"));
        int userId = Integer.valueOf(s);
        int goodsId = Integer.valueOf(s1);
        System.out.println(userId+" "+goodsId);
        List<ReceiveAddress> receiveAddressList = receiveAddressDao.findAllRaByUserId(userId);    //收货地址集合
        List<GoodsProduct> goodsProductList = dao.findNewProducts();                             //最新发布商品

        GoodsProduct goodsProduct = dao.findById(goodsId);

       // goodsProduct.setGpStock(goodsNumber);
        System.out.println(goodsProduct);
        System.out.println(goodsProductList.size());
        request.setAttribute("aggregate",goodsNumber*goodsProduct.getGpPromotePrice());
        request.setAttribute("newGoodsList",goodsProductList);
        request.setAttribute("goodsNum",goodsNumber);
        request.setAttribute("receiveAddressList",receiveAddressList);
        request.setAttribute("orderGoods",goodsProduct);

        return "success";
    }

    /**
     * 根据商品类别分页筛选商品
     * @return
     */
    public String findByType(){
        HttpServletRequest request = ServletActionContext.getRequest();
        if(request.getParameter("type")==null||request.getParameter("type").equals("")){
            return "error";
        }
        int page = 1;
        if(request.getParameter("page")!=null&&!request.getParameter("page").equals("")){
            page = Integer.parseInt(request.getParameter("page"));
        }
            if(page == 0)
                page = 1;

        int type = Integer.valueOf(request.getParameter("type"));
        List<GoodsProduct> productList = dao.findByType(type,page,pageSize);
        int totalPage = dao.totalPageType(type,pageSize);
        request.setAttribute("type",type);
        request.setAttribute("currentPage",page);
        request.setAttribute("goodsList",productList);
        request.setAttribute("totalPage",totalPage);
        return "success";
    }

    /**
     * 无类别直接筛选出商品
     * @return
     */
    public String findAllGoodsByPage(){
        int page = 1,pageSize = 4;
        List<GoodsProduct> productList = dao.findByType(1,page,pageSize);
        productList.addAll(dao.findByType(2,page,pageSize));
        productList.addAll(dao.findByType(3,page,pageSize));
        ServletActionContext.getRequest().setAttribute("goodsList",productList);
        return "success";
    }

    /**
     * 根据用户id查看商品   用于用户查看自己上传的商品
     * @return
     */
    public String findByUserId(){
        if(userId==0)
            return "error";
        int page = 1;
        HttpServletRequest request = ServletActionContext.getRequest();
        if(request.getParameter("page")!=null&&!request.getParameter("page").equals("")){
            page = Integer.parseInt(request.getParameter("page"));
        }
        if(page == 0)
            page = 1;
        List<GoodsProduct> list = dao.findByUserId(userId,page,8);
        int totalPage = dao.totalPageByUserId(userId,8);
        System.out.println(totalPage+"---------------------------");
        for (GoodsProduct gp:list){
            System.out.println(gp);
        }
        request.setAttribute("currentPage",page);
        request.setAttribute("totalPage",totalPage);
        request.setAttribute("goodsList",list);
        return "success";
    }

    /**
     * 模糊查找
     * @return
     */
    public String fuzzySearchGoods(){
        HttpServletRequest request = ServletActionContext.getRequest();
        int page = 1;
        String key = request.getParameter("key");
        if (key==null||key.equals(""))
            return "error";
        if(request.getParameter("page")!=null&&!request.getParameter("page").equals("")){
            page = Integer.parseInt(request.getParameter("page"));
        }
        if(page == 0)
            page = 1;

        List<GoodsProduct> list = dao.fuzzySearch(key,page,pageSize);
        int totalPage = dao.totalPageByFS(key,pageSize);
      /*  System.out.println(totalPage+"------------------------");
        for (GoodsProduct gp:list){
            System.out.println(gp);
        }*/

        request.setAttribute("currentPage",page);
        request.setAttribute("goodsList",list);
        request.setAttribute("totalPage",totalPage);
        return "success";
    }

    /**
     * 增加商品跳转类  查询出所有商品类别
     * @return
     */
    public String addGoods(){
        List<GoodsCategory> categoryList = categoryDao.findAll();
        ServletActionContext.getRequest().setAttribute("categoryList",categoryList);
        return "success";
    }

    /**
     * 处理增加商品的控制类
     * @return
     */
    public String submitAdd(){
        System.out.println(goods);
        //goods.setGpUid(1);
        int gpPid = dao.addGoods(goods);
        String[] goodsImg = ServletActionContext.getRequest().getParameterValues("goodsImg");
        ImgDao.addProductimage(new GoodsProductimage(gpPid,"封面",goods.getTitleImg(),1));
        List<GoodsProductimage> list = new ArrayList<GoodsProductimage>();
        for (String s:goodsImg
             ) {
            GoodsProductimage goodsProductimage = new GoodsProductimage();
            goodsProductimage.setGpiPid(gpPid);
            goodsProductimage.setGpiStatus(1);
            goodsProductimage.setGpiType("介绍");
            goodsProductimage.setGpiUrl(s);
            list.add(goodsProductimage);
        }
        ImgDao.batchAdd(list);

        return "success";
    }

    /**
     * 根据id查看商品详情
     * @return
     */
    public String goodsDetail(){
        HttpServletRequest request = ServletActionContext.getRequest();
        String s = request.getParameter("goodsId");
        if(s==null||s.equals("")) {
            return "error";
        }
        else {
            int goodsId = Integer.valueOf(s);
            GoodsProduct pc = dao.findById(goodsId);
            System.out.println(pc);
           // System.out.println(pc.getGoodsProductimages().size());
            List<GoodsProduct> goodsProductList = dao.findNewProducts();
            List<GoodsReview> goodsReviews = commandDao.findByGoodsId(goodsId);
            int commandNum = commandDao.totalNum(goodsId);
            request.setAttribute("newGoodsList",goodsProductList);
            request.setAttribute("commandList",goodsReviews);
            request.setAttribute("commandNum",commandNum);
            request.setAttribute("goods", pc);
        }
        return "success";
    }

    /**
     * 用户点击修改商品信息的Action 用于查询商品信息并回显
     * @return
     */
    public String updateGoods(){

        return "success";
    }

    /**
     * 提交修改  修改商品信息
     * @return
     */
    public String submitUpdate(){

        return "success";
    }

    /**
     * 商品图片上传
     * @return
     */
    public String upload() throws IOException {
        String path1 = System.getProperty("storage.root");
        System.out.println(file.length);

       // System.out.println(ServletActionContext.getRequest().getAttribute("file"));
       // System.out.println(file.length);
       // System.out.println(file.getAbsolutePath());
    /*        if(oldFile!=null&&!oldFile.equals("")){
                System.out.println(oldFile);
                String oldPath = path1 +  oldFile.substring(2);
                File oldFile1 = new File(oldPath);
                boolean flag =  oldFile1.delete();
                System.out.println(flag);
                //File oldFile = new File()
            }
            */
        String path2 = "../storeUpload/img/" + new SimpleDateFormat("yyyyMMdd").format(new Date());
        String path = path1 + path2;

        System.out.println(path);
        File file1 = new File(path);
        if (!file1.exists()) {
            file1.mkdirs();
        }
        HttpServletResponse response = ServletActionContext.getResponse();
        response.setContentType("text/html;charset=utf-8");
        List<String> list = new ArrayList<String>();
        for (int i = 0;i<file.length; i++) {

                String img = System.currentTimeMillis() + (int) Math.random() * 1000000 + ".jpg";
                InputStream is = null;
                FileOutputStream outputStream = null;
                try {
                    is = new FileInputStream(file[i]);
                    outputStream = new FileOutputStream(new File(file1, img));
                    byte[] bbuf = new byte[1024];
                    int length = 0;
                    while ((length = is.read(bbuf)) > 0) {
                        outputStream.write(bbuf);
                    }
                    list.add(path2 + "/" + img);
                } catch (IOException e) {
                    e.printStackTrace();
                    ServletActionContext.getResponse().getWriter().print("error");
                } finally {
                    is.close();
                    outputStream.close();
                }
            }
        JSONArray jsonArray;
        jsonArray = JSONArray.fromObject(list);
        response.getWriter().print(jsonArray);
      //  System.out.println(file.getPath());
       return null;
    }

    public GoodsProduct getGoods() {
        return goods;
    }

    public void setGoods(GoodsProduct goods) {
        this.goods = goods;
    }

    public File[] getFile() {
        return file;
    }

    public void setFile(File[] file) {
        this.file = file;
    }

    public String getOldFile() {
        return oldFile;
    }

    public void setOldFile(String oldFile) {
        this.oldFile = oldFile;
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

    public int getAddressId() {
        return addressId;
    }

    public void setAddressId(int addressId) {
        this.addressId = addressId;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public int getGoodsUid() {
        return goodsUid;
    }

    public void setGoodsUid(int goodsUid) {
        this.goodsUid = goodsUid;
    }

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }
}
