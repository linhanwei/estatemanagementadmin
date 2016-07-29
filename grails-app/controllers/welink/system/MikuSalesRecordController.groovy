package welink.system

import com.google.common.collect.ImmutableMap
import grails.orm.PagedResultList
import org.apache.commons.lang3.StringUtils
import org.joda.time.format.DateTimeFormat
import org.joda.time.format.DateTimeFormatter
import welink.business.SalesRecord
import welink.common.MikuItemSharePara
import welink.common.MikuSalesRecord
import welink.user.Profile

class MikuSalesRecordController {



    static ImmutableMap<String, String> TOTAL_FEE_OP_MAP = ImmutableMap.builder() //
            .put(">", "大于")
            .put("=", "等于")
            .put("<", "小于")
            .build()

    static ImmutableMap<String, String> ORDER_MAP = ImmutableMap.builder() //
            .put("+", "正序")
            .put("-", "倒序")
            .build()


    def index() {
        // 排序规则
        def ord = params.order
        //进行比较符号
        def totalFeeOp=params.totalFeeOp
        // 开始时间
        String startTime = params.startTime

        // 结束时间
        String endTime = params.endTime

        //订单号
        Long tradeidFalg=params.long('tradeidFalg')

        DateTimeFormatter formatter = DateTimeFormat.forPattern("yyyy-MM-dd HH:mm")

        Date start = StringUtils.isNotBlank(startTime) ? formatter.parseDateTime(startTime).toDate() : null

        Date end = StringUtils.isNotBlank(endTime) ? formatter.parseDateTime(endTime).toDate() : null
        //金钱的多少
        Long  targetTotalFee=params.long('targetTotalFee')
        if (targetTotalFee)
        {
            targetTotalFee=targetTotalFee*10
        }

        def  m=MikuSalesRecord.createCriteria()
        PagedResultList pagedResultList
        pagedResultList = m.list(max: params.max ?: 10, offset: params.offset ?: 0) {
            if (start != null) {
                gt("confirmDate", start)
            }

            if (end != null) {
                lt("confirmDate", end)
            }


            if(targetTotalFee)
            {
                if (totalFeeOp.equals(">"))
                {
                    gt("shareFee",targetTotalFee)
                }
                if (totalFeeOp.equals("="))
                {
                    eq("shareFee",targetTotalFee)
                }
                if (totalFeeOp.equals("<"))
                {
                    lt("shareFee",targetTotalFee)
                }
            }

            if(ord)
            {
                if (ord.equals("-"))
                {
                    order('shareFee','desc')
                }
                else if (ord.equals("+"))
                {
                    order('shareFee','asc')
                }
            }

            if (tradeidFalg)
            {
                eq('tradeId',tradeidFalg)
            }

            order('confirmDate','desc')

        }

        List<SalesRecord> srList=new ArrayList<SalesRecord>()
        //进行对分润信息的获取
        pagedResultList.iterator().each {
            MikuSalesRecord msr->
                Profile p=Profile.findById(msr.agencyId)
                srList.add(getSpecificInfo(p,msr))
//                if (p)
//                {
//                    srList.add(getSpecificInfo(p,msr))
//                }
        }
        def record= new SalesRecord()

        return [
                total          : pagedResultList?.totalCount,
                viewTotal      : pagedResultList?.totalCount,
                params         : params,
                record         : record,
                orderMap       : ORDER_MAP,
                totalFeeOpMap  : TOTAL_FEE_OP_MAP,
                recordList     : srList
        ]



    }

    def lookItemDetail()
    {
        MikuSalesRecord record=MikuSalesRecord.findById(params.long('id'))
        Profile p=Profile.findById(record.agencyId)
        SalesRecord sr=getSpecificInfo(p,record)
        render(template: "itemDetail", model: [
                record         : sr
        ])

    }



    def moneyChange()
    {
            List<MikuItemSharePara> msrList=MikuItemSharePara.findAll()
            msrList.each {
                MikuItemSharePara ms->
                    if (ms.itemCostFee)
                    {
                       ms.itemCostFee=ms.itemCostFee*10
                    }
                    if (ms.itemProfitFee)
                    {
                        ms.itemProfitFee=ms.itemProfitFee*10
                    }
                    if (ms.itemShareFee)
                    {
                        ms.itemShareFee=ms.itemShareFee*10
                    }
                    ms.save(failOnError: true, flush: true)
            }
        render("true")
    }








    def  getSpecificInfo(Profile p,MikuSalesRecord msr)
    {
        SalesRecord sr=new SalesRecord()
        if (p)
        {
            sr=new SalesRecord(
                    id: msr.id,
                    agencyId: msr.agencyId,
                    agencyLevelName: msr.agencyLevelName,
                    tradeId: msr.tradeId,
                    buyerId: msr.buyerId,
                    buyerName: msr.buyerName,
                    buyerMobile: msr.buyerMobile,
                    itemId: msr.itemId,
                    itemName: msr.itemName,
                    num: msr.num,
                    price: msr.price,
                    amount: msr.amount,
                    payTime: msr.payTime,
                    confirmDate: msr.confirmDate,
                    returnDate: msr.returnDate,
                    shareFee: msr.shareFee,
                    parameter: msr.parameter,
                    version: msr.version,
                    dateCreated: msr.dateCreated,
                    lastUpdated: msr.lastUpdated,
                    agencyName: p.nickname,
                    agencyMoblie: p.mobile
            )
        }
        else
        {
            sr=new SalesRecord(
                    id: msr.id,
                    agencyId: msr.agencyId,
                    agencyLevelName: msr.agencyLevelName,
                    tradeId: msr.tradeId,
                    buyerId: msr.buyerId,
                    buyerName: msr.buyerName,
                    buyerMobile: msr.buyerMobile,
                    itemId: msr.itemId,
                    itemName: msr.itemName,
                    num: msr.num,
                    price: msr.price,
                    amount: msr.amount,
                    payTime: msr.payTime,
                    confirmDate: msr.confirmDate,
                    returnDate: msr.returnDate,
                    shareFee: msr.shareFee,
                    parameter: msr.parameter,
                    version: msr.version,
                    dateCreated: msr.dateCreated,
                    lastUpdated: msr.lastUpdated,
                    agencyName: '无代理',
                    agencyMoblie: ''
            )
        }
        return  sr
    }
}
