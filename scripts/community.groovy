import org.apache.commons.lang.builder.ToStringBuilder
import welink.estate.Community
import welink.system.LbsStationBaiduMapService

LbsStationBaiduMapService lbsStationBaiduMapService = ctx.getBean("lbsStationBaiduMapService")

Community.findAll().each {
    Community community ->

        println grailsApplication.config.amap.rest_key
        def tableCreateResult = lbsStationBaiduMapService.createCommunityCloudMap(community)

        println ToStringBuilder.reflectionToString(tableCreateResult)

}

