package welink.jgservice

import cn.jpush.api.JPushClient
import cn.jpush.api.common.resp.APIConnectionException
import cn.jpush.api.common.resp.APIRequestException
import cn.jpush.api.push.PushResult
import cn.jpush.api.push.model.Options
import cn.jpush.api.push.model.Platform
import cn.jpush.api.push.model.PushPayload
import cn.jpush.api.push.model.audience.Audience
import cn.jpush.api.push.model.notification.AndroidNotification
import cn.jpush.api.push.model.notification.IosNotification
import cn.jpush.api.push.model.notification.Notification
import cn.jpush.api.report.ReceivedsResult
import com.alibaba.fastjson.JSON
import com.google.common.collect.ImmutableMap
import welink.business.MikuJGpushData
import welink.warehouse.MikuMsgPush
import welink.warehouse.MikuMsgPushService
//app 极光推送
class MikuJGhttpController {

    static def grailsApplication;
//    static  String masterSecret = grailsApplication.config.jpush.masterSecret;
//    static  String appKey = grailsApplication.config.jpush.appKey;
    MikuMsgPushService mikuMsgPushService;

    //定义IOS url跳转类型
    static ImmutableMap<Integer, String> UrlType = ImmutableMap.builder()
            .put(310, "url") //跳转到URL
            .put(311, "detail") //跳转到商品详情
            .put(313, "list") //跳转到商品列表
            .build()

    //跳转的类型
    static ImmutableMap<Integer, String> redirectTypeMap = ImmutableMap.builder() //
            .put(310, "Url")
            .put(311, "商品ID")
//            .put(312, "一级类目ID")
            .put(313, "二级类目ID")
//            .put(314, "积分")
//            .put(315, "优惠劵")
//            .put(316, "品牌id")
//            .put(317, "搜索关键字")
//            .put(318, "众筹首页")
//            .put(319, "众筹项目id")
//            .put(320, "无")
            .build()

