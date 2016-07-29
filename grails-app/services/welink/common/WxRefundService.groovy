package welink.common

import com.tencent.common.Configure
import com.tencent.common.HttpsRequest
import com.tencent.common.MD5
import com.tencent.common.Signature
import grails.transaction.Transactional
import welink.business.ReportTransferData
import welink.business.WxRefundData
import welink.user.ProfileWechat

import java.security.MessageDigest

@Transactional
class WxRefundService {

    public static final String[] hexDigits=["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "a", "b", "c", "d", "e", "f"] as String[]
    //进行基本参数配置项的设置【企业付款】---->丽源堂
    def wxRefundToMoneyConfig(String path) {
        Configure configure=new Configure();
        configure.setAppID("wx82d4b04a531ac1a3");
        configure.setCertPassword("1242526802");
        //configure.setCertLocalPath("D:/cert/apiclient_cert.p12");
        configure.setCertLocalPath(path);
        configure.setIp("121.26.217.212");
        configure.setKey("741cfd9021b2d0e7f4c883027513f153");
        //商务号
        configure.setMchID("1242526802");
        configure.setSubMchID("");
    }

    //进行基本参数配置项的设置【企业付款】---->mikuMine公众号
    def wxRefundToMoneyMikuMineConfig(String path) {
        Configure configure=new Configure();
        configure.setAppID("wx21647f957347c195");
        configure.setCertPassword("1235700302");
        //configure.setCertLocalPath("D:/cert/apiclient_cert.p12");
        configure.setCertLocalPath(path);
        configure.setIp("121.26.217.212");
        configure.setKey("741cfd9021b2d0e7f4c883027513f153");
        //商务号
        configure.setMchID("1235700302");
        configure.setSubMchID("");
    }


    //【企业付款】--->米酷SDP
    def wxgetMoneyMikuSDPConfig(String path){
        Configure configure=new Configure();
        configure.setAppID("wxec8055b78fdb49d4");
        configure.setCertPassword("1323192201");
        configure.setCertLocalPath(path);
        configure.setIp("121.26.217.212");
        configure.setKey("741cfd9021b2d0e7f4c883027513f153");
        //商务号
        configure.setMchID("1323192201");
        configure.setSubMchID("");
    }






    //基本配置的设置【申请退款】【丽源堂】
    def wxRefundConfig(String path){
        Configure configure=new Configure();
        configure.setAppID("wx82d4b04a531ac1a3");
        configure.setCertPassword("1242526802");
        configure.setCertLocalPath(path);
        configure.setKey("741cfd9021b2d0e7f4c883027513f153");
        //商务号
        configure.setMchID("1242526802");
    }


    //基本配置的设置【申请退款】【Miku Mine】
    def wxMikuMineRefundConfig(String path){
        Configure configure=new Configure();
        configure.setAppID("wx21647f957347c195");
        configure.setCertPassword("1235700302");
        configure.setCertLocalPath(path);
        configure.setKey("741cfd9021b2d0e7f4c883027513f153");
        //商务号
        configure.setMchID("1235700302");
    }


    //基本配置的设置【申请退款】【Miku SDP】
    def wxMikuSDPRefundConfig(String path){
        Configure configure=new Configure();
        configure.setAppID("wxec8055b78fdb49d4");
        configure.setCertPassword("1323192201");
        configure.setCertLocalPath(path);
        configure.setKey("741cfd9021b2d0e7f4c883027513f153");
        //商务号
        configure.setMchID("1323192201");
    }






    //基本配置的设置【申请退款】【App miku】
    def mikuwxRefundConfig(String path){
        Configure configure=new Configure();
        configure.setAppID("wxd23a16ff5cb412b9");
        configure.setCertPassword("1270566201");
        configure.setCertLocalPath(path);
        configure.setKey("d22898c75a950fe927a5e1facb90e032");
        //商务号
        configure.setMchID("1270566201");
    }

    //进行基本配置的参数的配置
    def getInfo(String url,ReportTransferData reportTransferData) throws Exception{
        HttpsRequest httpsRequest=new HttpsRequest();
        return httpsRequest.sendPost(url, reportTransferData);
    }

    //退款的操作的基本配置
    def wxRefundToHttp(String url,WxRefundData wxRefundData){
        HttpsRequest httpsRequest=new HttpsRequest();
        return httpsRequest.sendPost(url, wxRefundData);
    }

    def  wxRefundToMoneyToDo(){
        //配置前需要做的事情
        wxRefundToMoneyConfig()
        //传入对应的信息
        ReportTransferData reportTransferData=new ReportTransferData()
        //以下是需要操作对应用户对应微信的OpenId与退款的金额，还有交易号 还有最终的签名
        String url="https://api.mch.weixin.qq.com/mmpaymkttransfers/promotion/transfers";
        String str=getInfo(url, reportTransferData);
        System.out.println(str);
    }


    //进行分润提现-->【企业付款】
    def wxmikugetByWechatProfile(ProfileWechat profileWechat,int num,String path){
        //配置前需要做的事情
//        wxRefundToMoneyConfig(path)
        //米酷公众号
//        wxRefundToMoneyMikuMineConfig(path)
        //米酷SDP
        wxgetMoneyMikuSDPConfig(path)
        //传入对应的信息
        ReportTransferData reportTransferData=new ReportTransferData()
        reportTransferData.setOpenid(profileWechat.openid)
        reportTransferData.setAmount(num)
        String iso="米酷推广奖励提现"
//        reportTransferData.setDesc(new String(iso.getBytes("gbk"),"UTF-8"))
//        reportTransferData.setDesc(new String(iso.getBytes("UTF-8"),"gbk"))
        reportTransferData.setDesc(iso)
        reportTransferData.setSign(getSign(reportTransferData.toMap()))
        String url="https://api.mch.weixin.qq.com/mmpaymkttransfers/promotion/transfers"
        String str=getInfo(url, reportTransferData)
        System.out.println(str);
        return returnInfo(str)
    }



    //进行退款操作--->【申请退款】
    def wxrefundByOneTrade(String path,WeixinBack weixinBack){
        //【丽源堂】测试使用的
//        wxRefundConfig(path)
        //米酷公众号
//        wxMikuMineRefundConfig(path)
        //米酷SDP
        wxMikuSDPRefundConfig(path)
        WxRefundData wxRefundData=new WxRefundData()
        wxRefundData.setTotal_fee(weixinBack.totalFee)
        wxRefundData.setRefund_fee(weixinBack.totalFee)
        wxRefundData.setTransaction_id(weixinBack.transactionId)
        wxRefundData.setSign(Signature.getSign(wxRefundData.toMap()))
        String url="https://api.mch.weixin.qq.com/secapi/pay/refund"
        String str=wxRefundToHttp(url, wxRefundData)
        System.out.println(str);
        return returnInfo(str)
    }

    //进行退款操作--->【申请退款】【miku】
    def mikuwxrefundByOneTrade(String path,WeixinBack weixinBack){
        mikuwxRefundConfig(path)
        WxRefundData wxRefundData=new WxRefundData()
        wxRefundData.setTotal_fee(weixinBack.totalFee)
        wxRefundData.setRefund_fee(weixinBack.totalFee)
        wxRefundData.setTransaction_id(weixinBack.transactionId)
//        wxRefundData.setSign(getSign(wxRefundData.toMap()))
        wxRefundData.setSign(Signature.getSign(wxRefundData.toMap()))
        String url="https://api.mch.weixin.qq.com/secapi/pay/refund"
        String str=wxRefundToHttp(url, wxRefundData)
        System.out.println(str);
        return returnInfo(str)
    }


    //这是退货的时候做付款-->【企业付款】
    def wxRefundToMoneyToDoByWechatProfile(ProfileWechat profileWechat,MikuReturnGoods mikuReturnGoods,String path){
        //配置前需要做的事情
        wxRefundToMoneyConfig(path)
        //传入对应的信息
        ReportTransferData reportTransferData=new ReportTransferData()
        reportTransferData.setOpenid(profileWechat.openid)
        reportTransferData.setAmount(Integer.parseInt(mikuReturnGoods.refundFee.toString()))
        reportTransferData.setDesc(("TradeId:"+mikuReturnGoods.tradeId))
        reportTransferData.setSign(Signature.getSign(reportTransferData.toMap()))
        String url="https://api.mch.weixin.qq.com/mmpaymkttransfers/promotion/transfers"
        String str=getInfo(url, reportTransferData)
        System.out.println(str);
        return returnInfo(str)
    }


    def returnInfo(String str){
        if(getResultCode(str) == "SUCCESS"){
            return "SUCCESS";
        }else{
            int index=str.indexOf("<err_code_des><![CDATA[");
            int endex=str.indexOf("]]></err_code_des>");
            String mycontent=str.substring(index+("<err_code_des><![CDATA[").length(), endex);
            return mycontent;
        }
    }


    def getResultCode(String str){
        int index=str.indexOf("<result_code><![CDATA[");
        int endex=str.indexOf("]]></result_code>");
        String mycontent=str.substring(index+("<result_code><![CDATA[").length(), endex);
        return mycontent;
    }





//

    public static String getSign(Map<String, Object> map) {
        ArrayList list = new ArrayList();
        Iterator size = map.entrySet().iterator();

        while(size.hasNext()) {
            Map.Entry arrayToSort = (Map.Entry)size.next();
            if(arrayToSort.getValue() != "") {
                list.add((String)arrayToSort.getKey() + "=" + arrayToSort.getValue() + "&");
            }
        }
        int var6 = list.size();
        String[] var7 = (String[])list.toArray(new String[var6]);
        Arrays.sort(var7, String.CASE_INSENSITIVE_ORDER);
        StringBuilder sb = new StringBuilder();

        for(int result = 0; result < var6; ++result) {
            sb.append(var7[result]);
        }

        String var8 = sb.toString();
        var8 = var8 + "key=" + Configure.getKey();
        var8 = MD5Encode(var8).toUpperCase();
        return var8;
    }
    public static String MD5Encode(String origin) {
        String resultString = null;
        try {
            MessageDigest e = MessageDigest.getInstance("MD5");
//           resultString = byteArrayToHexString(e.digest(origin.getBytes()));
            //修改部分
            resultString = byteArrayToHexString(e.digest(origin.getBytes("utf-8")));
        } catch (Exception var3) {
            var3.printStackTrace();
        }

        return resultString;
    }
    public static String byteArrayToHexString(byte[] b) {
        StringBuilder resultSb = new StringBuilder();
        byte[] arr$ = b;
        int len$ = b.length;
        for(int i$ = 0; i$ < len$; ++i$) {
            byte aB = arr$[i$];
            resultSb.append(byteToHexString(aB));
        }
        return resultSb.toString();
    }
    private static String byteToHexString(byte b) {
        int n = b;
        if(b < 0) {
            n = 256 + b;
        }
        int d1 = n / 16;
        int d2 = n % 16;
        return hexDigits[d1] + hexDigits[d2];
    }
}
