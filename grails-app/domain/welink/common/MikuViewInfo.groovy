package welink.common

class MikuViewInfo {

    Long id
    //版本
    Long version=0L
    //页面说明
    String info
    //状态(0未删除状态 1为有效状态)
    Byte status
    //其他的说明
    String otherinfo
    //页面名称
    String name

    static mapping = {
        table('miku_view_info')
        id generator: 'identity'
    }
}
