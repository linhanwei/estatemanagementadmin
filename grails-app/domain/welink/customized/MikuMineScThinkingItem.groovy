package welink.customized

//私人定制解决问题的思路表
class MikuMineScThinkingItem {

    Long id

    //问题名称
    String scThinkingName

    //问题简称
    String scThinkingNote

//    针对上述问题的解决思路：
//    1、补水
//    2、补水、淡斑
//    3、补水、美白
//    4、祛黄、提亮
//    5、控油、收缩毛孔
//    6、控油、祛痘
//    7、修复、抗过敏
//    8、褪红、舒缓
//    9、保湿、弹力
//    10、紧致、提拉
//    11、祛黑头、祛粉刺
//    12、眼部祛黑眼圈
//    13、眼部祛细纹
//    14、待扩展
    String scThinkingValue

    //版本号
    Long version

    //创建时间
    Date dateCreated

    //修改时间
    Date lastUpdated

    static mapping = {
        id generator: 'identity'
        version(true)
    }
    static constraints = {

    }
}
