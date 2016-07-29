package welink.common

class MikuAgencyLevel {

    Long id

    Long version

    String levelName

    String memo

    Long creatorId

    Integer weight

    Date dateCreated

    Date lastUpdated

    Byte isDeleted

    static mapping = {
        table('miku_agency_level')
        id generator: 'identity'
        version(false)
    }
}
