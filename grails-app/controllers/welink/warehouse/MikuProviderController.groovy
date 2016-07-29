package welink.warehouse

import com.google.common.collect.ImmutableMap
import grails.converters.JSON
import grails.orm.PagedResultList
import welink.business.TreeNode

class MikuProviderController {
    DoExcelManagerService doExcelManagerService
    static ImmutableMap<Integer, String> PageMap = ImmutableMap.builder() //
            .put(5, "5")
            .put(10, "10")
            .put(20, "20")
            .put(30, "30")
            .put(40, "40")
            .put(50, "50")
            .put(100, "100")
            .put(200, "200")
            .put(500, "500")
            .build()

    def supplyCateList

    //展示的列表页�?
    def index() {
        List<MikuPclassify>  list=MikuPclassify.findAllByIsDelete(0 as byte)
        return [
                list:list
        ]
    }

    //查询全部的树的节点信�?
    def selectClassify(){
        List<MikuPclassify>  list=MikuPclassify.findAllByIsDelete(0 as byte)
        List<TreeNode> treeNodeList=new ArrayList<TreeNode>()
        list.each {
            MikuPclassify mm->
                TreeNode treeNode=new TreeNode()
                treeNode.id=mm.id
                treeNode.pId=mm.parentId
                treeNode.name=mm.name
                treeNodeList.add(treeNode)
        }
        render(treeNodeList as JSON)
    }

    //进行添加的节点信�?
    def addClassify(){
        String name=params.name
        Long pId=params.long('pId')
        System.out.println("====================================================================")
        System.out.println(name)
        System.out.println("====================================================================")
        MikuPclassify mikuPclassify=new MikuPclassify()
        mikuPclassify.with {
            it.dateCreated=new Date()
            it.lastUpdated=new Date()
            it.parentId=pId
            it.name=name
            it.memo=name
            it.isDelete=0 as byte
            it.save(failOnError: true, flush: true)
        }
        List<MikuPclassify>  list=MikuPclassify.findAllByIsDelete(0 as byte)
        List<TreeNode> treeNodeList=new ArrayList<TreeNode>()
        list.each {
            MikuPclassify mm->
                TreeNode treeNode=new TreeNode()
                treeNode.id=mm.id
                treeNode.pId=mm.parentId
                treeNode.name=mm.name
                treeNodeList.add(treeNode)
        }
        render(treeNodeList as JSON)
    }

    //删除的节点信�?
    def deleteClassify(){
        Long id=params.long('id')
        MikuPclassify mikuPclassify=MikuPclassify.findById(id)
        mikuPclassify.with {
            it.isDelete=1 as byte
            it.lastUpdated=new Date()
            it.save(failOnError: true, flush: true)
        }
        List<MikuPclassify>  list=MikuPclassify.findAllByIsDelete(0 as byte)
        List<TreeNode> treeNodeList=new ArrayList<TreeNode>()
        list.each {
            MikuPclassify mm->
                TreeNode treeNode=new TreeNode()
                treeNode.id=mm.id
                treeNode.pId=mm.parentId
                treeNode.name=mm.name
                treeNodeList.add(treeNode)
        }
        render(treeNodeList as JSON)
    }

    //更新节点信息
    def updateClassify(){
        String name=params.name
        Long id=params.long('id')
        MikuPclassify mikuPclassify=MikuPclassify.findById(id)
        mikuPclassify.with {
            it.lastUpdated=new Date()
            it.name=name
            it.memo=memo
            it.save(failOnError: true, flush: true)

        }
        List<MikuPclassify>  list=MikuPclassify.findAllByIsDelete(0 as byte)
        List<TreeNode> treeNodeList=new ArrayList<TreeNode>()
        list.each {
            MikuPclassify mm->
                TreeNode treeNode=new TreeNode()
                treeNode.id=mm.id
                treeNode.pId=mm.parentId
                treeNode.name=mm.name
                treeNodeList.add(treeNode)
        }
        render(treeNodeList as JSON)
    }

