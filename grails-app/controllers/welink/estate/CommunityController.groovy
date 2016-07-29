package welink.estate

import com.google.common.base.Preconditions
import com.google.common.collect.Lists
import com.welink.buy.utils.Constants
import com.welink.commons.commons.BizConstants
import grails.orm.PagedResultList
import org.apache.commons.lang3.StringUtils
import org.apache.shiro.SecurityUtils
import org.apache.shiro.subject.Subject
import org.joda.time.DateTime
import welink.activiti.ShopTaskService
import welink.common.Item
import welink.common.Shop
import welink.user.Employee

class CommunityController {

    def shopTaskService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def poly() {
        Long communityId = params.long('id')

        Community community = Community.findById(communityId)

        Preconditions.checkNotNull(community)

        def split = StringUtils.split(community.deliveryArea, ',')

        List<String> stringList = Lists.newArrayList()

        for (int i = 0; i < split.length / 2; i++) {
            stringList.add("${split[2 * i]},${split[2 * i + 1]}")
        }

        return [points: stringList]
    }

    def index() {

        def c = Community.createCriteria()
        PagedResultList pagedResultList = c.list(max: params.max ?: 10, offset: params.offset ?: 0) {
            order("id", "desc")
            eq('status', 1 as byte)
            if (params.query) {
                ilike("name", "%" + params.query + "%")
            }
        }

        return [
                communityList: pagedResultList,
                total        : pagedResultList.totalCount,
                params       : params,
        ]

    }

    def newCommunity() {

        Long communityId = params.long('communityId')

        Community community

        if (communityId) {

            community = Community.findById(communityId)
        }

        return [community: community]

    }

    def createCommunity() {

        withForm {


            Long communityId = params.long('communityId')

            Community community = Community.findById(communityId) ?: new Community()
            // 小区信息
            Long provinceId = params.long('province')
            String province = params.provinceName
            Long cityId = params.long('city')
            String city = params.cityName
            Long areaId = params.long('area')
            String area = params.areaName
            String name = params.name
            String description = params.description
            String phone = params.phone
            String location = params.location
            String lbs = StringUtils.trim(params.lbs)
            String openingHours = params.openingHours
            String deliveryArea = StringUtils.trim(params.deliveryArea)


            Preconditions.checkArgument(StringUtils.isNotBlank(deliveryArea))

            community.with {
                it.city = city
                it.cityId = cityId
                it.district = area
                it.districtId = areaId
                it.province = province
                it.provinceId = provinceId
                it.name = name
                it.phone = phone
                it.lbs = lbs
                it.openingHours = openingHours
                it.deliveryArea = deliveryArea
                it.location = location
                it.description = description
                save(failOnError: true, flush: true)
            }

            if(!Shop.findByShopId(community.id)){
                shopTaskService.createStationShopByCommunity(Shop.findByCityIdAndStatusAndType(community.cityId, 1 as byte, BizConstants.ShopTypeEnum.CITY_SHOP.action), community)
            }


            redirect(action: 'index')
        }.invalidToken {
            // bad request
            response.status = 405
        }
    }

    def editCommunity() {
        long id = params.long('id')

        Community community = Community.findById(id)

        [community: community]
    }

    boolean isCollectionOrArray(object) {
        [Collection, Object[]].any { it.isAssignableFrom(object.getClass()) }
    }

    def deleteCommunity() {
        if (params.id) {
            Community community = Community.findById(params.long('id'))
            if (community) {
                community.status = 0 as byte
                if (community.save(failOnError: true, flush: true)) {
                    def Slist=Shop.findAllByShopIdAndStatus(community.id,1 as byte)
                    Slist.each {
                        it.status=0 as byte
                        it.save(failOnError: true, flush: true)
                    }

                    render('true')
                    return
                }
            }
        }
        response.status = 405
    }
}
