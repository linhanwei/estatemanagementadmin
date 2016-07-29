package welink.estate

import com.google.common.collect.Lists
import org.joda.time.DateTime
import org.joda.time.format.DateTimeFormat
import org.joda.time.format.DateTimeFormatter
import welink.common.Item


class ObjectTaggedController {

    //商品打标
    def chageTag() {

        Item item = Item.findById(params.long('itemId'))

//        Tags tags = Tags.findById(params.long('newTags'))
        //现传tagsList的内容
        List<String> tagsList=params.newTags ? Lists.newArrayList(params.newTags) : Collections.emptyList();

        //找到所有的营销类有效标签
        def tagsOnShow = ObjectTagged.findAllByArtificialIdAndStatus(item.id, 1 as byte)
//        if (tagsList.size()==0)
//        {
        tagsOnShow.each {
            ObjectTagged obj->
                Tags tag=Tags.findById(obj.tagId)
                if (("4").equals(tag.bit.toString())){
                    item.with {
                        it.hasShowcase=0 as byte
                        it.save(failOnError: true, flush: true)
                    }
                }
                obj.status= 0 as byte
                obj.save(failOnError: true, flush: true)
        }
//        }else
//        {
        //进行多个标签打标
        for (int i=0;i<tagsList.size();i++)
        {
            Tags onetag = Tags.findById(Long.parseLong(tagsList.get(i)))
//                int falg=0
//                tagsOnShow.each {
//                    ObjectTagged obj->
//                        Tags tag=Tags.findById(obj.tagId)
////                        if (("4").equals(tag.bit.toString()) && !("限购标".equals(onetag.name))){
//                        if (("4").equals(tag.bit.toString())){
//                            falg=1
//                            return  false
//                        }
//                        if (tag.id==onetag.id)
//                        {
//                            falg=1
//                            return  false
//                        }
//                }
//                if (falg){continue}

            //橱窗位---商品
            if (("4").equals(onetag.bit.toString()))
            {
                item.with {
                    it.hasShowcase=1 as byte
                    it.save(failOnError: true, flush: true)
                }
            }
            ObjectTagged objectTagged = ObjectTagged.findByArtificialIdAndTagId(item.id, onetag.id) ?: new ObjectTagged()
            //有效时间期限为10年
            objectTagged.startTime = new DateTime().toDate()
            objectTagged.endTime = new DateTime().plusYears(10).toDate()
            //进行标的赋值
            if("限购标".equals(onetag.name))
            {
                def xgmun=[:]
                if (params.limitNum) {
                    xgmun.put('xgLimitNum', params.int('limitNum'))
                }
                else
                {
                    xgmun.put('xgLimitNum', 0)
                }
                String xgcontent=com.alibaba.fastjson.JSON.toJSONString(xgmun)
                objectTagged.kv=xgcontent
            }
            //进行对抢购标的操作
            if ("抢购标".equals(onetag.name))
            {
                DateTimeFormatter formatter = DateTimeFormat.forPattern("yyyy-MM-dd HH:mm")
//                    增加抢购标，选择打抢购标的时候，需要输入活动价格，活动销售基数，活动展示倍数（对应object_tagged表中kv字段中的，activityPrice，baseSoldNum，multiple），
//                    活动开始时间，活动结束时间（对应object_tagged表中start_time和end_time），活动限量数（对应object_tagged表中的activity_num）
                def  qgcontent=[:]
                if (params.activityPrice){
                    qgcontent.put('activityPrice',new BigDecimal(params.activityPrice)*100L)
                }
                qgcontent.put('baseSoldNum',params.int('baseSoldNum'))
                qgcontent.put('multiple',params.int('multiple'))
                String qgJsoncontent=com.alibaba.fastjson.JSON.toJSONString(qgcontent)
                objectTagged.kv=qgJsoncontent

                //时间的赋值
                if(params.start_time){
                    objectTagged.startTime=formatter.parseDateTime(params.start_time).toDate()
                }
                if (params.end_time){
                    objectTagged.endTime=formatter.parseDateTime(params.end_time).toDate()
                }
                objectTagged.activityNum=params.int('activity_num')
            }



            objectTagged.artificialId= item.id
            objectTagged.tagId= onetag?.id
            objectTagged.status= 1 as byte
            objectTagged.type= onetag?.type
            objectTagged.save(failOnError: true, flush: true)
        }
//        }



//        def limitmap = [:]
//
//        if (params.limitNum) {
//            limitmap.put('xgLimitNum', params.int('limitNum'))
//        }
//
//        String limitKv = com.alibaba.fastjson.JSON.toJSONString(limitmap)
//
//        ObjectTagged objectTagged = ObjectTagged.findByArtificialIdAndTagId(item.id, tags.id) ?: new ObjectTagged()
//
//        if (("4").equals(tags.bit.toString()))
//        {
//            item.with {
//                it.hasShowcase=1 as byte
//                it.save(failOnError: true, flush: true)
//            }
//        }
//
//        //打特价标
//        objectTagged.with {
//            it.kv = limitKv
//            it.artificialId = item.id
//            it.tagId = tags.id
////            it.startTime = new DateTime().toDate()
////            it.endTime = new DateTime().plusYears(20).toDate()
//            it.status = 1 as byte
//            it.type = tags?.type
//            it.save(failOnError: true, flush: true)
//        }

        //

        redirect(controller: 'itemInStock', action: 'index',params:[category: params.category,level1Category:params.level1Category,query:params.query])
    }

    //删除商品标签
    def deleteItemTag() {
        Item item = Item.findById(params.long('itemId'))
        Tags tags = Tags.findById(params.long('tagId'))
        if (tags && item) {
            ObjectTagged.findByArtificialIdAndTagIdAndStatus(item.id, tags.id, 1 as byte).with {
                it.status = 0 as byte
                save(failOnError: true, flush: true)
            }

            //LHD
            if ("4".equals(tags.bit.toString()))
            {
                item.with {
                    it.hasShowcase=0 as byte
                    it.save(failOnError: true, flush: true)
                }
            }

            render('true')
            return
        }

        response.status = 405
    }

    def index() {}


    def selectOneQuangouTag(){
        ObjectTagged objectTagged=ObjectTagged.findByArtificialIdAndTagId(params.long('itemid'),params.long('tid'))

    }



    //活动价格 限量数 活动开始时间，活动结束时间（对应object_tagged表中start_time和end_time） 活动销售基数0 活动展示倍数1
    //增加抢购标，选择打抢购标的时候，需要输入活动价格，活动销售基数，活动展示倍数（对应object_tagged表中kv字段中的，activityPrice，baseSoldNum，multiple），活动开始时间，活动结束时间（对应object_tagged表中start_time和end_time），活动限量数（对应object_tagged表中的activity_num）
}
