package welink.common

import grails.transaction.Transactional
import welink.business.OperateData

@Transactional
class OperateDataService {

    //统计的方法【4种方法】
    //1.单选类目
    def returnoperateDataList(Long onelevel,Long twolevel)
    {
        List<OperateData> operateDataList=new ArrayList<OperateData>()
        if(onelevel && twolevel==-1){
            //进行拉取每个一级类目对应的商品
            List<Category> childList=Category.findAllByParentIdAndStatus(onelevel,1 as byte)
            //C.根据对应的二级类目的id查出对应的有效item的数量
            childList.each {
                Category childcategory->
                    int zcnum=0
                    int sjnum=0
                    OperateData operateData=new OperateData()
                    //D.再进行相加操作
                    List<Item> itemList=Item.findAllByCategory2_idAndBaseItemIdAndApproveStatusNotEqual(childcategory.id,null,-1 as byte)
                    itemList.each {
                        Item item->
                            //总仓的标示
                            if (item.approveStatus == 0 as byte)
                            {
                                zcnum++
                            }else{
                                sjnum++
                            }
                    }
                    if (itemList.size()>0){
                        //operateData数据的封装
                        operateData.num=itemList.size()
                        operateData.id=childcategory.id
                        operateData.info=childcategory.name
                        operateData.name=childcategory.name
                        operateData.zcnum=zcnum
                        operateData.sjnum=sjnum
                        operateData.zccodition="/itemInStock/index?level1Category="+onelevel+"&category="+childcategory.id
                        operateData.sjcondition="/shopItemManager/index?level1Category="+onelevel+"&category="+childcategory.id
                        operateDataList.add(operateData)
                    }
            }
        }
        else if(onelevel && twolevel){

            //进行拉取每个一级类目对应的商品
            List<Category> childList=Category.findAllByParentIdAndStatus(twolevel,1 as byte)
            //C.根据对应的二级类目的id查出对应的有效item的数量
            childList.each {
                Category childcategory->
                    int zcnum=0
                    int sjnum=0
                    OperateData operateData=new OperateData()
                    //D.再进行相加操作
                    List<Item> itemList=Item.findAllByCategoryIdAndBaseItemIdAndApproveStatusNotEqual(childcategory.id,null,-1 as byte)
                    itemList.each {
                        Item item->
                            //总仓的标示
                            if (item.approveStatus == 0 as byte)
                            {
                                zcnum++
                            }else{
                                sjnum++
                            }
                    }
                    if (itemList.size()>0){
                        //operateData数据的封装
                        operateData.num=itemList.size()
                        operateData.id=childcategory.id
                        operateData.info=childcategory.name
                        operateData.name=childcategory.name
                        operateData.zcnum=zcnum
                        operateData.sjnum=sjnum
                        operateData.zccodition="/itemInStock/index?level1Category="+onelevel+"&category="+twolevel+"&threelevel="+childcategory.id
                        operateData.sjcondition="/shopItemManager/index?level1Category="+onelevel+"&category="+"&threelevel="+childcategory.id
                        operateDataList.add(operateData)
                    }
            }


//
//            Category category=Category.findById(twolevel)
//            int zcnum=0
//            int sjnum=0
//            List<Item> itemList=Item.findAllByCAndStatusAndBaseItemIdAndApproveStatusNotEqual(twolevel,1 as byte,null,-1 as byte)
//            itemList.each {
//                Item item->
//                    //总仓的标示
//                    if (item.approveStatus == 0 as byte)
//                    {
//                        zcnum++
//                    }else{
//                        sjnum++
//                    }
//            }
//            OperateData operateData=new OperateData()
//            operateData.num=itemList.size()
//            operateData.id=twolevel
//            operateData.zcnum=zcnum
//            operateData.sjnum=sjnum
//            operateData.info=category.name
//            operateData.name=category.name
//            operateData.zccodition="/itemInStock/index?category="+category.id
//            operateData.sjcondition="/shopItemManager/index?category="+category.id
//            operateDataList.add(operateData)
        }
        return  operateDataList
    }

