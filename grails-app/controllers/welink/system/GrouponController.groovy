package welink.system

import grails.orm.PagedResultList
import welink.common.Category
import welink.common.Groupon
import welink.common.Item

class GrouponController {

    def lookItemDetail(){

        Item item=Item.findById(params.long('id'))

        def grouponPrice=Groupon.findByItemIdAndStatusInList(item.id,[1 as byte,2 as byte])?.grouponPrice

        render(template: "itemDetail", model: [
                item:item,
                grouponPrice:grouponPrice,
                parentCategory:Category.findById(Category.findById(item.categoryId).parentId).name,
                childCategory:Category.findById(item.categoryId).name
        ])
    }

    def index() {

        List<Category> categoryList = Category.findAllByParentIdAndIdGreaterThanAndStatus(null, 20000000L,1 as byte)

        def c = Groupon.createCriteria()

        // 查询语句
        String query = params.query

        PagedResultList pagedResultList = c.list(max: params.max ?: 10, offset: params.offset ?: 0) {
            ne("status", 0 as byte)
            if(params.category){
                eq("itemCategoryId",params.long('category'))
            }

        }

        def categoryMap = Category.findAllByIdGreaterThan(20000000L).collectEntries { [it.id, it] }

        render(view: 'index', model: [
                total       : pagedResultList?.totalCount,
                grouponList : pagedResultList,
                params      : params,
                categoryList: categoryList,
                categoryMap : categoryMap
        ])
    }

    def last() {

        List<Category> categoryList = Category.findAllByParentIdAndIdGreaterThanAndStatus(null, 20000000L,1)

        def c = Groupon.createCriteria()

        // 查询语句
        String query = params.query

        PagedResultList pagedResultList = c.list(max: params.max ?: 10, offset: params.offset ?: 0) {
            eq("status", 0 as byte)
            if(params.category){
                eq("itemCategoryId",params.long('category'))
            }
        }

        def categoryMap = Category.findAllByIdGreaterThan(20000000L).collectEntries { [it.id, it] }

        render(view: 'last', model: [
                total       : pagedResultList?.totalCount,
                grouponList : pagedResultList,
                params      : params,
                categoryList: categoryList,
                categoryMap : categoryMap
        ])

    }
}
