import welink.common.Trade
import welink.system.LbsStationAmapService

LbsStationAmapService lbsStationAmapService = ctx.getBean("lbsStationAmapService")

Trade trade = Trade.findById(9880L)

lbsStationAmapService.createNewDate2AmapTable(trade)