package welink.system

import grails.orm.PagedResultList
import grails.transaction.Transactional
import org.joda.time.format.DateTimeFormat
import org.joda.time.format.DateTimeFormatter
import welink.ExceptionHandler
import welink.common.Category
import welink.common.Groupon
import welink.common.Item
import welink.common.Shop

import static com.welink.buy.utils.Constants.ApproveStatus.IN_STOCK
import static com.welink.buy.utils.Constants.ApproveStatus.ON_SALE

class ItemController extends ExceptionHandler {

    @Deprecated
    def inStock() {

        def c = Item.createCriteria()

        PagedResultList pagedResultList = c.list(max: params.max ?: 10, offset: params.offset ?: 0) {
            eq("approveStatus", IN_STOCK.approveStatusId)
            order("id", "desc")
        }

        return [
                itemLists  : pagedResultList,
                total      : pagedResultList.size(),
                params     : params,
                categoryMap: Category.findAll().collectEntries {
                    [it.id, it.name]
                }
        ]

    }

    @Deprecated
    def onSale() {
        def c = Item.createCriteria()
        PagedResultList pagedResultList = c.list(max: params.max ?: 10, offset: params.offset ?: 0) {
            order("id", "desc")
            eq("approveStatus", ON_SALE.approveStatusId)
        }

        return [
                itemLists  : pagedResultList,
                total      : pagedResultList.size(),
                params     : params,
                categoryMap: Category.findAll().collectEntries {
                    [it.id, it.name]
                }
        ]
    }


    def queryItemOnSale() {

        def c = Item.createCriteria()
        PagedResultList pagedResultList = c.list(max: params.max ?: 10, offset: params.offset ?: 0) {
            order("id", "desc")
            eq("approveStatus", ON_SALE.approveStatusId)
        }
        return [
                itemRecords: pagedResultList,
                total      : pagedResultList.size(),
                params     : params
        ]
    }

    def queryItemInStock() {
        def c = Item.createCriteria()
        PagedResultList pagedResultList = c.list(max: params.max ?: 10, offset: params.offset ?: 0) {
            order("id", "desc")
            eq("approveStatus", IN_STOCK.approveStatusId)
        }
        return [
                itemRecords: pagedResultList,
                total      : pagedResultList.size(),
                params     : params
        ]
    }

    @Transactional
    def makeInStock() {

        Long id = params.long('id')

        Shop shop = Shop.findBySellerTypeAndSellerId(2 as byte, 999L)

        Item item = Item.findByShopIdAndId((shop.id), id)

        if (item) {
            item.approveStatus = IN_STOCK.approveStatusId
            item.onlineEndTime = System.currentTimeMillis()

            //团购已作废
            Groupon.findByItemIdAndStatus(item.id, 1 as byte)?.with {
                it.onlineEndTime = System.currentTimeMillis()
                it.status = 0 as byte
                save(failOnError: true)
            }
            Groupon.findByItemIdAndStatus(item.id, 2 as byte)?.with {
                it.onlineEndTime = System.currentTimeMillis()
                it.status = 0 as byte
                save(failOnError: true)
            }

            //分站点商品状态为下架状态
            Item fzitem=Item.findByBaseItemId(item.id)
            if (fzitem)
            {
                fzitem.approveStatus= 0 as byte
                fzitem.onlineEndTime= System.currentTimeMillis()
                item.save(failOnError: true)
            }

            if (item.save(failOnError: true)) {
                render('true')
                return
            }
        }

        response.status = 405
    }

    def makeDelete() {

        Long id = params.long('id')

        Item item = Item.findByShopIdAndId(999, id)

        if (item) {
            item.approveStatus = -1 as byte
            item.onlineEndTime = System.currentTimeMillis()

            //删掉对应站点的上架商品
            Item nItem=Item.findByBaseItemId(id)
            if (nItem)
            {
                nItem.approveStatus = -1 as byte
                nItem.onlineEndTime = System.currentTimeMillis()
                nItem.save(failOnError: true, flush: true)
            }
            if (item.save(failOnError: true, flush: true)) {
                render('true')
            }
        }

        response.status = 405
    }

    def makeOnSale() {

        withForm {
            DateTimeFormatter dtf = DateTimeFormat.forPattern("dd/MM/yyyy HH:mm")

            Long itemId = params.long('itemId')
            Long level = params.long('level')
            Long onlineStartTime = dtf.parseDateTime(params.onlineStartTime).toDate().time
            Long onlineEndTime = dtf.parseDateTime(params.onlineEndTime).toDate().time
            Long price = new BigDecimal(params.price) * 100L
            Long num = params.long('num')

            Item item = Item.findByShopIdAndId(999, itemId)

            if (item) {
                item.approveStatus = ON_SALE.approveStatusId
                item.onlineStartTime = onlineStartTime
                item.onlineEndTime = onlineEndTime
                item.price = price
                item.num = num
                if (item.save(failOnError: true, flush: true)) {
                    redirect(action: 'onSale')
                }

            }
            redirect(action: 'onSale')
        }.invalidToken {
            // bad request
            response.status = 405
        }

    }


}
