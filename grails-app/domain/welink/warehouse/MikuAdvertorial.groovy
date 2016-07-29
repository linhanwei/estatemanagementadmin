package welink.warehouse

class MikuAdvertorial {

    Long id
    //标题，界面红色字体显示
    String advertorialTile
    //软文类型：
    //1、单品
    //2、拼团
    //3、满减
    //4、xxxx
    Byte advertorialType
    //文章标题
    String articleTile
    //文字内容
    String articleContent
    //图片
    String pics
    //mall_resource_url
    String mallResourceUrl
    //推广奖励
    String salesReward
    //录入者
    Long createrId
    //版本
    Long version=0
    //记录时间
    Date dateCreated
    //更新时间
    Date lastUpdated

    //是否有效
    Byte status=1 as byte
    //是否删除
    Byte isDelete=0 as byte

    //跳转类型，url-1,商品ID-2
    Integer redirectType

    //海报大图
    String posterPicUrl

    //海报中呈现的产品
    String posterProductPicUrl

    static mapping = {
        id generator: 'identity'
    }


    static constraints = {
    }
}
