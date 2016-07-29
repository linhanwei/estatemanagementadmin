package welink.system

import com.google.common.collect.ImmutableMap
import com.google.common.collect.Lists
import grails.orm.PagedResultList
import grails.transaction.Transactional
import org.apache.commons.lang3.StringUtils
import org.apache.poi.hssf.usermodel.HSSFCell
import org.apache.poi.hssf.usermodel.HSSFCellStyle
import org.apache.poi.hssf.usermodel.HSSFRow
import org.apache.poi.hssf.usermodel.HSSFSheet
import org.apache.poi.hssf.usermodel.HSSFWorkbook
import org.joda.time.DateTime
import org.joda.time.format.DateTimeFormat
import org.joda.time.format.DateTimeFormatter
import welink.business.MikuGetPayDetail
import welink.common.MikuAgencyShareAccount
import welink.common.ProFitGetPay

import java.text.SimpleDateFormat

class ProFitGetPayController {

    static ImmutableMap<String, String> PAY_TYPE_MAP = ImmutableMap.builder() //
            .put("1", "支付宝")
            .put("2", "微信钱包")
            .put("3", "银行卡")
            .build()

    static ImmutableMap<Integer, String> Delivery_Day_Map = ImmutableMap.builder() //
            .put(0, "今天")
            .put(1, "明天")
            .put(2, "后天")
            .build()

    static ImmutableMap<Integer, String> Delivery_Time_Map = ImmutableMap.builder() //
            .put(570, "9:30~12:00")
            .put(720, "12:00~14:30")
            .put(870, "14:30~17:00")
            .put(1020, "17:00~19:30")
            .build()

    static ImmutableMap<String, String> SHIPPING_TYPE_MAP = ImmutableMap.builder() //
            .put("-1", "送货上门")
            .put("1", "用户自提")
            .build()

    static ImmutableMap<String, String> TOTAL_FEE_OP_MAP = ImmutableMap.builder() //
            .put(">", "大于")
            .put("=", "等于")
            .put("<", "小于")
            .build()

    static ImmutableMap<String, String> ORDER_MAP = ImmutableMap.builder() //
            .put("+", "正序")
            .put("-", "倒序")
            .build()

    static ImmutableMap<String, String> ORDER_ENTITY_MAP = ImmutableMap.builder() //
            .put("total_fee", "商品总价")
            .put("date_created", "下单时间")
            .put("appoint_delivery_time", "预约时间")
            .build()

    def index() {

        def agencyMobile =params.agencyMobile
        if (agencyMobile) {
            agencyMobile = StringUtils.replace(agencyMobile, "-", "");
        }

        // 开始时间
        String startTime = params.startTime

        // 结束时间
        String endTime = params.endTime

        DateTimeFormatter formatter = DateTimeFormat.forPattern("yyyy-MM-dd HH:mm")

        Date start = StringUtils.isNotBlank(startTime) ? formatter.parseDateTime(startTime).toDate() : null

        Date end = StringUtils.isNotBlank(endTime) ? formatter.parseDateTime(endTime).toDate() : null

        // 支付方式
        def payType = params.payType

        // 排序规则
        def ord = params.order

        //进行比较符号
        def totalFeeOp=params.totalFeeOp
        //金钱的多少
        def  targetTotalFee=params.targetTotalFee
        if (targetTotalFee)
        {
            targetTotalFee=Long.parseLong(targetTotalFee)
        }





        def mkgp=ProFitGetPay.createCriteria()
        PagedResultList pagedResultList
        pagedResultList = mkgp.list(max: params.max ?: 10, offset: params.offset ?: 0) {

            'in'('status', [0] as byte[])

            if (agencyMobile) {
                eq('agencyMobile', agencyMobile)
            }

            if (start != null) {
                gt("transDate", start)
            }

            if (end != null) {
                lt("transDate", end)
            }

            if(payType)
            {
                eq('getpayType', Long.parseLong(payType))
            }


            if(targetTotalFee)
            {
                if (totalFeeOp.equals(">"))
                {
                    gt("getpayFee",targetTotalFee)
                }
                if (totalFeeOp.equals("="))
                {
                    eq("getpayFee",targetTotalFee)
                }
                if (totalFeeOp.equals("<"))
                {
                    lt("getpayFee",targetTotalFee)
                }
            }

            if(ord)
            {
                if (ord.equals("-"))
                {
                    order('getpayFee','desc')
                    order('applyDate','desc')
                }
                else if (ord.equals("+"))
                {
                    order('getpayFee','asc')
                    order('applyDate','asc')
                }
            }

            order('id','desc')
        }


        List<ProFitGetPay> mList=new ArrayList<ProFitGetPay>()
        pagedResultList.iterator().each{
            ProFitGetPay onepay->
                mList.add(onepay)
        }
        return [
                total          : pagedResultList?.totalCount,
                viewTotal      : pagedResultList?.totalCount,
                getPayList     : mList,
                params         : params,
                payTypeMap     : PAY_TYPE_MAP,
                orderMap       : ORDER_MAP,
                totalFeeOpMap  : TOTAL_FEE_OP_MAP
        ]


    }


