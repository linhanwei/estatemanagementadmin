package welink.common

import grails.transaction.Transactional
import org.apache.commons.codec.digest.DigestUtils

@Transactional
class AlipayRefundService {

    static String partner = "2088101295767275";
    static String key = "geconpb5bh6ols7qtb89n4b9c6cqej3d";
    static String input_charset = "utf-8";
    static String sign_type = "MD5";
    static final String ALIPAY_GATEWAY_NEW = "https://mapi.alipay.com/gateway.do?";

    //进行加密的操作
    def getMD5Content(){

    }


    //进行对企业付款支付宝的操作[进行批量的操作]
    @Transactional
    def insertTransBatch(String ids,Map<String, String> sPara,String lshids){
        String[] idsArr= ids.split("##")
//        String[] lshidsArr= lshids.split("##")
        for (int i=0;i<idsArr.length;i++){
            Long id=Long.parseLong(idsArr[i])
            ProFitGetPay proFitGetPay=ProFitGetPay.findById(id)
            if (proFitGetPay){
//                AlipayBack data=AlipayBack.findByOutTradeNoAndTradeNoAndBodyAndSignType(idsArr[i],"提现分润","MD5")?AlipayBack.findByOutTradeNoAndTradeNoAndBodyAndSignType(idsArr[i],"提现分润","MD5"):new AlipayBack()
                AlipayBack data=AlipayBack.findByOutTradeNo(idsArr[i],"提现分润")?AlipayBack.findByOutTradeNo(idsArr[i],"提现分润"):new AlipayBack()
                data.with {
                    it.paymentType="企业付款"
                    it.tradeNo=proFitGetPay.id
                    it.buyerEmail=proFitGetPay.getpayAccount
                    it.notifyTime=new Date()
                    it.body="提现分润"
                    it.tradeStatus="BATCH_TRANS"
                    it.totalFee=proFitGetPay.getpayFee/100f
                    it.discount=proFitGetPay.getpayFee/100f
                    it.sellerEmail=proFitGetPay.getpayUserName
                    it.price=proFitGetPay.getpayFee/100f
                    it.dateCreated=new Date()
                    it.gmtPayment=new Date()
                    it.useCoupon="N"
                    it.signType="MD5"
                    it.sign=sPara.get("sign")
                    it.isTotalFeeAdjust="N"
                    it.outTradeNo=proFitGetPay.id
                    it.subject="提现分润进行中"
                    it.quantity="1"
                    it.gmtCreate=new Date()
                    it.notifyType="BATCH_TRANS"
                    it.sellerId=proFitGetPay.id
                    it.save(failOnError: true, flush: true)
                }
            }
        }
    }




    //对已加密操作的全参数操作
    @Transactional
    def doAlipayRefundToOneData(Map<String, String> sPara,String tradeId){
        //是否为支付宝订单类型对应的trade
        Trade trade=Trade.findByTradeIdAndPayType(tradeId,3 as byte)
        int falg=0
        if (trade){
            //订单操作在接口操作即可
            //进行对回调表的操作
            AlipayBack alipayBack=AlipayBack.findByTradeNo(trade.alipayNo)
            AlipayBack data=AlipayBack.findByOutTradeNoAndTradeNoAndBodyAndSignType(tradeId,trade.alipayNo,"退款","MD5")?AlipayBack.findByOutTradeNoAndTradeNoAndBodyAndSignType(tradeId,trade.alipayNo,"退款","MD5"):new AlipayBack()
            data.with {
                it.paymentType=alipayBack.paymentType
                it.tradeNo=trade.alipayNo
                it.buyerEmail=alipayBack.buyerEmail
                it.notifyTime=new Date()
                it.body="退款"
                it.tradeStatus="TRADE_REFOUND"
                it.totalFee=alipayBack.totalFee
                it.discount=alipayBack.totalFee
                it.sellerEmail=alipayBack.sellerEmail
                it.price=alipayBack.price
                it.dateCreated=new Date()
                it.gmtPayment=new Date()
                it.useCoupon="N"
                it.signType="MD5"
                it.sign=sPara.get("sign")
                it.isTotalFeeAdjust="N"
                it.sellerId=alipayBack.sellerId
                it.outTradeNo=alipayBack.outTradeNo
                it.subject="退款进行中"
                it.quantity=sPara.get("batch_num")
                it.gmtCreate=new Date()
                it.notifyType=alipayBack.notifyType
                it.save(failOnError: true, flush: true)
            }
            falg=1
        }
        return falg
    }

    //submit的方法
    /**
     * 生成签名结果
     * @param sPara 要签名的数组
     * @return 签名结果字符串
     */
    public static String buildRequestMysign(Map<String, String> sPara) {
        String prestr = createLinkString(sPara); //把数组所有元素，按照“参数=参数值”的模式用“&”字符拼接成字符串
        String mysign = "";
        if(sign_type.equals("MD5") ) {
            mysign = sign(prestr, key, input_charset);
        }
        return mysign;
    }

