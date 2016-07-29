package welink.system

import org.springframework.scheduling.quartz.CronTriggerFactoryBean

/**
 * Needed to set Quartz useProperties=true when using Spring classes,
 * because Spring sets an object reference on JobDataMap that is not a String
 *
 * @see http://site.trimplement.com/using-spring-and-quartz-with-jobstore-properties/
 * @see http://forum.springsource.org/showthread.php?130984-Quartz-error-IOException
 * Created by saarixx on 15/4/15.
 */
class PersistableCronTriggerFactoryBean extends CronTriggerFactoryBean {

    String JOB_DETAIL_KEY = "jobDetail";

    @Override
    public void afterPropertiesSet() {
        super.afterPropertiesSet();

        //Remove the JobDetail element
        getJobDataMap().remove(JOB_DETAIL_KEY);
    }
}