    //进行全部信息查看
    def allInfo()
    {
        def agencyMobile =params.agencyMobile
        if (agencyMobile) {
            agencyMobile = StringUtils.replace(agencyMobile, "-", "");
        }

        // 开始时间
        String startTime = params.startTime

        // 结束时间
        String endTime = params.endTime

        DateTimeFormatter formatter = DateTimeFormat.forPattern("yyyy-MM-dd HH:mm")

        Date start = StringUtils.isNotBlank(startTime) ? formatter.parseDateTime(startTime).toDate() : null

        Date end = StringUtils.isNotBlank(endTime) ? formatter.parseDateTime(endTime).toDate() : null

        // 支付方式
        def payType = params.payType

        // 排序规则
        def ord = params.order

        //进行比较符号
        def totalFeeOp=params.totalFeeOp
        //金钱的多少
        def  targetTotalFee=params.targetTotalFee
        if (targetTotalFee)
        {
            targetTotalFee=Long.parseLong(targetTotalFee)
        }




        def mkgp=ProFitGetPay.createCriteria()
        PagedResultList pagedResultList
        pagedResultList = mkgp.list(max: params.max ?: 10, offset: params.offset ?: 0) {

            if (agencyMobile) {
                eq('agencyMobile', agencyMobile)
            }

            if (start != null) {
                gt("transDate", start)
            }

            if (end != null) {
                lt("transDate", end)
            }

            if(payType)
            {
                eq('getpayType', Long.parseLong(payType))
            }


            if(targetTotalFee)
            {
                if (totalFeeOp.equals(">"))
                {
                    gt("getpayFee",targetTotalFee)
                }
                if (totalFeeOp.equals("="))
                {
                    eq("getpayFee",targetTotalFee)
                }
                if (totalFeeOp.equals("<"))
                {
                    lt("getpayFee",targetTotalFee)
                }
            }

            if(ord)
            {
                if (ord.equals("-"))
                {
                    order('getpayFee','desc')
                    order('applyDate','desc')
                }
                else if (ord.equals("+"))
                {
                    order('getpayFee','asc')
                    order('applyDate','asc')
                }
            }

            order('id','desc')

        }


        List<ProFitGetPay> mList=new ArrayList<ProFitGetPay>()
        pagedResultList.iterator().each{
            ProFitGetPay onepay->
                mList.add(onepay)
        }
        return [
                total          : pagedResultList?.totalCount,
                viewTotal      : pagedResultList?.totalCount,
                getPayList     : mList,
                params         : params,
                payTypeMap     : PAY_TYPE_MAP,
                orderMap       : ORDER_MAP,
                totalFeeOpMap  : TOTAL_FEE_OP_MAP
        ]

    }


    @Transactional
    def shipTradeChecked()
    {
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
        def Ids = Lists.newArrayList(params.modelShipBox)
        for (int i=0;i<Ids.size();i++)
        {
            def  p=ProFitGetPay.findById(Long.parseLong(Ids.get(i)))

            //进行分润金额的修改
            MikuAgencyShareAccount masa=MikuAgencyShareAccount.findByAgencyId(p.agencyId)
            //未提现金额
            masa.noGetpayFee=masa.noGetpayFee-p.getpayFee
            //已提现
            masa.totalGotpayFee=masa.totalGotpayFee+p.getpayFee
            //提现中的数据
            masa.getpayingFee=masa.getpayingFee-p.getpayFee
            masa.lastUpdated=new Date()
//            masa.save(failOnError: true, flush: true)
            //进行对sql的操作
            String sqlStr="update MikuAgencyShareAccount mm set noGetpayFee="+masa.noGetpayFee+",totalGotpayFee="+masa.totalGotpayFee+",getpayingFee="+masa.getpayingFee
            sqlStr+="  ,lastUpdated='"+df.format(new Date())+"'  where mm.id="+masa.id
            MikuAgencyShareAccount.executeUpdate(sqlStr)

//            p.lastUpated=new Date()
//            p.status=1 as byte
//            p.save(failOnError: true, flush: true)
            String str="update  ProFitGetPay m set status=1,lastUpated='"+df.format(new Date())+"'"
            str+="  where m.id="+Long.parseLong(Ids[i])
            ProFitGetPay.executeUpdate(str)
        }
        redirect(action: "index")
    }



