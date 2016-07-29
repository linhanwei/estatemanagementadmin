package welink.warehouse

//极光推送数据表
class MikuMsgPush {
    //    id
    Long id
    //    推送标题
    String msg_title
    //    推送内容
    String msg_content
    //    推送内容类型(目前阶段暂不实现)
    String content_type
    //    拓展键值对
    String extras_content
    //    离线消息保留时长:默认 86400秒 即 1 天，最长 10 天（系统默认5天）
    Byte offline_msg_livetime
    //    推送后极光返回消息ID
    Long jpush_msg_id
    //    安卓首次推送成功数量
    Integer andorid_succ_num
    //    苹果首次推送成功数量
    Integer ios_succ_num

    //    安卓推送成功总数量
    Integer andorid_succ_total_num

    //    苹果推送成功总数量
    Integer ios_succ_total_num

    //    版本号
    Long version
    //    创建的时间
    Date date_created
    //    修改的时间
    Date last_updated

    static mapping = {
        id generator: 'identity'
        version(false)
    }

    static constraints = {
    }
}
