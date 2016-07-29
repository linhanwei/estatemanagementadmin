package com.welink.commons.commons;

import com.alibaba.fastjson.JSON;
import org.slf4j.LoggerFactory;

import java.io.IOException;

/**
 * Created by spider on 14/12/2.
 */
public class SMSUtils {
    public static final String APIKEY = "84ce5d237a29ae98b1629c0b177ab95d";

    public static final String URL_WITH_TEMPLATE = "http://yunpian.com/v1/sms/tpl_send.json";

    public static final String URL = "http://yunpian.com/v1/sms/send.json";

    private static org.slf4j.Logger log = LoggerFactory.getLogger(SMSUtils.class);

    private static final long CHECK_NO_TPL = 1;

    private static final long PURCHASE_UP_TPL=605045;//菜价提高模板

    private static final long GENERAL_TPL=608021;//通知模板

    private static final long SMS_TPL = 2;

    public static boolean sendSms(String msg, String mobile) {
        boolean sendResult = false;
        //发送验证码
        String tpl_value = "#purchases#=" + msg;
        //String sr = HttpRequest.sendPost(URL_WITH_TEMPLATE, "apikey="+APIKEY+"&mobile="+mobile+"&tpl_id="+CHECK_NO_TPL+"&tpl_value="+tpl_value);
        String sr = "";
        try {
            sr = JavaSmsApi.tplSendSms(APIKEY, PURCHASE_UP_TPL, tpl_value, mobile);
        } catch (IOException e) {
            log.error("send check code failed. exp:" + e.getMessage());
        }
        SmsResponseTpl responseTpl;
        responseTpl = JSON.parseObject(sr, SmsResponseTpl.class);
        if (responseTpl.getCode() != 0) {//失败
            sendResult = false;
            log.warn("短信息发送失败. mobile:" + mobile + ",reason:" + responseTpl.getMsg());
        } else {
            sendResult = true;
            //cache the code
            log.info("send check code success. mobile:" + mobile);
        }
        return sendResult;
    }

    public static boolean sendGeneralSms(String msg, String mobile) {
        boolean sendResult = false;
        //发送验证码
        String tpl_value = "#messag_in#=" + msg;
        //String sr = HttpRequest.sendPost(URL_WITH_TEMPLATE, "apikey="+APIKEY+"&mobile="+mobile+"&tpl_id="+CHECK_NO_TPL+"&tpl_value="+tpl_value);
        String sr = "";
        try {
            sr = JavaSmsApi.tplSendSms(APIKEY, GENERAL_TPL, tpl_value, mobile);
        } catch (IOException e) {
            log.error("send check code failed. exp:" + e.getMessage());
        }
        SmsResponseTpl responseTpl;
        responseTpl = JSON.parseObject(sr, SmsResponseTpl.class);
        if (responseTpl.getCode() != 0) {//失败
            sendResult = false;
            log.warn("短信息发送失败. mobile:" + mobile + ",reason:" + responseTpl.getMsg());
        } else {
            sendResult = true;
            //cache the code
            log.info("send check code success. mobile:" + mobile);
        }
        return sendResult;
    }



}