    def outPortExcel()
    {
        Byte type=params.byte('type')
        def ids=params.TradeExcelids
        String[] idsarr=ids.split(",")
        List<MikuGetPayDetail> mlist=new ArrayList<MikuGetPayDetail>()
        for(int i=0;i<idsarr.length;i++)
        {
            MikuGetPayDetail detail=getOneDetail(ProFitGetPay.findById(idsarr[i]))
            mlist.add(detail)
        }
        //支付宝
        if (type==1 as byte){
            buildOnePoiExcel(mlist,"支付宝处理提现");
        }
        //微信
        else if (type==2 as byte){
            buildOnePoiExcel(mlist,"微信处理提现");
        }else{
            buildOnePoiExcel(mlist,"处理提现");
        }

    }


    //全部打印
    def outPortAllExcel()
    {
        List<ProFitGetPay> mplist=ProFitGetPay.createCriteria().list {
            eq('status', 0 as byte)
//            'in' ('status', [0] as byte[])
        }
        List<MikuGetPayDetail> mlist=new ArrayList<MikuGetPayDetail>()
        for (int i=0;i<mplist.size();i++)
        {
            MikuGetPayDetail detail=getOneDetail(mplist.get(i))
            mlist.add(detail)
        }
        buildOnePoiExcel(mlist,"全部处理提现名单");
    }


    //处理详情与对象之间处理
    def getOneDetail(ProFitGetPay onepay)
    {
        MikuGetPayDetail detail=new MikuGetPayDetail()
        detail.agencyNickname=onepay.agencyNickname
        detail.agencyMobile=onepay.agencyMobile
        detail.lastUpated=onepay.lastUpated
        detail.getpayFee=onepay.getpayFee/100
        detail.amount=(onepay.getpayFee/100).toString()
        detail.getpayAccount=onepay.getpayAccount
        detail.getpayUserName=onepay.getpayUserName
        detail.agencyId=onepay.agencyId
        String status=onepay.status
        if (status.equals("0"))
        {
            detail.dostatusName="待审核"
        }
        else if(status.equals("1"))
        {
            detail.dostatusName="已审核"
        }

        Long payType= onepay.getpayType
        if (payType==1)
        {
            detail.getpayTypeName="支付宝支付";
        }
        else if (payType==2)
        {
            detail.getpayTypeName="微信支付";
        }
        else if (payType==3)
        {
            detail.getpayTypeName="银行卡支付";
        }

        //进行添加对应的核对信息
        detail.getpayId=onepay.id
        MikuAgencyShareAccount mikuAgencyShareAccount=MikuAgencyShareAccount.findByAgencyId(onepay.agencyId)
        if (mikuAgencyShareAccount){
            detail.totalpay=mikuAgencyShareAccount.totalShareFee
            detail.totalgetpay=mikuAgencyShareAccount.totalGotpayFee
            detail.getpayIng=mikuAgencyShareAccount.getpayingFee
        }
        return  detail
    }



