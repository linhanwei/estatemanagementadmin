import org.apache.commons.lang3.StringUtils
import welink.estate.Community
import welink.system.PointInPolygonService


PointInPolygonService pointInPolygonService = ctx.getBean("pointInPolygonService")
List<Community> communities = Community.findAllByStatus(1 as byte)

def point = "120.102289,30.330777"
communities.each {
    Community community ->
        if (StringUtils.isNotBlank(community.deliveryArea)) {

            if (pointInPolygonService.isIn(point, community.deliveryArea)) {
                println "${community.name}"
            }


        }
}