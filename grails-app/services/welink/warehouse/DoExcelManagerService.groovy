package welink.warehouse

import grails.transaction.Transactional
import org.apache.poi.hssf.usermodel.HSSFCell
import org.apache.poi.hssf.usermodel.HSSFCellStyle
import org.apache.poi.hssf.usermodel.HSSFRow
import org.apache.poi.hssf.usermodel.HSSFSheet
import org.apache.poi.hssf.usermodel.HSSFWorkbook
import org.apache.poi.poifs.filesystem.POIFSFileSystem
import welink.business.ItemDetailData
import welink.business.OutExcelDetail
import welink.common.ConsigneeAddr
import welink.common.Item
import welink.common.Logistics
import welink.common.MikuBrand
import welink.common.Order
import welink.common.Trade

import java.text.DecimalFormat
import java.text.SimpleDateFormat

@Transactional
class DoExcelManagerService {



    //查出对应订单的全部信息【出入库当中的完成订单的信息】
    def doProviderExcel(List<MikuPdeliveryTrade> tradeList){
        List<OutExcelDetail> milist=new ArrayList<OutExcelDetail>()
        tradeList.each {
            //查找各个小订单的信息
            List<MikuPdeliveryOrders> list=MikuPdeliveryOrders.findAllByTradeId(it.tradeId)
            list.each {
                OutExcelDetail one=buildoneOutExcelDetail(it)
                if (one && one.tradeid){
                    milist.add(one)
                }
            }
        }
        return  milist
    }



    //根据对应的路径来生成对应的文件
    def createOneExcel(String path,List<MikuPdeliveryTrade> tradeList){
        List<OutExcelDetail> milist=doProviderExcel(tradeList)
        return  buildOnePoiExcel(milist,path)
    }



    def getWlFlag(Long tradeId,String orderId){
        String str=""
        List<MikuOrdersLogistics> mikuOrdersLogisticsList=MikuOrdersLogistics.findAllByIsDeleteAndTradeId(0 as byte,tradeId)
        if (mikuOrdersLogisticsList.size()>0){
            mikuOrdersLogisticsList.each {
                String oneorderIds=it.orderIds
                String[] arr=oneorderIds.split(";")
                for (int j=0;j<arr.size();j++){
                    System.out.println(it.wlcompany+"##"+it.wlnumber)
                    System.out.println(orderId+"----------"+arr[j])
                    System.out.println(orderId.equals(arr[j]))
                        if (orderId.equals(arr[j])){
                            if(it.wlnumber && it.wlcompany){
                                str=(it.wlcompany+"##"+it.wlnumber)
                            }
                        }
                }
            }
        }
        return str
    }



