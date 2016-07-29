package welink.customized

//私人定制多媒体表
class MikuMineMultimediaRes {

    Long id

//    定制类型：
//    0、不限
//    1、护肤定制类
//    2、私密护理类
//    3、减肥定制类
//    4、脱发定制类
//    5、待扩展
    Byte mineType

//    资源类型：
//    1、资源
//    2、音频
//    3、图片
//    4、待扩展
    Byte resType

    //该步骤中使用的资源
    String resName

    //资源名缩写
    String resShortName

    //资源在云片上的url
    String resUrl

    //资源时长 单位秒
    Long resTime

    //资源使用提示
    String  resUseRemind

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
        resUrl(maxSize:2500)
    }
}
