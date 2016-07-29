package welink.system

import grails.converters.JSON
import grails.orm.PagedResultList
import welink.business.OperateData
import welink.business.TradeDetail
import welink.common.AlipayBack
import welink.common.MikuSalesRecord
import welink.common.ProFitGetPay
import welink.common.Trade
import welink.common.WeixinBack
import welink.user.Profile
import welink.warehouse.MikuPOperateService

class MikuPayMoneyController {


    MikuPOperateService mikuPOperateService

    //【记录的是平台总支出金钱】
    def index() {
        //========退款========
        //支付宝
        List<AlipayBack> Alist=AlipayBack.findAllBySubjectAndTradeStatusAndIsTotalFeeAdjust("退款完成","TRADE_REFOUND","Y")
        //微信
        List<WeixinBack> Wlist=WeixinBack.findAllByDeviceInfoAndTradeType("退款成功","WEB")
        List<TradeDetail> allList=ToBeDetailByAlipay(Alist)
        allList.addAll(ToBeDetailByWx(Wlist))
        //各种支付总金额 与 总金额 [总笔数]
        Long alipayFeel=0,WxFeel=0,AppWxFeel=0,SumFeel=0,AllSum=0
        int alipayNum=0,WxNum=0,AppWxNum=0
        allList.each {
            SumFeel+=it.price
            if (it.payType == 1 as byte){
                alipayFeel+=it.price
                alipayNum++
            }
            else if (it.payType == 2 as byte){
                AppWxFeel+=it.price
                AppWxNum++
            }
            else if (it.payType == 3 as byte){
                WxFeel+=it.price
                WxNum++
            }
        }
        AllSum+=SumFeel


        //========提现=====
        //支付宝
        List<AlipayBack> Alist1=AlipayBack.findAllByPaymentTypeAndTradeStatus("企业付款","BATCH_TRANS_SUCCESS")
        //微信
        List<WeixinBack> Wlist1=WeixinBack.findAllByDeviceInfoAndTradeType("提现分润","WEB")
        List<TradeDetail> allList1=ToBeGetPayByAlipay(Alist1)
        allList1.addAll(ToBeGetPayByWx(Wlist1))
        //各种支付总金额 与 总金额 [总笔数]
        Long alipayFeel1=0,WxFeel1=0,SumFeel1=0
        int alipayNum1=0,WxNum1=0
        allList1.each {
            SumFeel1+=it.price
            if (it.payType == 1 as byte){
                alipayFeel1+=it.price
                alipayNum1++
            }
            else if (it.payType == 2 as byte){
                WxFeel1+=it.price
                WxNum1++
            }
        }
        AllSum+=SumFeel1


        return [
                //退款
                alipayFeel:alipayFeel,
                WxFeel:WxFeel,
                AppWxFeel:AppWxFeel,
                SumFeel:SumFeel,
                AllSum:AllSum,
                alipayNum:alipayNum,
                WxNum:WxNum,
                AppWxNum:AppWxNum,
                total:allList.size(),
                //提现
                txalipayFeel:alipayFeel1,
                txWxFeel:WxFeel1,
                txSumFeel:SumFeel1,
                txalipayNum:alipayNum1,
                txWxNum:WxNum1,
                txtotal:allList1.size()
        ]



    }

    //退款详情页面
    def getRefund(){
        //支付宝
        List<AlipayBack> Alist=AlipayBack.findAllBySubjectAndTradeStatusAndIsTotalFeeAdjust("退款完成","TRADE_REFOUND","Y")
        //微信
        List<WeixinBack> Wlist=WeixinBack.findAllByDeviceInfoAndTradeType("退款成功","WEB")
        List<TradeDetail> allList=ToBeDetailByAlipay(Alist)
        allList.addAll(ToBeDetailByWx(Wlist))
        //各种支付总金额 与 总金额 [总笔数]
        Long alipayFeel=0,WxFeel=0,AppWxFeel=0,SumFeel=0
        int alipayNum=0,WxNum=0,AppWxNum=0
        allList.each {
            SumFeel+=it.price
            if (it.payType == 1 as byte){
                alipayFeel+=it.price
                alipayNum++
            }
            else if (it.payType == 2 as byte){
                AppWxFeel+=it.price
                AppWxNum++
            }
            else if (it.payType == 3 as byte){
                WxFeel+=it.price
                WxNum++
            }
        }
        return [
                alipayFeel:alipayFeel,
                WxFeel:WxFeel,
                AppWxFeel:AppWxFeel,
                SumFeel:SumFeel,
                alipayNum:alipayNum,
                WxNum:WxNum,
                AppWxNum:AppWxNum,
                total:allList.size(),
                list:allList
        ]
    }

