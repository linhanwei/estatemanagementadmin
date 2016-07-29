package welink.complain

import grails.orm.PagedResultList
import org.apache.shiro.SecurityUtils
import org.apache.shiro.subject.Subject
import org.slf4j.Logger
import org.slf4j.LoggerFactory
import welink.user.Employee
import welink.user.Profile

import java.text.SimpleDateFormat

class ComplainController {

    static Logger logger = LoggerFactory.getLogger(ComplainController)


    SimpleDateFormat simple = new SimpleDateFormat("yyyy-MM-dd HH:mm")

    def index() {

    }

    //完结处理中
    def finishComplainInHand() {

        Complain complain = Complain.findById(params.long('complainId'))
        complain.status = 3
        complain.save(failOnError: true, flush: true)
        queryInHandComplain()
    }

    //查询所有处理中的投诉
    def queryInHandComplain() {

        def c = Complain.createCriteria()

        PagedResultList result = c.list(max: params.max ?: 10, offset: params.offset ?: 0) {
            eq("status", 2 as byte)
            order('dateCreated', 'desc')
        }

        def profileMobileMap = [:]
        result.iterator().each() {
            Complain complain ->
                Profile profile = Profile.findById(complain.profileId)
                profileMobileMap.put(complain.id, profile.mobile)
        }

        render(template: "inHandComplain", model: [

                complainList    : result,

                profileMobileMap: profileMobileMap,

                total           : result.totalCount,

                params          : params
        ])
    }

    //处理投诉，增加他的note
    def dealComplain() {

        Subject currentUser = SecurityUtils.getSubject()

        Employee employee = Employee.findByUsername(currentUser.principal)

        Complain complain = Complain.findById(params.long('currentComplain'))

        if (complain.status == 1) {
            complain.status = 2
            complain.save(failOnError: true, flush: true)
        }

        ComplainDealNotes note = new ComplainDealNotes(complainId: complain?.id, replyerId: employee?.id, replyerType: 2, dealContent: params.dealcontent, status: 1)

        note.dateCreate = new Date()

        note.save(failOnError: true, flush: true)

        render(view: '_inHandComplain')
    }

    //完结某一投诉
    def finishComplain() {

        Complain complain = Complain.findById(params.long('complainId'))
        complain.status = 3
        complain.save(failOnError: true, flush: true)
        queryComplainList()

    }

    //查询某个Complain的详细信息
    def dealComplainHtml() {

        def complainId = params.long('complainId')

        Complain currentComplain = Complain.findById(complainId)

        LinkedList<ComplainDealNotes> notes = ComplainDealNotes.findAllByComplainId(complainId)

        def replyerMap = [:]

        notes.iterator().each() {

            ComplainDealNotes complainDealNotes ->

                if (complainDealNotes.replyerType == 1) {

                    LinkedList<String> replyerInfo = new LinkedList<String>()

                    def replyer = Profile.findById(currentComplain.profileId)

                    replyerInfo.add(0, '用户')

                    replyerInfo.add(1, replyer?.mobile)

                    replyerMap.put(complainDealNotes.id, replyerInfo)

                } else {

                    LinkedList<String> replyerInfo = new LinkedList<String>()

                    def replyer = Employee.findById(complainDealNotes.replyerId)

                    replyerInfo.add(0, replyer?.id + '/' + replyer?.name)

                    replyerInfo.add(1, replyer?.mobile)

                    replyerMap.put(complainDealNotes.id, replyerInfo)

                }
        }

        render(template: 'complainDetails', model: [

                total          : notes.size(),

                notes          : notes,

                currentComplain: currentComplain,

                replayerMap    : replyerMap

        ])
    }

    //插入新增投诉
    def addComplain() {

        String complainMobile = params.mobile

        complainMobile = complainMobile.replace('-', '')

        Profile profile = Profile.findByMobile(complainMobile)

        def content = params.complainContent

        def title = params.complainTitle

        new Complain(title: title, buildingId: -1, profileId: profile.id, content: content, communityId: -1, status: 1).save(failOnError: true)

        render(view: 'index')
    }

    //查询所有符合条件的待处理的投诉
    def queryComplainList() {

        def c = Complain.createCriteria()

        PagedResultList result = c.list(max: params.max ?: 10, offset: params.offset ?: 0) {
            eq("status", 1 as byte)
            order('dateCreated', 'desc')
        }

        def profileMobileMap = [:]
        result.iterator().each() {
            Complain complain ->
                Profile profile = Profile.findById(complain.profileId)

                profileMobileMap.put(complain?.id, profile?.mobile)
        }

        render(template: "waitDeal", model: [

                complainList    : result,

                profileMobileMap: profileMobileMap,

                total           : result.totalCount,

                params          : params
        ])
    }

    //查询所有符合条件的已完成的投诉
    def queryFinishComplainList() {

        def c = Complain.createCriteria()

        PagedResultList result = c.list(max: params.max ?: 10, offset: params.offset ?: 0) {
            eq("status", 3 as byte)
            order('dateCreated', 'desc')
        }

        def profileMobileMap = [:]
        result.iterator().each() {
            Complain complain ->
                Profile profile = Profile.findById(complain.profileId)
                profileMobileMap.put(complain.id, profile.mobile)
        }

        render(template: "finishComplain", model: [

                complainList    : result,

                profileMobileMap: profileMobileMap,

                total           : result.totalCount,

                params          : params
        ])
    }

}
