package welink.common

import grails.transaction.Transactional
import org.joda.time.DateTime
import welink.estate.Community
import welink.estate.CommunityData
import welink.estate.CompanyData

import java.text.SimpleDateFormat


class DataCalcuService {

    static lazyInit = false

    def dataSource

    def scheduleCalc() {
        communityDataCalcu()
        companyDataCalcu()
    }

    @Transactional
    def communityDataCalcu() {

        def db = new groovy.sql.Sql(dataSource)

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

        DateTime date = new DateTime().withTimeAtStartOfDay()

        Date start = date.minusDays(1).toDate()

        String startTime = sdf.format(start);

        Date end = date.toDate()

        String endTime = sdf.format(end);

        def communityList = Community.findAllByStatus(1 as byte)

        communityList.each {
            Community community ->
                CommunityData communityData = new CommunityData()

                communityData.calcuDate = start

                communityData.communityId = community.id

                String userTotalSql = "select count(*) as userTotal from profile p where p.id in (select buyer_id from trade where community_id=${community.id} and date_created<'${endTime}')"

                db.eachRow(userTotalSql) {
                    String userTotal = it.userTotal
                    communityData.userTotal = Long.parseLong(userTotal)
                }

                String oldUsersSql = "select count(*) as oldUsers from profile p where p.id in (select buyer_id from trade where community_id=${community.id} and date_created <'${startTime}')"

                db.eachRow(oldUsersSql) {
                    String oldUsers = it.oldUsers
                    communityData.newUsers = communityData.userTotal - Long.parseLong(oldUsers)
                }

                String tradeNumsSql = "select count(*) as tradeNums from trade where community_id=${community.id} and date_created >'${startTime}' and date_created<'${endTime}' and status in (4,6,5,7)"

                db.eachRow(tradeNumsSql) {
                    String tradeNums = it.tradeNums
                    communityData.tradeNums = Long.parseLong(tradeNums)
                }

                communityData.ConversionRate = (Long) ((1f * communityData.tradeNums / communityData.userTotal) * 10000)

                String tradeTotalSql = "select IFNULL(sum(total_fee),0) as tradeTotal from trade where community_id=${community.id} and date_created >'${startTime}' and date_created<'${endTime}'"

                db.eachRow(tradeTotalSql) {
                    String tradeTotal = it.tradeTotal
                    communityData.tradeTotal = Long.parseLong(tradeTotal)
                }

                String actualPaymentSql = "select IFNULL(sum(total_fee),0) as actualPayment from trade where community_id=${community.id} and status in (4,6,5,7) and date_created >'${startTime}' and date_created<'${endTime}'"

                db.eachRow(actualPaymentSql) {
                    String actualPayment = it.actualPayment
                    communityData.actualPayment = Long.parseLong(actualPayment)
                }

                communityData.guestUnitPrice = (Long) ((1f * communityData.actualPayment / (communityData.tradeNums ?: 1)))

                String shipmentsSql = "select count(*) as shipments from trade where community_id=${community.id} and status in (5,7) and date_created >'${startTime}' and date_created<'${endTime}'"

                db.eachRow(shipmentsSql) {
                    String shipments = it.shipments
                    communityData.shipments = Long.parseLong(shipments)
                }

                String receivingNumsSql = "select count(*) as receivingNums from trade where community_id=${community.id} and status = 7 and date_created >'${startTime}' and date_created<'${endTime}'"

                db.eachRow(receivingNumsSql) {
                    String receivingNums = it.receivingNums
                    communityData.receivingNums = Long.parseLong(receivingNums)
                }

                communityData.save(failOnError: true, flush: true)
        }


        db.close()
    }

