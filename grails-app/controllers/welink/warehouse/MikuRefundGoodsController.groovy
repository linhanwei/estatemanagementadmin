package welink.warehouse

import com.google.common.collect.ImmutableMap

class MikuRefundGoodsController {
    static ImmutableMap<Integer, String> PageMap = ImmutableMap.builder() //
            .put(5, "5")
            .put(10, "10")
            .put(20, "20")
            .put(30, "30")
            .put(40, "40")
            .put(50, "50")
            .put(100, "100")
            .put(200, "200")
            .put(500, "500")
            .build()

    def index() {}

    //退货管理
    def list(){

    }
}