    def index() {
        def MikuMsgPush = MikuMsgPush.createCriteria()
        def msgPushList = MikuMsgPush.list(max: params.max ?: 15, offset: params.offset ?: 0){
            order("last_updated", "desc")
        }

        return [
                msgPushList: msgPushList,
                total     : msgPushList.totalCount,
                params    : params,
        ]
    }

//    添加页面
    def addHtml(){

            return [
                'redirectTypeMap':redirectTypeMap
            ]
    }

//    添加
    def addSub(){
            Map<String, Object> data = new HashMap<String, Object>();
            Map<String,MikuJGpushData> json_extras = new HashMap<String, MikuJGpushData>();

            String msgTitle = params.msgTitle;
            String msgContent = params.msgContent;
            int redirectType = params.int('redirectType');
            String target = params.target;
            Byte isSend = params.byte('isSend');
            Byte offlineLiveTime = params.offlineLiveTime;

            MikuJGpushData mikuJGpushData = new MikuJGpushData()

            mikuJGpushData.with {
                it.target=target
                it.redirectType=redirectType
            }

            json_extras.put('banner',mikuJGpushData);
            data.put('msgTitle',msgTitle);
            data.put('msgContent',msgContent);
            data.put('extrasContent',JSON.toJSONString(json_extras));
            data.put('offlineLiveTime',offlineLiveTime);
            data.put('jpushMsgId','');
            data.put('andoridSuccNum','');
            data.put('iosSuccNum','');
            data.put('contentType','');
            data.put('lastUpdated',new Date());

            //推送APP消息
            if(isSend){
                Map<String,String> ios_json_extras = new HashMap<String, String>();
                Map<String,String> all_json_extras = new HashMap<String, String>();

                all_json_extras.put('banner',JSON.toJSONString(mikuJGpushData));
                ios_json_extras.put(UrlType.get(redirectType),target);

                msgPushData.msgTitle = msgTitle;
                msgPushData.msgContent = msgContent;
                msgPushData.all_extras = all_json_extras;
                msgPushData.ios_extras = ios_json_extras;
                msgPushData.offlineLiveTime = offlineLiveTime;

                def msgSendResult = sendMsg(msgPushData);

                if(msgSendResult){
                    data.put('jpushMsgId',msgSendResult.received_list.get(0).msg_id);
                    data.put('andoridSuccNum',msgSendResult.received_list.get(0).android_received);
                    data.put('iosSuccNum',msgSendResult.received_list.get(0).ios_msg_received);
                }

            }

        mikuMsgPushService.addData(data);

            redirect(action: "index");

    }

//    修改页面
    def editHtml(){
        Long id = params.long('id');
        def msgInfo = mikuMsgPushService.getDetail(id);
        def extras_content = JSON.parse(msgInfo.extras_content)

        return [
                'msg_id':id,
                'msgInfo':msgInfo,
                'target':extras_content.banner.target,
                'redirectType':extras_content.banner.redirectType,
                'redirectTypeMap':redirectTypeMap
        ]
    }

//    修改
    def editSub(){
        Map<String, Object> data = new HashMap<String, Object>();
        Map<String,MikuJGpushData> json_extras = new HashMap<String, MikuJGpushData>();

        Long id = params.long('id');
        String msgTitle = params.msgTitle;
        String msgContent = params.msgContent;
        int redirectType = params.int('redirectType');
        String target = params.target;
        Byte isSend = params.isSend;
        Byte offlineLiveTime = params.byte('offlineLiveTime');
        Long msg_id = params.long('msg_id');

        MikuJGpushData mikuJGpushData=new MikuJGpushData();

        mikuJGpushData.with {
            it.target=target
            it.redirectType=redirectType
        }

        json_extras.put('banner',mikuJGpushData);
        data.put('msgTitle',msgTitle);
        data.put('msgContent',msgContent);
        data.put('extrasContent',JSON.toJSONString(json_extras));
        data.put('offlineLiveTime',offlineLiveTime);
        data.put('jpushMsgId','');
        data.put('andoridSuccNum','');
        data.put('iosSuccNum','');
        data.put('contentType','');
        data.put('lastUpdated',new Date());

        //推送APP消息
        if(isSend){
            Map<String, Object> msgPushData = new HashMap<String, Object>();
            Map<String,String> ios_json_extras = new HashMap<String, String>();
            Map<String,String> all_json_extras = new HashMap<String, String>();

            all_json_extras.put('banner',JSON.toJSONString(mikuJGpushData));
            ios_json_extras.put(UrlType.get(redirectType),target);

            msgPushData.msgTitle = msgTitle;
            msgPushData.msgContent = msgContent;
            msgPushData.all_extras = all_json_extras;
            msgPushData.ios_extras = ios_json_extras;
            msgPushData.offlineLiveTime = offlineLiveTime;
            msgPushData.msg_id = msg_id;

            def msgSendResult = sendMsg(msgPushData);

            if(msgSendResult){
                data.put('jpushMsgId',msgSendResult.received_list.get(0).msg_id);
                data.put('andoridSuccNum',msgSendResult.received_list.get(0).android_received);
                data.put('iosSuccNum',msgSendResult.received_list.get(0).ios_apns_sent);
            }

        }

        mikuMsgPushService.editData(id,data);

        redirect(action: "index");

    }

    //删除
    def del(){

    }

    //推送APP消息
    def sendMsg(data){

        JPushClient jpushClient = new JPushClient(grailsApplication.config.jpush.masterSecret,grailsApplication.config.jpush.appKey);

        PushPayload payload = buildPushObject_all_alias_alert(data);
//        PushPayload payload = buildPushObject_android_tag_alertWithTitle(data);

        try {

            PushResult result = jpushClient.sendPush(payload);
            print("Got result - " + result);

            if(result){
                ReceivedsResult recoderResult = jpushClient.getReportReceiveds((String)result.msg_id); //查询推送结果
                return recoderResult;
            }



        } catch (APIConnectionException e) {
            print("Connection error, should retry later", e);
        } catch (APIRequestException e) {

        }
    }

