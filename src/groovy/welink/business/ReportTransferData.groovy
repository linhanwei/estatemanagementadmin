package welink.business

import com.tencent.common.Configure
import com.tencent.common.RandomStringGenerator
import com.tencent.common.Signature

import java.lang.reflect.Field

/**
 * Created by unescc on 2016/1/19.
 */
class ReportTransferData {
    String mch_appid;
    String mchid ;
    String device_info ;
    String nonce_str ;
    String sign ;
    String partner_trade_no ;
    String openid ;
    String re_user_name ;
    int amount;
    String desc ;
    String spbill_create_ip ;
    String check_name = "";

    public ReportTransferData() {
        setMch_appid(Configure.getAppid());
        setMchid(Configure.getMchid());
        setDevice_info("miku");
        setNonce_str(RandomStringGenerator.getRandomStringByLength(32));
        setPartner_trade_no(UUID.randomUUID().toString());
        //我们的系统有app的openid与微信公众好的openid【profile_wechat】
//        setOpenid("oKY0xsyug_QMDwFkAkrx06qHfNLo");
//        setAmount(100);
        //NO_CHECK 不校验     OPTION_CHECK:校验
        setCheck_name("NO_CHECK");
//        setDesc("Trade:90945454323");
        setSpbill_create_ip(Configure.getIP());
        //根据API给的签名规则进行签名
//        String sign = Signature.getSign(toMap());
//        setSign(sign);//把签名数据设置到Sign这个属性中
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
                    System.out.println(field.getName()+":"+obj)
                }
            } catch (IllegalArgumentException e) {
                e.printStackTrace();
            } catch (IllegalAccessException e) {
                e.printStackTrace();
            }
        }
        return map;
    }


    public boolean isAlearyObj(Object obj){
        String[] strArr=['mch_appid','mchid','device_info','nonce_str','sign','partner_trade_no','openid','re_user_name','amount','desc','spbill_create_ip','check_name'];
        boolean  flg=false;
        for(int i=0;i<strArr.length;i++){
            if (strArr[i].equals(obj.toString())){
                flg=true;
                break;
            }
        }
        return flg;
    }


    public String getCheck_name() {
        return check_name;
    }

    public void setCheck_name(String check_name) {
        this.check_name = check_name;
    }


    public String getMch_appid() {
        return mch_appid;
    }




    public void setMch_appid(String mch_appid) {
        this.mch_appid = mch_appid;
    }




    public String getMchid() {
        return mchid;
    }




    public void setMchid(String mchid) {
        this.mchid = mchid;
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




    public String getPartner_trade_no() {
        return partner_trade_no;
    }




    public void setPartner_trade_no(String partner_trade_no) {
        this.partner_trade_no = partner_trade_no;
    }




    public String getOpenid() {
        return openid;
    }




    public void setOpenid(String openid) {
        this.openid = openid;
    }




    public String getRe_user_name() {
        return re_user_name;
    }




    public void setRe_user_name(String re_user_name) {
        this.re_user_name = re_user_name;
    }




    public int getAmount() {
        return amount;
    }




    public void setAmount(int amount) {
        this.amount = amount;
    }




    public String getDesc() {
        return desc;
    }




    public void setDesc(String desc) {
        this.desc = desc;
    }




    public String getSpbill_create_ip() {
        return spbill_create_ip;
    }




    public void setSpbill_create_ip(String spbill_create_ip) {
        this.spbill_create_ip = spbill_create_ip;
    }



}