    /**
     * 生成要请求给支付宝的参数数组
     * @param sParaTemp 请求前的参数数组
     * @return 要请求的参数数组
     */
    private static Map<String, String> buildRequestPara(Map<String, String> sParaTemp) {
        //除去数组中的空值和签名参数
        Map<String, String> sPara = paraFilter(sParaTemp);
        //生成签名结果
        String mysign = buildRequestMysign(sPara);

        //签名结果与签名方式加入请求提交参数组中
        sPara.put("sign", mysign);
        sPara.put("sign_type", sign_type);
        return sPara;
    }

    /**
     * 建立请求，以表单HTML形式构造（默认）
     * @param sParaTemp 请求参数数组
     * @param strMethod 提交方式。两个值可选：post、get
     * @param strButtonName 确认按钮显示文字
     * @return 提交表单HTML文本
     */
    public static String buildRequest(Map<String, String> sParaTemp, String strMethod, String strButtonName) {
        //待请求参数数组
        Map<String, String> sPara = buildRequestPara(sParaTemp);
        List<String> keys = new ArrayList<String>(sPara.keySet());

        StringBuffer sbHtml = new StringBuffer();

        sbHtml.append("<form id=\"alipaysubmit\" name=\"alipaysubmit\" action=\"" + ALIPAY_GATEWAY_NEW
                + "_input_charset=" + input_charset + "\" method=\"" + strMethod
                + "\">");

        for (int i = 0; i < keys.size(); i++) {
            String name = (String) keys.get(i);
            String value = (String) sPara.get(name);

            sbHtml.append("<input type=\"hidden\" name=\"" + name + "\" value=\"" + value + "\"/>");
        }

        //submit按钮控件请不要含有name属性
        sbHtml.append("<input type=\"submit\" value=\"" + strButtonName + "\" style=\"display:none;\"></form>");
        sbHtml.append("<script>document.forms['alipaysubmit'].submit();</script>");
        return sbHtml.toString();
    }



    //MD5的方法
    /**
     * 签名字符串
     * @param text 需要签名的字符串
     * @param key 密钥
     * @param input_charset 编码格式
     * @return 签名结果
     */
    public static String sign(String text, String key, String input_charset) {
        text = text + key;
        return DigestUtils.md5Hex(getContentBytes(text, input_charset));
    }

    /**
     * 签名字符串
     * @param text 需要签名的字符串
     * @param sign 签名结果
     * @param key 密钥
     * @param input_charset 编码格式
     * @return 签名结果
     */
    public static boolean verify(String text, String sign, String key, String input_charset) {
        text = text + key;
        String mysign = DigestUtils.md5Hex(getContentBytes(text, input_charset));
        if(mysign.equals(sign)) {
            return true;
        }
        else {
            return false;
        }
    }

    /**
     * @param content
     * @param charset
     * @return
     * @throws UnsupportedEncodingException
     */
    private static byte[] getContentBytes(String content, String charset) {
        if (charset == null || "".equals(charset)) {
            return content.getBytes();
        }
        try {
            return content.getBytes(charset);
        } catch (UnsupportedEncodingException e) {
            throw new RuntimeException("MD5签名过程中出现错误,指定的编码集不对,您目前指定的编码集是:" + charset);
        }
    }



    //Core的方法
    /**
     * 除去数组中的空值和签名参数
     * @param sArray 签名参数组
     * @return 去掉空值与签名参数后的新签名参数组
     */
    public static Map<String, String> paraFilter(Map<String, String> sArray) {

        Map<String, String> result = new HashMap<String, String>();

        if (sArray == null || sArray.size() <= 0) {
            return result;
        }

        for (String key : sArray.keySet()) {
            String value = sArray.get(key);
            if (value == null || value.equals("") || key.equalsIgnoreCase("sign")
                    || key.equalsIgnoreCase("sign_type")) {
                continue;
            }
            result.put(key, value);
        }

        return result;
    }

    /**
     * 把数组所有元素排序，并按照“参数=参数值”的模式用“&”字符拼接成字符串
     * @param params 需要排序并参与字符拼接的参数组
     * @return 拼接后字符串
     */
    public static String createLinkString(Map<String, String> params) {

        List<String> keys = new ArrayList<String>(params.keySet());
        Collections.sort(keys);

        String prestr = "";

        for (int i = 0; i < keys.size(); i++) {
            String key = keys.get(i);
            String value = params.get(key);

            if (i == keys.size() - 1) {//拼接时，不包括最后一个&字符
                prestr = prestr + key + "=" + value;
            } else {
                prestr = prestr + key + "=" + value + "&";
            }
        }
        return prestr;
    }

}
