import org.apache.log4j.PatternLayout
import welink.utils.DailyMaxRollingFileAppender

// locations to search for config files that get merged into the main config;
// config files can be ConfigSlurper scripts, Java properties files, or classes
// in the classpath in ConfigSlurper format

// grails.config.locations = [ "classpath:${appName}-config.properties",
//                             "classpath:${appName}-config.groovy",
//                             "file:${userHome}/.grails/${appName}-config.properties",
//                             "file:${userHome}/.grails/${appName}-config.groovy"]

// if (System.properties["${appName}.config.location"]) {
//    grails.config.locations << "file:" + System.properties["${appName}.config.location"]
// }

grails.project.groupId = "com.7nb.estate.admin" // change this to alter the default package name and Maven publishing destination

// The ACCEPT header will not be used for content negotiation for user agents containing the following strings (defaults to the 4 major rendering engines)
grails.mime.disable.accept.header.userAgents = ['Gecko', 'WebKit', 'Presto', 'Trident']
grails.mime.types = [ // the first one is the default format
                      all          : '*/*', // 'all' maps to '*' or the first available format in withFormat
                      atom         : 'application/atom+xml',
                      css          : 'text/css',
                      csv          : 'text/csv',
                      form         : 'application/x-www-form-urlencoded',
                      html         : ['text/html', 'application/xhtml+xml'],
                      js           : 'text/javascript',
                      json         : ['application/json', 'text/json'],
                      multipartForm: 'multipart/form-data',
                      rss          : 'application/rss+xml',
                      text         : 'text/plain',
                      hal          : ['application/hal+json', 'application/hal+xml'],

                      xml          : ['text/xml', 'application/xml'],

                      pdf          : 'application/pdf',

                      rtf          : 'application/rtf',

                      excel        : 'application/vnd.ms-excel',

                      ods          : 'application/vnd.oasis.opendocument.spreadsheet',
]

// URL Mapping Cache Max Size, defaults to 5000
//grails.urlmapping.cache.maxsize = 1000

// Legacy setting for codec used to encode data with ${}
grails.views.default.codec = "html"

// The default scope for controllers. May be prototype, session or singleton.
// If unspecified, controllers are prototype scoped.
grails.controllers.defaultScope = 'singleton'

// GSP settings
grails {
    views {
        gsp {
            encoding = 'UTF-8'
            htmlcodec = 'xml' // use xml escaping instead of HTML4 escaping
            codecs {
                expression = 'html' // escapes values inside ${}
                scriptlet = 'html' // escapes output from scriptlets in GSPs
                taglib = 'none' // escapes output from taglibs
                staticparts = 'none' // escapes output from static template parts
            }
        }
        // escapes all not-encoded output at final stage of outputting
        // filteringCodecForContentType.'text/html' = 'html'
    }
}


grails.converters.encoding = "UTF-8"
// scaffolding templates configuration
grails.scaffolding.templates.domainSuffix = 'Instance'

// Set to false to use the new Grails 1.2 JSONBuilder in the render method
grails.json.legacy.builder = false
// enabled native2ascii conversion of i18n properties files
grails.enable.native2ascii = true
// packages to include in Spring bean scanning
grails.spring.bean.packages = []
// whether to disable processing of multi part requests
grails.web.disable.multipart = false

// request parameters to mask when logging exceptions
grails.exceptionresolver.params.exclude = ['password']

// configure auto-caching of queries by default (if false you can cache individual queries with 'cache: true')
grails.hibernate.cache.queries = true

// configure passing transaction's read-only attribute to Hibernate session, queries and criterias
// set "singleSession = false" OSIV mode in hibernate configuration after enabling
grails.hibernate.pass.readonly = false
// configure passing read-only to OSIV session by default, requires "singleSession = false" OSIV mode
grails.hibernate.osiv.readonly = false

environments {
    development {
        grails.logging.jul.usebridge = true
    }
    production {
        grails.logging.jul.usebridge = false
    }
}

// log4j configuration
log4j.main = {
    // Example of changing the log pattern for the default console appender:
    //
    appenders {
        appender new DailyMaxRollingFileAppender(
                name: "file",
                encoding: "UTF-8",
                //file: "/home/admin/logs/estatemanagementadmin/admin.log",
                file: "/home/unes/estatemanagementadmin/logs/admin.log",
                datePattern: "'.'yyyy-MM-dd",
                maxBackupIndex: 30,
                layout: new PatternLayout(conversionPattern: "%d{ABSOLUTE} %-5p [%t] [%c{1}] %m%n")
        )

        appender new DailyMaxRollingFileAppender(
                name: "stacktrace",
                encoding: "UTF-8",
                //file: "/home/admin/logs/estatemanagementadmin/stacktrace.log",
                file: "/home/unes/estatemanagementadmin/logs/stacktrace.log",
                datePattern: "'.'yyyy-MM-dd",
                maxBackupIndex: 30,
                layout: new PatternLayout(conversionPattern: "%d{ABSOLUTE} %-5p [%t] [%c{1}] %m%n")
        )

        console name: 'stdout', layout: pattern(conversionPattern: "%d{ABSOLUTE} %-5p [%t] [%c{1}] %m%n")
        console name: 'stacktrace'
    }

    info 'org.codehaus.groovy.grails.web.servlet',        // controllers
            'org.codehaus.groovy.grails.web.pages',          // GSP
            'org.codehaus.groovy.grails.web.sitemesh',       // layouts
            'org.codehaus.groovy.grails.web.mapping.filter', // URL mapping
            'org.codehaus.groovy.grails.web.mapping',        // URL mapping
            'org.codehaus.groovy.grails.commons',            // core / classloading
            'org.codehaus.groovy.grails.plugins',            // plugins
            'org.codehaus.groovy.grails.orm.hibernate'      // hibernate integration

    info 'org.springframework',
            'org.hibernate',
            'net.sf.ehcache.hibernate',
            'com.welink',
            'welink',
            'me.guogege'

    root {
        info 'stdout', 'file'
        additivity = false
    }
}