    def buildOnePoiExcel(List<MikuGetPayDetail> outList,String title)
    {
        // 第一步，创建一个webbook，对应一个Excel文件
        HSSFWorkbook wb = new HSSFWorkbook();
        // 第二步，在webbook中添加一个sheet,对应Excel文件中的sheet
        HSSFSheet sheet = wb.createSheet(title);
        // 第三步，在sheet中添加表头第0行,注意老版本poi对Excel的行数列数有限制short
        HSSFRow row = sheet.createRow((int) 0);
        // 第四步，创建单元格，并设置值表头 设置表头居中
        HSSFCellStyle style = wb.createCellStyle();
        style.setAlignment(HSSFCellStyle.ALIGN_CENTER); // 创建一个居中格式
//        def headers = ['外部订单号','订单号','单据日期','买家','联系人','联系电话','快递公司','送货地址','商品编码','商品单价','商品数量','买家留言','买家省份','买家城市','买家地区']
        HSSFCell cell = row.createCell((short) 0);
        cell.setCellValue("用户名称");
        cell.setCellStyle(style);
        cell = row.createCell((short) 1);
        cell.setCellValue("用户手机号");
        cell.setCellStyle(style);
        cell = row.createCell((short) 2);
        cell.setCellValue("操作时间");
        cell.setCellStyle(style);
        cell = row.createCell((short) 3);
        cell.setCellValue("金额");
        cell.setCellStyle(style);
        cell = row.createCell((short) 4);
        cell.setCellValue("提现账户");
        cell.setCellStyle(style);
        cell = row.createCell((short) 5);
        cell.setCellValue("账户姓名");
        cell.setCellStyle(style);
        cell = row.createCell((short) 6);
        cell.setCellValue("申请状态");
        cell.setCellStyle(style);
        cell = row.createCell((short) 7);
        cell.setCellValue("支付类型");
        cell.setCellStyle(style);
        cell = row.createCell((short) 8);
        cell.setCellValue("分润记录id");
        cell.setCellStyle(style);
        cell = row.createCell((short) 9);
        cell.setCellValue("对应分润账号id");
        cell.setCellStyle(style);
        cell = row.createCell((short) 10);
        cell.setCellValue("总分润");
        cell.setCellStyle(style);
        cell = row.createCell((short) 11);
        cell.setCellValue("提现当中");
        cell.setCellStyle(style);
        cell = row.createCell((short) 12);
        cell.setCellValue("已提现");
        cell.setCellStyle(style);


        //def withProperties = ['tradeid','outtradeid','createTime','buyerid','buyerName','buyeMobile','logisticsCompany','buyerAddr','itemcode','itemOnePrice','itemNum','itemMsg','buyerProvince','buyerCity','buyerArea']
        for (int i = 0; i < outList.size(); i++)
        {
            row = sheet.createRow((int) i + 1);
            MikuGetPayDetail oneExcel=outList.get(i);
            // 第四步，创建单元格，并设置值
            row.createCell((short) 0).setCellValue(oneExcel.agencyNickname);
            row.createCell((short) 1).setCellValue(oneExcel.agencyMobile);
//            row.createCell((short) 2).setCellValue(oneExcel.lastUpated);
            row.createCell((short) 2).setCellValue(oneExcel.lastUpated?new DateTime(oneExcel.lastUpated).toString("yyyy-MM-dd HH:mm").toString():"");
            row.createCell((short) 3).setCellValue(oneExcel.amount);
//            row.createCell((short) 3).setCellValue(oneExcel.getpayFee);
            row.createCell((short) 4).setCellValue(oneExcel.getpayAccount);
            row.createCell((short) 5).setCellValue(oneExcel.getpayUserName);
            row.createCell((short) 6).setCellValue(oneExcel.dostatusName);
            row.createCell((short) 7).setCellValue(oneExcel.getpayTypeName);

            row.createCell((short) 8).setCellValue(oneExcel.getpayId);
            row.createCell((short) 9).setCellValue(oneExcel.agencyId);
            row.createCell((short) 10).setCellValue(oneExcel.totalpay);
            row.createCell((short) 11).setCellValue(oneExcel.getpayIng);
            row.createCell((short) 12).setCellValue(oneExcel.totalgetpay);
        }

        // 第六步，将文件存到指定位置
        try
        {
            String path=request.getSession().getServletContext().getRealPath("")
            UUID uuid = UUID.randomUUID()
            FileOutputStream fout = new FileOutputStream(path+"\\"+uuid+".xls");
            wb.write(fout);
            fout.close();
            //提供进行下载
            // 处理中文乱码
            SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd")
            Calendar c = Calendar.getInstance()
            int hour = c.get(Calendar.HOUR_OF_DAY);
            int minute = c.get(Calendar.MINUTE);
            int second = c.get(Calendar.SECOND);
            String sfm=hour+"时"+minute+"分"+second+"秒"
            String downloadName=df.format(new Date()).toString()+"-"+sfm+title+".xls"
            def filename = URLEncoder.encode(downloadName, "UTF-8");
            response.setHeader("Content-disposition", "attachment; filename="+filename)
            response.contentType = "application/x-rarx-rar-compressed"
            def out = response.outputStream
            InputStream inputStream = new FileInputStream(path+"\\"+uuid+".xls")
            byte[] buffer = new byte[1024]
            int i = -1
            while ((i = inputStream.read(buffer)) != -1) {
                out.write(buffer, 0, i)
            }
            out.flush()
            out.close()
            inputStream.close()
            new File(path+"\\"+uuid+".xls").delete();
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }
    }
}
