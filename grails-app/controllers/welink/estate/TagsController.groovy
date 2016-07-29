package welink.estate

import com.google.common.collect.ImmutableMap
import com.google.common.collect.Lists
import grails.orm.PagedResultList
import grails.transaction.Transactional
import org.apache.commons.lang3.StringUtils

class TagsController {

    //类型,1000商品展示，1001逻辑处理
    static ImmutableMap<Integer, String> typeMap = ImmutableMap.builder() //
            .put(1000, "商品展示")
            .put(1001, "逻辑处理")
            .build()

    def addTagsHtml() {
        return [
                typeMap: typeMap
        ]
    }

    def modifyweight() {
        if (params.id) {
            Tags tags = Tags.findById(params.long('id'))
            if (tags && params.newWeight) {
                tags.weight = params.int('newWeight')
                if (tags.save(failOnError: true, flush: true)) {
                    render('true')
                    return
                }
            }
        }
        response.status = 405
    }

    def index() {

        def t = Tags.createCriteria()

        PagedResultList pagedResultList = t.list(max: params.max ?: 10, offset: params.offset ?: 0) {
            order('status', "desc")
            order('weight', "asc")
            ne('status', 0 as byte)
            if(params.query){
                ilike("name", "%" + params.query + "%")
            }
            if (params.bit) {
                eq('bit', params.long('bit'))
            }
        }

        return [
                typeMap: typeMap,
                tagList: pagedResultList,
                total  : pagedResultList.totalCount,
                params : params,
        ]
    }

    def deleteTag() {
        if (params.id) {
            Tags tags = Tags.findById(params.long('id'))
            if (tags) {
                tags.status = 0 as byte
                if (tags.save(failOnError: true, flush: true)) {
                    render('true')
                    return
                }
            }
        }
        response.status = 405
    }

    def showTag() {
        if (params.id) {
            Tags tags = Tags.findById(params.long('id'))
            if (tags) {
                tags.status = 2 as byte
                if (tags.save(failOnError: true, flush: true)) {
                    render('true')
                    return
                }
            }
        }
        response.status = 405
    }

    def hideTag() {
        if (params.id) {
            Tags tags = Tags.findById(params.long('id'))
            if (tags) {
                tags.status = 1 as byte
                if (tags.save(failOnError: true, flush: true)) {
                    render('true')
                    return
                }
            }
        }
        response.status = 405
    }

    //单单是添加一个新标【注意的是状态，weight排序问题，status状态值(0,1,2)】
    def addTag() {

        withForm {
            String name = params.name
            Long bit = params.long('bit')
            List<String> pics = params.'item-pic' ? Lists.newArrayList(params.'item-pic') : Collections.emptyList()
            Integer weight = params.int('weight')
            Integer type = params.int('type')
            new Tags().with {
                it.name = name
                it.pic = StringUtils.join(pics, ';')
                it.bit = bit
                it.type = type
                it.weight = weight
                if (params.show) {
                    it.status = 2 as byte
                } else {
                    it.status = 1 as byte
                }
                save(failOnError: true, flush: true)
            }
            redirect(controller: 'tags', action: 'index')
            return;
        }.invalidToken {
            // bad request
            response.status = 405
        }

    }



    //进行对标签编辑
    def edit(){
        Long id=params.long('id')
        Tags tags=Tags.findById(id)
        return [
                tags:tags,
                typeMap: typeMap
        ]
    }



    //进行编辑操作
    def addTagAagin(){
        Long id=params.long('tid')
        Tags tags=Tags.findById(id)
        Long bit = params.long('bit')
        List<String> pics = params.'item-pic' ? Lists.newArrayList(params.'item-pic') : Collections.emptyList()
        Integer weight = params.int('weight')
        Integer type = params.int('type')
        tags.with {
            it.name = name
            it.pic = StringUtils.join(pics, ';')
            it.bit = bit
            it.type = type
            it.weight = weight
            if (params.show) {
                it.status = 2 as byte
            } else {
                it.status = 1 as byte
            }
            it.save(failOnError: true, flush: true)
        }
        redirect(controller: 'tags', action: 'index')
        return;
    }

}
