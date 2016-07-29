package welink.customized

//私人定制可以解决的问题表
class MikuMineScProblemItem {
    // Id
    Long id

    //问题名称
    String scProblemName

    //问题简称
    String scProblemShortName

    String scProblemNote

//    用户需要改善的皮肤问题
//    1、干燥
//    2、色素/斑点
//    3、缺乏光泽/晦暗
//    4、毛孔粗大/油光
//    5、油光/痘痘
//    6、过敏/泛红
//    7、皱纹/细纹
//    8、松弛/衰老
//    9、暗疮/粉刺
//    10、眼部区域-黑眼圈
//    11、眼部区域-细纹
//    12、待扩展
    String scProblemValue

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