    //推送消息查询结果
    def getSendMsgResult(){
        Map<String, Object> returnData = new HashMap<String, Object>();
        Map<String, Object> returnResult = new HashMap<String, Object>();

        returnData.put('status' ,0);
        returnData.put('msg' ,'刷新失败');
        returnData.put('result' , '');

        Long id = params.long('id');
        String msg_id = params.msg_id;

        if(id == null){
            returnData.put('msg' ,'请选择推送消息');
            render returnData as grails.converters.JSON;
        }

        if(msg_id == null){
            returnData.put('msg' ,'请选择返回推送的消息');
            render returnData as grails.converters.JSON;
        }

        JPushClient jpushClient = new JPushClient(grailsApplication.config.jpush.masterSecret, grailsApplication.config.jpush.appKey);

        try {

            ReceivedsResult msgSendResult = jpushClient.getReportReceiveds(msg_id);

            if(msgSendResult){
                Map<String, Object> data = new HashMap<String, Object>();

                data.put('andoridSuccTotalNum',msgSendResult.received_list.get(0).android_received);
                data.put('iosSuccTotalNum',msgSendResult.received_list.get(0).ios_apns_sent);

                mikuMsgPushService.editData(id,data);

                //返回结果
                returnResult.put('android_received',msgSendResult.received_list.get(0).android_received);
                returnResult.put('ios_received',msgSendResult.received_list.get(0).ios_apns_sent);

                returnData.put('status' ,1);
                returnData.put('msg' ,'刷新成功');
                returnData.put('result' , returnResult);

                render returnData as grails.converters.JSON;
            }

            render returnData as grails.converters.JSON;


        } catch (APIConnectionException e) {
            // Connection error, should retry later


        } catch (APIRequestException e) {
            // Should review the error, and fix the request

        }
    }

    //只发送消息
    def singleSendMsg(){
        Map<String, Object> returnData = new HashMap<String, Object>();  //定义输出数据为对象

        returnData.put('status' ,0);
        returnData.put('msg' ,'发送失败');
        returnData.put('result' , '');

        //获取参数
        Long id = params.long('id');

        if(id == null){
            returnData.put('msg' ,'请选择发送消息');
            render returnData as grails.converters.JSON;  //返回输出json数据
        }

        def msgInfo =  mikuMsgPushService.getDetail(id);

        if(msgInfo){
            def extras_content = JSON.parse(msgInfo.extras_content);
            def target = extras_content.banner.target;
            def redirectType = extras_content.banner.redirectType;

            Map<String, Object> msgPushData = new HashMap<String, Object>();
            Map<String,String> ios_json_extras = new HashMap<String, String>();
            Map<String,String> all_json_extras = new HashMap<String, String>();
            MikuJGpushData mikuJGpushData=new MikuJGpushData();

            mikuJGpushData.with {
                it.target=target
                it.redirectType=redirectType
            }

            all_json_extras.put('banner',JSON.toJSONString(mikuJGpushData));
            ios_json_extras.put(UrlType.get(redirectType),target);

            msgPushData.msgTitle = msgInfo.msg_title;
            msgPushData.msgContent = msgInfo.msg_content;
            msgPushData.all_extras = all_json_extras;
            msgPushData.ios_extras = ios_json_extras;
            msgPushData.offlineLiveTime = msgInfo.offline_msg_livetime;

            def msgSendResult = sendMsg(msgPushData);

            if(msgSendResult){
                Map<String, Object> data = new HashMap<String, Object>();

                data.put('jpushMsgId',msgSendResult.received_list.get(0).msg_id);
                data.put('andoridSuccNum',msgSendResult.received_list.get(0).android_received);
                data.put('iosSuccNum',msgSendResult.received_list.get(0).ios_apns_sent);

                mikuMsgPushService.editData(id,data);
            }

            returnData.put('status' ,1);
            returnData.put('msg' ,'发送成功');
            returnData.put('result' , msgSendResult.received_list.get(0).msg_id);
            render returnData as grails.converters.JSON;  //返回输出json数据
        }


        render returnData as grails.converters.JSON;  //返回输出json数据

    }

