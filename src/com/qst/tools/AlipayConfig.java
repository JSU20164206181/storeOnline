package com.qst.tools;

import java.io.FileWriter;
import java.io.IOException;

/* *
 *类名：AlipayConfig
 *功能：基础配置类
 *详细：设置帐户有关信息及返回路径
 *修改日期：2017-04-05
 *说明：
 *以下代码只是为了方便商户测试而提供的样例代码，商户可以根据自己网站的需要，按照技术文档编写,并非一定要使用该代码。
 *该代码仅供学习和研究支付宝接口使用，只是提供一个参考。
 */

public class AlipayConfig {
	
//↓↓↓↓↓↓↓↓↓↓请在这里配置您的基本信息↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓

	// 应用ID,您的APPID，收款账号既是您的APPID对应支付宝账号
	public static String app_id = "2016100100642967";
	
	// 商户私钥，您的PKCS8格式RSA2私钥
    public static String merchant_private_key = "MIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDd2JB/LpJUWAbglYSSwmVFSK8Dqv7Z9u+R5KYIzA25v8VBvQ5p6X1mhL5rWrIYO+4WMdyLSDS6V6GhrT64BrfxuF9V7TiEvdm38LKg6pMPMQWa10NW1uCcGEAAaDEo/oynRacliC0Fk627LlMb40GhsCHcxQo9Jh1NhEX8xgShyonVsa1FtxLOMWUUC/Rc3c5QIjO4WLGrokp1NTUQ23yrXzr8yjYPV+4e3H5QdcjpkUeersv1tfnVkYiZLJ2sJw2GqXrxaZsjIGJLuSBNnrKoGdqJxQpXlOqvVt4X/mUzBnv8vPsxLJ0f7VELulJpEbKeyDdVu56Fbh/SaIjcUxxdAgMBAAECggEAZA/iXPsslU5/C51lBq0X8IAwMH9YJAf1VuDC4wTmy/lrh5M2hR8DqNIG8XUfDz84zFoBF/Ghlssf5ES4HVkqbqSym5c7/uOC6Cxw5ZPocNmzpXuiq/CPrthhRc25HrxxxKDuG0eoxvMtUVg7tEB0wfEn1OQrEhm27dfTmYfXXwGc0o9GG/PN2IU8b0YXtX7iA8J1+UB/ZlP+BUdqEaGYxjrm82jyQg7gFCcidXSoc84TBFI71BBt/wzcP0/i/+gtKDcvwksEbjh1T6UQxRJbyJpP873g/36Ca2/1dMABMdH0nwwflZ+sx08dzgjcpesPwqGwWo3ny6FMg+xBW+UaAQKBgQDzZi1ITZqvlbw+ajYoHO5eifb56lXR73VDatr6ghvs456XqkFVU4aZ0bFtm2trpQcs13/VAOKeSZ41tOUQ5Ao5OlIr6/e9bKFoZdgd87LnzNW+/MPmoA8JE3n3MEylL9Mz2l2jQ6H2ay9g+bXGN6yxpsK4UgQttc2ztN98Rl9hjQKBgQDpVL0P3KiH+OYKArP/JDv/lRPuiAx/pmRHC/faUJHiKLdyoZZWw/u2PbmXj6Kqg5l+3vilSWIP9rDIouj1eEV0Vo6qdjaSLxM19xwalOxFHXKXcgDAhtJInZMJ69+QVILU+kBRDcO4LJFGfaAiM2gAx+04p9zVQgDLIEzL8Y6qEQKBgQDRZuOoY9OkIj98tyX2psVRIoMQCdJhthD9um3AvbVGvaGQvBJPVXfk2Co8sUzepHEi3BgHaiaNpapubD3ypS5Cg/F0BiPynQXUamJfim0tzeVK1e24eZXV6iKxTqVyLE4ZO1H6B1LNTPPLC6qeaQGzKVQ2/aDIrrPVWtQ299hRdQKBgQDdT7uXnPLZLXJ70j6J5QNnky35lF9OgDMi1C49iygju/zsJGnlWDSakYdEQz/FvdbMaI6sr6Lsg08ArsyJb49pHmRpOIDgPPhaukyUxeYoVBsJnF8sPXSc3aDGy0wcqJwDiG2Ss5yNRvBwTN2jMuEVxIuzrjwepmD8SWGuGyr3EQKBgCOYMyMen6xcck7M10yNeWxL60XaIZAy/UFImoPioKJkAOI2flw6wrYYKg9UPHRaJc5JBbp11l55jOcwCx4+qFCBkGugqEif7kTEHcgIjUZDXZOQlX0le2plXPvZHL9F9Fgq2Z3NGqiF7e+vdX5lUPbNSOu5X+C+cVMXHGt5/oQ2";
	
	// 支付宝公钥,查看地址：https://openhome.alipay.com/platform/keyManage.htm 对应APPID下的支付宝公钥。
    public static String alipay_public_key = "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA2f0uusO+7otGtFXmasThr9/vB5n76M0kUqOf60jDmILYsRJqU8SNvz8bJeIt+KKSHPPTcbGuaZPLUYyFkT2Zkvg1CqlRmLhOFQ1832fFpGfi9fLd0Tu/+6jn1kQm+JJ5hpc6+qtlnNtADmqtWUb/gw0K4BqneRyBV4hyx3IoC7Uq3SgSFQ/YoYQEpH48NhDmg8sGll1pFysBd/NBhqo9YK2yH3POT8FNyGHPx9RFsr3ScYSO9VXfVhc4NkWsGltUVks+njBCzRx3XdGrisBQPNB00esgpKDJzaIfQjr4Ywes/XpeSSqA0ph4K+89Lqz4FMoI6XNVYS3/aGix+838xQIDAQAB";

	// 服务器异步通知页面路径  需http://格式的完整路径，不能加?id=123这类自定义参数，必须外网可以正常访问
	public static String notify_url = "http://127.0.0.1:8080/storeOnline117/succeedPay.action";

	// 页面跳转同步通知页面路径 需http://格式的完整路径，不能加?id=123这类自定义参数，必须外网可以正常访问
	public static String return_url = "http://127.0.0.1:8080/storeOnline117/succeedPay.action";

	// 签名方式
	public static String sign_type = "RSA2";
	
	// 字符编码格式
	public static String charset = "utf-8";
	
	// 支付宝网关
	public static String gatewayUrl = "https://openapi.alipaydev.com/gateway.do";
	
	// 支付宝网关
	public static String log_path = "C:\\";


//↑↑↑↑↑↑↑↑↑↑请在这里配置您的基本信息↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑

    /** 
     * 写日志，方便测试（看网站需求，也可以改成把记录存入数据库）
     * @param sWord 要写入日志里的文本内容
     */
    public static void logResult(String sWord) {
        FileWriter writer = null;
        try {
            writer = new FileWriter(log_path + "alipay_log_" + System.currentTimeMillis()+".txt");
            writer.write(sWord);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (writer != null) {
                try {
                    writer.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
    }
}

