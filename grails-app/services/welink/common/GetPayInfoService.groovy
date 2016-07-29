package welink.common

import grails.transaction.Transactional
import welink.business.MikuGetPayDetail
import welink.business.MikuSalesRecordDetail

import java.text.SimpleDateFormat

@Transactional
class GetPayInfoService {

    def getOneGetPayInfo(List<MikuSalesRecord> mikuSalesRecordList,ProFitGetPay getpay,int size) {
        MikuGetPayDetail detail=new MikuGetPayDetail()
        detail.id=getpay.id
        detail.agencyNickname=getpay.agencyNickname
        detail.agencyMobile=getpay.agencyMobile
        detail.agencyLevelName=getpay.agencyLevelName
        detail.applyDate=getpay.applyDate
        detail.getpayType=getpay.getpayType
        detail.getpayFee=getpay.getpayFee
        detail.getpayAccount=getpay.getpayAccount
        detail.getpayUserName=getpay.getpayUserName
        detail.status=getpay.status
        detail.clerkerUserName=getpay.clerkerUserName
        detail.clerkerName=getpay.clerkerName
        detail.dateCreated=getpay.dateCreated
        detail.lastUpated=getpay.lastUpated
        Integer sucessN=size
        Integer failN=0
        Integer tingN=0
        Integer tradeNum=size
        boolean flag=false
//        if (mikuSalesRecordList.size()>0){
//            //���жԲ����˻����жϣ��п��˻��Ļ���ִ��֮ǰ���߼�������ȫ�����ǿ����˵�
//            mikuSalesRecordList.each {
//                MikuSalesRecord mikuSalesRecord->
//                    Trade trade=Trade.findByTradeId(mikuSalesRecord.tradeId)
//                    String orders=trade.orders
//                    String[] arr=orders.split(";")
//                    for (int i=0;i<arr.length;i++){
//                        Long myid=Long.parseLong(arr[i])
//                        if (myid){
//                            Order order=Order.findById(myid)
//                            if (order){
//                                Item item=Item.findById(order.artificialId)
//                                if (item && item.isrefund==1 as byte && trade.status!=20 as byte)
//                                {
//                                    flag=true
//                                }
//                            }
//                        }
//                    }
//            }
//
//            if (flag){
//                mikuSalesRecordList.each {
//                    MikuSalesRecord mikuSalesRecord->
//                        tradeNum++
//                        Trade trade=Trade.findByTradeId(mikuSalesRecord.tradeId)
//                        if (trade.status==20 as byte){
//                            sucessN++
//                        }else if ((trade.status== 4 as byte) || (trade.status==5 as  byte) || (trade.status==6 as  byte) || (trade.status==7 as  byte)){
//                            tingN++
//                        }else{
//                            failN++
//                        }
//                }
//            }
//            else
//            {
//                mikuSalesRecordList.each {
//                    MikuSalesRecord mikuSalesRecord->
//                        tradeNum++
//                        sucessN++
//                }
//            }
//        }
        detail.tradeNum=tradeNum
        detail.successNum=sucessN
        detail.failNum=failN
        detail.tingNum=tingN
        return detail
    }




    //����mikuSalesRecord��ȡ�Ķ�Ӧ��Detail
    def  getsalesRecordeDetail(List<MikuSalesRecord> mikuSalesRecordList){
        List<MikuSalesRecordDetail> mikuSalesRecordDetailList=new ArrayList<MikuSalesRecordDetail>()
        for (int i=0;i<mikuSalesRecordList.size();i++){
            MikuSalesRecordDetail mikuSalesRecordDetail=new MikuSalesRecordDetail()
            MikuSalesRecord mikuSalesRecord=mikuSalesRecordList.get(i)
            Trade trade=Trade.findByTradeId(mikuSalesRecord.tradeId)
            mikuSalesRecordDetail.id=mikuSalesRecord.id
            mikuSalesRecordDetail.num=mikuSalesRecord.num
            mikuSalesRecordDetail.tradeId=mikuSalesRecord.tradeId
            mikuSalesRecordDetail.itemName=mikuSalesRecord.itemName
            mikuSalesRecordDetail.price=mikuSalesRecord.price
            mikuSalesRecordDetail.amount=mikuSalesRecord.amount
            mikuSalesRecordDetail.shareFee=mikuSalesRecord.shareFee
            //��׼��Ӧ��״̬
            mikuSalesRecordDetail.itemStatus=trade.status
            mikuSalesRecordDetailList.add(mikuSalesRecordDetail)
        }
        return  mikuSalesRecordDetailList
    }


    //���л�ȡ��Ӧ�ļ�¼��Ӧ�Ķ������ı�MikuSalesRecord��״̬  7Ϊ�ɹ�
    def changeSalesRecordStatus(List<MikuShareGetpay> mikuShareGetpayList,ProFitGetPay proFitGetPay){
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss")

        //����Ҫ�ķ�����Ϣ�����޸�
        //���з�������޸�
        MikuAgencyShareAccount masa=MikuAgencyShareAccount.findByAgencyId(proFitGetPay.agencyId)
        Long successNum=0L
        //��¼��������޸�
        for(int i=0;i<mikuShareGetpayList.size();i++){
            MikuShareGetpay mikuShareGetpay=mikuShareGetpayList.get(i)
            MikuSalesRecord mikuSalesRecord=MikuSalesRecord.findById(mikuShareGetpay.salesRecordId)
            Trade trade=Trade.findByTradeId(mikuSalesRecord.tradeId)
            if (trade.status==7 as byte){
                mikuSalesRecord.isGetpay=2L
                successNum+=mikuSalesRecord.shareFee
            }
            else if (trade.status== 8 as byte){
                mikuSalesRecord.isGetpay=1L
            }else {
                mikuSalesRecord.isGetpay=0L
            }
            String sql="update MikuSalesRecord msr set isGetpay="+mikuSalesRecord.isGetpay+" where msr.id="+mikuSalesRecord.id
            MikuSalesRecord.executeUpdate(sql)
//            mikuSalesRecord.save(failOnError: true, flush: true)
        }

        //δ���ֽ��
        masa.noGetpayFee=masa.noGetpayFee-successNum
        //������
        masa.totalGotpayFee=masa.totalGotpayFee+successNum
        //�����е�����
        masa.getpayingFee=masa.getpayingFee-successNum
        masa.lastUpdated=new Date()

        String sqlStr="update MikuAgencyShareAccount mm set noGetpayFee="+masa.noGetpayFee+",totalGotpayFee="+masa.totalGotpayFee+",getpayingFee="+masa.getpayingFee
        sqlStr+="  ,lastUpdated='"+df.format(new Date())+"'  where mm.id="+masa.id
        MikuAgencyShareAccount.executeUpdate(sqlStr)
    }


}