    //添加对应的供应商的信�?
    def add(){
        String name=params.name
        String sname=params.sname
        String cperson=params.cperson
        String job=params.job
        String address=params.address
        String mobile=params.mobile
        String accounttime=params.accounttime
        String zipcode=params.zipcode
        String email=params.email
        String memo=params.memo
        String assess=params.assess
        Long clssfiyId=params.long('clssfiyId')
        Byte recType = params.byte('recType') //跳转类型: 1:未审核供应商,0:审核供应商
        Long id=params.long('id')
        System.out.println("====================================================================")
        System.out.println(name)
        System.out.println("====================================================================")

        String qq=params.qq
        String scontacts=params.scontacts
        String scall=params.scall
        String fcontacts=params.fcontacts
        String fcall=params.fcontacts

        MikuProvider mikuProvider=new MikuProvider()
        if (id){
            mikuProvider=MikuProvider.findById(id)
            clssfiyId = clssfiyId ? clssfiyId : mikuProvider.clssfiyId;
        }
        mikuProvider.with {
            it.name=name
            it.sname=sname
            it.cperson=cperson
            it.address=address
            it.mobile=mobile
            it.accounttime=accounttime
            it.zipcode=zipcode
            it.email=email
            it.memo=memo
            it.job=job
            it.assess=assess
            it.clssfiyId=clssfiyId
            it.qq=qq
            it.scontacts=scontacts
            it.scall=scall
            it.fcontacts=fcontacts
            it.fcall=fcall
            //只要添加分类就表示审核通过
            if(clssfiyId){
                it.isCheck = 1 as byte
            }

            it.save(failOnError: true, flush: true)
        }

        if(recType == 1){
            redirect(action: 'checkList', controller: 'mikuProvider')
        }else{
            redirect(action: 'list', controller: 'mikuProvider')
        }

    }

    //删除对应的供应商的信�?
    def deleteProvider(){
        Byte recType = params.byte('recType') //跳转类型: 1:未审核供应商,0:审核供应商
        Long id=params.long('id')
        MikuProvider mikuProvider=MikuProvider.findById(id)
        mikuProvider.with {
            it.status=0 as byte
            it.save(failOnError: true, flush: true)
        }

        if(recType == 1){
            redirect(action: 'checkList', controller: 'mikuProvider')
        }else{
            redirect(action: 'list', controller: 'mikuProvider')
        }
    }

    def list(){
        String supplier=params.supplier
        String phone=params.phone

        Byte isparent=params.byte('isparent')
        Long tid=params.long('tid')
        def c = MikuProvider.createCriteria()
        PagedResultList pagedResultList = c.list(max: params.max ?:10, offset: params.offset ?: 0) {
            if (supplier)
            {
               ilike("name","%"+supplier+"%")
            }
            if (phone){
                eq("mobile",phone)
            }
            eq("isCheck",1 as byte)
            eq("status",1 as byte)
            if (isparent == 0 as byte){
                eq("clssfiyId",tid)
            }else if (isparent == 1 as byte){
                List<MikuPclassify>  list=MikuSupplierClassify.findAllByParentId(tid)
                'in'('clssfiyId',list*.id )
            }
            order("lastUpdated","desc")
        }

        return [
                params      : params,
                PageMap      : PageMap,
                total       : pagedResultList?.totalCount,
                list        : pagedResultList
        ]
    }

    //未审核供应商列表
    def checkList(){

        String supplier=params.supplier
        String phone=params.phone

        Byte isparent=params.byte('isparent')
        Long tid=params.long('tid')
        def c = MikuProvider.createCriteria()
        PagedResultList pagedResultList = c.list(max: params.max ?:10, offset: params.offset ?: 0) {
            if (supplier)
            {
                ilike("name","%"+supplier+"%")
            }
            if (phone){
                eq("mobile",phone)
            }
            eq("isCheck",0 as byte)
            eq("status",1 as byte)
            if (isparent == 0 as byte){
                eq("clssfiyId",tid)
            }else if (isparent == 1 as byte){
                List<MikuPclassify>  list=MikuSupplierClassify.findAllByParentId(tid)
                'in'('clssfiyId',list*.id )
            }
            order("lastUpdated","desc")
        }

        return [
                params      : params,
                PageMap      : PageMap,
                total       : pagedResultList?.totalCount,
                list        : pagedResultList
        ]
    }