    @Transactional
    def companyDataCalcu() {

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

        DateTime date = new DateTime().withTimeAtStartOfDay()

        Date start = date.minusDays(1).toDate()

        String startTime = sdf.format(start);

        Date end = date.toDate()

        String endTime = sdf.format(end);

        def db = new groovy.sql.Sql(dataSource)

        CompanyData companyData = new CompanyData()

        companyData.calcuDate = start

        String userTotalSql = "select count(*) as userTotal from profile where date_created<'${endTime}'"

        db.eachRow(userTotalSql) {
            String userTotal = it.userTotal
            companyData.userTotal = Long.parseLong(userTotal)
        }

        String newUsersSql = "select count(*) as newUsers from profile p where p.date_created >'${startTime}' and p.date_created<'${endTime}'"

        db.eachRow(newUsersSql) {
            String newUsers = it.newUsers
            companyData.newUsers = Long.parseLong(newUsers)
        }

        String tradeNumsSql = "select count(*) as tradeNums from trade where date_created >'${startTime}' and date_created<'${endTime}' and status in (4,5,6,7)"

        db.eachRow(tradeNumsSql) {
            String tradeNums = it.tradeNums
            companyData.tradeNums = Long.parseLong(tradeNums)
        }

        companyData.ConversionRate = (Long) ((1f * companyData.tradeNums / companyData.userTotal) * 10000)

        String tradeTotalSql = "select IFNULL(sum(total_fee),0) as tradeTotal from trade where date_created >'${startTime}' and date_created<'${endTime}'"

        db.eachRow(tradeTotalSql) {
            String tradeTotal = it.tradeTotal
            companyData.tradeTotal = Long.parseLong(tradeTotal)
        }

        String actualPaymentSql = "select IFNULL(sum(total_fee),0) as actualPayment from trade where status in (4,6,5,7) and date_created >'${startTime}' and date_created<'${endTime}'"

        db.eachRow(actualPaymentSql) {
            String actualPayment = it.actualPayment
            companyData.actualPayment = Long.parseLong(actualPayment)
        }

        companyData.guestUnitPrice = (Long) ((1f * companyData.actualPayment / (companyData.tradeNums ?: 1)))


        String shipmentsSql = "select count(*) as shipments from trade where status in (5,7) and date_created >'${startTime}' and date_created<'${endTime}'"

        db.eachRow(shipmentsSql) {
            String shipments = it.shipments
            companyData.shipments = Long.parseLong(shipments)
        }

        String receivingNumsSql = "select count(*) as receivingNums from trade where status = 7 and date_created >'${startTime}' and date_created<'${endTime}'"

        db.eachRow(receivingNumsSql) {
            String receivingNums = it.receivingNums
            companyData.receivingNums = Long.parseLong(receivingNums)
        }

        companyData.save(failOnError: true, flush: true)

        db.close()

    }

    def calcuold() {

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

        DateTime date = new DateTime().withTimeAtStartOfDay()

        def db = new groovy.sql.Sql(dataSource)

        for (int i = 1; i < 13; i++) {

            Date start = date.minusDays(i + 1).toDate()

            String startTime = sdf.format(start);

            Date end = date.minusDays(i).toDate()

            String endTime = sdf.format(end);

            def communityList = Community.findAllByStatus(1 as byte)

            communityList.each {
                Community community ->
                    CommunityData communityData = new CommunityData()

                    communityData.calcuDate = start

                    communityData.communityId = community.id

                    String userTotalSql = "select count(*) as userTotal from profile p where p.id in (select buyer_id from trade where community_id=${community.id} and date_created<'${endTime}')"

                    db.eachRow(userTotalSql) {
                        String userTotal = it.userTotal
                        communityData.userTotal = Long.parseLong(userTotal)
                    }

                    String oldUsersSql = "select count(*) as oldUsers from profile p where p.id in (select buyer_id from trade where community_id=${community.id} and date_created <'${startTime}')"

                    db.eachRow(oldUsersSql) {
                        String oldUsers = it.oldUsers
                        communityData.newUsers = communityData.userTotal - Long.parseLong(oldUsers)
                    }

                    String tradeNumsSql = "select count(*) as tradeNums from trade where community_id=${community.id} and date_created >'${startTime}' and date_created<'${endTime}'"

                    db.eachRow(tradeNumsSql) {
                        String tradeNums = it.tradeNums
                        communityData.tradeNums = Long.parseLong(tradeNums)
                    }

                    communityData.ConversionRate = (Long) ((1f * communityData.tradeNums / communityData.userTotal) * 10000)

                    String tradeTotalSql = "select IFNULL(sum(total_fee),0) as tradeTotal from trade where community_id=${community.id} and date_created >'${startTime}' and date_created<'${endTime}'"

                    db.eachRow(tradeTotalSql) {
                        String tradeTotal = it.tradeTotal
                        communityData.tradeTotal = Long.parseLong(tradeTotal)
                    }

                    String actualPaymentSql = "select IFNULL(sum(total_fee),0) as actualPayment from trade where community_id=${community.id} and status in (4,5,7) and date_created >'${startTime}' and date_created<'${endTime}'"

                    db.eachRow(actualPaymentSql) {
                        String actualPayment = it.actualPayment
                        communityData.actualPayment = Long.parseLong(actualPayment)
                    }

                    communityData.guestUnitPrice = (Long) ((1f * communityData.tradeTotal / (communityData.tradeNums ?: 1)))

                    String shipmentsSql = "select count(*) as shipments from trade where community_id=${community.id} and status in (5,7) and date_created >'${startTime}' and date_created<'${endTime}'"

                    db.eachRow(shipmentsSql) {
                        String shipments = it.shipments
                        communityData.shipments = Long.parseLong(shipments)
                    }

                    String receivingNumsSql = "select count(*) as receivingNums from trade where community_id=${community.id} and status = 7 and date_created >'${startTime}' and date_created<'${endTime}'"

                    db.eachRow(receivingNumsSql) {
                        String receivingNums = it.receivingNums
                        communityData.receivingNums = Long.parseLong(receivingNums)
                    }

                    communityData.save(failOnError: true, flush: true)

            }


        }


        db.close()


    }

