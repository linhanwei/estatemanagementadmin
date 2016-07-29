package welink.system

import com.google.common.base.Preconditions
import com.google.common.collect.Lists
import grails.converters.JSON
import grails.orm.PagedResultList
import grails.transaction.Transactional
import groovy.sql.Sql
import org.hibernate.SessionFactory
import org.hibernate.jdbc.Work
import welink.category.Node
import welink.common.Category

import javax.annotation.Resource
import java.sql.Connection
import java.sql.SQLException

class ItemCategoryController {

    @Resource
    SessionFactory sessionFactory

    def index() {

        List<Category> level1Categories = Category.findAllByParentIdAndIdGreaterThanAndStatus(null, 20000000L,1)

        def c = Category.createCriteria()
        PagedResultList pagedResultList = c.list(max: params.max ?: 10, offset: params.offset ?: 0) {
            eq('status', 1 as Byte)
            order("id", "desc")
        }

        return [
                categoryList    : pagedResultList,
                total           : pagedResultList.totalCount,
                params          : params,
                level1Categories: level1Categories
        ]
    }

    def tree() {

        List<Node> nodes = Lists.newArrayList()
        Category.findAllByParentIdAndIdGreaterThanAndStatusGreaterThan(null, 20000000L,0).each {
//        Category.findAllByParentIdAndIdGreaterThanAndStatus(null, 20000000L,1).each {
            Category category ->
                Preconditions.checkNotNull(category, 'category cannot be null')
                Node child = new Node()
                child.id = category.id
                child.text = category.name
                child.features=category.features
                if (category.status == 0 as byte) {
                    child.state.put("disabled", true)
                }
                nodes.add(child)

                findChildren(child)
        }

        render(nodes as JSON)
    }

    void findChildren(Node node) {

        List<Node> children = Lists.newArrayList()

        Category.findAllByParentIdAndStatusGreaterThan(node.id,0 as byte).each {
            Category category ->
                Node child = new Node()
                child.id = category.id
                child.text = category.name
                children.add(child)
                if (category.status == 0 as byte) {
                    child.state.put("disabled", true)
                }

                findChildren(child)
        }

        if (!children) {
            node.children = null
        } else {
            node.children = children
        }
    }

    def edit() {

        Long id = params.long('id')

        List<Category> level1Categories = Category.findAllByParentIdAndIdGreaterThanAndStatus(null, 20000000L,1)

        return [

                level1Categories: level1Categories,
                category        : Category.findByIdAndStatus(id,1 as byte)
        ]
    }

    def queryCategoryByParentId() {
        Long id = params.long('id')

        List<Category> categories

        if(params.category&&(params.category!='-1')){
            categories = Category.findAllById(params.long('category'))
            Category.findAllByParentIdAndIdGreaterThanAndStatusAndIdNotEqual(id, 20000000L,1,params.long('category')).each {
                Category category->
                    categories.add(category)
            }
        }else {
            categories = Category.findAllByParentIdAndIdGreaterThanAndStatus(id, 20000000L,1)
        }

        def ret = []

        categories.each {
            Category category ->
                def map = [:]
                map.put("id", category.id)
                map.put("name", category.name)
                ret.add(map)
        }

        render(ret as JSON)
    }

    def deleteCategory(Long id) {

        //这里分子节点与父节点的删除
        Category.findByIdAndStatus(id,1 as byte)?.with {
            it.status = 0 as byte
            save(failOnError: true, flush: true)
        }

        //子节点的删除
        def list=Category.findAllByParentIdAndStatus(id,1 as byte)
        if (list.size()>0)
        {
            list.each {
                it.status=0 as byte
                it.save(failOnError: true, flush: true)
            }
        }

        render([])
    }

    @Transactional
    def createOrUpdateCategory() {

        withForm {

            String name = params.name
            String memo = params.memo
            //类目属性
            String features=params.features

            // 父类目id
            Long parentId = params.long('pId')

            Long id = params.long('id')

            Category category
            String picture =""
            if (!id) {
                category = new Category()
                id = getMaxIdInSpecialCategoryRange() + 1
                picture=params.'item-pic'
                category.id = id
                category.parentId = parentId
            } else {
                category = Category.findByIdAndStatusGreaterThan(id,0 as byte)
                picture = params.'detail-pic'
            }
            category.picture = picture
            category.name = name
            category.memo = memo
            category.features=features?features:""

            if (parentId) {
                Category parent = Category.findByIdAndStatusGreaterThan(parentId,0 as byte)
                category.level = parent.level + 1
                parent.isParent = 1 as byte
                parent.save(failOnError: true)
            }

            category.save(failOnError: true)

            redirect(uri: "/itemCategory/index")

            return
        }.invalidToken {
            // bad request
            response.status = 405
        }
    }

    def selectedNodeDetail() {

        Long selectedId = params.long('id')
        Category category = Category.findByIdAndStatusGreaterThan(selectedId,0 as byte)
//        Category category = Category.findByIdAndStatus(selectedId,1 as byte)
        Category parent = category?.parentId ? Category.findByIdAndStatusGreaterThan(category.parentId,0 as byte) : null
        render(template: 'detail', model: [
                parent  : parent,
                node    : category,
                hasChild: category.isParent == 1 as byte
        ])
    }

    def getMaxIdInSpecialCategoryRange() {
        final session = sessionFactory.currentSession

        // Query string with :startId as parameter placeholder.
        final String query =
                "select max(id) as max from category"

        // Create native SQL query.

        def max = 0

        session.doWork new Work() {
            @Override
            public void execute(Connection conn) throws SQLException {
                // execute your statement against the connection
                Sql sql = new Sql(connection: conn)
                max = sql.firstRow(query).max
            }

        };

        (max > 20000000L ? max : 20000000L)
    }





    //查询对应的二级类目一条数据
    def queryOneCategoryContent()
    {
        //二级类目的id
        Long id = params.long('id')
        Category category=Category.findByIdAndStatus(id,1 as byte)
        //查找其子节点
        List<Category> list=Category.findAllByParentId(category.id)
        def map=[:]
        map.put('data',category)
        map.put('list',list)
        render(map as JSON)
    }



    //隐藏节点
    @Transactional
    def hideCategory(){
        Long id = params.long('id')
        //这里分子节点与父节点的删除
        Category.findByIdAndStatus(id,1 as byte)?.with {
            it.status = 2 as byte
            save(failOnError: true, flush: true)
        }
        //子节点的删除
        def list=Category.findAllByParentIdAndStatus(id,1 as byte)
        if (list.size()>0)
        {
            list.each {
                it.status=2 as byte
                it.save(failOnError: true, flush: true)
            }
        }
        render([])
    }

    //显示节点
    @Transactional
    def showCategory(){
        Long id = params.long('id')
        //这里分子节点与父节点的删除
        Category.findByIdAndStatus(id,2 as byte)?.with {
            it.status = 1 as byte
            save(failOnError: true, flush: true)
        }
        def list=Category.findAllByParentIdAndStatus(id,2 as byte)
        if (list.size()>0)
        {
            list.each {
                it.status=1 as byte
                it.save(failOnError: true, flush: true)
            }
        }
        render([])
    }
}
