package welink.estate

import grails.orm.PagedResultList
import grails.transaction.Transactional
import org.joda.time.DateTime
import org.joda.time.format.DateTimeFormat
import org.joda.time.format.DateTimeFormatter
import welink.business.ActivityDetail
import welink.common.Item

class ItemAtHalfController {
    def itemCopyTaskService

    def deleteActivity() {
        if (params.id) {
            ItemAtHalf itemAtHalf = ItemAtHalf.findById(params.long('id'))
            if (itemAtHalf) {
                itemAtHalf.status = 0
                if (itemAtHalf.save(failOnError: true, flush: true)) {
                    render('true')
                    return
                }
            }
        }
        response.status = 405
    }

    def addActivityHtml() {
        return [

        ]
    }


    def addActivity() {

        DateTimeFormatter formatter = DateTimeFormat.forPattern("yyyy-MM-dd HH:mm")

        withForm {

            if (params.startTime) {

                Long itemId = params.long('itemId')

                Integer limitNum = params.int('limitNum')

                Integer weight = params.int('weight')?:0

                Long activityPrice = new BigDecimal(params.activityPrice) * 100L

                Long bannerId = params.long('bannerId')

                DateTime startTime = formatter.parseDateTime(params.startTime)

                DateTime announceTime = formatter.parseDateTime(params.startTime)

                DateTime endTime = formatter.parseDateTime(params.endTime)

                ItemAtHalf itemAtHalf = new ItemAtHalf()

                itemAtHalf.with {
                    it.inventory=10000
                    it.activityPrice = activityPrice
                    it.itemId = itemId
                    it.announceTime = announceTime.toDate()
                    it.limitNum = limitNum
                    it.bannerId = bannerId
                    it.startTime = startTime.toDate()
                    it.endTime = endTime.toDate()
                    it.status = 1 as byte
                    it.activeStatus = 0 as Integer
                    save(failOnError: true, flush: true)
                }

                def tjmap = [:]

                tjmap.put('tjWeight', weight)
                String tjKv = com.alibaba.fastjson.JSON.toJSONString(tjmap)

                //打特价标
                new ObjectTagged().with {
                    it.kv = tjKv
                    it.artificialId = itemId
                    it.tagId = Tags.findByBit(2L)?.id
                    it.startTime = startTime.toDate()
                    it.endTime = endTime.toDate()
                    it.status = 1 as byte
                    it.type = Tags.findByBit(2L)?.type
                    it.save(failOnError: true, flush: true)
                }

                def limitmap = [:]

                limitmap.put('xgLimitNum', limitNum)
                String limitKv = com.alibaba.fastjson.JSON.toJSONString(limitmap)

                //打限购标
                new ObjectTagged().with {
                    it.kv = limitKv
                    it.artificialId = itemId
                    it.tagId = Tags.findByBit(1L)?.id
                    it.startTime = startTime.toDate()
                    it.endTime = endTime.toDate()
                    it.status = 1 as byte
                    it.type = Tags.findByBit(1L)?.type
                    it.save(failOnError: true, flush: true)
                }

                //商品的同步逻辑需要去实现,半价活动强同步
                itemCopyTaskService.pushItemToAllStation(Item.findById(itemId), true)

            }

            redirect(controller: 'itemAtHalf', action: 'index')
            return;
        }.invalidToken {
            // bad request
            response.status = 405
        }

    }

    def startActivity() {

        if (params.id) {
            ItemAtHalf itemAtHalf = ItemAtHalf.findById(params.long('id'))
            if (itemAtHalf) {
                itemAtHalf.activeStatus = 15 as Integer
                if (itemAtHalf.save(failOnError: true, flush: true)) {
                    render('true')
                    return
                }
            }
        }
        response.status = 405

    }

    def index() {

        def activityMap = [:]

        def i = ItemAtHalf.createCriteria()

        PagedResultList pagedResultList = i.list(max: params.max ?: 10, offset: params.offset ?: 0) {
            eq('status', 1 as byte)
            if (params.announceTime) {
                DateTimeFormatter announceFormat = DateTimeFormat.forPattern("yyyy-MM-dd")
                DateTime announceTime = announceFormat.parseDateTime(params.announceTime)
                eq('announceTime', announceTime.toDate())
            }
            order("announceTime", "desc")
            order("startTime", "desc")
        }

        pagedResultList.iterator().each {
            ItemAtHalf itemAtHalf ->
                activityMap.put(itemAtHalf?.id, new ActivityDetail(
                        inventory: itemAtHalf?.inventory,
                        activityPrice: itemAtHalf?.activityPrice / 100f,
                        itemId: itemAtHalf?.itemId,
                        itemName: Item.findById(itemAtHalf?.itemId)?.title,
                        announceTime: itemAtHalf.announceTime.toString().substring(0, 11),
                        limitNum: itemAtHalf?.limitNum,
                        startTime: itemAtHalf?.startTime.toString().substring(0, 16),
                        endTime: itemAtHalf?.endTime.toString().substring(0, 16),
                        bannerId: itemAtHalf.bannerId,
                        bannerPicUrls: Banner.findById(itemAtHalf?.bannerId)?.picUrl
                ))
        }

        return [
                activityMap : activityMap,
                activityList: pagedResultList,
                total       : pagedResultList.totalCount,
                params      : params,
        ]
    }

}
