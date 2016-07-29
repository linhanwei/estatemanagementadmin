package welink.system

import com.google.common.collect.ImmutableMap
import grails.orm.PagedResultList
import welink.business.AgencyInfo
import welink.common.MikuUserAgency
import welink.user.Profile

class MikuUserAgencyController {

    static ImmutableMap<Integer, String> PageMap = ImmutableMap.builder() //
            .put(5, "5")
            .put(10, "10")
            .put(20, "20")
            .put(30, "30")
            .put(40, "40")
            .put(50, "50")
            .put(100, "100")
            .put(200, "200")
            .build()

    //代理信息表
    def index()
    {
        //代理ID
        def puserId =params.long('puserId')
        //电话号码
        def mobile =params.mobile
        //上级代理
        def parentId=params.long('parentId')



        def  p=Profile.createCriteria()
        PagedResultList pagedResultList
        pagedResultList = p.list(max: params.max ?: 10, offset: params.offset ?: 0) {
            if (puserId)
            {
                eq('id',puserId)
            }
            if (mobile)
            {
                eq('mobile',mobile)
            }
            if (parentId)
            {
                def mList=MikuUserAgency.findAllByPUserId(parentId)
                if (mList) {
                    'in'("id", mList*.userId)
                } else {
                    eq("id", -1L)
                }
            }
        }



        List<AgencyInfo> acyList=new ArrayList<AgencyInfo>()
        pagedResultList.iterator().each {
            Profile pp->
                MikuUserAgency mua=MikuUserAgency.findByUserId(pp.id)
                acyList.add(getAgencyInfoData(pp,mua))
        }

        boolean falg=false
        if (mobile &&  pagedResultList?.totalCount==1){
            pagedResultList.iterator().each {
                Profile pp->
//                    MikuUserAgency mua=MikuUserAgency.findByUserId(pp.id)
//                    acyList.add(getAgencyInfoData(pp,mua))
                    //根据手机号码来进行查找他以下的代理的人的关系
                    //第一个等级的添加
                    List<MikuUserAgency> oneList=MikuUserAgency.findAllByPUserId(pp.id)
                    oneList.each {
                        MikuUserAgency mikuUserAgency->
                            Profile op=Profile.findById(mikuUserAgency.userId)
                            acyList.add(getAgencyInfoData(op,mikuUserAgency))
                    }
                    //第二个等级的添加
                    List<MikuUserAgency> twoList=MikuUserAgency.findAllByP2_userId(pp.id)
                    twoList.each {
                        MikuUserAgency mikuUserAgency->
                            Profile tp=Profile.findById(mikuUserAgency.userId)
                            acyList.add(getAgencyInfoData(tp,mikuUserAgency))

                    }
                    //第三个等级的添加
                    List<MikuUserAgency> threeList=MikuUserAgency.findAllByP3_userId(pp.id)
                    threeList.each {
                        MikuUserAgency mikuUserAgency->
                            Profile ttp=Profile.findById(mikuUserAgency.userId)
                            acyList.add(getAgencyInfoData(ttp,mikuUserAgency))
                    }
            }
            falg=true
        }

        AgencyInfo acy=new AgencyInfo()
        return [
                total          : falg?acyList.size():pagedResultList?.totalCount,
                viewTotal      : falg?1:pagedResultList?.totalCount,
                params         : params,
                PageMap        : PageMap,
                agencyInfo     : acy,
                profileList    : acyList,
                agencyInfo     : acy
        ]

    }

    def agencyDetail()
    {
        Long id=params.long('id')
        Profile profile=Profile.findById(id)
        MikuUserAgency mua=MikuUserAgency.findByUserId(id)
        AgencyInfo acy=getAgencyInfoData(profile,mua)
        render(template: "agencyDetail", model: [
                agencyInfo     : acy
        ])
    }


    //进行代理信息整合
    def getAgencyInfoData(Profile profile,MikuUserAgency mua)
    {
        AgencyInfo ai=new AgencyInfo()
        ai.agencyName=profile.nickname
        ai.agencyMobile=profile.mobile
        ai.isAgency=profile.isAgency
        ai.id=profile.id
        ai.agencyDateCreate=profile.dateCreated
        def query="select count(*) from MikuUserAgency where pUserId="+profile.id
        def sum=MikuUserAgency.executeQuery(query).sum()
        ai.childCount=sum
        if (mua)
        {
            ai.version=mua.version
            ai.userId=mua.userId
            ai.agencyLevel=mua.agencyLevel
            ai.pUserId=mua.pUserId
            ai.p2UserId=mua.p2_userId
            ai.p3UserId=mua.p3_userId
            ai.p4UserId=mua.p4_userId
            ai.p5UserId=mua.p5_userId
            ai.isParent=mua.isParent
            ai.path=mua.path
            ai.isValidated=mua.isValidated
            ai.dateCreated=mua.dateCreated
            ai.lastUpdated=mua.lastUpdated
            ai.isDeleted=mua.isDeleted
            if (mua.pUserId)
            {
                Profile p=Profile.findById(mua.pUserId)
                if (p)
                {
                    ai.pUserName=p.nickname
                    ai.pUserMobile=p.mobile
                }
            }

            if (mua.p2_userId)
            {
                Profile p=Profile.findById(mua.p2_userId)
                if (p)
                {
                    ai.p2UserName=p.nickname
                    ai.p2UserMobile=p.mobile
                }
            }

            if (mua.p3_userId)
            {
                Profile p=Profile.findById(mua.p3_userId)
                if (p)
                {

                    ai.p3UserName=p.nickname
                    ai.p3UserMobile=p.mobile
                }
            }


            if (mua.p4_userId)
            {
                Profile p=Profile.findById(mua.p4_userId)
                if (p)
                {
                    ai.p4UserName=p.nickname
                    ai.p4UserMobile=p.mobile
                }
            }
            if (mua.p5_userId)
            {
                Profile p=Profile.findById(mua.p5_userId)
                if (p)
                {
                    ai.p5UserName=p.nickname
                    ai.p5UserMobile=p.mobile
                }
            }

        }
        return ai
    }
}
