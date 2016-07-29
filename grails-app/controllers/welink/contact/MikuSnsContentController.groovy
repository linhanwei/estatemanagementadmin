package welink.contact

import com.google.common.collect.ImmutableMap
import com.google.common.collect.Lists
import grails.orm.PagedResultList
import grails.transaction.Transactional
import org.apache.commons.lang3.StringUtils
import org.apache.shiro.SecurityUtils
import org.apache.shiro.subject.Subject
import welink.user.Employee
import welink.user.Profile

class MikuSnsContentController {
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

    def index() {



    }


    def list(){
        def mksc=MikuMyDynamic.createCriteria()
        PagedResultList pagedResultList= mksc.list(max: params.max ?: 10, offset: params.offset ?: 0) {
            order("lastUpdated","desc")
        }
        List<MikuSnsContentDetail> list=new ArrayList<MikuSnsContentDetail>()
        //进行对数据的封装【动态表--->文章表】
        pagedResultList.each {
            MikuMyDynamic mikuMyDynamic->
                MikuSnsContent mikuSnsContent=MikuSnsContent.findById(mikuMyDynamic.getGoalId())
                if(mikuSnsContent){
                    MikuSnsContentDetail mikuSnsContentDetail=doOneContentDetail(mikuMyDynamic,mikuSnsContent)
                    list.add(mikuSnsContentDetail)
                }
        }
        return [
                list: list,
                total  : pagedResultList.totalCount,
                params : params,
                PageMap:PageMap
        ]
    }

    def edit(){
        Long dyId=params.long('dyId')
        MikuSnsContent mikuSnsContent=new  MikuSnsContent()
        MikuMyDynamic mikuMyDynamic=MikuMyDynamic.findById(dyId)
        if(mikuMyDynamic){
            //查找对应的文章
            mikuSnsContent=MikuSnsContent.findById(mikuMyDynamic.goalId)
        }
        List<Profile> profileList=Profile.findAllByIdentityCard('mikusysidcard')
        return [
                list:profileList,
                mikuSnsContent:mikuSnsContent,
                mikuMyDynamic:mikuMyDynamic
        ]
    }


    def delete(){
        Long id=params.long('id')
        //内容表
        MikuSnsContent mikuSnsContent =MikuSnsContent.findById(id)
        if (mikuSnsContent){
            //活动表
            MikuMyDynamic mikuMyDynamic= MikuMyDynamic.findByGoalId(mikuSnsContent.id)
            //2个表都进行删除了
            mikuMyDynamic.delete(flush: true);
            mikuSnsContent.delete(flush: true);
        }
        redirect(action: 'list')
    }


    def add(){
        List<Profile> profileList=Profile.findAllByIdentityCard('mikusysidcard')
        return [
                list:profileList
        ]
    }

