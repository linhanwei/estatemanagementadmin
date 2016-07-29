import grails.util.Environment
import me.chanjar.weixin.mp.api.WxMpServiceImpl
import net.spy.memcached.DefaultHashAlgorithm
import net.spy.memcached.auth.AuthDescriptor
import net.spy.memcached.auth.PlainCallbackHandler
import net.spy.memcached.spring.MemcachedClientFactoryBean
import net.spy.memcached.transcoders.SerializingTranscoder
import org.apache.shiro.authc.credential.HashedCredentialsMatcher
import org.apache.shiro.crypto.hash.Sha512Hash
import org.springframework.batch.core.configuration.annotation.JobBuilderFactory
import org.springframework.batch.core.configuration.annotation.StepBuilderFactory
import org.springframework.batch.core.configuration.support.MapJobRegistry
import org.springframework.batch.core.explore.support.JobExplorerFactoryBean
import org.springframework.batch.core.launch.support.SimpleJobLauncher
import org.springframework.batch.core.launch.support.SimpleJobOperator
import org.springframework.batch.core.repository.support.JobRepositoryFactoryBean
import welink.system.ReloadableJobRegistryBeanPostProcessor
import welink.system.wechat.WxMpMemcachedConfigStorage

// Place your Spring DSL code here
beans = {

    xmlns task: "http://www.springframework.org/schema/task"
    task.'annotation-driven'('proxy-target-class': true)

    switch (Environment.current) {
        case Environment.PRODUCTION:
            authDescriptor(AuthDescriptor, "PLAIN", new PlainCallbackHandler("b47d907e204145bb", "Unescn123456")) {
            }
            memcachedClient(MemcachedClientFactoryBean) {
                //servers = "b47d907e204145bb.m.cnhzaliqshpub001.ocs.aliyuncs.com:11211"
//                servers = "192.168.1.45:11211"
                servers = "120.24.102.187:11211"
                //authDescriptor = authDescriptor
                protocol = "BINARY"
                transcoder = new SerializingTranscoder().with { setCompressionThreshold(1024) }
                opTimeout = 1000
                timeoutExceptionThreshold = 1998
                hashAlg = DefaultHashAlgorithm.KETAMA_HASH
                locatorType = "CONSISTENT"
                failureMode = "Redistribute"
                useNagleAlgorithm = false
            }

            break

        case Environment.DEVELOPMENT:
        case Environment.TEST:
            authDescriptor(AuthDescriptor, "PLAIN", new PlainCallbackHandler("b47d907e204145bb", "Unescn123456")) {
            }
            memcachedClient(MemcachedClientFactoryBean) {
                //servers = "b47d907e204145bb.m.cnhzaliqshpub001.ocs.aliyuncs.com:11211"
                servers = "120.24.102.187:11211"
//                servers = "192.168.1.45:11211"
                //authDescriptor = authDescriptor
                protocol = "BINARY"
                transcoder = new SerializingTranscoder().with { setCompressionThreshold(1024) }
                opTimeout = 1000
                timeoutExceptionThreshold = 1998
                hashAlg = DefaultHashAlgorithm.KETAMA_HASH
                locatorType = "CONSISTENT"
                failureMode = "Redistribute"
                useNagleAlgorithm = false
            }

            break
    }

    // WeChat
    wxMpConfigStorage(WxMpMemcachedConfigStorage) {
        memcachedClient = memcachedClient
        grailsApplication = grailsApplication
    }

    wxMpService(WxMpServiceImpl) {
        wxMpConfigStorage = wxMpConfigStorage
    }

    // 密码相关
    credentialMatcher(HashedCredentialsMatcher) {
        storedCredentialsHexEncoded = true
        hashAlgorithmName = Sha512Hash.ALGORITHM_NAME
        hashIterations = Integer.valueOf(grailsApplication.config.security.iterate_times)

    }

    // spring batch
    jobRepository(JobRepositoryFactoryBean) {
        dataSource = ref("dataSource")
        transactionManager = ref("transactionManager")
        databaseType = "mysql"
    }

    /*
     * Additional Job Launcher to support synchronous scheduling
     */
    jobLauncher(SimpleJobLauncher) {
        jobRepository = ref("jobRepository")
        taskExecutor = ref("eventTaskExecutor")
    }

    jobExplorer(JobExplorerFactoryBean) {
        dataSource = ref("dataSource")
    }
    jobRegistry(MapJobRegistry) {}
    //Use a custom bean post processor that will unregister the job bean before trying to initializing it again
    //This could cause some problems if you define a job more than once, you'll probably end up with 1 copy
    //of the last definition processed instead of getting a DuplicateJobException
    //Had to do this to get reloading to work
    jobRegistryPostProcessor(ReloadableJobRegistryBeanPostProcessor) {
        jobRegistry = ref("jobRegistry")
    }

    jobOperator(SimpleJobOperator) {
        jobRepository = ref("jobRepository")
        jobLauncher = ref("jobLauncher")
        jobRegistry = ref("jobRegistry")
        jobExplorer = ref("jobExplorer")
    }


    stepBuilderFactory(StepBuilderFactory, ref("jobRepository"), ref("transactionManager"))

    jobBuilderFactory(JobBuilderFactory, ref("jobRepository"))
}