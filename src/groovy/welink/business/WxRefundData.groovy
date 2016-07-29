package welink.business

import com.tencent.common.Configure
import com.tencent.common.RandomStringGenerator

import java.lang.reflect.Field

/**
 * Created by unescc on 2016/1/19.
 */
class WxRefundData {
    //公众账号ID
    String appid
    //商户号
    String mch_id
    //设备号
    String device_info
    //随机字符串
    String nonce_str
    //签名
    String sign
//    微信订单号	transaction_id	二选一	String(28)	1217752501201407033233368018	微信生成的订单号，在支付通知中有返回
//    商户订单号	out_trade_no	String(32)	1217752501201407033233368018	商户侧传给微信的订单号
    String transaction_id
    //商户退款单号
    String out_refund_no
    //总金额
    int total_fee
    //退款金额
    int refund_fee
    //货币种类
    String refund_fee_type
    //操作员
    String op_user_id

    public WxRefundData() {
        setAppid(Configure.getAppid());
        setMch_id(Configure.getMchid());
        setDevice_info("miku");
        setNonce_str(RandomStringGenerator.getRandomStringByLength(32));
        setOut_refund_no(UUID.randomUUID().toString());
        setRefund_fee_type("CNY");
        setOp_user_id(Configure.getMchid());
    }

    public boolean isAlearyObj(Object obj){
        String[] strArr=['appid','mch_id','device_info','nonce_str','sign','transaction_id','out_refund_no','total_fee','refund_fee','refund_fee_type','op_user_id'];
        boolean  flg=false;
        for(int i=0;i<strArr.length;i++){
            if (strArr[i].equals(obj.toString())){
                flg=true;
                break;
            }
        }
        return flg;
    }

    public Map<String,Object> toMap(){
        Map<String,Object> map = new HashMap<String, Object>();
        Field[] fields = this.getClass().getDeclaredFields();

        for (Field field : fields) {
            Object obj;
            try {
                obj = this.getProperty(field.getName())
                if(obj!=null && isAlearyObj(field.getName())){
                    map.put(field.getName(), obj);
                }
            } catch (IllegalArgumentException e) {
                e.printStackTrace();
            } catch (IllegalAccessException e) {
                e.printStackTrace();
            }
        }
        return map;
    }



    public String getAppid() {
        return appid;
    }
    public void setAppid(String appid) {
        this.appid = appid;
    }
    public String getMch_id() {
        return mch_id;
    }
    public void setMch_id(String mch_id) {
        this.mch_id = mch_id;
    }
    public String getDevice_info() {
        return device_info;
    }
    public void setDevice_info(String device_info) {
        this.device_info = device_info;
    }
    public String getNonce_str() {
        return nonce_str;
    }
    public void setNonce_str(String nonce_str) {
        this.nonce_str = nonce_str;
    }
    public String getSign() {
        return sign;
    }
    public void setSign(String sign) {
        this.sign = sign;
    }
    public String getTransaction_id() {
        return transaction_id;
    }
    public void setTransaction_id(String transaction_id) {
        this.transaction_id = transaction_id;
    }
    public String getOut_refund_no() {
        return out_refund_no;
    }
    public void setOut_refund_no(String out_refund_no) {
        this.out_refund_no = out_refund_no;
    }
    public int getTotal_fee() {
        return total_fee;
    }
    public void setTotal_fee(int total_fee) {
        this.total_fee = total_fee;
    }
    public int getRefund_fee() {
        return refund_fee;
    }
    public void setRefund_fee(int refund_fee) {
        this.refund_fee = refund_fee;
    }
    public String getRefund_fee_type() {
        return refund_fee_type;
    }
    public void setRefund_fee_type(String refund_fee_type) {
        this.refund_fee_type = refund_fee_type;
    }
    public String getOp_user_id() {
        return op_user_id;
    }
    public void setOp_user_id(String op_user_id) {
        this.op_user_id = op_user_id;
    }


}
