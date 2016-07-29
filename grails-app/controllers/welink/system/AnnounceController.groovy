package welink.system

import grails.orm.PagedResultList
import org.apache.commons.lang.StringUtils
import org.slf4j.Logger
import org.slf4j.LoggerFactory
import welink.common.Announce

import java.util.concurrent.ExecutorService
import java.util.concurrent.Executors

class AnnounceController {

    static Logger logger = LoggerFactory.getLogger(AnnounceController)

    ExecutorService executorService = Executors.newFixedThreadPool(4)


    def index() {}

    //公告删除，将announce的状态(status)改为无效(0)
    def deleteAnnounce() {

        Announce announce = Announce.findByCommunityIdAndId(199L, params.long('announceId'))

        announce.status = 0

        announce.save(failOnError: true, flush: true)

        queryCommunityAnnounce()

    }

    //查询当前小区有效的公告
    def queryCommunityAnnounce() {

        def c = Announce.createCriteria()

        PagedResultList pagedResultList = c.list(max: params.max ?: 10, offset: params.offset ?: 0) {
            eq("communityId", 199L)
            order("id", "desc")
            eq('status', 1)
        }

        pagedResultList.iterator().each {
            Announce announce ->

                if (announce.title.length() > 10) {
                    announce.title = StringUtils.substring(announce.title, 0, 10) + "..."
                }

                if (announce.contentTxt.length() > 10) {
                    announce.contentTxt = StringUtils.substring(announce.contentTxt, 0, 10) + "..."
                }
        }


        render(template: "announceList", model: [
                announceRecords: pagedResultList,
                total          : pagedResultList.totalCount

        ])


    }

    //增加小区公告
    def createCommunityAnnounce() {


        Announce announce = (params?.announceId) ? Announce.findById(params.long('announceId')) : new Announce()
        announce.communityId = 199
        announce.title = params.title
        announce.content = params.addContentHtml
        announce.contentTxt = params.addContentTxt
        announce.status = 1
        announce.publisher = 'wc'

        executorService.execute(new Runnable() {
            @Override
            void run() {
                messagePushService.pushAnnounceMessage(announce)
            }
        })


        announce.save(failOnError: true, flush: true)

    }

    //查看指定ID的公告详细信息
    def lookAnnounceInfoHTML() {

        Announce announce = Announce.findById(params.long('announceId'))
        render(template: 'announceInfo', model: ['announce': announce])

    }
}