environments {
    development {
        /**
         * Possible values : "local", "node", "dataNode", "transport"
         * If set to null, "node" mode is used by default.
         */
        opensearch {
            accesskey = "GDheOkyZuLg7VALU";
            secret = "7sQA8nMHZkB3CNgspOWnpzrl5B7tx0";
        }

        grails {
            redis {
                poolConfig {
                    // jedis pool specific tweaks here, see jedis docs & src
                    maxTotal = 512
                    maxIdle = 512
                }
                timeout = 2000 //default in milliseconds
//            password = "Immysql123456" //defaults to no password

                // use a single redis server (use only if nore using sentinel cluster)
                port = 6379
                host = "localhost"
            }
        }

    }
    test {
        opensearch {
            accesskey = "GDheOkyZuLg7VALU";
            secret = "7sQA8nMHZkB3CNgspOWnpzrl5B7tx0";
        }

        grails {
            redis {
                poolConfig {
                    // jedis pool specific tweaks here, see jedis docs & src
                    maxTotal = 512
                    maxIdle = 512
                }
                timeout = 2000 //default in milliseconds
//            password = "Immysql123456" //defaults to no password

                // use a single redis server (use only if nore using sentinel cluster)
                port = 6379
                host = "7nb.com.cn"
            }

        }

    }
    production {
        opensearch {
            accesskey = "aHg4n4dESlLleVJz";
            secret = "L2iNoTs1UyRStJgUtkTtqmHUS22Thd";
        }

        grails {
            redis {
                poolConfig {
                    // jedis pool specific tweaks here, see jedis docs & src
                    maxTotal = 512
                    maxIdle = 512
                }
                timeout = 2000 //default in milliseconds
                password = "3ca38052c8a611e4:MASkin616510" //defaults to no password

                // use a single redis server (use only if nore using sentinel cluster)
                port = 6379
                host = "3ca38052c8a611e4.m.cnhza.kvstore.aliyuncs.com"
            }
        }
    }
}