    //审核供应商
    def bingProvider(){
        Map<String,Object> returnData = new HashMap<String, Object>();
        returnData.put('status' ,0);
        returnData.put('msg' ,'更改失败');
        returnData.put('result' , '');

        Long id = params.long('id')
        Long clssfiyId = params.long('cateId')

        if(!id){
            returnData.put('msg' ,'请选择供应商');
            render(returnData as JSON);
        }

        if(!clssfiyId){
            returnData.put('msg' ,'请选择分类');
            render(returnData as JSON);
        }

        MikuProvider mikuProvider=MikuProvider.findById(id)

        if(mikuProvider){
            mikuProvider.with {
                it.clssfiyId = clssfiyId
                it.isCheck = 1 as byte

                it.save(failOnError: true, flush: true)
            }

            returnData.put('status' ,1);
            returnData.put('msg' ,'更改成功');
            returnData.put('result' , '');
        }

        render(returnData as JSON);
    }

    //搜索供应商
    def search(){
            Map<String,Object> returnData = new HashMap<String, Object>();
            returnData.put('status' ,0);
            returnData.put('msg' ,'查询失败');
            returnData.put('result' , '');
            int i=0

            //查询条件
            Long id=params.long('id');
            Long clssfiyId = params.long('cateId'); //分类id
            String words = params.words
            Byte isCheck = params.byte('ischeck');

            if(id){
                def info = MikuProvider.findById(id);
                returnData.put('status' ,1);
                returnData.put('result' , info);
                returnData.put('msg' ,'查询成功');

                render(returnData as JSON);
            }

            def c = MikuProvider.createCriteria()

            PagedResultList pagedResultList = c.list(max: params.max ?:1000, offset: params.offset ?: 0) {

                if(clssfiyId){
                    eq("clssfiyId",clssfiyId)
                }

                if (words){
                    ilike('name',"%"+words+"%")
                }

                if(isCheck){
                    eq("isCheck",isCheck)
                }

                order("lastUpdated","desc")
            }

            if(pagedResultList){

                returnData.put('result' , pagedResultList);
                returnData.put('status' ,1);
                returnData.put('msg' ,'查询成功');

            }

            render(returnData as JSON);

    }

    //进行编辑
    def edit(){
        def cateNameList

        Long id=params.long('id')
        MikuProvider mikuProvider=MikuProvider.findById(id)

        if(mikuProvider){
            def cateInfo = MikuSupplierClassify.findById(mikuProvider.clssfiyId);
            if(cateInfo){
                supplyCateList = ''; //初始化
                cateNameList = searchSupplyCate(cateInfo.parentId);
                cateNameList = cateNameList ? cateNameList+"/"+cateInfo.name : cateInfo.name;
            }

        }

//        List<MikuPclassify>  list=MikuSupplierClassify.findAllByIsDeleteAndLevel(0 as byte,1)


        return [
                mikuProvider:mikuProvider,
//                list: list
                cateNameList:cateNameList
        ]

    }

    //遍历查找供应商父级所有分类获取分类名字 supplyCateList
    def searchSupplyCate(Long cateId){

        if(!cateId){
            return supplyCateList;
        }

        def cateInfo = MikuSupplierClassify.findById(cateId)
        if(cateInfo){
            if(cateInfo.level == 1){
                if(supplyCateList){
                    return cateInfo.name+'/'+ supplyCateList;
                }else{
                    return cateInfo.name;
                }

            }else{
                if(supplyCateList){
                    supplyCateList = cateInfo.name+'/'+ supplyCateList;
                }else{
                    supplyCateList = cateInfo.name;
                }

                searchSupplyCate(cateInfo.parentId);
            }
        }else{
            return supplyCateList;
        }

    }

    //查找遍历组装供应商的分类
    def searchSupplyAllCate(){
        Map<String,Object> returnData = new HashMap<String, Object>();
        returnData.put('status' ,0);
        returnData.put('msg' ,'查询失败');
        returnData.put('result' , '');

        Long cateId = params.long('cateId')

        if(!cateId){
            returnData.put('msg' ,'请选择分类');
            render(returnData as JSON);
        }

        def cateInfo = MikuSupplierClassify.findById(cateId);
        if(cateInfo){
            supplyCateList = ''; //初始化
            def cateNameList = searchSupplyCate(cateInfo.parentId);
            cateNameList = cateNameList ? cateNameList+"/"+cateInfo.name : cateInfo.name;

            returnData.put('status' ,1);
            returnData.put('msg' ,'查询成功');
            returnData.put('result' , cateNameList);
        }

        render(returnData as JSON);
    }