    //添加一篇新的系统文章
    @Transactional
    def publish(){
        //用户的图像
        List<String> urlPics = params.'url-pic' ? Lists.newArrayList(params.'url-pic') : Collections.emptyList()
        //用户名称
        String userName=params.userName
        //文章标题
        String contentTitle=params.contentTitle
        //文章标题简称
        String contentShortTitle=params.contentShortTitle
        //内容摘要
        String contentAbstract=params.contentAbstract
        //封面图
        List<String> itemPics = params.'item-pic' ? Lists.newArrayList(params.'item-pic') : Collections.emptyList()
        //缩略图
        List<String> detailPics = params.'detail-pic' ? Lists.newArrayList(params.'detail-pic') : Collections.emptyList()
        //内容图
        List<String> snsPic = params.'sns-pic' ? Lists.newArrayList(params.'sns-pic') : Collections.emptyList()
        //文字内容
        String content=params.content
        //添加用户的标示
        String userInfoflag=params.userInfoflag
        //被引用资源类型对象类型:1、客服/私人管家2、文章3、课程4、私人定制线下店
        Byte referencedGoalType=params.byte('referencedGoalType')
        //用于处理特殊文章：0、正常文章1、负面文章（作者可见，其它用户不可见） 2、待定
        Byte specialFlag=params.byte('specialFlag')
        Long userId=params.long('userId')
        Long dyId=params.long('dyId')
        Long sId=params.long('sId')
        //1.首先添加操作用户   2.文章内容添加  3.文章活动表的添加
        Profile profile=new Profile()
        if(userId){
            profile=Profile.findById(userId)
        }else {
            if("1".equals(userInfoflag)){
                profile.with {
                    it.nickname=userName
                    it.lemonName=userName
                    it.profilePic=StringUtils.join(urlPics, ';')
                    it.version=1L
                    it.identityCard="mikusysidcard"
                    it.mobile="999999"
                    it.dateCreated=new Date()
                    it.lastUpdated=new Date()
                    it.save(failOnError: true,flush: true)
                }

                Subject currentUser = SecurityUtils.getSubject()
                String name=currentUser.principals.toString()
                def user = Employee.findByUsername(name)
                //添加多一个用户关联用户
                MikuSnsProfile mikuSnsProfile=new MikuSnsProfile()
                mikuSnsProfile.with {
                    it.createrId=user.id
                    it.dateCreated=new Date()
                    it.lastUpdated=new Date()
                    it.profileId=profile.id
                    it.save(failOnError: true,flush: true)
                }
            }
        }
        //文章内容表的添加
        boolean snscontentflag=MikuSnsContent.findById(sId)?true:false
        MikuSnsContent mikuSnsContent=snscontentflag?MikuSnsContent.findById(sId):new MikuSnsContent()
        mikuSnsContent.with {
            it.userId=profile.id
            it.userName=profile.nickname
            it.contentCreateType=1 as byte
            it.contentTitle=contentTitle
            it.contentShortTitle=contentShortTitle
            it.contentAbstract=contentAbstract
            it.contentSurfacePicUrl=StringUtils.join(itemPics, ';')
            it.contenThumbPicUrl=StringUtils.join(detailPics, ';')
            it.content=content
            it.picUrls=StringUtils.join(snsPic, ';')
            it.referencedGoalType=referencedGoalType
            it.specialFlag=specialFlag
            it.version=1L
            it.dateCreated=new Date()
            it.lastUpdated=new Date()
            it.save(flush:true,failOnError: true)
        }

        //活动表
        boolean dyflag=MikuMyDynamic.findById(dyId)?true:false
        MikuMyDynamic mikuMyDynamic=dyflag?MikuMyDynamic.findById(dyId):new MikuMyDynamic()
        mikuMyDynamic.with {
            it.userId=profile.id
            it.userName=profile.nickname
            it.actionType=1 as byte
            it.goalType=2 as byte
            it.goalId=mikuSnsContent.id
            if (!dyflag){
                it.timesOfBrowsed=0
                it.timesOfPraised=0
                it.timesOfReferenced=0
                it.timesOfCommented=0
                it.timesOfCollected=0
            }
            it.topFlag=0 as  byte
            it.note="系统内容"
            it.isDelete=0 as  byte
            it.dateCreated=new Date()
            it.lastUpdated=new Date()
            it.save(flush:true,failOnError: true)
        }
        redirect(action: "list")
    }


    //处理2个东西
    def doOneContentDetail(MikuMyDynamic mikuMyDynamic,MikuSnsContent mikuSnsContent){
        MikuSnsContentDetail mikuSnsContentDetail=new MikuSnsContentDetail()
        mikuSnsContentDetail.with {
            it.cid=mikuSnsContent.id
            it.dyId=mikuMyDynamic.id
            it.dateCreate=mikuMyDynamic.dateCreated
            it.lastUpdate=mikuMyDynamic.lastUpdated
            it.userId=mikuMyDynamic.userId
            it.userName=mikuMyDynamic.userName
            it.contentTitle=mikuSnsContent.contentTitle
            it.contentShortTitle=mikuSnsContent.contentShortTitle
            it.contentAbstract=mikuSnsContent.contentAbstract
            it.contentSurfacePicUrl=mikuSnsContent.contentSurfacePicUrl
            it.contenThumbPicUrl=mikuSnsContent.contenThumbPicUrl
            it.content=mikuSnsContent.content
            it.timesOfBrowsed=mikuMyDynamic.timesOfBrowsed
            it.timesOfPraised=mikuMyDynamic.timesOfPraised
            it.timesOfReferenced=mikuMyDynamic.timesOfReferenced
            it.timesOfCommented=mikuMyDynamic.timesOfCommented
            it.timesOfCollected=mikuMyDynamic.timesOfCollected
        }
        return mikuSnsContentDetail
    }









}