    //单选品牌
    def returnPingpaiDataList(Long onelevel,Long twolevel)
    {
        List<OperateData> operateDataList=new ArrayList<OperateData>()
        List<MikuBrand> mikuBrandList=MikuBrand.findAllByIsDeleted(0 as byte)
        List<Item> AllitemList=new ArrayList<Item>()
        String conditionstr="&"
        if(onelevel && twolevel==-1){
            conditionstr+="level1Category="+onelevel
//            List<Category> childList=Category.findAllByParentIdAndStatus(onelevel,1 as byte)
//            //C.根据对应的二级类目的id查出对应的有效item的数量
//            childList.each {
//                Category childcategory->
//                    //D.再进行相加操作
//                    List<Item> itemList=Item.findAllByCategory1_idAndBaseItemIdAndApproveStatusNotEqual(childcategory.id,null,-1 as byte)
//                    AllitemList.addAll(itemList)
//            }
            Category category=Category.findById(onelevel)
            conditionstr+="category="+twolevel
            List<Item> itemList=Item.findAllByCategory1_idAndBaseItemIdAndApproveStatusNotEqual(category.id,null,-1 as byte)
            AllitemList.addAll(itemList)

        }
        else if(onelevel && twolevel){
            Category category=Category.findById(twolevel)
            conditionstr+="category="+twolevel
            List<Item> itemList=Item.findAllByCategory2_idAndBaseItemIdAndApproveStatusNotEqual(category.id,null,-1 as byte)
            AllitemList.addAll(itemList)
        }
        //进行品牌的分开
        mikuBrandList.each {
            MikuBrand mikuBrand->
                int sum=0
                int zcnum=0
                int sjnum=0
                AllitemList.each {
                    Item item ->
                        if (mikuBrand.id==item.brandId){
                            sum++
                            if (item.approveStatus == 0 as byte)
                            {
                                zcnum++
                            }else{
                                sjnum++
                            }
                        }
                }
                if (sum>0){
                    OperateData operateData=new OperateData()
                    operateData.num=sum
                    operateData.id=mikuBrand.id
                    operateData.zcnum=zcnum
                    operateData.sjnum=sjnum
                    operateData.info=mikuBrand.name
                    operateData.name=mikuBrand.name
                    operateData.zccodition="/itemInStock/index?brandId="+mikuBrand.id+conditionstr
                    operateData.sjcondition="/shopItemManager/index?brandId="+mikuBrand.id+conditionstr
                    operateDataList.add(operateData)
                }
        }
        return  operateDataList
    }

    //全不选
    def returnNoCheckDataList(Long onelevel,Long twolevel)
    {
        List<OperateData> operateDataList=new ArrayList<OperateData>()
        if(onelevel && twolevel==-1){
            Category category=Category.findById(onelevel)
            int zcnum=0
            int sjnum=0
            List<Item> itemList=Item.findAllByCategory1_idAndBaseItemIdAndApproveStatusNotEqual(onelevel,null,-1 as byte)
            itemList.each {
                Item item->
                    //总仓的标示
                    if (item.approveStatus == 0 as byte)
                    {
                        zcnum++
                    }else{
                        sjnum++
                    }
            }
            OperateData operateData=new OperateData()
            operateData.num=itemList.size()
            operateData.id=twolevel
            operateData.zcnum=zcnum
            operateData.sjnum=sjnum
            operateData.info=category.name
            operateData.name=category.name
            operateData.zccodition="/itemInStock/index?level1Category="+onelevel
            operateData.sjcondition="/shopItemManager/index?level1Category="+onelevel
            operateDataList.add(operateData)
        }
        else if(onelevel && twolevel){
            Category category=Category.findById(twolevel)
            int zcnum=0
            int sjnum=0
            List<Item> itemList=Item.findAllByCategory2_idAndBaseItemIdAndApproveStatusNotEqual(twolevel,null,-1 as byte)
            itemList.each {
                Item item->
                    //总仓的标示
                    if (item.approveStatus == 0 as byte)
                    {
                        zcnum++
                    }else{
                        sjnum++
                    }
            }
            OperateData operateData=new OperateData()
            operateData.num=itemList.size()
            operateData.id=twolevel
            operateData.zcnum=zcnum
            operateData.sjnum=sjnum
            operateData.info=category.name
            operateData.name=category.name
            operateData.zccodition="/itemInStock/index?level1Category="+onelevel+"&category="+twolevel
            operateData.sjcondition="/shopItemManager/index?level1Category="+onelevel+"&category="+twolevel
            operateDataList.add(operateData)
        }
        return  operateDataList
    }


