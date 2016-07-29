package welink.common

class MikuViewConnectInfo {

    Long id
    //与配置页面关联
    Long viewId
    //版本
    Long version=0L
    //关联信息说明
    String info
    //页面一级模块状态标示状态状态(0删除  1隐藏  2显示)
    Byte oneLevelStatus
    //页面二级模块状态标示状态(0删除  1隐藏  2显示)
    Byte twoLevelStatus
    //名称
    String name
    //页面的一级模块id
    Long oneLevelId
    //页面的二级模块id
    Long twoLevelId
    //类型(418, "顶部活动位"    419, "类目入口"      420, "品牌入口"    421, "活动专区"  422, "秒杀专区"    423, "商品专区")
    Long type
    //一级模块添加内容标示(0 类型内容与其无关  1 一级模块新添加的内容)
    Byte oneLevelFlag
    //修改时间
    Date time
    //还有一个顺序的操作
    Long weight=0L



    static mapping = {
        table('miku_view_connect_info')
        id generator: 'identity'
    }
}
