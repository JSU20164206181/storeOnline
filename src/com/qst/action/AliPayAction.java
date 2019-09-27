package com.qst.action;

import com.alipay.api.AlipayApiException;
import com.alipay.api.AlipayClient;
import com.alipay.api.DefaultAlipayClient;
import com.alipay.api.internal.util.AlipaySignature;
import com.alipay.api.request.AlipayTradePagePayRequest;
import com.qst.dao.GoodsDao;
import com.qst.dao.OrderDao;
import com.qst.dao.ReceiveAddressDao;
import com.qst.pojo.GoodsOrder;
import com.qst.pojo.GoodsOrderitem;
import com.qst.pojo.GoodsProduct;
import com.qst.tools.AlipayConfig;
import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.*;

/**
 * @Auther: CGL
 * @Date: 2019/8/13 15:03
 * @Description: 支付宝支付相关action
 */
@Transactional
@Controller("aliPayAction")
public class AliPayAction {

    @Autowired
    private OrderDao orderDao;

    @Autowired
    private ReceiveAddressDao receiveAddressDao;

    @Autowired
    private GoodsDao goodsDao;

    public String pay() throws IOException {
        HttpServletRequest request = ServletActionContext.getRequest();
        HttpServletResponse response = ServletActionContext.getResponse();
        //获得初始化的AlipayClient
        AlipayClient alipayClient = new DefaultAlipayClient(AlipayConfig.gatewayUrl, AlipayConfig.app_id, AlipayConfig.merchant_private_key, "json", AlipayConfig.charset, AlipayConfig.alipay_public_key, AlipayConfig.sign_type);
        //设置请求参数
        AlipayTradePagePayRequest alipayRequest = new AlipayTradePagePayRequest();
        alipayRequest.setReturnUrl(AlipayConfig.return_url);
        alipayRequest.setNotifyUrl(AlipayConfig.notify_url);

        int orderId = Integer.parseInt(request.getParameter("orderId"));
        System.out.println(orderId);
        System.out.println(orderDao);
        GoodsOrder order = orderDao.findOrderById(orderId);

        //商户订单号，商户网站订单系统中唯一订单号，必填
        String out_trade_no = order.getGoOrderCode();
        //付款金额，必填
        String total_amount = order.getGoTotalPrice()+"";
        //订单名称，必填
        String sName = order.getGoSname();
        String subject = "付款给"+sName;
        //商品描述，可空
        String body = "";

        String merpri = request.getSession().getId();

        alipayRequest.setBizContent("{\"out_trade_no\":\""+ out_trade_no +"\","
                + "\"total_amount\":\""+ total_amount +"\","
                + "\"subject\":\""+ subject +"\","
                + "\"body\":\""+ body +"\","
                + "\"merpri\":\""+ merpri +"\","
                + "\"product_code\":\"FAST_INSTANT_TRADE_PAY\"}");

        //请求
        String result;
        try {
            result = alipayClient.pageExecute(alipayRequest).getBody();
            response.setContentType("text/html;charset=" + AlipayConfig.charset);
            response.getWriter().write(result);//直接将完整的表单html输出到页面
            response.getWriter().flush();
            response.getWriter().close();
        } catch (
                AlipayApiException e) {
            e.printStackTrace();
            response.getWriter().write("捕获异常出错");
            response.getWriter().flush();
            response.getWriter().close();
        }
        return null;
    }

