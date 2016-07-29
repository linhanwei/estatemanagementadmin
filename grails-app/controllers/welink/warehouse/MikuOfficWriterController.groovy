package welink.warehouse

import com.google.common.collect.ImmutableMap
import com.google.common.collect.Lists
import grails.orm.PagedResultList
import org.apache.commons.lang3.StringUtils
import org.apache.shiro.SecurityUtils
import org.apache.shiro.subject.Subject
import welink.user.Employee

class MikuOfficWriterController {
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

    static ImmutableMap<Integer, String> typeMap = ImmutableMap.builder() //
            .put(1, "单品")
            .put(2, "拼团")
            .put(3, "满减")
            .put(4, "其他")
            .build()

    static ImmutableMap<Integer, String> redirectTypeMap = ImmutableMap.builder() //
            .put(1, "Url")
            .put(2, "商品id")
            .put(3, "众筹项目id")
//            .put(4, "二级类目ID")
//            .put(5, "积分")
//            .put(6, "优惠劵")
//            .put(7, "品牌id")
//            .put(8, "搜索关键字")
//            .put(9, "众筹首页")
//            .put(10, "无")
            .build()

    def add(){
        return [
                redirectTypeMap:redirectTypeMap,
                PageMap:PageMap,
                typeMap:typeMap
        ]
    }

    def publish() {
        String advertorialTile=params.mtitle
        Byte advertorialType=params.byte('type')
        String articleTile=params.ltitle
        String articleContent=params.articleContent
        String salesReward=params.fee
        List<String> itemPics = params.'item-pic' ? Lists.newArrayList(params.'item-pic') : Collections.emptyList()
        List<String> detailPics = params.'detail-pic' ? Lists.newArrayList(params.'detail-pic') : Collections.emptyList()
        List<String> urlPics = params.'url-pic' ? Lists.newArrayList(params.'url-pic') : Collections.emptyList()
        String mallResourceUrl=params.contenturl
        String content=params.content
        Byte isstatus=params.byte('isstatus')

        int redirectType=params.redirectType?params.int('redirectType'):0

        Subject currentUser = SecurityUtils.getSubject()
        String name=currentUser.principals.toString()
        def user = Employee.findByUsername(name)

        Long id=params.long('id')
        Boolean flag=MikuAdvertorial.findById(id)?true:false
        MikuAdvertorial mikuAdvertorial=flag?MikuAdvertorial.findById(id):new MikuAdvertorial()

        mikuAdvertorial.with {
            it.advertorialTile=advertorialTile
            if (advertorialType){
                it.advertorialType=advertorialType
            }
            it.articleTile=articleTile
            it.articleContent=articleContent
            it.pics=StringUtils.join(itemPics, ';')
            it.posterProductPicUrl=StringUtils.join(urlPics, ';')
            it.salesReward=salesReward
            it.mallResourceUrl=mallResourceUrl
            it.posterPicUrl=StringUtils.join(detailPics, ';')
            it.articleContent=content
            it.lastUpdated=new Date()
            it.redirectType=redirectType
            if (!flag){
                it.dateCreated=new Date()
            }
            if(user){
                it.createrId=user.id
            }
            if (isstatus){
                it.status=1 as  byte
            }else {
                it.status=0 as  byte
            }
            it.save(flush: true,failOnError: true)
        }

        redirect(action: "list")

    }


    def edit(){
        Long id=params.long('id')
        MikuAdvertorial mikuAdvertorial=MikuAdvertorial.findById(id)
        return [
                redirectTypeMap:redirectTypeMap,
                typeMap:typeMap,
                data:mikuAdvertorial
        ]
    }


    def list(){
        String query=params.query
        String btitle=params.btitle
        def adr=MikuAdvertorial.createCriteria()
        PagedResultList pagedResultList= adr.list(max: params.max ?: 10, offset: params.offset ?: 0) {
            if (query){
                ilike("articleTile","%"+query+"%")
            }
            if (btitle){
                ilike("advertorialTile","%"+btitle+"%")
            }
            eq("isDelete",0 as byte)
            order("lastUpdated","desc")
        }

        return [
                typeMap:typeMap,
                PageMap:PageMap,
                list:pagedResultList,
                total  : pagedResultList.totalCount,
                params : params
        ]
    }



    def dostatus(){
        Byte flag=params.byte('flag')
        Long id=params.long('id')
        MikuAdvertorial mikuAdvertorial=MikuAdvertorial.findById(id)
        mikuAdvertorial.with {
            it.lastUpdated=new Date()
            it.status=flag
            it.save(flush: true,failOnError: true)
        }
        redirect(action: "list")
    }



    def delete(){
        Long id=params.long('id')
        MikuAdvertorial mikuAdvertorial=MikuAdvertorial.findById(id)
        mikuAdvertorial.with {
            it.lastUpdated=new Date()
            it.isDelete=1 as byte
            it.save(flush: true,failOnError: true)
        }
        redirect(action: "list")
    }





    def index(){
        def adr=MikuAdvertorial.createCriteria()
        PagedResultList pagedResultList= adr.list(max: params.max ?: 10, offset: params.offset ?: 0) {
            eq("isDelete",0 as byte)
            order("lastUpdated","desc")
        }

        return [
                typeMap:typeMap,
                list:pagedResultList,
                total  : pagedResultList.totalCount,
                params : params
        ]

    }


}