    //提现分润详情页面
    def getSharePay(){
        //支付宝
        List<AlipayBack> Alist=AlipayBack.findAllByPaymentTypeAndTradeStatus("企业付款","BATCH_TRANS_SUCCESS")
        //微信
        List<WeixinBack> Wlist=WeixinBack.findAllByDeviceInfoAndTradeType("提现分润","WEB")
        List<TradeDetail> allList=ToBeGetPayByAlipay(Alist)
        allList.addAll(ToBeGetPayByWx(Wlist))
        //各种支付总金额 与 总金额 [总笔数]
        Long alipayFeel=0,WxFeel=0,SumFeel=0
        int alipayNum=0,WxNum=0
        allList.each {
            SumFeel+=it.price
            if (it.payType == 1 as byte){
                alipayFeel+=it.price
                alipayNum++
            }
            else if (it.payType == 2 as byte){
                WxFeel+=it.price
                WxNum++
            }
        }
        return [
                alipayFeel:alipayFeel,
                WxFeel:WxFeel,
                SumFeel:SumFeel,
                alipayNum:alipayNum,
                WxNum:WxNum,
                total:allList.size(),
                list:allList
        ]
    }


    //将AlipayBack变成TradeDetail
    //提现时间  提现金额  提现人账户 提现人手机  支付类型
    def ToBeGetPayByAlipay(List<AlipayBack> Alist){
        List<TradeDetail> allList=new ArrayList<TradeDetail>()
        Alist.each {
            TradeDetail tradeDetail=new TradeDetail()
            tradeDetail.id=it.id
            tradeDetail.buyerMemo="支付宝提现"
            tradeDetail.dateCreated=it.dateCreated
            tradeDetail.price=new Double(Double.parseDouble(it.discount)*100).longValue()
            //支付方式
            tradeDetail.payType=1 as byte
            tradeDetail.info=it.sellerEmail
            tradeDetail.courierMobile=it.buyerEmail
            allList.add(tradeDetail)
        }
        return allList
    }

    //将WinXinBack变成TradeDetail
    //提现时间  提现金额  提现人账户 提现人手机  支付类型
    def ToBeGetPayByWx(List<WeixinBack> wlist){
        List<TradeDetail> allList=new ArrayList<TradeDetail>()
        wlist.each {
            TradeDetail tradeDetail=new TradeDetail()
            tradeDetail.id=it.id
            tradeDetail.buyerMemo=it.deviceInfo
            tradeDetail.dateCreated=it.dateCreated
            tradeDetail.price=it.totalFee
            //支付方式
            tradeDetail.payType=2 as byte
            tradeDetail.info=it.attach
            allList.add(tradeDetail)
        }
        return allList
    }



    //将AlipayBack变成TradeDetail
    //退款时间  退款金额  退款的人 退款人手机  退款的项目  支付类型  退款的订单
    def ToBeDetailByAlipay(List<AlipayBack> Alist){
        List<TradeDetail> allList=new ArrayList<TradeDetail>()
        Alist.each {
            TradeDetail tradeDetail=new TradeDetail()
            tradeDetail.id=it.id
            tradeDetail.buyerMemo="支付宝退款"
            tradeDetail.tradeId=it.outTradeNo
            tradeDetail.dateCreated=it.dateCreated
            tradeDetail.price=new Double(Double.parseDouble(it.discount)*100).longValue()
            tradeDetail.alipayNo=it.tradeNo
            Trade trade=Trade.findByTradeId(Long.parseLong(it.outTradeNo))
            if (trade){
                tradeDetail.memo=trade.title
                //支付方式
                tradeDetail.payType=1 as byte
                Profile profile=Profile.findById(trade.buyerId)
                if (profile){
                    tradeDetail.info=profile.nickname
                    tradeDetail.courierMobile=profile.mobile
                }
            }
            allList.add(tradeDetail)
        }
        return allList
    }