    def calCompanyOld() {

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

        DateTime date = new DateTime().withTimeAtStartOfDay()

        def db = new groovy.sql.Sql(dataSource)

        for (int i = 1; i < 13; i++) {
            Date start = date.minusDays(i + 1).toDate()

            String startTime = sdf.format(start);

            Date end = date.minusDays(i).toDate()

            String endTime = sdf.format(end);

            CompanyData companyData = new CompanyData()

            companyData.calcuDate = start

            String userTotalSql = "select count(*) as userTotal from profile where date_created<'${endTime}'"

            db.eachRow(userTotalSql) {
                String userTotal = it.userTotal
                companyData.userTotal = Long.parseLong(userTotal)
            }

            String newUsersSql = "select count(*) as newUsers from profile p where p.date_created >'${startTime}' and p.date_created<'${endTime}'"

            db.eachRow(newUsersSql) {
                String newUsers = it.newUsers
                companyData.newUsers = Long.parseLong(newUsers)
            }

            String tradeNumsSql = "select count(*) as tradeNums from trade where date_created >'${startTime}' and date_created<'${endTime}'"

            db.eachRow(tradeNumsSql) {
                String tradeNums = it.tradeNums
                companyData.tradeNums = Long.parseLong(tradeNums)
            }

            companyData.ConversionRate = (Long) ((1f * companyData.tradeNums / companyData.userTotal) * 10000)

            String tradeTotalSql = "select IFNULL(sum(total_fee),0) as tradeTotal from trade where date_created >'${startTime}' and date_created<'${endTime}'"

            db.eachRow(tradeTotalSql) {
                String tradeTotal = it.tradeTotal
                companyData.tradeTotal = Long.parseLong(tradeTotal)
            }

            String actualPaymentSql = "select IFNULL(sum(total_fee),0) as actualPayment from trade where status in (4,5,7) and date_created >'${startTime}' and date_created<'${endTime}'"

            db.eachRow(actualPaymentSql) {
                String actualPayment = it.actualPayment
                companyData.actualPayment = Long.parseLong(actualPayment)
            }

            companyData.guestUnitPrice = (Long) ((1f * companyData.tradeTotal / (companyData.tradeNums ?: 1)))


            String shipmentsSql = "select count(*) as shipments from trade where status in (5,7) and date_created >'${startTime}' and date_created<'${endTime}'"

            db.eachRow(shipmentsSql) {
                String shipments = it.shipments
                companyData.shipments = Long.parseLong(shipments)
            }

            String receivingNumsSql = "select count(*) as receivingNums from trade where status = 7 and date_created >'${startTime}' and date_created<'${endTime}'"

            db.eachRow(receivingNumsSql) {
                String receivingNums = it.receivingNums
                companyData.receivingNums = Long.parseLong(receivingNums)
            }

            companyData.save(failOnError: true, flush: true)

            db.close()
        }

        db.close()

    }

    def serviceMethod() {

    }
}