    def buildoneOutExcelDetail(MikuPdeliveryOrders mikuPdeliveryOrders){
        def order=Order.findById(mikuPdeliveryOrders.orderId)
        Trade trade=Trade.findByTradeId(mikuPdeliveryOrders.tradeId)
        MikuProvider mikuProvider=MikuProvider.findById(mikuPdeliveryOrders.pid)
        MikuPiteminfo mikuPiteminfo=MikuPiteminfo.findById(mikuPdeliveryOrders.pitemId)
        //物流信息
        def  logic=Logistics.findById(trade.consigneeId)
        ConsigneeAddr consigneeAddr = ConsigneeAddr.findById(logic?.consigneeId)
        Item oneitem=Item.findById(order.artificialId)
        OutExcelDetail oneTd=new OutExcelDetail()

        //添加对应的物流公司 物流号
        String wlh="",wlcompany=""
        String strFlg=getWlFlag(mikuPdeliveryOrders.tradeId,mikuPdeliveryOrders.orderId+"")
        if (strFlg && !("".equals(strFlg))){
            wlh=strFlg.split("##")[0]
            wlcompany=strFlg.split("##")[1]
        }

        if (oneitem && mikuProvider)
        {
            //一个小订单多个供应商的操作
            MikuBrand mikuBrand=MikuBrand.findById(oneitem.brandId)
            oneTd=new OutExcelDetail(
                    tradeid:mikuPdeliveryOrders.tradeId,
                    outtradeid:"VC_米酷_"+mikuPdeliveryOrders.tradeId,
                    logisticsCompany:"",
                    createTime:trade.payTime?trade.payTime.toString().split(" ")[0]:"",
                    buyerid:trade.consigneeId,
                    buyeMobile:logic.mobile,
                    buyerName:logic.contactName,
                    buyerAddr:consigneeAddr?consigneeAddr.receiverAddress:"",
                    itemcode:oneitem.id,
                    code: oneitem.code,
                    itemOnePrice:oneitem.price/100,
                    itemNum:mikuPdeliveryOrders.num,
                    itemMsg:trade.buyerMessage,
                    buyerProvince:logic.province,
                    buyerCity:logic.city,
                    buyerArea:consigneeAddr?consigneeAddr.receiverDistrict:"",
                    //进行添加商品名称与品牌名称
                    itemName:oneitem.title,
                    //销售价
                    xsprice: oneitem.price?(oneitem.price/ 100f):0,
                    //成本价
                    cbprice: (com.alibaba.fastjson.JSON.parseObject(oneitem?.features)?.getLongValue('purchasingPrice') ?: 0) / 100f,
                    brandName:mikuBrand?mikuBrand.name:"",
                    orderId:order.id,
                    //身份证
                    idCard:logic.idCard,
                    //采购价
                    cgprice:oneitem.cgprice?(oneitem.cgprice/ 100f):0,
                    //邮费
                    postFee: oneitem.postFee?(oneitem.postFee/ 100f):0,
                    //供应商名称
                    providerinof:mikuProvider.name?mikuProvider.name:"",
                    //供应商品名称
                    providerItemName: mikuPiteminfo.title,
                    //供应商的价格
                    proprice:mikuPiteminfo.price?(mikuPiteminfo.price/100f):"",
                    wlcompany: wlcompany,
                    wlnumber:wlh
            )
        }
        return  oneTd
    }




