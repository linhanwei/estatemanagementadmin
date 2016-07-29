package welink.common

class MikuCrowdfundDetail {
    Long id
    //众筹id
    Long crowdfundId
    //商品id
    Long itemId
    //支持数
    Integer soldNum
    //版本
    Long version
    //创建时间
    Date dateCreated
    //更新时间
    Date lastUpdated
    //回报内容 return_content
    String returnContent
    //风险提示 risk_tips
    String riskTips
    //特别说明 special_note
    String specialNote

    //状态[显示  隐藏  删除]--->[1  0  -1]
    Byte approveStatus


    static constraints = {
    }
    static mapping = {
        id generator: 'identity'
    }
}
