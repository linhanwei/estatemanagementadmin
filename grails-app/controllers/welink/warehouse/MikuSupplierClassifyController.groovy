package welink.warehouse

import grails.converters.JSON
import welink.business.TreeNode

//供应商分类管理控制器
class MikuSupplierClassifyController {

    //查询所有分类
    def list() {
            List<MikuSupplierClassify>  list=MikuSupplierClassify.findAllByIsDelete(0 as byte)
            List<TreeNode> treeNodeList=new ArrayList<TreeNode>()
            list.each {
                MikuSupplierClassify mm->
                    TreeNode treeNode=new TreeNode()
                    treeNode.id=mm.id
                    treeNode.pId=mm.parentId
                    treeNode.name=mm.name
                    treeNodeList.add(treeNode)
            }
            render(treeNodeList as JSON)
    }

    //搜索
    def search(){
        String name=params.name;
        Long pId=params.long('pId');
        def c = MikuSupplierClassify.createCriteria();

        List<MikuSupplierClassify>  list = c.list(max: params.max ?:1000, offset: params.offset ?: 0){
            if(pId){
                eq('parentId',pId)
            }

            if(name){
                ilike('name',"%"+name+"%")
            }

            eq('isDelete',0 as byte)

        }

        List<TreeNode> treeNodeList=new ArrayList<TreeNode>()
        list.each {
            MikuSupplierClassify mm->
                TreeNode treeNode=new TreeNode()
                treeNode.id=mm.id
                treeNode.pId=mm.parentId
                treeNode.name=mm.name
                treeNodeList.add(treeNode)
        }
        render(treeNodeList as JSON)
    }

    //添加分类
    def add(){
        String name=params.name
        Long pId=params.long('pId')

        def parentInfo = MikuSupplierClassify.findById(pId);

        MikuSupplierClassify mikuSupplierClassify=new MikuSupplierClassify()
        mikuSupplierClassify.with {
            it.dateCreated=new Date()
            it.lastUpdated=new Date()
            it.level = (parentInfo && parentInfo.level) ? (parentInfo.level + 1) : 1
            it.parentId=pId
            it.name=name
            it.memo=name
            it.isDelete=0 as byte
            it.save(failOnError: true, flush: true)
        }
        List<MikuSupplierClassify>  list=MikuSupplierClassify.findAllByIsDelete(0 as byte)
        List<TreeNode> treeNodeList=new ArrayList<TreeNode>()
        list.each {
            MikuSupplierClassify mm->
                TreeNode treeNode=new TreeNode()
                treeNode.id=mm.id
                treeNode.pId=mm.parentId
                treeNode.name=mm.name
                treeNodeList.add(treeNode)
        }
        render(treeNodeList as JSON)
    }

    //删除分类
    def del(){
        Long id=params.long('id')
        MikuSupplierClassify mikuSupplierClassify=MikuSupplierClassify.findById(id)
        mikuSupplierClassify.with {
            it.isDelete=1 as byte
            it.lastUpdated=new Date()
            it.save(failOnError: true, flush: true)
        }
        List<MikuSupplierClassify>  list=MikuSupplierClassify.findAllByIsDelete(0 as byte)
        List<TreeNode> treeNodeList=new ArrayList<TreeNode>()
        list.each {
            MikuSupplierClassify mm->
                TreeNode treeNode=new TreeNode()
                treeNode.id=mm.id
                treeNode.pId=mm.parentId
                treeNode.name=mm.name
                treeNodeList.add(treeNode)
        }
        render(treeNodeList as JSON)
    }

    //更新分类
    def edit(){
        String name=params.name
        Long id=params.long('id')
        MikuSupplierClassify mikuSupplierClassify=MikuSupplierClassify.findById(id)
        mikuSupplierClassify.with {
            it.lastUpdated=new Date()
            it.name=name
            it.memo=memo
            it.save(failOnError: true, flush: true)

        }
        List<MikuSupplierClassify>  list=MikuSupplierClassify.findAllByIsDelete(0 as byte)
        List<TreeNode> treeNodeList=new ArrayList<TreeNode>()
        list.each {
            MikuSupplierClassify mm->
                TreeNode treeNode=new TreeNode()
                treeNode.id=mm.id
                treeNode.pId=mm.parentId
                treeNode.name=mm.name
                treeNodeList.add(treeNode)
        }
        render(treeNodeList as JSON)
    }
}