    def buildOnePoiExcel(List<OutExcelDetail> outList,String path)
    {

        // 第一步，创建一个webbook，对应一个Excel文件
        HSSFWorkbook wb = new HSSFWorkbook();
        // 第二步，在webbook中添加一个sheet,对应Excel文件中的sheet
        HSSFSheet sheet = wb.createSheet("出库单");
        // 第三步，在sheet中添加表头第0行,注意老版本poi对Excel的行数列数有限制short
        HSSFRow row = sheet.createRow((int) 0);
        // 第四步，创建单元格，并设置值表头 设置表头居中
        HSSFCellStyle style = wb.createCellStyle();
        style.setAlignment(HSSFCellStyle.ALIGN_CENTER); // 创建一个居中格式
        def headers = ['订单号','外部订单号','单据日期','买家','联系人','联系电话','快递公司','送货地址','商品编码','商品单价','商品数量','买家留言','买家省份','买家城市','买家地区','商品名称','品牌名称','成本价','销售价','身份证号码','拆单号','邮费','采购价','供应商','供应商品','供应商价格','物流公司','物流单号']
        for(int i=0;i<headers.size();i++){
            HSSFCell  cell = row.createCell((short) i);
            cell.setCellValue(headers[i]);
            cell.setCellStyle(style);
        }
        for (int i = 0; i < outList.size(); i++)
        {
            row = sheet.createRow((int) i + 1);
            OutExcelDetail oneExcel=outList.get(i);
            // 第四步，创建单元格，并设置值
            row.createCell((short) 0).setCellValue(oneExcel.tradeid);
            row.createCell((short) 1).setCellValue(oneExcel.outtradeid);
            row.createCell((short) 2).setCellValue(oneExcel.createTime);
            row.createCell((short) 3).setCellValue(oneExcel.buyerid);
            row.createCell((short) 4).setCellValue(oneExcel.buyerName);
            row.createCell((short) 5).setCellValue(oneExcel.buyeMobile);
            row.createCell((short) 6).setCellValue(oneExcel.logisticsCompany);
            row.createCell((short) 7).setCellValue(oneExcel.buyerAddr);
            row.createCell((short) 8).setCellValue(oneExcel.code);
            row.createCell((short) 9).setCellValue(oneExcel.itemOnePrice);
            row.createCell((short) 10).setCellValue(oneExcel.itemNum);
            row.createCell((short) 11).setCellValue(oneExcel.itemMsg);
            row.createCell((short) 12).setCellValue(oneExcel.buyerProvince);
            row.createCell((short) 13).setCellValue(oneExcel.buyerCity);
            row.createCell((short) 14).setCellValue(oneExcel.buyerArea);
            row.createCell((short) 15).setCellValue(oneExcel.itemName);
            row.createCell((short) 16).setCellValue(oneExcel.brandName);
            row.createCell((short) 17).setCellValue(oneExcel.cbprice);
            row.createCell((short) 18).setCellValue(oneExcel.xsprice);
            row.createCell((short) 19).setCellValue(oneExcel.idCard);
            row.createCell((short) 20).setCellValue(oneExcel.orderId);
            row.createCell((short) 21).setCellValue(oneExcel.postFee);
            row.createCell((short) 22).setCellValue(oneExcel.cgprice);
            row.createCell((short) 23).setCellValue(oneExcel.providerinof);
            row.createCell((short) 24).setCellValue(oneExcel.providerItemName);
            row.createCell((short) 25).setCellValue(oneExcel.proprice);
            row.createCell((short) 26).setCellValue(oneExcel.wlcompany);
            row.createCell((short) 27).setCellValue(oneExcel.wlnumber);
        }

        // 第六步，将文件存到指定位置
        try
        {
            UUID uuid = UUID.randomUUID()
            FileOutputStream fout = new FileOutputStream(path+"\\"+uuid+".xls");
            wb.write(fout);
            fout.close();
            return uuid;
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }
    }






    //根据一个文件名称来进行读取的对应的excel文件
//    def getOneExcelContentInfo(def uploadedFile, String path){
//        File newBuildFile=new File(path)
//        uploadedFile.transferTo(newBuildFile)
//        InputStream is=new FileInputStream(path)
//        String[] title=readExcelTitle(is)
//        InputStream is2=new FileInputStream(path)
//        Map<Integer, String> map = readExcelContent(is2);
//        //删除文件
//        newBuildFile.delete();
//        List<MikuProvider>  providerList=getDataInfoByMap(title,Map<Integer, String> map)
//        providerList.each {
//            it.version=1L
//            it.save(failOnError: true,flush: true)
//        }
//        return;
//    }


    //根据对应的map集合来进行封装对应的数据【处理的是正在的米酷商品 ---> 然后添加到对应供应商仓库中】
    def getMikuDataInfoByMap(String[] titleArr,Map<Integer, String> map){
        List<ItemDetailData> detailDataList=new ArrayList<ItemDetailData>();
        for (int i=1;i<=map.size();i++)
        {
            String[] contentArr=map.get(i).split("##");
            ItemDetailData one=new ItemDetailData();
            for (int j=0;j<titleArr.length;j++)
            {
                switch (titleArr[j]){
                    case "商品id":
                        one.id=contentArr[j];
                        break;
                    case "商品名称":
                        one.title=contentArr[j]
                        break;
                    case "商品编码":
                        one.code=contentArr[j];
                        break;
                    case "采购价":
                        one.cgprice=contentArr[j];
                        break;
                    case "规格":
                        one.specification=contentArr[j];
                        break;
                    case "关键字":
                        one.keyWord=contentArr[j];
                        break;
                    case "邮费":
                        one.postFee=contentArr[j];
                        break;
                }
            }
            detailDataList.add(one);
        }
        return detailDataList
    }




