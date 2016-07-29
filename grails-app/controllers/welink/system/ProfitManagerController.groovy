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


    //������Ӷ�Ӧ�ĵķ���ȼ�
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


    //���б༭����ȼ�
    def edit()
    {
        def id=params.long('id')
        MikuShareLevel oneMl=MikuShareLevel.findById(id)
        return [
                oneLevel:oneMl
        ]

    }


    //�����޸ĵķ���ȼ�
    def updateProfitLevel()
    {
        //��ȡ�����޸�level����Ϣ
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


    //ɾ������
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

    //ajax���в�ѯ��Ӧ��Ӧ�ı���
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




    //���µ�ʱ���������ʾ
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
