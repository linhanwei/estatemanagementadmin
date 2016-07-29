package welink.warehouse

class MikuProvider {
    //供应商的基本信息
    //    id
    Long id
    //    供应商编号
    String code
    //    供应商名称
    String name
    //    供应商简称
    String sname
    //    联系人
    String cperson
    //    职务
    String job
    //    地址
    String address
    //    电话
    String mobile
    //    邮政编码
    String zipcode
    //    电子邮箱
    String email
    //    备注
    String memo
    //    账期
    String accounttime
    //    评价
    String assess
    // 状态[0删除  1显示  2隐藏]
    Byte status = 1 as Byte
    // 创建时间
    Date dateCreated
    // 修改时间
    Date lastUpdated
    //修改人ID
    Long changeId

    //类目Id
    Long clssfiyId

    //是否已经审核  0 为否   1为是
    Byte isCheck =0 as byte


    //新增内容
    //QQ
    String qq
    //发货联系人
    String scontacts
    //售后联系方式
    String scall
    //售后联系人
    String fcontacts
    //发货联系方式
    String fcall





    static mapping = {
        id generator: 'identity'
        version(false)
    }
    static constraints = {
    }
}