    //根据对应的map集合来进行封装对应的数据
    def getDataInfoByMap(String[] titleArr,Map<Integer, String> map){
        List<MikuProvider>  providerList=new ArrayList<MikuProvider>()
        for (int i=1;i<=map.size();i++)
        {
            String[] contentArr=map.get(i).split("##");
            MikuProvider one=new MikuProvider();
            for (int j=0;j<titleArr.length;j++)
            {
                switch (titleArr[j]){
                    case "供应商名称":
                        one.name=contentArr[j];
                        break;
                    case "供应商简称":
                        one.sname=contentArr[j]
                        break;
                    case "联系人":
                        one.cperson=contentArr[j];
                        break;
                    case "手机":
                        one.mobile=contentArr[j];
                        break;
                    case "职务":
                        one.job=contentArr[j];
                        break;
                    case "供应商编号":
                        one.code=contentArr[j];
                        break;
                    case "邮政编码":
                        one.zipcode=contentArr[j];
                        break;
                    case "电子邮箱":
                        one.email=contentArr[j];
                        break;
                    case "备注":
                        one.memo=contentArr[j];
                        break;
                    case "地区":
                        one.address=contentArr[j];
                        break;
                    case "账期(天)":
                        one.accounttime=contentArr[j];
                        break;
                    case "qq":
                        one.qq=contentArr[j];
                        break;
                    case "售后联系方式":
                        one.scall=contentArr[j];
                        break;
                    case "售后联系人":
                        one.scontacts=contentArr[j];
                        break;
                    case "发货联系人":
                        one.fcontacts=contentArr[j];
                        break;
                    case "发货联系方式":
                        one.fcall=contentArr[j];
                        break;
                    case "评价":
                        one.assess=contentArr[j];
                        break;
                }
            }
            providerList.add(one);
        }
        return providerList;
    }




    //根据对应的map集合来进行封装对应的数据
    def getDataInfoByPItemMap(String[] titleArr,Map<Integer, String> map){
        List<MikuPiteminfo>  piteminfoList=new ArrayList<MikuPiteminfo>()
        for (int i=1;i<=map.size();i++)
        {
            String[] contentArr=map.get(i).split("##");
            MikuPiteminfo one=new MikuPiteminfo();
            for (int j=0;j<titleArr.length;j++)
            {
                switch (titleArr[j]){
                    case "商品名称":
                        one.title=contentArr[j];
                        break;
                    case "库存":
                        one.num=Integer.parseInt(contentArr[j])
                        break;
                    case "价格":
                        if (contentArr[j]){
                            one.price=Long.parseLong(contentArr[j])
                        }
                        break;
                    case "邮费":
                        if (contentArr[j]){
                            one.postFee=Long.parseLong(contentArr[j])
                        }
                        break;
                    case "供应商品编码":
                        one.code=contentArr[j];
                        break;
                    case "进货价":
                        if (contentArr[j]){
                            one.jhprice=Long.parseLong(contentArr[j])
                        }
                        break;
                    case "建议销售价":
                        if (contentArr[j]){
                            one.xsprice=Long.parseLong(contentArr[j])
                        }
                        break;
                    case "规格":
                        one.type=contentArr[j];
                        break;
                    case "备注":
                        one.memo=contentArr[j];
                        break;
                    case "物流说明":
                        one.logisticDestrion=contentArr[j];
                        break;
                    case "关键字":
                        one.keyword=contentArr[j];
                        break;
                }
            }
            piteminfoList.add(one);
        }
        return piteminfoList;
    }




    //读入的EXCEL
    String[] readExcelTitle(InputStream is)
    {
        def POIFSFileSystem fs;
        def HSSFWorkbook wb;
        def HSSFSheet sheet;
        def HSSFRow row;

        try {
            fs = new POIFSFileSystem(is);
            wb = new HSSFWorkbook(fs);
        } catch (IOException e) {
            e.printStackTrace();
        }
        sheet = wb.getSheetAt(0);
        row = sheet.getRow(0);
        // 标题总列数
        int colNum = row.getPhysicalNumberOfCells();
        System.out.println("colNum:" + colNum);
        String[] title = new String[colNum];
        for (int i = 0; i < colNum; i++) {
            title[i] = getCellFormatValue(row.getCell((short) i));
        }
        return title;
    }



