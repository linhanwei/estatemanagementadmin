package main

import com.google.common.base.Preconditions
import grails.converters.JSON
import io.keen.client.java.KeenClient
import welink.common.Item
import welink.system.UndeliveredTradeScheduleService

import javax.annotation.PostConstruct
import javax.annotation.Resource

class DashboardController {

    static lazyInit = false

    def keenIOService

    @Resource
    KeenClient keenClient;

    def index() {

    }

    @PostConstruct
    public void init() {
        Preconditions.checkNotNull(keenClient)
    }
}