    //全选
    def returnAllCheckDataList(Long onelevel,Long twolevel)
    {
        List<OperateData> operateDataList=new ArrayList<OperateData>()
        List<MikuBrand> mikuBrandList=MikuBrand.findAllByIsDeleted(0 as byte)
        if(onelevel && twolevel==-1){
            //进行拉取每个一级类目对应的商品
            List<Category> childList=Category.findAllByParentIdAndStatus(onelevel,1 as byte)
            //C.根据对应的二级类目的id查出对应的有效item的数量
            childList.each {
                Category childcategory->
                    List<Item> itemList=Item.findAllByCategory2_idAndBaseItemIdAndApproveStatusNotEqual(childcategory.id,null,-1 as byte)
                    //进行品牌的分开
                    mikuBrandList.each {
                        MikuBrand mikuBrand->
                            int sum=0
                            int zcnum=0
                            int sjnum=0
                            itemList.each {
                                Item item ->
                                    if (mikuBrand.id==item.brandId){
                                        sum++
                                        if (item.approveStatus == 0 as byte)
                                        {
                                            zcnum++
                                        }else{
                                            sjnum++
                                        }
                                    }
                            }
                            if (sum>0){
                                OperateData operateData=new OperateData()
                                operateData.num=sum
                                operateData.zcnum=zcnum
                                operateData.sjnum=sjnum
                                operateData.id=mikuBrand.id
                                operateData.info=childcategory.name+"("+mikuBrand.name+")"
                                operateData.name=childcategory.name+"("+mikuBrand.name+")"
//                                operateData.zccodition="/itemInStock/index?level1Category="+childcategory.id+"&brandId="+mikuBrand.id
//                                operateData.sjcondition="/shopItemManager/index?level1Category="+childcategory.id+"&brandId="+mikuBrand.id
                                operateData.zccodition="/itemInStock/index?level1Category="+onelevel+"&category="+childcategory.id+"&brandId="+mikuBrand.id
                                operateData.sjcondition="/shopItemManager/index?level1Category="+onelevel+"&category="+childcategory.id+"&brandId="+mikuBrand.id
                                operateDataList.add(operateData)
                            }
                    }
            }
        }
        else if(onelevel && twolevel){
//            Category category=Category.findById(twolevel)
//            List<Item> itemList=Item.findAllByCategoryIdAndStatusAndBaseItemIdAndApproveStatusNotEqual(twolevel,1 as byte,null,-1 as byte)
//            //进行品牌的分开
//            mikuBrandList.each {
//                MikuBrand mikuBrand->
//                    int sum=0
//                    int zcnum=0
//                    int sjnum=0
//                    itemList.each {
//                        Item item ->
//                            if (mikuBrand.id==item.brandId){
//                                sum++
//                                if (item.approveStatus == 0 as byte)
//                                {
//                                    zcnum++
//                                }else{
//                                    sjnum++
//                                }
//                            }
//                    }
//                    if (sum>0){
//                        OperateData operateData=new OperateData()
//                        operateData.num=sum
//                        operateData.zcnum=zcnum
//                        operateData.sjnum=sjnum
//                        operateData.id=mikuBrand.id
//                        operateData.info=category.name+"("+mikuBrand.name+")"
//                        operateData.name=category.name+"("+mikuBrand.name+")"
//                        operateData.zccodition="/itemInStock/index?category="+category.id+"&brandId="+mikuBrand.id
//                        operateData.sjcondition="/shopItemManager/index?category="+category.id+"&brandId="+mikuBrand.id
//                        operateDataList.add(operateData)
//                    }
//            }
            //进行拉取每个一级类目对应的商品
            List<Category> childList=Category.findAllByParentIdAndStatus(twolevel,1 as byte)
            //C.根据对应的二级类目的id查出对应的有效item的数量
            childList.each {
                Category childcategory->
                    List<Item> itemList=Item.findAllByCategoryIdAndBaseItemIdAndApproveStatusNotEqual(childcategory.id,null,-1 as byte)
                    //进行品牌的分开
                    mikuBrandList.each {
                        MikuBrand mikuBrand->
                            int sum=0
                            int zcnum=0
                            int sjnum=0
                            itemList.each {
                                Item item ->
                                    if (mikuBrand.id==item.brandId){
                                        sum++
                                        if (item.approveStatus == 0 as byte)
                                        {
                                            zcnum++
                                        }else{
                                            sjnum++
                                        }
                                    }
                            }
                            if (sum>0){
                                OperateData operateData=new OperateData()
                                operateData.num=sum
                                operateData.zcnum=zcnum
                                operateData.sjnum=sjnum
                                operateData.id=mikuBrand.id
                                operateData.info=childcategory.name+"("+mikuBrand.name+")"
                                operateData.name=childcategory.name+"("+mikuBrand.name+")"
                                operateData.zccodition="/itemInStock/index?level1Category="+onelevel+"&category="+twolevel+"&brandId="+mikuBrand.id+"&threelevel="+childcategory.id
                                operateData.sjcondition="/shopItemManager/index?level1Category="+onelevel+"&category="+twolevel+"&brandId="+mikuBrand.id+"&threelevel="+childcategory.id
                                operateDataList.add(operateData)
                            }
                    }
            }
        }
        return  operateDataList
    }

