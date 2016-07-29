package welink.system

import com.google.common.collect.ImmutableMap
import com.welink.commons.commons.SMSUtils
import grails.converters.JSON
import grails.orm.PagedResultList
import grails.transaction.Transactional
import org.apache.commons.lang3.StringUtils
import org.apache.poi.hssf.usermodel.HSSFCell
import org.apache.poi.hssf.usermodel.HSSFRow
import org.apache.poi.hssf.usermodel.HSSFSheet
import org.apache.poi.hssf.usermodel.HSSFWorkbook
import org.apache.poi.poifs.filesystem.POIFSFileSystem
import org.springframework.web.multipart.MultipartFile
import welink.common.Item
import welink.common.ItemAndPurchase
import welink.common.PurPrice
import welink.common.Purchase

import static com.welink.buy.utils.Constants.ApproveStatus.IN_STOCK

class PurchasesMangerController {

    def searchService

    def getTitleById(){
        Long price=0
        if(params.id){
            Purchase purchase=Purchase.findById(params.long('id'))
            price=purchase.price
        }
        render(price/10000f)
    }

    def makeInStockByPurchase() {
        def purchaseId = params.long('purchaseId')
        if (purchaseId) {
            if (ItemAndPurchase.findByPurchaseIdAndStatus(purchaseId,1 as byte)) {
                Item item = Item.findById(ItemAndPurchase.findByPurchaseId(purchaseId).itemId)
                item.approveStatus = IN_STOCK.approveStatusId
                item.onlineEndTime = System.currentTimeMillis()
                item.save(failOnError: true,flush: true)
            }
        }
        redirect(action: 'index',params: params)
    }

    def lookhistory() {
        Long id = params.long('id')
        Purchase purchase = Purchase.findById(id)
        def history = PurPrice.findAllByPurchaseId(id)
        List<String> labels = new ArrayList<String>()
        ArrayList<Integer> datalist = new ArrayList<Integer>()

        history.each {
            PurPrice purPrice ->
                labels.add(purPrice.dateCreated.minus(1).format('MM-dd'))
                datalist.add(purPrice.unitPrice.toInteger() / 100)
        }

        labels.add('今天')
        datalist.add(purchase.unitPrice.toInteger() / 100)

        def data = [:]

        data.put('按斤价', datalist)
        render(template: "purchaseDetail", model: [
                purchase: purchase,
                labels  : labels,
                data    : data
        ])
    }

    def searchByTitle() {

        def res = searchService.searchPurchaseByTitle("${params.term}", 0, 20).searchResults

        List list = []
        res.each {
            Purchase purchase ->
                list << ImmutableMap.of('value', purchase.title, 'id', purchase.id)
        }

        render list as JSON
    }

    def index() {

        def p = Purchase.createCriteria()

        //页面第一次载入时间为当天时间
        String acceptTime = params.acceptTime ?: new Date().format('yyyy-MM-dd')

        LinkedList<String> categoryList = new ArrayList<String>()

        categoryList = Purchase.executeQuery("select distinct a.categoryName from Purchase a")

        PagedResultList pagedResultList = p.list(max: params.max ?: 10, offset: params.offset ?: 0) {
            if (params.variation) {
                ne('variation', 0 as byte)
            }
            if (params.query) {
                eq('title', params.query)
            }
            if (params.queryCategory) {
                eq('categoryName', params.queryCategory)
            }
            if(params.associated){
                def itemAndPurchaseList=ItemAndPurchase.findAllByStatus(1 as byte)
                if(itemAndPurchaseList){
                    'in'("id", itemAndPurchaseList*.purchaseId)
                }
            }
        }

        def approveStatusMap = [:]
        pagedResultList.iterator().each {
            Purchase purchase ->

                if (ItemAndPurchase.findByPurchaseIdAndStatus(purchase.id,1 as byte)) {
                    Item item = Item.findById(ItemAndPurchase.findByPurchaseIdAndStatus(purchase.id,1 as byte).itemId)
                    approveStatusMap.put(purchase.id, (item?.approveStatus))
                } else {
                    //未匹配
                    approveStatusMap.put(purchase.id, -1)
                }
        }

        return [
                categoryList    : categoryList,
                approveStatusMap: approveStatusMap,
                purchaseList    : pagedResultList,
                acceptTime      : acceptTime,
                total           : pagedResultList.totalCount
        ]
    }

