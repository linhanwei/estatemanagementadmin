import groovyx.gpars.actor.Actors
import groovyx.gpars.scheduler.DefaultPool
import org.apache.commons.lang.builder.ToStringBuilder
import org.apache.commons.lang3.StringUtils
import org.slf4j.Logger
import org.slf4j.LoggerFactory
import welink.common.AlipayBack
import welink.common.ConsigneeAddr
import welink.estate.Community
import welink.system.PointInPolygonService

import java.util.concurrent.Executors
import java.util.concurrent.ThreadPoolExecutor
import java.util.concurrent.TimeUnit

import static grails.async.Promises.waitAll
import static groovyx.gpars.GParsExecutorsPool.withPool

PointInPolygonService pointInPolygonService = ctx.getBean("pointInPolygonService")

Logger logger = LoggerFactory.getLogger(AlipayBack)

def communityIds = [2014L, 2015L, 2016L, 2017L, 2019L, 2021L, 2022L, 2023L, 2024L, 2032L, 2033L, 2035L, 2036L, 2037L, 2029L, 2030L, 2031L]


List<Community> communities = Community.findAllByIdInList(communityIds).findAll {
    StringUtils.isNotBlank(it.deliveryArea)
}

List<ConsigneeAddr> consigneeAddrList = ConsigneeAddr.findAllByCommunityIdInList([2005L, 2000L]).findAll {
    ConsigneeAddr consigneeAddr ->
        consigneeAddr.longitude && consigneeAddr.latitude
}

logger.info("size --> ${consigneeAddrList.size()}")
logger.info("size --> ${consigneeAddrList.get(0).id}")
logger.info("size --> ${consigneeAddrList.get(1).id}")

def executor = Executors.newFixedThreadPool(100)

def map = [:]


consigneeAddrList.each {
    consigneeAddr ->
        executor.execute(new Runnable() {
            @Override
            void run() {
                boolean bingo = false

                def point = "${consigneeAddr.longitude},${consigneeAddr.latitude}"

                logger.info "id -> ${consigneeAddr.id}"

                for (Community community : communities) {
                    if (pointInPolygonService.isIn(point, community.deliveryArea)) {
                        bingo = true;
                        logger.info("bingo : ${consigneeAddr.communityId} -> ${community.id} : ${consigneeAddr.id}")
                        map.put(consigneeAddr.id, community.id)
                        break;
                    }
                }

                if (!bingo) {
                    map.put(consigneeAddr.id, -1L)
                }
            }
        })
}



executor.shutdown()
executor.awaitTermination(10, TimeUnit.MINUTES)

logger.info(ToStringBuilder.reflectionToString(map))

DefaultPool pool = (DefaultPool) Actors.defaultActorPGroup.threadPool
ThreadPoolExecutor exe = (ThreadPoolExecutor) pool.executorService
exe.maximumPoolSize = 100

def tasks = []

consigneeAddrList.each {
    consigneeAddr ->
        withPool 100, {
            tasks << ConsigneeAddr.async.task {
                withTransaction {
                    consigneeAddr.communityId = map.get(consigneeAddr.id)
                    consigneeAddr.save(flush: true, failOnError: true)
                }
            }
        }
}

waitAll(tasks)

println 1
