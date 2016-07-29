package welink.estate

import grails.orm.PagedResultList
import org.apache.commons.lang3.StringUtils
import org.joda.time.format.DateTimeFormat
import org.joda.time.format.DateTimeFormatter

class CompanyDataController {

    def index() {

        def cd = CompanyData.createCriteria()

        PagedResultList pagedResultList

        DateTimeFormatter formatter = DateTimeFormat.forPattern("yyyy-MM-dd HH:mm")

        String startTime = params.startTime

        String endTime = params.endTime

        Date start = StringUtils.isNotBlank(startTime) ? formatter.parseDateTime(startTime).toDate() : null

        Date end = StringUtils.isNotBlank(endTime) ? formatter.parseDateTime(endTime).toDate() : null

        pagedResultList = cd.list(max: params.max ?: 10, offset: params.offset ?: 0) {
            order('calcuDate', 'desc')
            if (params.communityId) {
                eq('communityId', params.long('communityId'))
            }

            if (start) {
                gt("dateCreated", start)
            }

            if (end) {
                lt("dateCreated", end)
            }
        }

        return [
                total          : pagedResultList?.totalCount,
                params         : params,
                companyDataList: pagedResultList
        ]

    }

    def addUV(){
        if (params.id) {
            CompanyData companyData = CompanyData.findById(params.long('id'))
            if (companyData && params.dailyUv) {
                companyData.dailyUv = params.long('dailyUv')
                if (companyData.save(failOnError: true, flush: true)) {
                    render('true')
                    return
                }
            }
        }
        response.status = 405
    }


    def addPV(){
        if (params.id) {
            CompanyData companyData = CompanyData.findById(params.long('id'))
            if (companyData && params.dailyPv) {
                companyData.dailyPv = params.long('dailyPv')
                if (companyData.save(failOnError: true, flush: true)) {
                    render('true')
                    return
                }
            }
        }
        response.status = 405
    }
}
