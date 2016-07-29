package welink.common

import com.google.common.collect.ImmutableMap
import com.google.common.collect.Lists
import grails.orm.PagedResultList
import org.apache.commons.lang3.StringUtils
import org.joda.time.DateTime
import org.joda.time.format.DateTimeFormat
import org.joda.time.format.DateTimeFormatter
import sun.security.provider.SHA
import welink.estate.Banner
import welink.estate.Community
import welink.estate.ItemAtHalf

class CouponController {

    static ImmutableMap<Integer, String> yhType = ImmutableMap.builder() //
            .put(2001, "满减")
            .put(2002, "新人")
            .put(2003, "邀请")
            .put(2004, "注册")
            .build()

    def deleteCoupon(){
        if (params.id) {
            Coupon coupon = Coupon.findById(params.long('id'))
            if (coupon) {
                coupon.status = 0
                if (coupon.save(failOnError: true, flush: true)) {
                    render('true')
                    return
                }
            }
        }
        response.status = 405
    }

    def addCoupons() {

        DateTimeFormatter formatter = DateTimeFormat.forPattern("yyyy-MM-dd HH:mm")

        withForm {
            Long id=params.long('id')
//            Long shopId = params.long('shopId')
//            DateTime startTime = params.startTime?formatter.parseDateTime(params.startTime):null
//            DateTime endTime = params.endTime?formatter.parseDateTime(params.endTime):null
            String name = params.name
            String description = params.description
            Integer value = params.int('value')
            Integer type = params.int('type')
            Byte status = 1 as byte
            Integer minVaule = params.int('minValue')
            if (minVaule>=0){
                minVaule=minVaule*100
            }
            if (value>=0){
                value=value*100
            }
//            String probability = params.probability
//            Long limitNum = params.long('limitNum')
//            String attributes = params.attributes
            List<String> pics = params.'item-pic' ? Lists.newArrayList(params.'item-pic') : Collections.emptyList()
            List<String> pdpics = params.'detail-pic' ? Lists.newArrayList(params.'detail-pic') : Collections.emptyList()
            List<String> npics=new ArrayList<String>()
            List<String> pnpics=new ArrayList<String>()
            //正常使用的优惠券的信息
            if (pics.size())
            {
                npics.add(pics.get(0))
            }
            //过期优惠券图片信息
            if (pdpics.size())
            {
                pnpics.add(pdpics.get(0))
            }

            String picUrl=StringUtils.join(npics, ';')

            //过期图片信息
            String pdicUrl=StringUtils.join(pnpics, ';')
            //有效天数
            Long validity=params.long('validity')
            //发放数量
            Long giveNum=params.long('giveNum')

            Coupon coupon = id?Coupon.findById(id):new Coupon()
            coupon.with {
//                it.shopId = shopId
//                it.startTime =startTime? startTime.toDate():null
//                it.endTime = endTime?endTime.toDate():null
                it.name = name
                it.description = description
                it.value = value
                it.type = type
                it.status = status
                it.minValue = minVaule
//                it.probability = probability
//                it.limitNum = limitNum
//                it.attributes = attributes
                it.picUrl=picUrl
                it.expirationPicUrl=pdicUrl
                it.giveNum=giveNum?giveNum:1
                it.validity=validity?validity:15
                save(failOnError: true, flush: true)
            }
            redirect(controller: 'coupon', action: 'index')
            return;
        }.invalidToken {
            // bad request
            response.status = 405
        }

    }

    def addCouponHtml() {
//        def shops = Shop.findAllByApproveStatus(1 as byte)
        def shops = Shop.findAllByStatus(1 as byte)
        List<Shop> sList=new ArrayList<Shop>()
        shops.each {
            Shop ss->
                if(ss.shopId)
                {
                    Community cc=Community.findById(ss.shopId)
                    ss.title=cc.name
                    sList.add(ss)
                }
        }
        return [
                typeMap  : yhType,
                shops: sList
        ]

    }

    def index() {

        def i = Coupon.createCriteria()
        PagedResultList pagedResultList = i.list(max: params.max ?: 10, offset: params.offset ?: 0) {
            eq('status', 1 as byte)
            order("startTime", "desc")
        }

        return [

                couponList: pagedResultList,
                total     : pagedResultList.totalCount,
                params    : params,
        ]
    }


    def edit()
    {
        Long id=params.long('id')
        Coupon ccp=Coupon.findById(id)
        def shops = Shop.findAllByStatus(1 as byte)
        List<Shop> sList=new ArrayList<Shop>()
        shops.each {
            Shop ss->
                if(ss.shopId)
                {
                    Community cc=Community.findById(ss.shopId)
                    ss.title=cc.name
                    sList.add(ss)
                }
        }
        return [
                typeMap  : yhType,
                shops: sList,
                coupon:ccp]
    }

}