    String getCellFormatValue(HSSFCell cell)
    {
        String cellvalue = "";
        if (cell != null) {
            // 判断当前Cell的Type
            switch (cell.getCellType()) {
            // 如果当前Cell的Type为NUMERIC
                case HSSFCell.CELL_TYPE_NUMERIC:
                case HSSFCell.CELL_TYPE_FORMULA:
                    DecimalFormat df =new DecimalFormat("0");
//                    String str=df.format(cell.getNumericCellValue());
                    //不转为科学计算法
                    cellvalue = df.format(cell.getNumericCellValue());
//                    cellvalue = (cell.getNumericCellValue()).toString();
//                    cellvalue = String.valueOf(cell.getNumericCellValue());
                    break;
            // 如果当前Cell的Type为STRIN
                case HSSFCell.CELL_TYPE_STRING:
                    // 取得当前的Cell字符串
                    cellvalue = cell.getRichStringCellValue().getString();
                    break;
            // 默认的Cell值
                default:
                    cellvalue = " ";
            }
        } else {
            cellvalue = "";
        }
        return cellvalue;
    }



    /**
     * 获取单元格数据内容为字符串类型的数据
     *
     * @param cell Excel单元格
     * @return String 单元格数据内容
     */
    String getStringCellValue(HSSFCell cell) {
        String strCell = "";
        switch (cell.getCellType()) {
            case HSSFCell.CELL_TYPE_STRING:
                strCell = cell.getStringCellValue();
                break;
            case HSSFCell.CELL_TYPE_NUMERIC:
                strCell = String.valueOf(cell.getNumericCellValue());
                break;
            case HSSFCell.CELL_TYPE_BOOLEAN:
                strCell = String.valueOf(cell.getBooleanCellValue());
                break;
            case HSSFCell.CELL_TYPE_BLANK:
                strCell = "";
                break;
            default:
                strCell = "";
                break;
        }
        if (strCell.equals("") || strCell == null) {
            return "";
        }
        if (cell == null) {
            return "";
        }
        return strCell;
    }



    /**
     * 读取Excel数据内容
     * @param InputStream
     * @return Map 包含单元格数据内容的Map对象
     */
    Map<Integer, String> readExcelContent(InputStream is)
    {
        def POIFSFileSystem fs;
        def HSSFWorkbook wb;
        def HSSFSheet sheet;
        def HSSFRow row;
        Map<Integer, String> content = new HashMap<Integer, String>();
        String str = "";
        try {
            fs = new POIFSFileSystem(is);
            wb = new HSSFWorkbook(fs);
        } catch (IOException e) {
            e.printStackTrace();
        }
        sheet = wb.getSheetAt(0);
        // 得到总行数
        int rowNum = sheet.getLastRowNum();
        row = sheet.getRow(0);
        int colNum = row.getPhysicalNumberOfCells();
        // 正文内容应该从第二行开始,第一行为表头的标题
        for (int i = 1; i <= rowNum; i++) {
            row = sheet.getRow(i);
            int j = 0;
            while (j < colNum) {
                // 每个单元格的数据内容用"-"分割开，以后需要时用String类的replace()方法还原数据
                // 也可以将每个单元格的数据设置到一个javabean的属性中，此时需要新建一个javabean
                // str += getStringCellValue(row.getCell((short) j)).trim() +
                // "-";
                String loc=getCellFormatValue(row.getCell((short) j)).trim();

                if ("".equals(loc))
                {
                    str +="  "+ "##";
                }
                else{
                    str +=loc+ "##";
                }
                j++;
            }
            content.put(i, str);
            str = "";
        }
        return content;
    }












}
