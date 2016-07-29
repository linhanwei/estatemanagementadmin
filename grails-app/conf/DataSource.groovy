dataSource {
    pooled = true
    jmxExport = true
    driverClassName = "com.mysql.jdbc.Driver"
    dialect = 'org.hibernate.dialect.MySQL5InnoDBDialect'
    dbCreate = "validate" // one of 'create', 'create-drop', 'update', 'validate', ''
    environments {
        development {
            loggingSql = true
        }
        production {
            loggingSql = false
        }
    }
}
hibernate {
    cache.use_second_level_cache = false
    cache.use_query_cache = false
//    cache.region.factory_class = 'net.sf.ehcache.hibernate.EhCacheRegionFactory' // Hibernate 3
    cache.region.factory_class = 'org.hibernate.cache.ehcache.EhCacheRegionFactory' // Hibernate 4
    singleSession = true // configure OSIV singleSession mode
    flush.mode = 'manual' // OSIV session flush mode outside of transactional context
}

// environment specific settings
environments {
    development {
        dataSource {
            dbCreate = "update" // one of 'create', 'create-drop', 'update', 'validate', ''

//            username = "unes"
//            password = "Unes2015"
//            /*username = "welinklife"
//            password = "Immysql123456"
//            url = "jdbc:mysql://unescn00.mysql.rds.aliyuncs.com/linklife?useUnicode=true&amp;characterEncoding=utf8"*/
////            username = "unes"
////            password = "8xW7wdWdhFe"
//            //生产环境
////            url = "jdbc:mysql://rdsh3zt3j690338a36lao.mysql.rds.aliyuncs.com:3306/linklife?useUnicode=true&amp;characterEncoding=utf8"
//            url = "jdbc:mysql://rdsh3zt3j690338a36lao.mysql.rds.aliyuncs.com:3306/linklife?useUnicode=true&amp;characterEncoding=utf8"


                //测试环境
                username = "unes"
                password = "8xW7wdWdhFe"
//////                //外网
                url = "jdbc:mysql://rdsqv472b2f2i81q2b11o.mysql.rds.aliyuncs.com:3306/miku_test?useUnicode=true&amp;characterEncoding=utf8"
                //内网
//              url = "jdbc:mysql://rdsqv472b2f2i81q2b11.mysql.rds.aliyuncs.com:3306/miku_test?useUnicode=true&amp;characterEncoding=utf8"


                //开发环境
//                username = "unes"
//                password = "Unes2015"
//                url = "jdbc:mysql://rdsh3zt3j690338a36lao.mysql.rds.aliyuncs.com:3306/linklife?useUnicode=true&amp;characterEncoding=utf8"

//            //内网
//            url = "jdbc:mysql://rdsqv472b2f2i81q2b11.mysql.rds.aliyuncs.com:3306/miku_test?useUnicode=true&amp;characterEncoding=utf8"
            properties {
                // See http://grails.org/doc/latest/guide/conf.html#dataSource for documentation
                jmxEnabled = true
                initialSize = 5
                maxActive = 50
                minIdle = 5
                maxIdle = 25
                maxWait = 10000
                maxAge = 10 * 60000
                timeBetweenEvictionRunsMillis = 5000
                minEvictableIdleTimeMillis = 60000
                validationQuery = "SELECT 1"
                validationQueryTimeout = 3
                validationInterval = 15000
                testOnBorrow = false
                testWhileIdle = true
                testOnReturn = false
                jdbcInterceptors = "ConnectionState"
                defaultTransactionIsolation = java.sql.Connection.TRANSACTION_READ_COMMITTED
            }
        }
    }
    test {
        dataSource {
//            dbCreate = "update" // one of 'create', 'create-drop', 'update', 'validate', ''
            username = "unes"
            password = "8xW7wdWdhFe"
//            url = "jdbc:mysql://120.24.102.187:4407/linklife?useUnicode=true&amp;characterEncoding=utf8"
//            url = "jdbc:mysql://rds4544gvd3899g5ukdypublic.mysql.rds.aliyuncs.com:3306/linklife?useUnicode=true&amp;characterEncoding=utf8"
//            url = "jdbc:mysql://rdsqv472b2f2i81q2b11.mysql.rds.aliyuncs.com:3306/linklife?useUnicode=true&amp;characterEncoding=utf8"
            //miku_test 2016年03年14月开始
            //公网
            url = "jdbc:mysql://rdsqv472b2f2i81q2b11o.mysql.rds.aliyuncs.com:3306/miku_test?useUnicode=true&amp;characterEncoding=utf8"
            //内网
//            url = "jdbc:mysql://rdsqv472b2f2i81q2b11.mysql.rds.aliyuncs.com:3306/miku_test?useUnicode=true&amp;characterEncoding=utf8"
            properties {
                // See http://grails.org/doc/latest/guide/conf.html#dataSource for documentation
                jmxEnabled = true
                initialSize = 5
                maxActive = 50
                minIdle = 5
                maxIdle = 25
                maxWait = 10000
                maxAge = 10 * 60000
                timeBetweenEvictionRunsMillis = 5000
                minEvictableIdleTimeMillis = 60000
                validationQuery = "SELECT 1"
                validationQueryTimeout = 3
                validationInterval = 15000
                testOnBorrow = false
                testWhileIdle = true
                testOnReturn = false
                jdbcInterceptors = "ConnectionState"
                defaultTransactionIsolation = java.sql.Connection.TRANSACTION_READ_COMMITTED
            }
        }
    }
    production {
        dataSource {
            dbCreate = "update" // one of 'create', 'create-drop', 'update', 'validate', ''
            username = "unes"
            password = "Unes2015"
//            url = "jdbc:mysql://120.24.102.187:4407/linklife?useUnicode=true&amp;characterEncoding=utf8"
//            url = "jdbc:mysql://rds4544gvd3899g5ukdypublic.mysql.rds.aliyuncs.com:3306/linklife?useUnicode=true&amp;characterEncoding=utf8"
//            url = "jdbc:mysql://rdsh3zt3j690338a36lao.mysql.rds.aliyuncs.com:3306/linklife?useUnicode=true&amp;characterEncoding=utf8"
            url = "jdbc:mysql://rdsh3zt3j690338a36la.mysql.rds.aliyuncs.com:3306/linklife?useUnicode=true&amp;characterEncoding=utf8"
            properties {
                // See http://grails.org/doc/latest/guide/conf.html#dataSource for documentation
                jmxEnabled = true
                initialSize = 5
                maxActive = 50
                minIdle = 5
                maxIdle = 25
                maxWait = 10000
                maxAge = 10 * 60000
                timeBetweenEvictionRunsMillis = 5000
                minEvictableIdleTimeMillis = 60000
                validationQuery = "SELECT 1"
                validationQueryTimeout = 3
                validationInterval = 15000
                testOnBorrow = false
                testWhileIdle = true
                testOnReturn = false
                jdbcInterceptors = "ConnectionState"
                defaultTransactionIsolation = java.sql.Connection.TRANSACTION_READ_COMMITTED
            }
        }
    }
}