environments {
    development {

        //极光推送配置信息
        jpush{
            masterSecret = "7a2492ceb70cf6e0e08a73e8"
            appKey = "a4e8f80c0065acd781a8dce2"

        }

        upyun {
//            bucket = "welinklife"
//            domain = "http://v0.api.upyun.com/"
//            return_url = "http://localhost:8080/estatemanagementadmin/upyun/no-use.txt"
//            form_api_secret = 'ygN9BrWue6oPEQPl2Djg6HIgN6w='
//            username = 'karsa'
//            password = 'welink@168'
            bucket = "unesmall"
            domain = "http://v0.api.upyun.com/"
            return_url = "http://localhost:8080/estatemanagementadmin/upyun/no-use.txt"
            form_api_secret = 'YRz/0/uKWWTKWk5dd9tPiNjOSeQ='
            username = 'unesmall'
            password = 'unesmall123456'
        }

        security {
//            salted = 'SoraAoi'
//            iterate_times = 1
            salted = 'YuiAragaki'
            iterate_times = 179
        }

//        ons {
//            item_update {
//                topic = "unescn_item_update"
//                producer_id = "PID_UNESCN_ITEM_UPDATE"
//            }
//            system_signal {
//                topic = "unescn_system_signal"
//                producer_id = "PID_UNESCN_SYSTEM_SIGNAL"
//            }
//            trade_event {
//                topic = "unescn_trade_event"
//                producer_id = "PID_UNESCN_TRADE_EVENT"
//            }
//        }
        ons {
            item_update {
                topic = "unes_item_update"
                producer_id = "PID_UNES_ITEM_UPDATE"
            }
            system_signal {
                topic = "unes_system_signal"
                producer_id = "PID_UNES_SYSTEM_SIGNAL"
            }
            trade_event {
                topic = "unes_trade_event"
                producer_id = "PID_UNES_TRADE_EVENT"
            }
        }

        weChat {
            appId = "wxac1318c07e16ee69";
            secret = "f223218fef63b7f7e83fe85e67c1fe70";
            token = "7fOWBiQdXjWihcUxNmq6L6jkpcc11ezA";
            aesKey = "HmIlsrjG9K4GNcRKja55D8dG0b9QyTfCDnlvjiyVhQO";
        }


        baidu {
            name = "guogege"
            rest_key = "EvhWsp4Px5UYYrHz6UvjUph1"
            js_key = "lE3TSjZj7uWuikeZo1tboAF2"
        }

        amap {
            rest_key = "45037846683337ee5ba40b262fc548f0"
            js_key = "5ed63337c84e1692c4e8fccefe639250"
        }
    }
    test {
        //极光推送配置信息
        jpush{
            masterSecret = "7a2492ceb70cf6e0e08a73e8"
            appKey = "a4e8f80c0065acd781a8dce2"

        }

        upyun {
            bucket = "bonamana"
            return_url = "http://localhost:8080/estatemanagementadmin/upyun/no-use.txt"
            form_api_secret = 'ygN9BrWue6oPEQPl2Djg6HIgN6w=';
        }

        security {
            salted = 'SoraAoi'
            iterate_times = 1
        }

//        ons {
//            item_update {
//                topic = "unescn_item_update"
//                producer_id = "PID_UNESCN_ITEM_UPDATE"
//            }
//            system_signal {
//                topic = "unescn_system_signal"
//                producer_id = "PID_UNESCN_SYSTEM_SIGNAL"
//            }
//            trade_event {
//                topic = "unescn_trade_event"
//                producer_id = "PID_UNESCN_TRADE_EVENT"
//            }
//        }
        ons {
            item_update {
                topic = "unes_item_update"
                producer_id = "PID_UNES_ITEM_UPDATE"
            }
            system_signal {
                topic = "unes_system_signal"
                producer_id = "PID_UNES_SYSTEM_SIGNAL"
            }
            trade_event {
                topic = "unes_trade_event"
                producer_id = "PID_UNES_TRADE_EVENT"
            }
        }

        weChat {
            appId = "wx85c76d40f0472258";
            secret = "72830cb66db45f1aa0120850553f47ec";
            token = "7fOWBiQdXjWihcUxNmq6L6jkpcc11ezA";
            aesKey = "HmIlsrjG9K4GNcRKja55D8dG0b9QyTfCDnlvjiyVhQO";
        }

        baidu {
            name = "guogege"
            rest_key = "EvhWsp4Px5UYYrHz6UvjUph1"
            js_key = "lE3TSjZj7uWuikeZo1tboAF2"
        }

        amap {
            rest_key = "45037846683337ee5ba40b262fc548f0"
            js_key = "5ed63337c84e1692c4e8fccefe639250"
        }
    }
    production {
        //极光推送配置信息
        jpush{
            masterSecret = "c8317190ee041f974ca19840"
            appKey = "6b00b2174d2826f3b9867b50"

        }

        upyun {
            bucket = "mikumine"
            domain = "http://v0.api.upyun.com/"
            return_url = "http://localhost:8080/estatemanagementadmin/upyun/no-use.txt"
            form_api_secret = 'N7kQXoPUhGSbApd6t1Xbx0ygwUo='
            username = 'unesmall'
            password = 'unesmall123456'
        }

        security {
            salted = 'YuiAragaki'
            iterate_times = 179
        }

//        ons {
//            item_update {
//                topic = "unescn_item_update"
//                producer_id = "PID_UNESCN_ITEM_UPDATE"
//            }
//            system_signal {
//                topic = "unescn_system_signal"
//                producer_id = "PID_UNESCN_SYSTEM_SIGNAL"
//            }
//            trade_event {
//                topic = "unescn_trade_event"
//                producer_id = "PID_UNESCN_TRADE_EVENT"
//            }
//        }
        ons {
            item_update {
                topic = "miku_item_update"
                producer_id = "PID_MIKU_ITEM_UPDATE"
            }
            system_signal {
                topic = "miku_system_signal"
                producer_id = "PID_MIKU_SYSTEM_SIGNAL"
            }
            trade_event {
                topic = "miku_trade_event"
                producer_id = "PID_MIKU_TRADE_EVENT"
            }
        }

        weChat {
            appId = "wx85c76d40f0472258";
            secret = "72830cb66db45f1aa0120850553f47ec";
            token = "7fOWBiQdXjWihcUxNmq6L6jkpcc11ezA";
            aesKey = "HmIlsrjG9K4GNcRKja55D8dG0b9QyTfCDnlvjiyVhQO";
        }

        baidu {
            name = "guogege"
            rest_key = "FUF4yIyLEGE9CnkD2M9qPgVU"
            js_key = "CyUHFdFmANZOjSxcCoGk3bjk"
        }

        amap {
            rest_key = "36d9f8e2f79ffb2dd451b6d109ac1d4b"
            js_key = "095a410b47da49ee0a4bbb5a5db34ef5"
        }
    }
}

grails.gorm.default.constraints = {
    '*'(nullable: true)
}

grails.plugin.console.enabled = true