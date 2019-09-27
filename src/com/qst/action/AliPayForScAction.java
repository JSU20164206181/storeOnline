package com.qst.action;

import com.alipay.api.AlipayApiException;
import com.alipay.api.AlipayClient;
import com.alipay.api.DefaultAlipayClient;
import com.alipay.api.internal.util.AlipaySignature;
import com.alipay.api.request.AlipayTradePagePayRequest;
import com.qst.dao.GoodsDao;
import com.qst.dao.OrderDao;
import com.qst.dao.OrderItemDao;
import com.qst.pojo.GoodsOrder;
import com.qst.pojo.GoodsOrderitem;
import com.qst.pojo.GoodsProduct;
import com.qst.tools.AlipayForScConfig;
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
@Controller("aliPayForScAction")
public class AliPayForScAction {
	@Autowired
	private OrderDao od;
	@Autowired
	private OrderItemDao oid;
	@Autowired
	private GoodsDao gd;

	public String pay() throws IOException {
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		// 获得初始化的AlipayClient
		AlipayClient alipayClient = new DefaultAlipayClient(AlipayForScConfig.gatewayUrl, AlipayForScConfig.app_id,
				AlipayForScConfig.merchant_private_key, "json", AlipayForScConfig.charset,
				AlipayForScConfig.alipay_public_key, AlipayForScConfig.sign_type);
		// 设置请求参数
		AlipayTradePagePayRequest alipayRequest = new AlipayTradePagePayRequest();
		alipayRequest.setReturnUrl(AlipayForScConfig.return_url);
		alipayRequest.setNotifyUrl(AlipayForScConfig.notify_url);

		// 商户订单号，商户网站订单系统中唯一订单号，必填
		String out_trade_no = request.getParameter("OcList");
		// 付款金额，必填
		String total_amount = request.getParameter("totalPrice");
		// 订单名称，必填
		String sName = request.getParameter("sId");
		String subject = "付款给" + sName;
		// 商品描述，可空
		String body = "";

		System.out.println("~~~~~~~~~~~~~~" + out_trade_no + "~" + total_amount + "~" + subject);

		alipayRequest.setBizContent("{\"out_trade_no\":\"" + out_trade_no + "\"," + "\"total_amount\":\"" + total_amount
				+ "\"," + "\"subject\":\"" + subject + "\"," + "\"body\":\"" + body + "\","
				+ "\"product_code\":\"FAST_INSTANT_TRADE_PAY\"}");

		// 请求
		String result;
		try {
			result = alipayClient.pageExecute(alipayRequest).getBody();
			response.setContentType("text/html;charset=" + AlipayForScConfig.charset);
			response.getWriter().write(result);// 直接将完整的表单html输出到页面
			response.getWriter().flush();
			response.getWriter().close();
		} catch (AlipayApiException e) {
			e.printStackTrace();
			response.getWriter().write("捕获异常出错");
			response.getWriter().flush();
			response.getWriter().close();
		}
		return null;
	}

	/**
	 * 支付完成异步处理action
	 * 
	 * @return
	 * @throws UnsupportedEncodingException
	 * @throws AlipayApiException
	 */
	public String successPay() throws UnsupportedEncodingException, AlipayApiException {
		System.out.println("进入同步通知请求————————————————————");
		HttpServletRequest request = ServletActionContext.getRequest();
		// 获取支付宝GET过来反馈信息
		Map<String, String> params = new HashMap<String, String>();
		Map<String, String[]> requestParams = request.getParameterMap();
		for (Iterator<String> iter = requestParams.keySet().iterator(); iter.hasNext();) {
			String name = (String) iter.next();
			String[] values = (String[]) requestParams.get(name);
			String valueStr = "";
			for (int i = 0; i < values.length; i++) {
				valueStr = (i == values.length - 1) ? valueStr + values[i] : valueStr + values[i] + ",";
			}
			// 乱码解决，这段代码在出现乱码时使用
			valueStr = new String(valueStr.getBytes("ISO-8859-1"), "utf-8");
			params.put(name, valueStr);
		}

		boolean signVerified = AlipaySignature.rsaCheckV1(params, AlipayForScConfig.alipay_public_key,
				AlipayForScConfig.charset, AlipayForScConfig.sign_type); // 调用SDK验证签名

		// ——请在这里编写您的程序（以下代码仅作参考）——
		if (signVerified) {
			// 商户订单号
			String out_trade_no = new String(request.getParameter("out_trade_no").getBytes("ISO-8859-1"), "UTF-8");

			// 支付宝交易号
			String trade_no = new String(request.getParameter("trade_no").getBytes("ISO-8859-1"), "UTF-8");

			// 付款金额
			String total_amount = new String(request.getParameter("total_amount").getBytes("ISO-8859-1"), "UTF-8");

			System.out.println(
					"trade_no:" + trade_no + "<br/>out_trade_no:" + out_trade_no + "<br/>total_amount:" + total_amount);

			String[] ocList = out_trade_no.split(",");
			List<GoodsOrder> goList = new ArrayList<GoodsOrder>();// 订单List
			List<GoodsOrderitem> goiList = new ArrayList<GoodsOrderitem>();// 订单商品List
			for (int i = 0; i < ocList.length; i++) {
				goList.add(od.findOrderByOrderCode(ocList[i]));
				goiList.addAll(oid.findGoiByOrderCode(ocList[i]));
			}
			for (int i = 0; i < goList.size(); i++) {
				goList.get(i).setGoStatus(2);
				goList.get(i).setGoPayDate(new Date());
				System.out.println("~~~~~~~go：" + goList.get(i).getGoId() + "~" + goList.get(i).getGoStatus());
			}
			for (int i = 0; i < goiList.size(); i++) {
				goiList.get(i).setGoiStatus(2);
				System.out.println("~~~~~~~goi：" + goiList.get(i).getGoiId() + "~" + goiList.get(i).getGoiStatus());
			}

			request.setAttribute("goList", goList);
			request.setAttribute("goiList", goiList);

			List<GoodsProduct> goodsProductList = gd.findNewProducts();
			request.setAttribute("goodsProductList", goodsProductList);
			return "success";

		} else {
			// out.println("验签失败");
			return "error";
		}

		// ——请在这里编写您的程序（以上代码仅作参考）——
		// return ;
	}
}
