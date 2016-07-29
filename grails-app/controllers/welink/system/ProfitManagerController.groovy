package welink.system

import com.alibaba.fastjson.JSON
import org.apache.shiro.SecurityUtils
import org.apache.shiro.subject.Subject
import welink.business.remainData
import welink.common.MikuShareLevel
import welink.user.Employee

class ProfitManagerController {

    def index() {
        List<MikuShareLevel> mlist= MikuShareLevel.findAllByIsDeleted(0 as byte)
        return [
                mlist  : mlist,
                total  : mlist.size(),
                params : params,
        ]


    }


    //进行添加对应的的分润等级
    def addProfitLevel()
    {
    withForm {
        Subject currentUser = SecurityUtils.getSubject()
        String name=currentUser.principals.toString()
        def user = Employee.findByUsername(name)
        def profitname=params.profitname
        def profitpercent=params.long('profitpercent')
        def profitid=params.long('profitid')
        Integer weight = params.int('weight')
        def profitInfo=params.profitInfo
        new MikuShareLevel().with {
            it.id=profitid
            it.creatorName=name
            it.levelName=profitname
            it.defaultShareScale=profitpercent
            it.weight=weight
            it.isDeleted=0 as byte
            it.memo=profitInfo
            it.dateCreated=new Date()
            it.creatorId=user.id
            save(failOnError: true, flush: true)
        }
        redirect(controller: 'ProfitManager', action: 'index')
        return

    }.invalidToken {
        // bad request
        //response.status = 405
    }


    }


    //进行编辑分润等级
    def edit()
    {
        def id=params.long('id')
        MikuShareLevel oneMl=MikuShareLevel.findById(id)
        return [
                oneLevel:oneMl
        ]

    }


    //进行修改的分润等级
    def updateProfitLevel()
    {
        //获取的是修改level的信息
        def id=params.long('levelid')
        Subject currentUser = SecurityUtils.getSubject()
        String name=currentUser.principals.toString()
        def user = Employee.findByUsername(name)

        def profitname=params.profitname
        def profitpercent=params.long('profitpercent')
        Integer weight = params.int('weight')
        def profitInfo=params.profitInfo

        MikuShareLevel one=MikuShareLevel.findById(id)
        one.with {
            it.creatorName=name
            it.levelName=profitname
            it.defaultShareScale=profitpercent
            it.weight=weight
            it.isDeleted=0 as byte
            it.memo=profitInfo
            it.lastUpdated=new Date()
            it.creatorId=user.id
            it.save(failOnError: true, flush: true)
        }

        redirect(controller: 'ProfitManager', action: 'index')
    }


    //删除操作
    def deleteOneLevel()
    {
        def id=params.long('id')
        Subject currentUser = SecurityUtils.getSubject()
        String name=currentUser.principals.toString()
        def user = Employee.findByUsername(name)
        MikuShareLevel one=MikuShareLevel.findById(id)
        one.with {
            it.isDeleted=1 as byte
            it.lastUpdated=new Date()
            it.creatorId=user.id
            it.creatorName=name
            it.save(failOnError: true, flush: true)
        }
        redirect(controller: 'ProfitManager', action: 'index')
    }

    //ajax进行查询对应对应的比例
    def getAllPercent()
    {
        def newPercent=params.long('profitpercent')
        List<MikuShareLevel> mlist= MikuShareLevel.findAllByIsDeleted(0 as byte)
        Long sum=0
        mlist.each {
            MikuShareLevel om->
                System.out.print(om.defaultShareScale)
                sum+=om.defaultShareScale

        }
//        remainData oner=new remainData();
//        oner.sum=sum.toString();
//        oner.remian=100-sum;
//        if (newPercent+sum>100)
//        {
//            oner.flag="0"
//        }
//        else
//        {
//            oner.flag="1"
//        }
        render(sum)
    }




    //更新的时候过来的提示
    def getUpAllpercent()
    {
        def id=params.long('id')
        List<MikuShareLevel> mlist= MikuShareLevel.findAllByIdNotEqualAndIsDeleted(id,0 as byte)
        Long sum=0
        mlist.each {
            MikuShareLevel om->
                System.out.print(om.defaultShareScale)
                sum+=om.defaultShareScale

        }
        render(sum)
    }



}
