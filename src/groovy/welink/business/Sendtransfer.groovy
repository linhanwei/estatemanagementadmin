package welink.business

/**
 * Created by unescc on 2016/1/19.
 */
class Sendtransfer {
    //	�����˺�appid	mch_appid	��	wx8888888888888888	String	΢�ŷ���Ĺ����˺�ID����ҵ��corpid��Ϊ��appId��
//	�̻���	mchid	��	1900000109	String(32)	΢��֧��������̻���
//	�豸��	device_info	��	013467007045764	String(32)	΢��֧��������ն��豸��
//	����ַ���	nonce_str	��	5K8264ILTKCH16CQ2502SI8ZNMTM67VS	String(32)	����ַ�����������32λ
//	ǩ��	sign	��	C380BEC2BFD727A4B6845133519F3AD6	String(32)	ǩ�������ǩ���㷨
//	�̻�������	partner_trade_no	��	10000098201411111234567890	String	�̻������ţ��豣��Ψһ��
//	�û�openid	openid	��	oxTWIuGaIt6gTKsQRLau2M0yL16E	String	�̻�appid�£�ĳ�û���openid
//	У���û�����ѡ��	check_name	��	OPTION_CHECK	String	NO_CHECK����У����ʵ����
//	FORCE_CHECK��ǿУ����ʵ������δʵ����֤���û���У��ʧ�ܣ��޷�ת�ˣ�
//	OPTION_CHECK�������ʵ����֤���û���У����ʵ������δʵ����֤�û���У�飬����ת�˳ɹ���
//	�տ��û�����	re_user_name	��ѡ	����	String	�տ��û���ʵ������
//	���check_name����ΪFORCE_CHECK��OPTION_CHECK��������û���ʵ����
//	���	amount	��	10099	int	��ҵ�������λΪ��
//	��ҵ����������Ϣ	desc	��	����	String	��ҵ�������˵����Ϣ�����
//	Ip��ַ	spbill_create_ip	��	192.168.0.1	String(32)	���ýӿڵĻ���Ip��ַ?
    private String mch_appid = "";
    private String mchid = "";
    private String device_info = "";
    private String nonce_str = "";
    private String sign = "";
    private String partner_trade_no = "";
    private String check_name = "";
    private String openid = "";
    private String re_user_name = "";
    private int amount = 0;
    private String desc = "";
    private String spbill_create_ip = "";

    public String getMch_appid() {
        return mch_appid;
    }
    public void setMch_appid(String mch_appid) {
        this.mch_appid = mch_appid;
    }
    public String getCheck_name() {
        return check_name;
    }
    public void setCheck_name(String check_name) {
        this.check_name = check_name;
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
