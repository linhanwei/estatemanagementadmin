package welink.estate

class UserInteractionRecords {
    Long id

    Long userId

    Integer type

    Integer from

    Integer value

    String targetId

    String destination

    Byte status

    //创建时间
    Date dateCreated
    //最后修改时间
    Date lastUpdated

    static constraints = {
    }
}
