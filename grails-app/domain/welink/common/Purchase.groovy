package welink.common

class Purchase {

    Long id

    //商品表ID
    Long itemId

    //商品名称
    String title

    //规格名称
    String specification

    //产地
    String source

    //数量
    String number

    //类目名称
    String categoryName

    //规格数量
    Long specNum

    //进价
    Long price

    //斤价=price/specNum
    Long unitPrice

    //昨天价格
    Long yesterdayPrice

    //参考价、小美价
    Long referencePrice

    //备注
    String memo

    //是否被拍
    byte pictured

    //价格变动标识。-1表示跌价，1表示涨价，0表示不变
    byte variation

    //1表示有效，0表示无效
    byte status

    Date lastUpdated

    Date dateCreated

    static constraints = {

    }

    static mapping = {
        id generator: 'identity'
        version(true)
    }
}
