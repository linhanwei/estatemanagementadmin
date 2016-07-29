package welink.common

import com.google.common.collect.Lists
import org.joda.time.DateTime
import org.joda.time.format.DateTimeFormat
import org.joda.time.format.DateTimeFormatter
import pl.touk.excel.export.WebXlsxExporter
import welink.business.TradeDetail
import welink.trade.TradeGroup
import welink.user.Profile

import javax.annotation.Resource

class TradeExportController {

    def index() {}

    //导出默认订单
    def exportExcel() {

        //计算订单总数
        Long total = 0

        byte status = params.byte('status')

        DateTimeFormatter formatter = DateTimeFormat.forPattern("yyyy-MM-dd HH:mm")

        String startTime = params.startTime ?: new Date().format('yyyy-MM-dd HH:mm')

        String endTime = params.endTime ?: new Date().format('yyyy-MM-dd HH:mm')

        DateTime earlistTime = formatter.parseDateTime(startTime)

        DateTime latestTime = formatter.parseDateTime(endTime)

        String query = params.query

        ArrayList<Trade> tradeList = new ArrayList<Trade>()

        List<TradeDetail> tradeDetailList = new ArrayList<TradeDetail>()

        def groupResult

        if (params.exportBox) {
            def tradeIds = Lists.newArrayList(params.exportBox)
            tradeIds.each {
                String it ->
                    Long id = Long.parseLong(it)
                    Trade trade = Trade.findById(id)
                    if (trade) {
                        tradeList.add(trade)
                    }
            }
        } else {
            tradeList = Trade.withCriteria {
                if (params.payType) {
                    if (params.payType == '-1') {
                        eq('type', 1 as byte)
                        'in'("payType", [3 as byte, 4 as byte])
                    } else if (params.payType == '1') {
                        eq('type', 2 as byte)
                        'in'("payType", [2 as byte, 5 as byte, 6 as byte])
                    }
                }
                if (params.startTime && params.endTime) {
                    between("dateCreated", earlistTime.toDate(), latestTime.toDate())
                }
                if (params.courierId) {
                    def tes = TradeEmployee.findAllByEmployeeIdAndTypeAndStatus(params.long('courierId'), 1 as byte, 1 as byte)
                    if (tes) {
                        'in'("id", tes*.tradeId)
                    } else {
                        eq("id", -1L)
                    }
                }
                if (query && !(query.equals('null')) && (query.length() == 13)) {
                    def logisticss = Logistics.findAllByMobile(query.replace('-', ''))
                    Profile profile = Profile.findByMobile(query.replace('-', ''))
                    if (profile && logisticss) {
                        or {
                            eq("buyerId", profile.id)
                            'in'("consigneeId", logisticss*.id)
                        }
                    } else if (profile) {
                        eq('buyerId', profile.id)
                    } else if (logisticss) {
                        "in"('consigneeId', logisticss*.id)
                    } else {
                        eq("id", -1L)
                    }
                }
                if (status) {
                    eq('status', status)
                }
                order('id', 'esc')
            }
        }

        if (params.addressQuery) {
            String addressQuery = params.addressQuery
        } else {
        }

        groupResult = Lists.newArrayList()

        groupResult.iterator().each {
            TradeGroup tradeGroup ->
                tradeGroup.trades.iterator().each {
                    Trade trade ->
                        total = total + 1

                        def orderIds = trade.orders.split(';')
                        //该地址对应的ID
                        Logistics logistics = Logistics.findById(trade.consigneeId)

                        int blankIndex

                        if (logistics.addr.contains(' ')) {
                            blankIndex = logistics.addr.indexOf(' ')
                        } else {
                            blankIndex = 0
                        }

                        tradeDetailList.add(new TradeDetail(
                                tradeId: trade?.tradeId,
                                address: logistics?.addr.substring(blankIndex),
                                receiverName: logistics?.contactName,
                                receiverMobile: logistics?.mobile,
                                buyerMessage: (trade?.buyerMessage) ?: '无'
                        ))

                        orderIds.iterator().each {
                            String id ->
                                Order order = Order.findById(Long.parseLong(id))
                                if (order) {
                                    tradeDetailList.add(new TradeDetail(
                                            receiverMobile: order?.title,
                                            address: order?.num,
                                    ))
                                }
                        }
                        //每条trade记录后加一条空白
                        tradeDetailList.add(new TradeDetail())
                }
        }

        tradeDetailList.add(new TradeDetail(communityName: '总订单数：', communityAddress: total))

        def headers = ['订单编号', '联系人', '联系电话', '收货地址', '用户留言']

        def withProperties = ['tradeId', 'receiverName', 'receiverMobile', 'address', 'buyerMessage']

        WebXlsxExporter webXlsxExporter = new WebXlsxExporter()

        webXlsxExporter.with {
            setResponseHeaders(response)
            fillHeader(headers)
            add(tradeDetailList, withProperties)
            for (int g = 0; g < 9; g++) {
                getSheet().autoSizeColumn(g)
            }
            save(response.outputStream)
        }
    }

}
