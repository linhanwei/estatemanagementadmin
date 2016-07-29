package welink.warehouse

import grails.transaction.Transactional

@Transactional
class MikuMsgPushService {

//    static  DateTimeFormatter formatter = DateTimeFormat.forPattern("yyyy-MM-dd HH:mm")

    //根据消息ID查询
    def getDetail(Long msg_id){
        def info = [];

        if(msg_id){
            info = MikuMsgPush.findById(msg_id);
        }

        return info;
    }

    //添加
    @Transactional
    def addData(data){
        MikuMsgPush mikuMsgPush = new MikuMsgPush();

        mikuMsgPush.with {

            if(data.msgTitle){
                it.msg_title = data.msgTitle

            }

            if(data.msgContent){
                it.msg_content = data.msgContent

            }

            if(data.extrasContent){
                it.extras_content = data.extrasContent

            }

            if(data.offlineLiveTime){
                it.offline_msg_livetime = data.offlineLiveTime
            }
            if (data.andoridSuccNum){
                it.andorid_succ_total_num = data.andoridSuccTotalNum

            }

            if (data.iosSuccNum){
                it.ios_succ_total_num = data.iosSuccTotalNum
            }
            it.jpush_msg_id = data.jpushMsgId ? data.jpushMsgId : 0;
            it.andorid_succ_num = data.andoridSuccNum ? data.andoridSuccNum : 0;
            it.ios_succ_num = data.iosSuccNum ? data.iosSuccNum : 0;
            it.andorid_succ_total_num = data.andoridSuccTotalNum ? data.andoridSuccTotalNum : 0;
            it.ios_succ_total_num = data.iosSuccTotalNum ? data.iosSuccTotalNum : 0;
            it.version = data.version ? data.version : 1;

            if(data.lastUpdated){
                it.last_updated = data.lastUpdated
                it.date_created = data.lastUpdated
            }

            if(data.contentType){
                it.content_type = data.contentType
            }

            it.save(failOnError: true, flush: true)
        }
    }

    //添加或者更改
    @Transactional
    def editData(Long id,data){

        MikuMsgPush mikuMsgPush = MikuMsgPush.findById(id)

        mikuMsgPush.with {

            if(data.msgTitle){
                it.msg_title = data.msgTitle

            }

            if(data.msgContent){
                it.msg_content = data.msgContent

            }

            if(data.extrasContent){
                it.extras_content = data.extrasContent

            }

            if(data.offlineLiveTime){
                it.offline_msg_livetime = data.offlineLiveTime
            }

            if(data.jpushMsgId){
                it.jpush_msg_id = data.jpushMsgId

            }

            if (data.andoridSuccNum){
                it.andorid_succ_num = data.andoridSuccNum

            }

            if (data.iosSuccNum){
                it.ios_succ_num = data.iosSuccNum
            }

            if (data.andoridSuccTotalNum){
                it.andorid_succ_total_num = data.andoridSuccTotalNum

            }

            if (data.iosSuccTotalNum){
                it.ios_succ_total_num = data.iosSuccTotalNum
            }

            if(data.lastUpdated){
                it.last_updated = data.lastUpdated
            }

            if(data.contentType){
               it.content_type = data.contentType
            }

            it.save(failOnError: true, flush: true)
        }
    }

    //发送消息
    @Transactional
    def sendMsg(){

    }

    //删除
    def delData(){

    }
}