    //进行复制的操�?
    def copy(){
        Byte recType = params.byte('recType') //跳转类型: 1:未审核供应商,0:审核供应商
        Long id=params.long('id')
        MikuProvider mikuProvider=MikuProvider.findById(id)
        MikuProvider newp=new MikuProvider()
        newp.with {
            it.dateCreated=new Date()
            it.lastUpdated=new Date()
            it.accounttime=mikuProvider.accounttime
            it.address=mikuProvider.address
            it.assess=mikuProvider.assess
            it.clssfiyId=mikuProvider.clssfiyId
            it.cperson=mikuProvider.cperson
            it.job=mikuProvider.job
            it.email=mikuProvider.email
            it.mobile=mikuProvider.mobile
            it.name=mikuProvider.name+"-复制"
            it.sname=mikuProvider.sname
            it.zipcode=mikuProvider.zipcode
            it.save(failOnError: true, flush: true)
        }

        if(recType == 1){
            redirect(action: 'checkList', controller: 'mikuProvider')
        }else{
            redirect(action: 'list', controller: 'mikuProvider')
        }
    }

    //导入对应的供应商数据
    def inputExcelData(){

        Byte type=params.byte('type')
        def uploadedFile = request.getFile('myFile')
        String path=request.getSession().getServletContext().getRealPath("")
        UUID uuid = UUID.randomUUID()
        //新建的文件目录
        File newFile=new File(path)
        if (!newFile.exists())
        {
            newFile.mkdirs()
        }
        path=path+uuid+".xls"
        File newBuildFile=new File(path)
        uploadedFile.transferTo(newBuildFile)
        InputStream is=new FileInputStream(path)
        String[] title=doExcelManagerService.readExcelTitle(is)
        InputStream is2=new FileInputStream(path)
        Map<Integer, String> map = doExcelManagerService.readExcelContent(is2);
        //删除文件
        newBuildFile.delete();
        if (type == 1 as byte){
            List<MikuPiteminfo>  piteminfoList=doExcelManagerService.getDataInfoByPItemMap(title,map)
            piteminfoList.each {
                it.version=1L
                it.cknum=0
                it.pclassifyId=0L
                it.providerId=0L
                it.classfiId=0L
                it.save(failOnError: true,flush: true)
            }
            redirect(controller: 'mikuPiteminfo', action: 'checkList')
        }else if (type == 1 as byte){

        }
        else{
            List<MikuProvider>  providerList=doExcelManagerService.getDataInfoByMap(title,map)
            providerList.each {
                MikuProvider p=MikuProvider.findByName(it.name)
                if (p){
                    it.isCheck=2 as byte
                }else{
                    it.isCheck=0 as byte
                }
                it.status=1 as byte
                it.version=1L
                it.save(failOnError: true,flush: true)
            }
            redirect(controller: 'mikuProvider', action: 'checkList')
        }
    }

    //生成模板
    def createOneModelExcel(){
        String flag=params.flag
        def filename =""
        if("1".equals(flag)){
            filename ="供应商导入模板.xls"
        }else{
            filename ="供应商品导入模板.xls"
        }

        def newfilename = URLEncoder.encode(filename, "UTF-8");
        response.setHeader("Content-disposition", "attachment; filename="+newfilename)
        response.contentType = "application/x-rarx-rar-compressed"
        def webRootDir = request.getSession().getServletContext().getRealPath("//")
        def filepath = new File(webRootDir,filename)
        def out = response.outputStream
        def inputStream = new FileInputStream(filepath)
        byte[] buffer = new byte[1024]
        int i = -1
        while ((i = inputStream.read(buffer)) != -1) {
            out.write(buffer, 0, i)
        }
        out.flush()
        out.close()
        inputStream.close()
    }

}
