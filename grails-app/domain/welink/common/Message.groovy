package welink.common

class Message {
    Long id

    Long employerId

    // 	小区IDs
    String communityIds

    //标题
    String title

    //短信消息
    String messageContent

    //客户端消息
    String appContent

    //推送消息
    String pushContent

    //发送量
    String count

    //1表示已推送，0表示未推送
    byte status

    //发送时间
    Date sendTime

    Date lastUpdated

    Date dateCreated

    static constraints = {
    }

    static mapping = {
        id generator: 'identity'
        version(true)
    }
}