    //将WinXinBack变成TradeDetail
    //退款时间  退款金额  退款的人 退款人手机  退款的项目  支付类型  退款的订单
    def ToBeDetailByWx(List<WeixinBack> wlist){
        List<TradeDetail> allList=new ArrayList<TradeDetail>()
        wlist.each {
            TradeDetail tradeDetail=new TradeDetail()
            tradeDetail.id=it.id
            tradeDetail.buyerMemo=it.nonceStr
            tradeDetail.tradeId=it.outTradeNo
            tradeDetail.dateCreated=it.dateCreated
            tradeDetail.price=it.totalFee
            tradeDetail.alipayNo=it.transactionId
            Trade trade=Trade.findByTradeId(Long.parseLong(it.outTradeNo))
            //支付方式
            if ("App微信支付退款".equals(it.nonceStr)){
                tradeDetail.payType=2 as byte
            }else{
                tradeDetail.payType=3 as byte
            }
            if (trade){
                tradeDetail.memo=trade.title
                Profile profile=Profile.findById(trade.buyerId)
                if (profile){
                    tradeDetail.info=profile.nickname
                    tradeDetail.courierMobile=profile.mobile
                }
            }
            allList.add(tradeDetail)
        }
        return allList
    }



    //进行财务需要的信息
    def list(){
        //查询订单总数 总金额
        PagedResultList pagedResultList=Trade.createCriteria().list(max: 1000000, offset:0) {
            'in'('type', [1,9] as byte[])
            'in'('status', [4, 6, 5, 7, 20] as byte[])
            eq('returnStatus', 0 as byte)
        }
        //订单总数
        int tradeSum=0
        //订单总金额
        int tradeFee=0
        pagedResultList.iterator().each {
            Trade trade ->
                tradeSum++
                tradeFee+=trade.totalFee
        }


        //查询的是分润的总金额
        int  frsum=0
        int  frfee=0
        PagedResultList frlist=MikuSalesRecord.createCriteria().list(max: 1000000, offset:0) {
            //return_status 不等于 5
            not {
                eq('returnStatus',5L)
            }

        }
        frlist.iterator().each {
            MikuSalesRecord mikuSalesRecord->
                frsum++
                frfee+=mikuSalesRecord.shareFee
        }

        //查询可提现的总金额
        int  ktxsum=0
        int  ktxfee=0
        int  wxktxsum=0
        int  wxktxfee=0
        int  alipaysum=0
        int  alipayfee=0

        //进行已经提现金额
        int yjtxwxfee=0
        int yjtxwxnum=0
        int yjtxaliapayfee=0
        int yjtxaliapaynum=0

        //在审核中
        int shwxnum=0
        int shwxfee=0
        int shalipayfee=0
        int shalipaynum=0
        PagedResultList ktxlist=ProFitGetPay.createCriteria().list(max: 1000000, offset:0) {
            //不等于2 is_getpay
            not {
                eq('status',2 as byte)
            }
        }
        ktxlist.iterator().each {
            ProFitGetPay proFitGetPay->
                ktxsum++
                ktxfee+=proFitGetPay.getpayFee
                if (proFitGetPay.getpayType==1L){
                    alipaysum++
                    alipayfee+=proFitGetPay.getpayFee

                    //统计已经提现与未提现数据
                    if (proFitGetPay.status == 1 as byte){
                        yjtxaliapaynum++
                        yjtxaliapayfee+=proFitGetPay.getpayFee
                    }else {
                        shalipaynum++
                        shalipayfee+=proFitGetPay.getpayFee
                    }

                }else if(proFitGetPay.getpayType==2L){
                    wxktxsum++
                    wxktxfee+=proFitGetPay.getpayFee

                    //统计已经提现与未提现数据
                    if (proFitGetPay.status == 1 as byte){
                        yjtxwxnum++
                        yjtxwxfee+=proFitGetPay.getpayFee
                    }else {
                        shwxnum++
                        shwxfee+=proFitGetPay.getpayFee
                    }
                }
        }

        return [
                tradeSum:tradeSum ,
                tradeFee:tradeFee,
                frsum:frsum,
                ktxfee:ktxfee,
                ktxsum:ktxsum,
                alipayfee:alipayfee,
                wxktxfee:wxktxfee,
                alipaysum:alipaysum,
                wxktxsum:wxktxsum,
                yjtxwxfee:yjtxwxfee,
                yjtxwxnum:yjtxwxnum,
                yjtxaliapayfee:yjtxaliapayfee,
                yjtxaliapaynum:yjtxaliapaynum,

                shwxnum:shwxnum,
                shwxfee:shwxfee,
                shalipayfee:shalipayfee,
                shalipaynum:shalipaynum,

                frfee:frfee
        ]

    }


    //进行统计值的统计
    def  opratingTradeData(){
        //接收类型的是：type --> Fee  num  Frun  FrunNum
        //接收的时间标示: flag  --> Y  M
        //具体的时间值：time
        String  type=params.type
        String  flag=params.flag
        String  time=params.time
        List<OperateData> sumlist=mikuPOperateService.getTradeFeeByTimeType(flag,time,type)
        render(sumlist as JSON)
    }



    def  operTradeData(){

    }


}
