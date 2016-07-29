package welink.estate

class ItemAtHalf {

    Long id

    Long itemId

    //半价日期
    Date announceTime

    //活动价格
    Long activityPrice

    //本次限量库存
    Long inventory

    //购买数量
    Integer limitNum

    //开始时间
    Date startTime

    //结束时间
    Date endTime

    //Bannerd的Id
    Long bannerId

    //1114未开始，1115进行中，1116已结束
    Integer activeStatus

    //有效1，无效0
    Byte status

    Date lastUpdated

    Date dateCreated

    static constraints = {
    }
}