    /**
     * 支付完成异步处理action
     * @return
     * @throws UnsupportedEncodingException
     * @throws AlipayApiException
     */
    public String successPay() throws UnsupportedEncodingException, AlipayApiException {
        System.out.println("进入同步通知请求————————————————————");
        HttpServletRequest request = ServletActionContext.getRequest();
      /*  //获取支付宝POST过来反馈信息

        Map<String,String> params = new HashMap<String,String>();
        Map<String,String[]> requestParams = request.getParameterMap();
        for (Iterator<String> iter = requestParams.keySet().iterator(); iter.hasNext();) {
            String name = (String) iter.next();
            String[] values = (String[]) requestParams.get(name);
            String valueStr = "";
            for (int i = 0; i < values.length; i++) {
                valueStr = (i == values.length - 1) ? valueStr + values[i]
                        : valueStr + values[i] + ",";
            }
            //乱码解决，这段代码在出现乱码时使用
            valueStr = new String(valueStr.getBytes("ISO-8859-1"), "utf-8");
            params.put(name, valueStr);
        }

        boolean signVerified = AlipaySignature.rsaCheckV1(params, AlipayConfig.alipay_public_key, AlipayConfig.charset, AlipayConfig.sign_type); //调用SDK验证签名

        //——请在这里编写您的程序（以下代码仅作参考）——

	*//* 实际验证过程建议商户务必添加以下校验：
	1、需要验证该通知数据中的out_trade_no是否为商户系统中创建的订单号，
	2、判断total_amount是否确实为该订单的实际金额（即商户订单创建时的金额），
	3、校验通知中的seller_id（或者seller_email) 是否为out_trade_no这笔单据的对应的操作方（有的时候，一个商户可能有多个seller_id/seller_email）
	4、验证app_id是否为该商户本身。
	*//*
        if(signVerified) {//验证成功
            //商户订单号
            String out_trade_no = new String(request.getParameter("out_trade_no").getBytes("ISO-8859-1"),"UTF-8");

            //支付宝交易号
            String trade_no = new String(request.getParameter("trade_no").getBytes("ISO-8859-1"),"UTF-8");

            //交易状态
            String trade_status = new String(request.getParameter("trade_status").getBytes("ISO-8859-1"),"UTF-8");

            if(trade_status.equals("TRADE_FINISHED")){
                //判断该笔订单是否在商户网站中已经做过处理
                //如果没有做过处理，根据订单号（out_trade_no）在商户网站的订单系统中查到该笔订单的详细，并执行商户的业务程序
                //如果有做过处理，不执行商户的业务程序

                //注意：
                //退款日期超过可退款期限后（如三个月可退款），支付宝系统发送该交易状态通知
            }else if (trade_status.equals("TRADE_SUCCESS")){
                System.out.print("付款成功");
                System.out.println(out_trade_no);
                //判断该笔订单是否在商户网站中已经做过处理
                //如果没有做过处理，根据订单号（out_trade_no）在商户网站的订单系统中查到该笔订单的详细，并执行商户的业务程序
                //如果有做过处理，不执行商户的业务程序

                //注意：
                //付款完成后，支付宝系统发送该交易状态通知
            }


        }else {//验证失败

            //调试用，写文本函数记录程序运行情况是否正常
            //String sWord = AlipaySignature.getSignCheckContentV1(params);
            //AlipayConfig.logResult(sWord);
        }*/

        //获取支付宝GET过来反馈信息
        Map<String,String> params = new HashMap<String,String>();
        Map<String,String[]> requestParams = request.getParameterMap();
        for (Iterator<String> iter = requestParams.keySet().iterator(); iter.hasNext();) {
            String name = (String) iter.next();
            String[] values = (String[]) requestParams.get(name);
            String valueStr = "";
            for (int i = 0; i < values.length; i++) {
                valueStr = (i == values.length - 1) ? valueStr + values[i]
                        : valueStr + values[i] + ",";
            }
            //乱码解决，这段代码在出现乱码时使用
            valueStr = new String(valueStr.getBytes("ISO-8859-1"), "utf-8");
            params.put(name, valueStr);
        }

        boolean signVerified = AlipaySignature.rsaCheckV1(params, AlipayConfig.alipay_public_key, AlipayConfig.charset, AlipayConfig.sign_type); //调用SDK验证签名

        //——请在这里编写您的程序（以下代码仅作参考）——
        if(signVerified) {
            //商户订单号
            String out_trade_no = new String(request.getParameter("out_trade_no").getBytes("ISO-8859-1"),"UTF-8");

            //支付宝交易号
            String trade_no = new String(request.getParameter("trade_no").getBytes("ISO-8859-1"),"UTF-8");

            //付款金额
            String total_amount = new String(request.getParameter("total_amount").getBytes("ISO-8859-1"),"UTF-8");

            String finalSession = request.getParameter("merpri");

            System.out.println("trade_no:"+trade_no+"<br/>out_trade_no:"+out_trade_no+"<br/>total_amount:"+total_amount+"sessionId："+finalSession);

            GoodsOrder order = orderDao.findByOrderCode(out_trade_no);
            order.setGoStatus(2);                                                          //修改订单商品状态为已付款
            order.setGoPayDate(new Date());
            request.setAttribute("order",order);
          //  orderDao.updateOrder(order);
            System.out.println(order);
           Set<GoodsOrderitem> goodsOrderitem = order.getGoodsOrderitemSet();
            for(GoodsOrderitem goodsOrderitem1:goodsOrderitem) {
                goodsOrderitem1.setGoiStatus(2);                                                            //修改订单商品状态
                GoodsProduct goodsProduct = goodsDao.findById(goodsOrderitem1.getGoiPid());                     //修改商品库存
                int num = goodsProduct.getGpStock();
                goodsProduct.setGpStock(num-goodsOrderitem1.getGoiNumber());
            }

            List<GoodsProduct> goodsProductList = goodsDao.findNewProducts();
            request.setAttribute("newGoodsList",goodsProductList);
            return "success";

        }else {
          //  out.println("验签失败");
            return "error";
        }

        //——请在这里编写您的程序（以上代码仅作参考）——
        //return ;
    }
}

