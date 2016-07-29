package welink.schedule

import org.quartz.JobExecutionContext
import org.quartz.JobExecutionException
import org.springframework.beans.factory.config.BeanDefinition
import org.springframework.context.annotation.Scope
import org.springframework.scheduling.quartz.QuartzJobBean
import org.springframework.stereotype.Component
import welink.common.DataCalcuService

import javax.annotation.Resource

/**
 * Created by saarixx on 15/4/15.
 */
@Component
@Scope(value = BeanDefinition.SCOPE_PROTOTYPE)
class JobStatistic extends QuartzJobBean {

    @Resource
    DataCalcuService dataCalcuService

    @Override
    protected void executeInternal(JobExecutionContext context) throws JobExecutionException {
        dataCalcuService.scheduleCalc()
    }

}
