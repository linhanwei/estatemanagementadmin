package welink.common

import grails.converters.JSON
import welink.complain.Complain

import javax.annotation.PostConstruct
import java.util.concurrent.Executors
import java.util.concurrent.ScheduledExecutorService

import static com.welink.buy.utils.Constants.AppointmentServiceCategory.*
import static com.welink.buy.utils.Constants.TradeStatus.WAIT_BUYER_PAY

class BadgeService {

    public ScheduledExecutorService scheduledExecutorService = Executors.newScheduledThreadPool(1);

    static lazyInit = false

    /**
     * 更新预约与投诉的badge，
     */
    def refreshBadge(long communityId) {


        def household = countAppointmentStatus(communityId, HouseholdManagementService.getCategoryId(), WAIT_BUYER_PAY.tradeStatusId)
        def maintenance = countAppointmentStatus(communityId, MaintenanceService.getCategoryId(), WAIT_BUYER_PAY.tradeStatusId)
        def water = countAppointmentStatus(communityId, BottledWaterService.getCategoryId(), WAIT_BUYER_PAY.tradeStatusId)

        def appointment = household + maintenance + water

        def complain = countComplainStatus(communityId, 1 as byte);

        def data = [appointment: appointment, household: household, maintenance: maintenance, water: water, complain: complain]

        def json = [source: 'badge', data: data]

        def response = [type: "notification", resource: mapping, message: json] as JSON
    }

    /**
     * 预约
     *
     * @param communityId
     * @param categoryId
     * @param status
     * @return
     */
    int countAppointmentStatus(long communityId, long categoryId, byte status) {
        Trade.countByCommunityIdAndCategoryIdAndStatus(communityId, categoryId, status)
    }

    /**
     * 1代表待处理，2代表处理中，3代表已经完结
     *
     * @param communityId
     * @param status
     * @return
     */
    int countComplainStatus(long communityId, byte status) {
        Complain.countByCommunityIdAndStatus(communityId, status)
    }

    @PostConstruct
    void init() {

    }
}
