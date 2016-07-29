package welink.trade

import com.google.common.collect.Lists
import welink.common.Trade

/**
 * Created by saarixx on 23/12/14.
 */
class TradeGroup {

    List<Trade> trades = Lists.newArrayList()

    Long sum

    Date earliest

    Boolean emergency

}
