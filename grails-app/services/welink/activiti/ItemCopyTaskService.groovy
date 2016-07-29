package welink.activiti

import com.google.common.collect.Lists
import com.welink.buy.utils.Constants
import grails.transaction.Transactional
import org.springframework.batch.core.JobParametersBuilder
import org.springframework.batch.core.Step
import org.springframework.batch.core.StepContribution
import org.springframework.batch.core.configuration.annotation.JobBuilderFactory
import org.springframework.batch.core.configuration.annotation.StepBuilderFactory
import org.springframework.batch.core.job.SimpleJob
import org.springframework.batch.core.job.builder.JobBuilder
import org.springframework.batch.core.job.builder.SimpleJobBuilder
import org.springframework.batch.core.launch.JobLauncher
import org.springframework.batch.core.scope.context.ChunkContext
import org.springframework.batch.core.step.tasklet.Tasklet
import org.springframework.batch.core.step.tasklet.TaskletStep
import org.springframework.batch.repeat.RepeatStatus
import org.springframework.core.task.TaskExecutor
import welink.common.Item
import welink.common.Shop
import welink.estate.Community
import welink.estate.ObjectTagged

import javax.annotation.PostConstruct
import javax.annotation.Resource

import static com.google.common.base.Preconditions.checkArgument
import static com.google.common.base.Preconditions.checkNotNull
import static com.welink.commons.commons.BizConstants.ShopTypeEnum.CITY_SHOP
import static com.welink.commons.commons.BizConstants.ShopTypeEnum.STATION_SHOP

/**
 * 商品从总资源店铺到各个分站点店铺，所以需要开一个任务流
 */
class ItemCopyTaskService {

    static lazyInit = false

    @Resource
    JobBuilderFactory jobBuilderFactory

    @Resource
    StepBuilderFactory stepBuilderFactory

    @Resource(name = 'eventTaskExecutor')
    TaskExecutor eventTaskExecutor

    @Resource
    JobLauncher jobLauncher

    static transactional = false

    def checkCityItemInAllStation(Item item) {
        checkNotNull(item)
        checkArgument(item.shopType == CITY_SHOP.action)

        Long cityId = Shop.findById(item.shopId).cityId

        // 找到城市的所有站点店铺Id

        def result = [:]

        Shop.findByCityIdAndTypeAndStatus(cityId, 1 as byte, 1 as byte).each {
            Shop stationShop ->
                int count = Item.countByShopIdAndBaseItemId(stationShop.id, item.id)
                if (count > 0) {
                    result.put(stationShop.id, count)
                }
        }

        result
    }

    /**
     * 推一个店铺商品拷贝任务
     *
     * @param item
     * @return
     */
    def pushItemToAllStation(Item item, boolean force) {
        checkNotNull(item)
        checkArgument(item.shopType == CITY_SHOP.action)

        if (!force && checkCityItemInAllStation(item)?.size() > 0) {
            return false
        }


        Long cityId = Shop.findById(item.shopId).cityId
        Shop.findAllByCityIdAndTypeAndStatus(cityId, 1 as byte, 1 as byte).each {
            Shop stationShop ->
                copyCityItemToStationItem(item, stationShop)
        }

//        Spring Bath的批量操作
//        List<Step> steps = Lists.newArrayList()
//
//        Shop.findAllByCityIdAndTypeAndStatus(cityId, 1 as byte, 1 as byte).each {
//            Shop stationShop ->
//
//                TaskletStep taskletStep = stepBuilderFactory.get("copy_city_item_to_station").tasklet(new Tasklet() {
//                    @Override
//                    RepeatStatus execute(StepContribution contribution, ChunkContext chunkContext) throws Exception {
//                        copyCityItemToStationItem(item, stationShop)
//                        return RepeatStatus.FINISHED
//                    }
//                }).build()
//
//
//                steps.add(taskletStep)
//        }
//
//        JobBuilder jobBuilder = jobBuilderFactory.get("push_item_to_all_station")
//
//        SimpleJobBuilder simpleJobBuilder = new SimpleJobBuilder(jobBuilder)
//
//        SimpleJob job = simpleJobBuilder.build()
//        job.setSteps(steps)
//
//
//        jobLauncher.run(job, new JobParametersBuilder().addLong("city.item.id", item.id).addDate("sync_time", new Date()).toJobParameters())

        true
    }

    /**
     * 获取一个城市的所有有效站点店铺
     *
     * @param city
     * @return
     */
    List<Shop> getCityAllStationShop(Long city) {
        Shop cityShop = Shop.findByCityIdAndTypeAndStatus(city, CITY_SHOP.action, 1 as Byte)

        // 如果这个城市的城市店铺不在抛错
        checkNotNull(cityShop)

        return Shop.findAllByCityIdAndTypeAndStatus(city, STATION_SHOP.action, 1 as Byte)
    }

    /**
     * 获取一个城市的所有的站点数据
     *
     * @param city
     * @return
     */
    List<Community> getCityAllCommunity(Long city) {
        return Community.findAllByCityIdAndStatus(city, 1 as Byte)
    }

    /**
     * 动态step，从店铺的一个商品拷贝到另外一个店铺的商品
     */
    def serviceMethod() {

    }

    /**
     * 从店铺的一个商品拷贝到另外一个店铺的商品的实际实现过程
     *
     */

    @Transactional
    def copyCityItemToStationItem(Item source, Shop targetStationShop) {

        Item newItem = Item.findOrCreateByShopIdAndBaseItemId(targetStationShop.id, source.id)?.with {

            it.categoryId = source?.categoryId
            it.title = source?.title
            it.sellerId = targetStationShop?.sellerId
            it.sellerType = targetStationShop?.sellerType
            it.address = source?.address
            it.specification = source?.specification
            it.video = source?.video
            it.price = source?.price
            it.features = source?.features
            it.onlineStartTime = source?.onlineStartTime
            it.onlineEndTime = source?.onlineEndTime
            it.type = source?.type
            it.picUrls = source?.picUrls
            it.detail = source?.detail
            it.description = source?.description
            //复制的核心，店铺ID，商品编号，店铺等级
            it.shopId = targetStationShop?.id
            it.shopType = targetStationShop?.type
            it.baseItemId = source?.id
            it.approveStatus=0 as byte
            it.num = source?.num
            it.price = source?.price
            it.brandId=source?.brandId
            it.code=source?.code

            save(failOnError: true, flush: true)
        }

        // tag 复制
        ObjectTagged.findAllByArtificialIdAndTypeBetween(source.id, 999, 1999)?.each {
            ObjectTagged objectTagged ->
                ObjectTagged.findOrCreateByArtificialIdAndTagId(newItem.id, objectTagged.tagId)?.with {
                    it.artificialId = newItem.id
                    it.type = objectTagged?.type
                    it.kv = objectTagged?.kv
                    it.status = objectTagged?.status
                    it.startTime = objectTagged?.startTime
                    it.endTime = objectTagged?.endTime
                    it.tagId = objectTagged?.tagId
                    it.activityNum=objectTagged?.activityNum
                    it.activitySoldNum=objectTagged?.activitySoldNum
                    save(failOnError: true, flush: true)
                }
        }
    }


    @PostConstruct
    public final void init() {
        checkNotNull(jobBuilderFactory)
        checkNotNull(stepBuilderFactory)
        checkNotNull(eventTaskExecutor)
        checkNotNull(jobLauncher)
    }
}