    //推送所有设备
    public static PushPayload buildPushObject_all_alias_alert(data) {
        String msg_title = data.msgTitle;
        String msg_content = data.msgContent;
        Long msg_id = data.msg_id ? data.msg_id : 0;
        Long time_to_live = data.offlineLiveTime*24*60*60;
        def all_extras = data.all_extras;
        def ios_extras = data.ios_extras;
        def ios_environment = true; //ios选择推送环境: true:生产环境,false:测试环境

        if(msg_id > 0){
            return PushPayload.newBuilder()
                    .setPlatform(Platform.all())
                    .setAudience(Audience.all())
                    .setNotification(Notification.newBuilder()
                        .setAlert(msg_content)
                        .addPlatformNotification((AndroidNotification.newBuilder()
                            .setAlert(msg_content)
                            .setTitle(msg_title)
                            .addExtras(all_extras))
                            .build())
                        .addPlatformNotification(IosNotification.newBuilder()
                            .setAlert(msg_content)
                            .setBadge(1)
                            .addExtras(ios_extras)
                            .build())
                        .build())
                    .setOptions(Options.newBuilder()
                        .setApnsProduction(ios_environment)
                        .setTimeToLive(time_to_live)
                        .setOverrideMsgId(msg_id)
                        .build())
                    .build();
        }else{
            return PushPayload.newBuilder()
                    .setPlatform(Platform.all())
                    .setAudience(Audience.all())
                    .setNotification(Notification.newBuilder()
                                .addPlatformNotification((AndroidNotification.newBuilder()
                                .setAlert(msg_content)
                                .setTitle(msg_title)
                                .addExtras(all_extras))
                                .build())
                            .addPlatformNotification(IosNotification.newBuilder()
                                .setAlert(msg_content)
                                .setBadge(1)
                                .addExtras(ios_extras)
                                .build())
                        .build())
                    .setOptions(Options.newBuilder()
                        .setApnsProduction(ios_environment)
                        .setTimeToLive(time_to_live)
                        .build())
                    .build();
        }

    }

    //android 推送
    public static PushPayload buildPushObject_android_tag_alertWithTitle(data) {
        String msg_title = data.msgTitle;
        String msg_content = data.msgContent;
        Long msg_id = data.msg_id ? data.msg_id : 0;
        Long time_to_live = data.offlineLiveTime*24*60*60;
        def extras = data.all_extras;

        if(msg_id > 0){
            return PushPayload.newBuilder()
                    .setPlatform(Platform.android())
                    .setAudience(Audience.all())
                    .setNotification(Notification.android(msg_title,msg_content,extras))
                    .setOptions(Options.newBuilder()
                                    .setOverrideMsgId(msg_id)
                                    .setTimeToLive(time_to_live)
                                    .build())
                    .build();
        }else{
            return PushPayload.newBuilder()
                    .setPlatform(Platform.android())
                    .setAudience(Audience.all())
                    .setNotification(Notification.android(msg_title,msg_content,extras))
                    .setOptions(Options.newBuilder()
                                .setTimeToLive(time_to_live)
                                .build())
                    .build();
        }

    }

    //IOS 推送
    public static PushPayload buildPushObject_ios_tagAnd_alertWithExtrasAndMessage(data) {

        String msg_content = data.msgContent;
//        Long msg_id = data.msg_id ? data.msg_id : 0;
        Long time_to_live = data.offlineLiveTime*24*60*60;
//        def all_extras = data.all_extras;
        def ios_extras = data.ios_extras;
        def ios_environment = false; //ios选择推送环境: true:生产环境,false:测试环境

        return PushPayload.newBuilder()
                .setPlatform(Platform.ios())
                .setAudience(Audience.all())
                .setNotification(Notification.newBuilder()
                                .addPlatformNotification(IosNotification.newBuilder()
                                                        .setAlert(msg_content)
//                                                        .setBadge(5)  //角度
//                                                        .setSound("happy.caf")  //声音
                                                        .addExtras(ios_extras)
                                                        .build())
                                .build())
                .setOptions(Options.newBuilder()
                            .setApnsProduction(ios_environment)  //推送环境: true:为生成环境,false:为测试环境
                            .setTimeToLive(time_to_live)
                            .build())
                .build();
    }


}