    //全不选的时候
    def nocheckLMDataList(String falg){
        List<OperateData> operateDataList=new ArrayList<OperateData>()
        if ("0".equals(falg) || "1".equals(falg))
        {
            operateDataList=initDataList()
        }
        //选品牌
        else if ("2".equals(falg))
        {
            operateDataList= noCheckLMCheckPP()
        }
        //选类目+品牌
        else if ("3".equals(falg))
        {
            operateDataList= noCheckLMCheckPPAndLM()
        }
        return  operateDataList
    }

    //单单类目选项就是默认的选项
    def initDataList(){
        List<OperateData> operateDataList=new ArrayList<OperateData>()
        //A.获取所有的一级类目id
        List<Category> categoryList = Category.findAllByParentIdAndIdGreaterThanAndStatus(null, 20000000L, 1)
        //进行拉取每个一级类目对应的商品
        categoryList.each {
            Category category->
                int sum=0
                int zcnum=0
                int sjnum=0
                OperateData operateData=new OperateData()
                //总仓商品
                List<Item> itemList=Item.findAllByCategory1_idAndBaseItemIdAndApproveStatusNotEqual(category.id,null,-1 as byte)
                sum+=itemList.size()
                itemList.each {
                    Item item->
                        //总仓的标示
                        if (item.approveStatus == 0 as byte)
                        {
                            zcnum++
                        }else{
                            sjnum++
                        }
                }
//                //B.根据一级类目id获取所有的二级类目id
//                List<Category> childList=Category.findAllByParentIdAndStatus(category.id,1 as byte)
//                OperateData operateData=new OperateData()
//                int sum=0
//                int zcnum=0
//                int sjnum=0
//                //C.根据对应的二级类目的id查出对应的有效item的数量
//                childList.each {
//                    Category childcategory->
//                        //D.再进行相加操作
////                        List<Item> itemList=Item.findAllByCategoryIdAndStatusAndBaseItemId(childcategory.id,1 as byte,null)
//                        List<Item> itemList=Item.findAllByCategoryIdAndStatusAndBaseItemIdAndApproveStatusNotEqual(childcategory.id,1 as byte,null,-1 as byte)
//                        sum+=itemList.size()
//                        itemList.each {
//                            Item item->
//                                //总仓的标示
//                                if (item.approveStatus == 0 as byte)
//                                {
//                                    zcnum++
//                                }else{
//                                    sjnum++
//                                }
//                        }
//                }
                if (sum>0){
                    //operateData数据的封装
                    operateData.num=sum
                    operateData.zcnum=zcnum
                    operateData.sjnum=sjnum
                    operateData.id=category.id
                    operateData.name=category.name
                    operateData.info=category.name
                    operateData.zccodition="/itemInStock/index?level1Category="+category.id
                    operateData.sjcondition="/shopItemManager/index?level1Category="+category.id
                    operateDataList.add(operateData)
                }
        }
        return  operateDataList
    }

