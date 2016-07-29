package welink.estate

import grails.orm.PagedResultList
import org.apache.commons.lang3.StringUtils
import org.apache.shiro.SecurityUtils
import org.apache.shiro.subject.Subject
import org.joda.time.format.DateTimeFormat
import org.joda.time.format.DateTimeFormatter
import welink.common.DataCalcuService
import welink.user.Employee

class CommunityDataController {

    def index() {

        def communityMap = [:]

        def cd = CommunityData.createCriteria()

        PagedResultList pagedResultList

        DateTimeFormatter formatter = DateTimeFormat.forPattern("yyyy-MM-dd HH:mm")

        String startTime = params.startTime

        String endTime = params.endTime

        Date start = StringUtils.isNotBlank(startTime) ? formatter.parseDateTime(startTime).toDate() : null

        Date end = StringUtils.isNotBlank(endTime) ? formatter.parseDateTime(endTime).toDate() : null

        LinkedList<Community> communityList = Community.createCriteria().list {
            order("id", "asc")
        }

        communityList.iterator().each {
            Community community ->
                communityMap.put(community.id, community)
        }

        Subject currentUser = SecurityUtils.getSubject()
        Employee employee = Employee.findByUsername(currentUser.principal)

        pagedResultList = cd.list(max: params.max ?: 10, offset: params.offset ?: 0) {
            order('calcuDate', 'desc')
            if (params.communityId) {
                eq('communityId', params.long('communityId'))
            }
            if(employee.communityId!=1999L){
                eq('communityId', employee.communityId)
            }
            if (start) {
                gt("calcuDate", start)
            }

            if (end) {
                lt("calcuDate", end)
            }
        }

        return [
                total            : pagedResultList?.totalCount,
                params           : params,
                communityDataList: pagedResultList,
                communityList    : communityList,
                communityMap     : communityMap
        ]

    }
}