    @Transactional
    def loadexcel() {

        MultipartFile file = (MultipartFile) request.getFile('myFile')

        POIFSFileSystem fs

        HSSFWorkbook wb

        fs = new POIFSFileSystem(file.getInputStream());

        wb = new HSSFWorkbook(fs);

        HSSFSheet sheet = wb.getSheetAt(0);

        int rowNumber = sheet.getLastRowNum()

        def currentCategory

        String message = '['

        String messageOfSpec = '['

        boolean send = false

        boolean sendAboutSpec = false

        for (int i = 1; i < rowNumber + 1; i++) {
            HSSFRow row = sheet.getRow(i)
            if (row) {
                HSSFCell cell = row.getCell(0);

                if (StringUtils.isBlank(row.getCell(1).toString())) {
                    currentCategory = cell.toString()
                }

                if (cell && StringUtils.isNotBlank(row.getCell(1).toString())) {
                    if (Purchase.findByTitle(cell.toString())) {
                        //存在同名的商品
                        Purchase purchase = new Purchase()
                        //更新库中已存在的商品
                        purchase = Purchase.findByTitle(cell.toString())
                        new PurPrice(purchaseId: purchase.id,
                                unitPrice: purchase?.unitPrice ?: (purchase?.price / purchase?.specNum),
                                status: 1,
                                specNum: purchase?.specNum
                        ).save(failOnError: true)
                        def oldSpcNum = purchase.specNum ?: 0
                        def oldUnitPrice = purchase.unitPrice ?: 0
                        purchase.yesterdayPrice = oldUnitPrice
                        //将新规格给商品
                        if (StringUtils.isNotBlank(row.getCell(1).toString())) {
                            purchase.specNum = new BigDecimal(row.getCell(1).toString()) * 100L ?: 0
                        }
                        if (StringUtils.isNotBlank(row.getCell(3).toString())) {
                            purchase.unitPrice = new BigDecimal(row.getCell(3).toString()) * 100L ?: 0
                            purchase.price = purchase.specNum * purchase.unitPrice ?: 0
                        } else if (StringUtils.isNotBlank(row.getCell(4).toString())) {
                            purchase.price = new BigDecimal(row.getCell(4).toString()) * 100L ?: 0
                        }
                        purchase.memo = row.getCell(5).toString() ?: '无备注'
                        purchase.status = 1

                        if (StringUtils.isNotBlank(row.getCell(6).toString())) {
                            purchase.pictured = 1 as byte
                        } else {
                            purchase.pictured = 0 as byte
                        }

                        //价格比较，涨价，关键字为1，跌价关键字为-1
                        if (oldUnitPrice > purchase.unitPrice) {
                            purchase.variation = -1
                        } else if (oldUnitPrice < purchase.unitPrice) {
                            purchase.variation = 1
                        } else {
                            purchase.variation = 0
                        }

                        purchase.save(failOnError: true)

                        //涨幅超过20%时发送通知短信
                        if ((oldUnitPrice * 1.2 - (purchase.unitPrice ?: 0)) < 0) {
                            send = true
                            message = message + purchase.title + ','
                        }

                        //商品规格发生变化时，发送短信通知
                        if (oldSpcNum != purchase.specNum) {
                            sendAboutSpec = true
                            messageOfSpec = messageOfSpec + purchase.title + ','
                        }

                    } else {
                        //此时新建一个Purchase对象
                        Purchase purchase = new Purchase()
                        purchase.categoryName = currentCategory
                        purchase.title = cell.toString()
                        purchase.specNum = new BigDecimal(row.getCell(1).toString()) * 100L ?: 0
                        purchase.specification = row.getCell(2).toString() ?: '无规格描述'

                        if (StringUtils.isNotBlank(row.getCell(3).toString())) {
                            purchase.unitPrice = new BigDecimal(row.getCell(3).toString()) * 100L ?: 0
                            purchase.price = purchase.specNum * purchase.unitPrice ?: 0
                        } else if (StringUtils.isNotBlank(row.getCell(4).toString())) {
                            purchase.unitPrice = 0
                            purchase.price = new BigDecimal(row.getCell(4).toString()) * 100L ?: 0
                        }

                        purchase.memo = row.getCell(5).toString() ?: '无备注'
                        purchase.yesterdayPrice = 0
                        purchase.variation = 0
                        if (StringUtils.isNotBlank(row.getCell(6).toString())) {
                            purchase.pictured = 1 as byte
                        } else {
                            purchase.pictured = 0 as byte
                        }
                        purchase.save(failOnError: true)
                    }
                }
            }
        }

        //发送短信的代码
        String receiverMobile = params.mobile
        if (send && receiverMobile && !(receiverMobile.equals('null')) && (receiverMobile.length() == 13)) {
            receiverMobile = receiverMobile.replace('-', '')
            message = message + ']'
            SMSUtils.sendSms(message, receiverMobile)
            if (sendAboutSpec) {
                messageOfSpec = messageOfSpec + ']以上商品价格规格发生变动，注意修改商品啊~紧急！'
                SMSUtils.sendGeneralSms(messageOfSpec, receiverMobile)
            }
        }
        redirect(action: 'index')
    }

    def loadexcelHtml() {
        redirect(url: "purchase/uploadExcel")
    }

}