    //没选类目单单选品牌
    def noCheckLMCheckPP(){
        List<OperateData> operateDataList=new ArrayList<OperateData>()
        List<MikuBrand> mikuBrandList=MikuBrand.findAllByIsDeleted(0 as byte)
        List<Item> itemList=Item.findAllByBaseItemIdAndApproveStatusNotEqual(null,-1 as byte)
        mikuBrandList.each {
            MikuBrand mikuBrand->
                int sum=0
                int zcnum=0
                int sjnum=0
                itemList.each {
                    Item item ->
                        if (mikuBrand.id==item.brandId){
                            sum++
                            if (item.approveStatus == 0 as byte)
                            {
                                zcnum++
                            }else{
                                sjnum++
                            }
                        }
                }
                if (sum>0){
                    OperateData operateData=new OperateData()
                    operateData.num=sum
                    operateData.id=mikuBrand.id
                    operateData.zcnum=zcnum
                    operateData.sjnum=sjnum
                    operateData.info=mikuBrand.name
                    operateData.name=mikuBrand.name
                    operateData.zccodition="/itemInStock/index?brandId="+mikuBrand.id
                    operateData.sjcondition="/shopItemManager/index?brandId="+mikuBrand.id
                    operateDataList.add(operateData)
                }
        }
        return operateDataList
    }

    //没选类目即选了品牌与类目
    def noCheckLMCheckPPAndLM(){
        List<OperateData> operateDataList=new ArrayList<OperateData>()
        List<MikuBrand> mikuBrandList=MikuBrand.findAllByIsDeleted(0 as byte)
        //A.获取所有的一级类目id
        List<Category> categoryList = Category.findAllByParentIdAndIdGreaterThanAndStatus(null, 20000000L, 1)
        //进行拉取每个一级类目对应的商品
        categoryList.each {
            Category category->
                List<Item> AllitemList=new ArrayList<Item>()
                //B.根据一级类目id获取所有的二级类目id
                List<Category> childList=Category.findAllByParentIdAndStatus(category.id,1 as byte)
                //C.根据对应的二级类目的id查出对应的有效item的数量
                childList.each {
                    Category childcategory->
                        //D.再进行相加操作
//                        List<Item> itemList=Item.findAllByCategoryIdAndStatusAndBaseItemId(childcategory.id,1 as byte,null)
                        List<Item> itemList=Item.findAllByCategoryIdAndStatusAndBaseItemIdAndApproveStatusNotEqual(childcategory.id,1 as byte,null,-1 as byte)
                        AllitemList.addAll(itemList)
                }
                //进行品牌的分开
                mikuBrandList.each {
                    MikuBrand mikuBrand->
                        int sum=0
                        int zcnum=0
                        int sjnum=0
                        AllitemList.each {
                            Item item ->
                                if (mikuBrand.id==item.brandId){
                                    sum++
                                    if (item.approveStatus == 0 as byte)
                                    {
                                        zcnum++
                                    }else{
                                        sjnum++
                                    }
                                }
                        }
                        if (sum>0){
                            OperateData operateData=new OperateData()
                            operateData.num=sum
                            operateData.zcnum=zcnum
                            operateData.sjnum=sjnum
                            operateData.id=mikuBrand.id
                            operateData.info=category.name+"("+mikuBrand.name+")"
                            operateData.name=category.name+"("+mikuBrand.name+")"
                            operateData.zccodition="/itemInStock/index?level1Category="+category.id+"&brandId="+mikuBrand.id
                            operateData.sjcondition="/shopItemManager/index?level1Category="+category.id+"&brandId="+mikuBrand.id
                            operateDataList.add(operateData)
                        }
                }
        }
        return  operateDataList
    }



































}
