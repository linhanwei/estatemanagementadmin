grails.servlet.version = "3.0" // Change depending on target container compliance (2.5 or 3.0)
grails.tomcat.nio = true
grails.project.class.dir = "target/classes"
grails.project.test.class.dir = "target/test-classes"
grails.project.test.reports.dir = "target/test-reports"
grails.project.work.dir = "target/work"
grails.project.target.level = 1.8
grails.project.source.level = 1.8
//grails.project.war.file = "target/${appName}.tar.gz"
grails.project.war.file = "target/${appName}.war"

grails.project.fork = [
        // configure settings for compilation JVM, note that if you alter the Groovy version forked compilation is required
//        compile: [maxMemory: 256, minMemory: 64, debug: false, maxPerm: 256, daemon: true],
        compile: [maxMemory: 1024, minMemory: 64, debug: false, maxPerm: 512, daemon: true],

        // configure settings for the test-app JVM, uses the daemon by default
//        test   : [maxMemory: 768, minMemory: 64, debug: false, maxPerm: 256, daemon: true],
        test:false,
        // configure settings for the run-app JVM
//         run    : [maxMemory: 768, minMemory: 64, debug: false, maxPerm: 256, forkReserve: false],
        run:false,
        // configure settings for the run-war JVM
//        war    : [maxMemory: 768, minMemory: 64, debug: false, maxPerm: 256, forkReserve: false],
        war    : [maxMemory: 1024, minMemory: 64, debug: false, maxPerm: 512, forkReserve: false],
        // configure settings for the Console UI JVM
//        console: [maxMemory: 768, minMemory: 64, debug: false, maxPerm: 256]
        console: [maxMemory: 1024, minMemory: 64, debug: false, maxPerm: 512]
]

grails.project.dependency.resolver = "maven" // or ivy
grails.project.dependency.resolution = {
    // inherit Grails' default dependencies
    inherits("global") {
        // specify dependency exclusions here; for example, uncomment this to disable ehcache:
        // excludes 'ehcache'
        excludes 'com.google.guava:guava'
    }
    log "error" // log level of Ivy resolver, either 'error', 'warn', 'info', 'debug' or 'verbose'
    checksums true // Whether to verify checksums on resolve
    legacyResolve false
    // whether to do a secondary resolve on plugin installation, not advised and here for backwards compatibility

    repositories {
        inherits true // Whether to inherit repository definitions from plugins

        mavenLocal("${userHome}/.m2/repository")

        mavenRepo "http://central.maven.org/maven2/"
        mavenCentral()

        grailsPlugins()
        grailsHome()
        grailsCentral()

        // uncomment these (or add new ones) to enable remote dependency resolution from public Maven repositories
        //mavenRepo "http://repository.codehaus.org"
        //mavenRepo "http://download.java.net/maven/2/"
        //mavenRepo "http://repository.jboss.com/maven2/"
        mavenRepo "http://central.maven.org/maven2/"
        mavenRepo "http://repo.grails.org/grails/core"
        mavenRepo "http://maven.nlpcn.org/"
        //excel
        mavenRepo "http://repo.grails.org/grails/libs-releases/"
        mavenRepo "http://m2repo.spockframework.org/ext/"
    }

    dependencies {
        // specify dependencies here under either 'build', 'compile', 'runtime', 'test' or 'provided' scopes e.g.
        runtime 'mysql:mysql-connector-java:5.1.34'
        compile 'com.google.guava:guava:18.0'
        // runtime 'org.postgresql:postgresql:9.3-1101-jdbc41'
        test "org.grails:grails-datastore-test-support:1.0.2-grails-2.4"
        compile "org.apache.commons:commons-lang3:3.0"
        compile 'joda-time:joda-time:2.7'
        compile 'com.alibaba:fastjson:1.2.4'
        compile 'com.google.code.findbugs:jsr305:3.0.0'
        compile 'commons-fileupload:commons-fileupload:1.3.1'
        compile 'commons-httpclient:commons-httpclient:3.1'

        compile 'com.aliyun.openservices:aliyun-openservices-sls-v0.3:0.1.0'
        compile 'com.aliyun.openservices:ons-client:1.1.5'
        compile('com.aliyun.opensearch:aliyun-sdk-opensearch:2.1.2') {
            excludes "org.slf4j:slf4j-nop"
        }
        compile 'com.vividsolutions:jts:1.13'

        compile 'net.spy:spymemcached:2.11.5'
        compile 'me.chanjar:weixin-java-mp:1.1.4'
        compile 'xerces:xerces:2.4.0'

        compile 'org.apache.httpcomponents:httpclient:4.3.5'
        compile 'org.apache.httpcomponents:httpcore:4.3.2'

        compile 'org.apache.commons:commons-math3:3.4'

        compile 'io.keen:keen-client-api-java:2.1.0'

        compile 'redis.clients:jedis:2.7.0'

        runtime 'org.slf4j:jul-to-slf4j:1.7.10'

        compile('org.springframework.batch:spring-batch-core:3.0.3.RELEASE')
        compile('org.springframework.batch:spring-batch-infrastructure:3.0.3.RELEASE')

        compile('org.quartz-scheduler:quartz:2.2.1')
        compile('org.quartz-scheduler:quartz-jobs:2.2.1')
        compile('org.quartz-scheduler:quartz-jobs:2.2.1')


        compile('com.fasterxml.jackson.core:jackson-core:2.5.1', 'com.fasterxml.jackson.core:jackson-databind:2.5.1')

//        compile ":excel-export:0.2.1"
    }

    plugins {
        // plugins for the build system only
        build ":tomcat:8.0.21"

        // plugins for the compile step
        compile ":scaffolding:2.1.2"
        compile ':cache:1.1.8'
        compile ":asset-pipeline:2.1.5"

        // plugins needed at runtime but not for compilation
        runtime ":hibernate4:4.3.8.1" // or ":hibernate:3.6.10.18"
        runtime ":database-migration:1.4.0"

        compile ":console:1.5.4"
        runtime ":jquery:1.11.1"

        runtime(":redis:1.6.4") { exclude "jedis" }
        compile(":shiro:1.2.1") { exclude "quartz" }
        compile ":excel-export:0.2.1"

        // Uncomment these to enable additional asset-pipeline capabilities
        //compile ":sass-asset-pipeline:1.9.0"
        //compile ":less-asset-pipeline:1.10.0"
        //compile ":coffee-asset-pipeline:1.8.0"
        //compile ":handlebars-asset-pipeline:1.3.0.3"
    }
}
