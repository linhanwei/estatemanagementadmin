/*
SQLyog 企业版 - MySQL GUI v8.14 
MySQL - 5.6.29 : Database - miku_test
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`miku_test` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `miku_test`;

/*Table structure for table `active_item` */

DROP TABLE IF EXISTS `active_item`;

CREATE TABLE `active_item` (
  `id` bigint(11) unsigned NOT NULL AUTO_INCREMENT,
  `item_id` bigint(20) DEFAULT NULL,
  `active_id` bigint(11) DEFAULT NULL,
  `pic` varchar(256) DEFAULT NULL,
  `ref_price` bigint(20) DEFAULT NULL,
  `price` bigint(20) DEFAULT NULL,
  `sold_quantity` bigint(20) DEFAULT NULL,
  `num` bigint(20) DEFAULT NULL,
  `version` bigint(20) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Table structure for table `alipay_back` */

DROP TABLE IF EXISTS `alipay_back`;

CREATE TABLE `alipay_back` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `discount` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `payment_type` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `subject` varchar(512) COLLATE utf8_unicode_ci DEFAULT NULL,
  `trade_no` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `buyer_email` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `gmt_create` datetime DEFAULT NULL,
  `notify_type` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `quantity` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `out_trade_no` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `seller_id` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `notify_time` datetime DEFAULT NULL,
  `body` varchar(1024) COLLATE utf8_unicode_ci DEFAULT NULL,
  `trade_status` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `is_total_fee_adjust` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `total_fee` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `seller_email` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `price` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `buyer_id` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `notify_id` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `use_coupon` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `sign_type` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `sign` varchar(2048) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `gmt_payment` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idex_tradeId` (`out_trade_no`)
) ENGINE=InnoDB AUTO_INCREMENT=2321 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `alipay_back_spare` */

DROP TABLE IF EXISTS `alipay_back_spare`;

CREATE TABLE `alipay_back_spare` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `discount` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `payment_type` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `subject` varchar(512) COLLATE utf8_unicode_ci DEFAULT NULL,
  `trade_no` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `buyer_email` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `gmt_create` datetime DEFAULT NULL,
  `notify_type` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `quantity` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `out_trade_no` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `seller_id` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `notify_time` datetime DEFAULT NULL,
  `body` varchar(1024) COLLATE utf8_unicode_ci DEFAULT NULL,
  `trade_status` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `is_total_fee_adjust` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `total_fee` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `seller_email` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `price` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `buyer_id` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `notify_id` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `use_coupon` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `sign_type` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `sign` varchar(2048) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date_create` datetime DEFAULT NULL,
  `gmt_payment` datetime DEFAULT NULL,
  `version` bigint(20) DEFAULT '0',
  `status` tinyint(4) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_tstats_status` (`status`,`trade_status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `annouce` */

DROP TABLE IF EXISTS `annouce`;

CREATE TABLE `annouce` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) NOT NULL DEFAULT '0',
  `announce_pic` varchar(255) DEFAULT NULL,
  `community_id` bigint(20) NOT NULL,
  `content` varchar(2500) NOT NULL,
  `date_created` datetime NOT NULL,
  `publisher` varchar(255) NOT NULL,
  `status` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `content_txt` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `around_number` */

DROP TABLE IF EXISTS `around_number`;

CREATE TABLE `around_number` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `community_id` bigint(20) DEFAULT NULL,
  `type` tinyint(4) DEFAULT NULL,
  `type_name` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `lat` double DEFAULT NULL,
  `lng` double DEFAULT NULL,
  `address` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `tel` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `count` bigint(20) DEFAULT NULL,
  `distance` bigint(20) DEFAULT NULL,
  `tags` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `name` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `price` bigint(20) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `avos_nexus` */

DROP TABLE IF EXISTS `avos_nexus`;

CREATE TABLE `avos_nexus` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `profile_id` bigint(20) NOT NULL,
  `installation` varchar(255) NOT NULL,
  `device_token` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `date_created` datetime NOT NULL,
  `last_updated` datetime NOT NULL,
  `channels` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `os` varchar(64) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `banner` */

DROP TABLE IF EXISTS `banner`;

CREATE TABLE `banner` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) NOT NULL,
  `date_created` datetime NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `last_updated` datetime NOT NULL,
  `online_end_time` datetime DEFAULT NULL,
  `online_start_time` datetime DEFAULT NULL,
  `pic_url` varchar(255) DEFAULT NULL,
  `redirect_type` int(11) DEFAULT NULL,
  `show_status` tinyint(4) DEFAULT NULL,
  `status` tinyint(4) DEFAULT NULL,
  `target` varchar(255) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `type` int(11) DEFAULT NULL,
  `weight` int(11) DEFAULT NULL,
  `community_id` bigint(20) DEFAULT NULL,
  `show_text` tinyint(4) DEFAULT NULL,
  `category_id` bigint(20) DEFAULT NULL,
  `module_type` int(11) DEFAULT NULL,
  `topic_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_status` (`status`)
) ENGINE=InnoDB AUTO_INCREMENT=654 DEFAULT CHARSET=utf8mb4;

/*Table structure for table `basic_setting` */

DROP TABLE IF EXISTS `basic_setting`;

CREATE TABLE `basic_setting` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) NOT NULL,
  `community_id` bigint(20) DEFAULT NULL,
  `last_community_pmf_date` datetime DEFAULT NULL,
  `communityu` datetime DEFAULT NULL,
  `community_unit_price` datetime DEFAULT NULL,
  `c` datetime DEFAULT NULL,
  `energy_fee` bigint(20) DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `last_updated` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `batch_job_execution` */

DROP TABLE IF EXISTS `batch_job_execution`;

CREATE TABLE `batch_job_execution` (
  `JOB_EXECUTION_ID` bigint(20) NOT NULL,
  `VERSION` bigint(20) DEFAULT NULL,
  `JOB_INSTANCE_ID` bigint(20) NOT NULL,
  `CREATE_TIME` datetime NOT NULL,
  `START_TIME` datetime DEFAULT NULL,
  `END_TIME` datetime DEFAULT NULL,
  `STATUS` varchar(10) DEFAULT NULL,
  `EXIT_CODE` varchar(2500) DEFAULT NULL,
  `EXIT_MESSAGE` varchar(2500) DEFAULT NULL,
  `LAST_UPDATED` datetime DEFAULT NULL,
  `JOB_CONFIGURATION_LOCATION` varchar(2500) DEFAULT NULL,
  PRIMARY KEY (`JOB_EXECUTION_ID`),
  KEY `JOB_INST_EXEC_FK` (`JOB_INSTANCE_ID`),
  CONSTRAINT `JOB_INST_EXEC_FK` FOREIGN KEY (`JOB_INSTANCE_ID`) REFERENCES `batch_job_instance` (`JOB_INSTANCE_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `batch_job_execution_context` */

DROP TABLE IF EXISTS `batch_job_execution_context`;

CREATE TABLE `batch_job_execution_context` (
  `JOB_EXECUTION_ID` bigint(20) NOT NULL,
  `SHORT_CONTEXT` varchar(2500) NOT NULL,
  `SERIALIZED_CONTEXT` text,
  PRIMARY KEY (`JOB_EXECUTION_ID`),
  CONSTRAINT `JOB_EXEC_CTX_FK` FOREIGN KEY (`JOB_EXECUTION_ID`) REFERENCES `batch_job_execution` (`JOB_EXECUTION_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `batch_job_execution_params` */

DROP TABLE IF EXISTS `batch_job_execution_params`;

CREATE TABLE `batch_job_execution_params` (
  `JOB_EXECUTION_ID` bigint(20) NOT NULL,
  `TYPE_CD` varchar(6) NOT NULL,
  `KEY_NAME` varchar(100) NOT NULL,
  `STRING_VAL` varchar(250) DEFAULT NULL,
  `DATE_VAL` datetime DEFAULT NULL,
  `LONG_VAL` bigint(20) DEFAULT NULL,
  `DOUBLE_VAL` double DEFAULT NULL,
  `IDENTIFYING` char(1) NOT NULL,
  KEY `JOB_EXEC_PARAMS_FK` (`JOB_EXECUTION_ID`),
  CONSTRAINT `JOB_EXEC_PARAMS_FK` FOREIGN KEY (`JOB_EXECUTION_ID`) REFERENCES `batch_job_execution` (`JOB_EXECUTION_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `batch_job_execution_seq` */

DROP TABLE IF EXISTS `batch_job_execution_seq`;

CREATE TABLE `batch_job_execution_seq` (
  `ID` bigint(20) NOT NULL,
  `UNIQUE_KEY` char(1) NOT NULL,
  UNIQUE KEY `UNIQUE_KEY_UN` (`UNIQUE_KEY`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `batch_job_instance` */

DROP TABLE IF EXISTS `batch_job_instance`;

CREATE TABLE `batch_job_instance` (
  `JOB_INSTANCE_ID` bigint(20) NOT NULL,
  `VERSION` bigint(20) DEFAULT NULL,
  `JOB_NAME` varchar(100) NOT NULL,
  `JOB_KEY` varchar(32) NOT NULL,
  PRIMARY KEY (`JOB_INSTANCE_ID`),
  UNIQUE KEY `JOB_INST_UN` (`JOB_NAME`,`JOB_KEY`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `batch_job_seq` */

DROP TABLE IF EXISTS `batch_job_seq`;

CREATE TABLE `batch_job_seq` (
  `ID` bigint(20) NOT NULL,
  `UNIQUE_KEY` char(1) NOT NULL,
  UNIQUE KEY `UNIQUE_KEY_UN` (`UNIQUE_KEY`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `batch_step_execution` */

DROP TABLE IF EXISTS `batch_step_execution`;

CREATE TABLE `batch_step_execution` (
  `STEP_EXECUTION_ID` bigint(20) NOT NULL,
  `VERSION` bigint(20) NOT NULL,
  `STEP_NAME` varchar(100) NOT NULL,
  `JOB_EXECUTION_ID` bigint(20) NOT NULL,
  `START_TIME` datetime NOT NULL,
  `END_TIME` datetime DEFAULT NULL,
  `STATUS` varchar(10) DEFAULT NULL,
  `COMMIT_COUNT` bigint(20) DEFAULT NULL,
  `READ_COUNT` bigint(20) DEFAULT NULL,
  `FILTER_COUNT` bigint(20) DEFAULT NULL,
  `WRITE_COUNT` bigint(20) DEFAULT NULL,
  `READ_SKIP_COUNT` bigint(20) DEFAULT NULL,
  `WRITE_SKIP_COUNT` bigint(20) DEFAULT NULL,
  `PROCESS_SKIP_COUNT` bigint(20) DEFAULT NULL,
  `ROLLBACK_COUNT` bigint(20) DEFAULT NULL,
  `EXIT_CODE` varchar(2500) DEFAULT NULL,
  `EXIT_MESSAGE` varchar(2500) DEFAULT NULL,
  `LAST_UPDATED` datetime DEFAULT NULL,
  PRIMARY KEY (`STEP_EXECUTION_ID`),
  KEY `JOB_EXEC_STEP_FK` (`JOB_EXECUTION_ID`),
  CONSTRAINT `JOB_EXEC_STEP_FK` FOREIGN KEY (`JOB_EXECUTION_ID`) REFERENCES `batch_job_execution` (`JOB_EXECUTION_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `batch_step_execution_context` */

DROP TABLE IF EXISTS `batch_step_execution_context`;

CREATE TABLE `batch_step_execution_context` (
  `STEP_EXECUTION_ID` bigint(20) NOT NULL,
  `SHORT_CONTEXT` varchar(2500) NOT NULL,
  `SERIALIZED_CONTEXT` text,
  PRIMARY KEY (`STEP_EXECUTION_ID`),
  CONSTRAINT `STEP_EXEC_CTX_FK` FOREIGN KEY (`STEP_EXECUTION_ID`) REFERENCES `batch_step_execution` (`STEP_EXECUTION_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `batch_step_execution_seq` */

DROP TABLE IF EXISTS `batch_step_execution_seq`;

CREATE TABLE `batch_step_execution_seq` (
  `ID` bigint(20) NOT NULL,
  `UNIQUE_KEY` char(1) NOT NULL,
  UNIQUE KEY `UNIQUE_KEY_UN` (`UNIQUE_KEY`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `biz_message` */

DROP TABLE IF EXISTS `biz_message`;

CREATE TABLE `biz_message` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `profile_id` bigint(20) NOT NULL,
  `building_id` bigint(20) NOT NULL,
  `community_id` bigint(20) NOT NULL,
  `biz_type` bigint(20) NOT NULL,
  `content` varchar(512) COLLATE utf8_unicode_ci NOT NULL,
  `date_created` datetime DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  `biz_status` int(11) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `biz_name` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `title` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `trade_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `cart` */

DROP TABLE IF EXISTS `cart`;

CREATE TABLE `cart` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) DEFAULT NULL,
  `item_id` bigint(20) DEFAULT NULL,
  `item_count` bigint(20) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  `type` tinyint(4) DEFAULT '-1',
  PRIMARY KEY (`id`),
  KEY `idx_uid` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=144806 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `category` */

DROP TABLE IF EXISTS `category`;

CREATE TABLE `category` (
  `id` bigint(20) NOT NULL,
  `version` bigint(20) NOT NULL,
  `date_created` datetime NOT NULL,
  `features` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `is_parent` tinyint(4) DEFAULT NULL,
  `last_updated` datetime NOT NULL,
  `market` int(11) DEFAULT NULL,
  `memo` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `picture` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `status` tinyint(4) DEFAULT NULL,
  `weight` int(11) DEFAULT NULL,
  `creator_id` bigint(20) DEFAULT NULL,
  `last_operator_id` bigint(20) DEFAULT NULL,
  `parent_id` bigint(20) DEFAULT NULL,
  `level` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_parentId_status` (`parent_id`,`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `community` */

DROP TABLE IF EXISTS `community`;

CREATE TABLE `community` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) NOT NULL,
  `city` varchar(255) CHARACTER SET utf8mb4 DEFAULT NULL,
  `city_id` bigint(20) DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `delivery_area` varchar(3000) CHARACTER SET utf8mb4 DEFAULT NULL,
  `description` varchar(255) CHARACTER SET utf8mb4 DEFAULT NULL,
  `district` varchar(255) CHARACTER SET utf8mb4 DEFAULT NULL,
  `district_id` bigint(20) DEFAULT NULL,
  `last_updated` datetime NOT NULL,
  `lbs` varchar(255) CHARACTER SET utf8mb4 DEFAULT NULL,
  `location` varchar(255) CHARACTER SET utf8mb4 DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 DEFAULT NULL,
  `opening_hours` varchar(255) CHARACTER SET utf8mb4 DEFAULT NULL,
  `phone` varchar(255) CHARACTER SET utf8mb4 DEFAULT NULL,
  `pic_urls` varchar(255) CHARACTER SET utf8mb4 DEFAULT NULL,
  `province` varchar(255) CHARACTER SET utf8mb4 DEFAULT NULL,
  `province_id` bigint(20) DEFAULT NULL,
  `status` tinyint(4) DEFAULT NULL,
  `em_company_id` bigint(20) DEFAULT NULL,
  `level` int(11) DEFAULT NULL,
  `cloud_table` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_city_id` (`city_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2049 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `community_data` */

DROP TABLE IF EXISTS `community_data`;

CREATE TABLE `community_data` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) NOT NULL,
  `actual_payment` bigint(20) DEFAULT NULL,
  `average_time` bigint(20) DEFAULT NULL,
  `calcu_date` datetime DEFAULT NULL,
  `community_id` bigint(20) DEFAULT NULL,
  `conversion_rate` bigint(20) DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `guest_unit_price` bigint(20) DEFAULT NULL,
  `last_updated` datetime NOT NULL,
  `new_users` bigint(20) DEFAULT NULL,
  `receiving_nums` bigint(20) DEFAULT NULL,
  `shipments` bigint(20) DEFAULT NULL,
  `trade_nums` bigint(20) DEFAULT NULL,
  `trade_total` bigint(20) DEFAULT NULL,
  `user_total` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2239 DEFAULT CHARSET=utf8mb4;

/*Table structure for table `company` */

DROP TABLE IF EXISTS `company`;

CREATE TABLE `company` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) NOT NULL,
  `date_created` datetime NOT NULL,
  `description` varchar(500) COLLATE utf8_unicode_ci DEFAULT NULL,
  `last_updated` datetime NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `company_data` */

DROP TABLE IF EXISTS `company_data`;

CREATE TABLE `company_data` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) NOT NULL,
  `actual_payment` bigint(20) DEFAULT NULL,
  `average_time` bigint(20) DEFAULT NULL,
  `calcu_date` datetime DEFAULT NULL,
  `conversion_rate` bigint(20) DEFAULT NULL,
  `daily_pv` bigint(20) DEFAULT NULL,
  `daily_uv` bigint(20) DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `guest_unit_price` bigint(20) DEFAULT NULL,
  `last_updated` datetime NOT NULL,
  `new_users` bigint(20) DEFAULT NULL,
  `receiving_nums` bigint(20) DEFAULT NULL,
  `shipments` bigint(20) DEFAULT NULL,
  `trade_nums` bigint(20) DEFAULT NULL,
  `trade_total` bigint(20) DEFAULT NULL,
  `user_total` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=502 DEFAULT CHARSET=utf8mb4;

/*Table structure for table `complain` */

DROP TABLE IF EXISTS `complain`;

CREATE TABLE `complain` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) NOT NULL,
  `building_id` bigint(20) DEFAULT NULL,
  `community_id` bigint(20) DEFAULT NULL,
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `date_created` datetime DEFAULT NULL,
  `last_updated` datetime NOT NULL,
  `pic_urls` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `profile_id` bigint(20) NOT NULL,
  `status` tinyint(4) NOT NULL,
  `title` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `complain_deal_notes` */

DROP TABLE IF EXISTS `complain_deal_notes`;

CREATE TABLE `complain_deal_notes` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) NOT NULL,
  `complain_id` bigint(20) NOT NULL,
  `date_create` datetime NOT NULL,
  `deal_content` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `pic_urls` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `replyer_id` bigint(20) DEFAULT NULL,
  `replyer_type` tinyint(4) NOT NULL,
  `status` tinyint(4) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `consignee_addr` */

DROP TABLE IF EXISTS `consignee_addr`;

CREATE TABLE `consignee_addr` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) DEFAULT NULL,
  `receiver_name` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `receiver_phone` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `receiver_mobile` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `receiver_state` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `receiver_city` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `receiver_district` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `receiver_address` varchar(512) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `receiver_zip` varchar(16) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  `version` bigint(20) NOT NULL,
  `community_id` bigint(20) DEFAULT NULL,
  `community` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `get_def` tinyint(4) DEFAULT NULL,
  `cancel_def` tinyint(4) DEFAULT NULL,
  `community_name` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `longitude` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `latitude` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `uid` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `province_code` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `city_code` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `add_code` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` tinyint(4) DEFAULT NULL,
  `modifi_addr` varchar(512) CHARACTER SET utf8mb4 DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `id_card` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=38412 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `controller_permission` */

DROP TABLE IF EXISTS `controller_permission`;

CREATE TABLE `controller_permission` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) NOT NULL,
  `controller_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `require_permission_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `show_status` tinyint(4) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=102 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `coop_profile` */

DROP TABLE IF EXISTS `coop_profile`;

CREATE TABLE `coop_profile` (
  `id` bigint(11) unsigned NOT NULL AUTO_INCREMENT,
  `profile_id` bigint(20) DEFAULT NULL,
  `coop_id` bigint(20) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  `status` tinyint(4) DEFAULT '1',
  `version` bigint(20) DEFAULT '1',
  `type` tinyint(4) DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7411 DEFAULT CHARSET=utf8mb4;

/*Table structure for table `coupon` */

DROP TABLE IF EXISTS `coupon`;

CREATE TABLE `coupon` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `shop_id` bigint(20) DEFAULT NULL,
  `start_time` datetime DEFAULT NULL COMMENT '开始时间',
  `end_time` datetime DEFAULT NULL COMMENT '结束时间',
  `name` varchar(32) DEFAULT NULL COMMENT '显示名字',
  `description` varchar(255) DEFAULT NULL COMMENT '使用规则描述',
  `value` int(11) DEFAULT NULL COMMENT '值',
  `pic_url` varchar(255) DEFAULT NULL COMMENT '优惠券图片',
  `type` int(11) DEFAULT NULL COMMENT '优惠券类型15抵用券，16满减券',
  `status` tinyint(4) DEFAULT NULL COMMENT '状态，1未领取，2已领取，0已关闭',
  `min_value` int(11) DEFAULT NULL COMMENT '最小金额',
  `probability` varchar(20) DEFAULT NULL COMMENT '概率',
  `limit_num` bigint(20) DEFAULT NULL,
  `attributes` varchar(255) DEFAULT NULL COMMENT '属性',
  `version` bigint(20) DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `expiration_pic_url` varchar(255) DEFAULT NULL,
  `validity` int(11) DEFAULT NULL,
  `give_num` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_type_status` (`type`,`status`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4;

/*Table structure for table `department` */

DROP TABLE IF EXISTS `department`;

CREATE TABLE `department` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) NOT NULL,
  `community_id` bigint(20) NOT NULL,
  `date_created` datetime NOT NULL,
  `last_updated` datetime NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `status` tinyint(4) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `ecs_activity_bonus_bingo` */

DROP TABLE IF EXISTS `ecs_activity_bonus_bingo`;

CREATE TABLE `ecs_activity_bonus_bingo` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` double DEFAULT NULL,
  `user_name` varchar(180) DEFAULT NULL,
  `number` char(16) DEFAULT NULL COMMENT '中奖码',
  `m_number` char(32) DEFAULT NULL,
  `money` decimal(10,2) DEFAULT NULL,
  `is_bingo` tinyint(1) DEFAULT '0' COMMENT '是否中奖:0:否,1是',
  `is_get` tinyint(1) DEFAULT '0' COMMENT '是否已对奖',
  `get_time` datetime DEFAULT '0000-00-00 00:00:00' COMMENT '对奖时间',
  `is_pay` tinyint(1) DEFAULT '0' COMMENT '是否支付: 0:未,1:已',
  `pay_time` datetime DEFAULT NULL COMMENT '支付时间',
  `add_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `number` (`number`),
  KEY `is_bingo` (`is_bingo`),
  KEY `is_get` (`is_get`),
  KEY `is_pay` (`is_pay`)
) ENGINE=InnoDB AUTO_INCREMENT=4062 DEFAULT CHARSET=utf8;

/*Table structure for table `employee` */

DROP TABLE IF EXISTS `employee`;

CREATE TABLE `employee` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) DEFAULT NULL,
  `community_id` bigint(20) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `department_id` bigint(20) DEFAULT NULL,
  `id_number` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  `mobile` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `password` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `status` tinyint(11) DEFAULT NULL,
  `user_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=218 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `employee_permissions` */

DROP TABLE IF EXISTS `employee_permissions`;

CREATE TABLE `employee_permissions` (
  `employee_id` bigint(20) DEFAULT NULL,
  `permissions_string` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  KEY `FK_3q6oleptsnisgqxshio2op8hs` (`employee_id`),
  CONSTRAINT `FK_3q6oleptsnisgqxshio2op8hs` FOREIGN KEY (`employee_id`) REFERENCES `employee` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `employee_role` */

DROP TABLE IF EXISTS `employee_role`;

CREATE TABLE `employee_role` (
  `employee_id` bigint(20) NOT NULL,
  `role_id` bigint(20) NOT NULL,
  PRIMARY KEY (`employee_id`,`role_id`),
  KEY `FK_3ene23nq9uvnj1cktmk8ydhah` (`role_id`),
  CONSTRAINT `FK_3ene23nq9uvnj1cktmk8ydhah` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_3f8wqxdumr93k2hevf7cuwqxg` FOREIGN KEY (`employee_id`) REFERENCES `employee` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `eval_summary` */

DROP TABLE IF EXISTS `eval_summary`;

CREATE TABLE `eval_summary` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `item_id` bigint(20) DEFAULT NULL,
  `eval_code` tinyint(4) DEFAULT NULL,
  `code_count` bigint(20) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `groupon` */

DROP TABLE IF EXISTS `groupon`;

CREATE TABLE `groupon` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) NOT NULL,
  `item_id` bigint(20) DEFAULT NULL,
  `item_title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `purchasing_price` bigint(20) DEFAULT NULL,
  `reference_price` bigint(20) DEFAULT NULL,
  `online_end_time` bigint(20) DEFAULT NULL,
  `online_start_time` bigint(20) DEFAULT NULL,
  `quantity` bigint(20) DEFAULT NULL,
  `type` tinyint(4) DEFAULT NULL,
  `status` tinyint(4) DEFAULT NULL,
  `sold_quantity` bigint(20) DEFAULT NULL,
  `groupon_price` bigint(20) DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `last_updated` datetime NOT NULL,
  `shop_id` bigint(20) DEFAULT NULL,
  `price` bigint(20) DEFAULT NULL,
  `item_category_id` bigint(20) DEFAULT NULL,
  `banner_url` varchar(256) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_shopId_status_onlineStartTime` (`shop_id`,`status`,`online_start_time`),
  KEY `idx_id_gid` (`item_id`,`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `install_active` */

DROP TABLE IF EXISTS `install_active`;

CREATE TABLE `install_active` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `item_id` bigint(20) DEFAULT NULL,
  `category_id` bigint(20) DEFAULT NULL,
  `buyer_id` bigint(20) DEFAULT NULL,
  `mobile` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  `count` int(11) DEFAULT NULL,
  `base_item_id` bigint(20) DEFAULT NULL,
  `trade_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_buyer_item_date` (`buyer_id`,`item_id`,`date_created`),
  KEY `idx_buyer_item` (`buyer_id`,`item_id`),
  KEY `idx_buyer_bitem` (`buyer_id`,`base_item_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2562 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `item` */

DROP TABLE IF EXISTS `item`;

CREATE TABLE `item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) DEFAULT NULL,
  `address` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `allow_community_ids` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `approve_status` tinyint(4) DEFAULT NULL,
  `category1_id` bigint(20) DEFAULT NULL,
  `category2_id` bigint(20) DEFAULT NULL,
  `category_id` bigint(20) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `delivery_time` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `delivery_time_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` varchar(2500) COLLATE utf8_unicode_ci NOT NULL,
  `features` varchar(2500) COLLATE utf8_unicode_ci DEFAULT NULL,
  `food_security` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `forbidden_community_ids` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `freight_payer` tinyint(4) DEFAULT NULL,
  `has_discount` tinyint(4) DEFAULT NULL,
  `has_invoice` tinyint(4) DEFAULT NULL,
  `has_showcase` tinyint(4) DEFAULT NULL,
  `has_sku` tinyint(4) DEFAULT NULL,
  `has_warranty` tinyint(4) DEFAULT NULL,
  `increment` int(11) DEFAULT NULL,
  `input_pids` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `input_str` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `item_size` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `item_weight` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  `need_delivery_time` tinyint(4) DEFAULT NULL,
  `num` int(11) DEFAULT NULL,
  `online_end_time` bigint(20) DEFAULT NULL,
  `online_start_time` bigint(20) DEFAULT NULL,
  `pic_urls` varchar(2500) COLLATE utf8_unicode_ci DEFAULT NULL,
  `post_fee` bigint(20) DEFAULT NULL,
  `price` bigint(20) DEFAULT NULL,
  `prop_imgs` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `props` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `props_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `score` int(11) DEFAULT NULL,
  `second_kill` tinyint(4) DEFAULT NULL,
  `seller_id` bigint(20) DEFAULT NULL,
  `seller_type` tinyint(4) DEFAULT NULL,
  `shop_id` bigint(20) DEFAULT NULL,
  `skus` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `stuff_status` tinyint(4) DEFAULT NULL,
  `sub_stock` tinyint(4) DEFAULT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `type` tinyint(4) DEFAULT NULL,
  `video` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `virtual` tinyint(4) DEFAULT NULL,
  `with_hold_quantity` int(11) DEFAULT NULL,
  `status` tinyint(4) DEFAULT NULL,
  `sold_quantity` int(11) DEFAULT '0',
  `specification` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `detail` varchar(6000) COLLATE utf8_unicode_ci DEFAULT NULL,
  `base_item_id` bigint(64) DEFAULT NULL,
  `shop_type` tinyint(11) DEFAULT NULL,
  `brand_id` bigint(20) DEFAULT NULL,
  `code` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `weight` int(11) DEFAULT NULL,
  `base_sold_quantity` int(11) DEFAULT NULL,
  `is_import` tinyint(4) DEFAULT NULL COMMENT '是否进口(0=否；1=是)',
  `isrefund` tinyint(4) DEFAULT NULL,
  `key_word` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `uuid` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `is_tax_free` tinyint(4) DEFAULT NULL,
  `cgprice` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_cat_status_type` (`category_id`,`approve_status`,`type`),
  KEY `idx_approve_status` (`approve_status`),
  KEY `idx_iid_apstatus` (`id`,`approve_status`),
  KEY `idx_last_updated` (`last_updated`),
  KEY `idx_shop_id_base_item_id` (`shop_id`,`base_item_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13907 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `item_and_purchase` */

DROP TABLE IF EXISTS `item_and_purchase`;

CREATE TABLE `item_and_purchase` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) NOT NULL,
  `date_created` datetime NOT NULL,
  `item_id` bigint(20) DEFAULT NULL,
  `last_updated` datetime NOT NULL,
  `purchase_id` bigint(20) DEFAULT NULL,
  `status` tinyint(4) NOT NULL,
  `approve_status` tinyint(4) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `item_association` */

DROP TABLE IF EXISTS `item_association`;

CREATE TABLE `item_association` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) NOT NULL,
  `date_created` datetime NOT NULL,
  `item_id` bigint(20) DEFAULT NULL,
  `last_updated` datetime NOT NULL,
  `status` tinyint(4) DEFAULT NULL,
  `target_id` bigint(20) DEFAULT NULL,
  `weight` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Table structure for table `item_at_half` */

DROP TABLE IF EXISTS `item_at_half`;

CREATE TABLE `item_at_half` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) NOT NULL,
  `active_status` int(11) DEFAULT NULL,
  `announce_time` datetime DEFAULT NULL,
  `banner_id` bigint(20) DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `end_time` datetime DEFAULT NULL,
  `inventory` bigint(20) DEFAULT NULL,
  `item_id` bigint(20) DEFAULT NULL,
  `last_updated` datetime NOT NULL,
  `limit_num` int(11) DEFAULT NULL,
  `activity_price` bigint(11) DEFAULT NULL,
  `start_time` datetime DEFAULT NULL,
  `status` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_item_id` (`item_id`),
  KEY `idx_banner_id` (`banner_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;

/*Table structure for table `link_category` */

DROP TABLE IF EXISTS `link_category`;

CREATE TABLE `link_category` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `con_type` tinyint(4) DEFAULT NULL,
  `con_name` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `last_update` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `link_conversation` */

DROP TABLE IF EXISTS `link_conversation`;

CREATE TABLE `link_conversation` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `profile_id` bigint(20) DEFAULT NULL,
  `con_type` bigint(20) DEFAULT NULL,
  `favour_count` bigint(20) DEFAULT '0',
  `content` varchar(1024) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pics` varchar(2048) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `last_update` datetime DEFAULT NULL,
  `status` tinyint(4) DEFAULT '1',
  `reply_count` bigint(20) DEFAULT '0',
  `community_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `link_message` */

DROP TABLE IF EXISTS `link_message`;

CREATE TABLE `link_message` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `con_id` bigint(20) DEFAULT NULL,
  `msg_count` bigint(20) DEFAULT '0',
  `date_created` datetime DEFAULT NULL,
  `last_update` datetime DEFAULT NULL,
  `profile_id` bigint(20) DEFAULT NULL,
  `community_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `link_notify_msg` */

DROP TABLE IF EXISTS `link_notify_msg`;

CREATE TABLE `link_notify_msg` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `action_type` tinyint(4) DEFAULT NULL,
  `conv_id` bigint(20) DEFAULT NULL,
  `profile_id` bigint(20) DEFAULT NULL,
  `status` tinyint(4) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `last_update` datetime DEFAULT NULL,
  `operator_id` bigint(20) DEFAULT NULL,
  `reply_id` bigint(20) DEFAULT NULL,
  `community_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `link_reply` */

DROP TABLE IF EXISTS `link_reply`;

CREATE TABLE `link_reply` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `con_id` bigint(20) DEFAULT NULL,
  `profile_id` bigint(20) DEFAULT NULL,
  `pics` varchar(2048) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `content` varchar(2048) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `last_update` datetime DEFAULT NULL,
  `status` tinyint(4) DEFAULT NULL,
  `action_type` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `logistics` */

DROP TABLE IF EXISTS `logistics`;

CREATE TABLE `logistics` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `contact_name` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `province` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `city` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `addr` varchar(512) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `zip_code` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mobile` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `seller_company` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `memo` text COLLATE utf8mb4_unicode_ci,
  `get_def` tinyint(4) DEFAULT NULL,
  `cancel_def` tinyint(4) DEFAULT NULL,
  `community_id` bigint(20) DEFAULT '-1',
  `district_id` bigint(20) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  `user_id` bigint(20) DEFAULT '-1',
  `version` bigint(20) NOT NULL DEFAULT '0',
  `consignee_id` bigint(20) DEFAULT NULL,
  `latitude` text COLLATE utf8mb4_unicode_ci,
  `longitude` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` tinyint(4) DEFAULT NULL COMMENT '类型(0=购买物流;1=退货物流)',
  `express_company` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '快递公司',
  `express_no` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '快递号',
  `id_card` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `logicSpecificAddr` text COLLATE utf8mb4_unicode_ci,
  `logic_specific_addr` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_mobile` (`mobile`)
) ENGINE=InnoDB AUTO_INCREMENT=8737 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `message` */

DROP TABLE IF EXISTS `message`;

CREATE TABLE `message` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) NOT NULL,
  `app_content` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `message_content` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `push_content` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `community_ids` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `employer_id` bigint(20) DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `last_updated` datetime NOT NULL,
  `status` tinyint(4) NOT NULL,
  `send_time` datetime DEFAULT NULL,
  `count` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `message_summary` */

DROP TABLE IF EXISTS `message_summary`;

CREATE TABLE `message_summary` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `profile_id` bigint(20) DEFAULT NULL,
  `building_id` bigint(20) DEFAULT NULL,
  `community_id` bigint(20) DEFAULT NULL,
  `last_message` varchar(2014) COLLATE utf8_unicode_ci DEFAULT NULL,
  `non_read_count` int(11) DEFAULT '0',
  `date_created` datetime DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  `biz_type` bigint(20) DEFAULT NULL,
  `biz_name` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `target` bigint(20) DEFAULT NULL,
  `status` tinyint(4) DEFAULT NULL,
  `messageType` tinyint(4) DEFAULT NULL,
  `msg_type_name` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  `content` varchar(1024) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `miku_active_topic` */

DROP TABLE IF EXISTS `miku_active_topic`;

CREATE TABLE `miku_active_topic` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) NOT NULL,
  `banner_id` bigint(20) DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `end_time` datetime DEFAULT NULL,
  `last_updated` datetime NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `parameter` varchar(255) DEFAULT NULL,
  `pic_urls` varchar(255) DEFAULT NULL,
  `start_time` datetime DEFAULT NULL,
  `status` tinyint(4) DEFAULT NULL,
  `active_type` bigint(20) DEFAULT NULL,
  `type` tinyint(4) DEFAULT NULL,
  `content` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8;

/*Table structure for table `miku_activity_bonus` */

DROP TABLE IF EXISTS `miku_activity_bonus`;

CREATE TABLE `miku_activity_bonus` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `number` char(16) NOT NULL DEFAULT '0' COMMENT '兑换码',
  `m_number` char(32) NOT NULL COMMENT '加密号码',
  `bonus` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '红包金额',
  `is_win` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否已对奖: 0:未,1:已',
  `edit_time` datetime NOT NULL COMMENT '更改时间',
  `win_time` datetime NOT NULL COMMENT '对奖时间',
  `add_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '生成时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `number` (`number`),
  KEY `is_win` (`is_win`),
  KEY `m_number` (`m_number`)
) ENGINE=InnoDB AUTO_INCREMENT=95001 DEFAULT CHARSET=utf8 COMMENT='活动红包';

/*Table structure for table `miku_advertorial` */

DROP TABLE IF EXISTS `miku_advertorial`;

CREATE TABLE `miku_advertorial` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) NOT NULL,
  `advertorial_tile` varchar(255) DEFAULT NULL,
  `advertorial_type` tinyint(4) DEFAULT NULL,
  `article_content` varchar(255) DEFAULT NULL,
  `article_tile` varchar(255) DEFAULT NULL,
  `creater_id` bigint(20) DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `last_updated` datetime NOT NULL,
  `mall_resource_url` varchar(255) DEFAULT NULL,
  `pics` varchar(4000) DEFAULT NULL,
  `sales_reward` varchar(255) DEFAULT NULL,
  `is_delete` tinyint(4) DEFAULT NULL,
  `status` tinyint(4) DEFAULT NULL,
  `poster_pic_url` varchar(2000) DEFAULT NULL,
  `poster_product_pic_url` varchar(2000) DEFAULT NULL,
  `redirect_type` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

/*Table structure for table `miku_agency_level` */

DROP TABLE IF EXISTS `miku_agency_level`;

CREATE TABLE `miku_agency_level` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) DEFAULT NULL,
  `level_name` varchar(255) DEFAULT NULL,
  `memo` varchar(1000) DEFAULT NULL,
  `weight` int(11) DEFAULT NULL,
  `creator_id` bigint(20) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  `is_deleted` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

/*Table structure for table `miku_agency_share_account` */

DROP TABLE IF EXISTS `miku_agency_share_account`;

CREATE TABLE `miku_agency_share_account` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `agency_id` bigint(20) DEFAULT NULL,
  `total_share_fee` bigint(20) DEFAULT NULL,
  `total_introduce_fee` bigint(20) DEFAULT NULL,
  `total_gotpay_fee` bigint(20) DEFAULT NULL,
  `no_getpay_fee` bigint(20) DEFAULT NULL,
  `getpaying_fee` bigint(20) DEFAULT NULL,
  `direct_sales_fee` bigint(20) DEFAULT NULL,
  `direct_share_fee` bigint(20) DEFAULT NULL,
  `indirect_sales_fee` bigint(20) DEFAULT NULL,
  `indirect_share_fee` bigint(20) DEFAULT NULL,
  `p_trades_count` bigint(20) DEFAULT NULL,
  `p2_trades_count` bigint(20) DEFAULT NULL,
  `p3_trades_count` bigint(20) DEFAULT NULL,
  `p4_trades_count` bigint(20) DEFAULT NULL,
  `p5_trades_count` bigint(20) DEFAULT NULL,
  `p_sales_fee` bigint(20) DEFAULT NULL,
  `p2_sales_fee` bigint(20) DEFAULT NULL,
  `p3_sales_fee` bigint(20) DEFAULT NULL,
  `p4_sales_fee` bigint(20) DEFAULT NULL,
  `p5_sales_fee` bigint(20) DEFAULT NULL,
  `p_offer_fee` bigint(20) DEFAULT NULL,
  `p2_offer_fee` bigint(20) DEFAULT NULL,
  `p3_offer_fee` bigint(20) DEFAULT NULL,
  `p4_offer_fee` bigint(20) DEFAULT NULL,
  `p5_offer_fee` bigint(20) DEFAULT NULL,
  `share_stat` varchar(255) DEFAULT NULL,
  `version` bigint(20) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9700 DEFAULT CHARSET=utf8;

/*Table structure for table `miku_brand` */

DROP TABLE IF EXISTS `miku_brand`;

CREATE TABLE `miku_brand` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `full_name` varchar(255) DEFAULT NULL,
  `company` varchar(255) DEFAULT NULL,
  `picture` varchar(255) DEFAULT NULL,
  `memo` varchar(255) DEFAULT NULL,
  `market` int(11) DEFAULT NULL,
  `version` bigint(20) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  `is_deleted` tinyint(4) DEFAULT NULL,
  `weight` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=271 DEFAULT CHARSET=utf8;

/*Table structure for table `miku_cid_tmp` */

DROP TABLE IF EXISTS `miku_cid_tmp`;

CREATE TABLE `miku_cid_tmp` (
  `id` bigint(20) DEFAULT NULL,
  `depth` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `miku_city` */

DROP TABLE IF EXISTS `miku_city`;

CREATE TABLE `miku_city` (
  `id` bigint(20) NOT NULL,
  `province` varchar(30) DEFAULT NULL,
  `city` varchar(30) DEFAULT NULL,
  `area_code` varchar(30) DEFAULT NULL,
  `area` varchar(20) DEFAULT NULL,
  `version` bigint(20) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `miku_comments` */

DROP TABLE IF EXISTS `miku_comments`;

CREATE TABLE `miku_comments` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) DEFAULT NULL,
  `building_id` bigint(20) DEFAULT NULL COMMENT '评论对象id(如商品id,众筹id)',
  `building_type` tinyint(4) DEFAULT NULL COMMENT '评论类型(1=商品;2=众筹)',
  `trade_id` bigint(20) DEFAULT NULL COMMENT '交易id',
  `content` varchar(2500) DEFAULT NULL COMMENT '内容',
  `pic_urls` varchar(10000) DEFAULT NULL COMMENT '图片',
  `user_id` bigint(20) DEFAULT NULL COMMENT '用户id',
  `user_name` varchar(50) DEFAULT NULL COMMENT '用户名',
  `user_mobile` varchar(50) DEFAULT NULL,
  `reply_count` int(11) DEFAULT NULL COMMENT '已回复数',
  `status` tinyint(4) DEFAULT NULL COMMENT '状态(0=待审核;1=已审核)',
  `star` tinyint(11) DEFAULT NULL COMMENT '评论星级',
  `date_created` datetime DEFAULT NULL COMMENT '创建日期',
  `last_updated` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=372 DEFAULT CHARSET=utf8 COMMENT='V1_评论';

/*Table structure for table `miku_comments_count` */

DROP TABLE IF EXISTS `miku_comments_count`;

CREATE TABLE `miku_comments_count` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) DEFAULT NULL,
  `building_id` bigint(20) DEFAULT NULL COMMENT '评论对象id(如商品id,众筹id)',
  `building_type` tinyint(4) DEFAULT NULL COMMENT '评论类型(1=商品;2=众筹)',
  `mouth_count` int(11) DEFAULT NULL COMMENT '总口碑数',
  `count` int(11) DEFAULT NULL COMMENT '总评论数',
  `star_count` int(11) DEFAULT NULL COMMENT '一星评论总数',
  `star2_count` int(11) DEFAULT NULL COMMENT '二星评论总数',
  `star3_count` int(11) DEFAULT NULL COMMENT '三星评论总数',
  `star4_count` int(11) DEFAULT NULL COMMENT '四星评论总数',
  `star5_count` int(11) DEFAULT NULL COMMENT '五星评论总数',
  `high_opinion` int(11) DEFAULT NULL COMMENT '好评率',
  `date_created` datetime DEFAULT NULL COMMENT '创建日期',
  `last_updated` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=142 DEFAULT CHARSET=utf8 COMMENT='评论统计';

/*Table structure for table `miku_comments_reply` */

DROP TABLE IF EXISTS `miku_comments_reply`;

CREATE TABLE `miku_comments_reply` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) DEFAULT NULL,
  `comments_id` bigint(20) DEFAULT NULL COMMENT '评论id',
  `content` varchar(2500) DEFAULT NULL,
  `pic_urls` varchar(10000) DEFAULT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `user_name` varchar(50) DEFAULT NULL,
  `user_mobile` char(10) DEFAULT NULL,
  `status` tinyint(4) DEFAULT NULL,
  `reply_user_id` bigint(20) DEFAULT NULL,
  `reply_user_name` varchar(50) DEFAULT NULL,
  `reply_user_mobile` varchar(50) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='评论详情';

/*Table structure for table `miku_content` */

DROP TABLE IF EXISTS `miku_content`;

CREATE TABLE `miku_content` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL,
  `content_type` tinyint(4) DEFAULT NULL,
  `content_title` varchar(100) DEFAULT NULL,
  `content_short_title` varchar(100) DEFAULT NULL,
  `content_surface_pic_url` varchar(1000) DEFAULT NULL,
  `content` varchar(1500) DEFAULT NULL,
  `pic_urls` varchar(3500) DEFAULT NULL,
  `times_of_browsed` int(8) DEFAULT NULL,
  `times_of_praised` int(8) DEFAULT NULL,
  `times_of_referenced` int(8) DEFAULT NULL,
  `author_show_name` varchar(80) DEFAULT NULL,
  `special_flag` tinyint(4) DEFAULT NULL,
  `version` bigint(20) NOT NULL,
  `date_created` datetime NOT NULL,
  `last_updated` datetime NOT NULL,
  `content_create_type` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=94 DEFAULT CHARSET=utf8;

/*Table structure for table `miku_crowdfund` */

DROP TABLE IF EXISTS `miku_crowdfund`;

CREATE TABLE `miku_crowdfund` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL COMMENT '众筹名称',
  `pic_urls` varchar(2500) DEFAULT NULL,
  `detail` varchar(6000) DEFAULT NULL,
  `description` varchar(2500) DEFAULT NULL,
  `target_amount` bigint(20) DEFAULT NULL,
  `total_fee` bigint(20) DEFAULT NULL,
  `start_time` datetime NOT NULL,
  `end_time` datetime NOT NULL,
  `sold_num` int(11) DEFAULT NULL,
  `plus_day` int(11) NOT NULL,
  `status` tinyint(4) DEFAULT NULL COMMENT '状态(-1=无效;0=正常;1=众筹结束;2=成功;3=失败)',
  `approve_status` tinyint(4) DEFAULT NULL,
  `weight` tinyint(4) DEFAULT NULL,
  `period_num` int(11) DEFAULT NULL,
  `version` bigint(20) NOT NULL,
  `date_created` datetime NOT NULL,
  `last_updated` datetime NOT NULL,
  `video` varchar(255) DEFAULT NULL,
  `force_flag` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=131 DEFAULT CHARSET=utf8 COMMENT='众筹';

/*Table structure for table `miku_crowdfund_detail` */

DROP TABLE IF EXISTS `miku_crowdfund_detail`;

CREATE TABLE `miku_crowdfund_detail` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `approve_status` tinyint(4) DEFAULT NULL,
  `crowdfund_id` bigint(20) DEFAULT NULL,
  `item_id` bigint(20) DEFAULT NULL,
  `sold_num` int(11) DEFAULT NULL,
  `return_content` varchar(2500) DEFAULT NULL,
  `risk_tips` varchar(2500) DEFAULT NULL,
  `special_note` varchar(2500) DEFAULT NULL,
  `version` bigint(20) NOT NULL,
  `date_created` datetime NOT NULL,
  `last_updated` datetime NOT NULL,
  `force_num` int(11) DEFAULT NULL,
  `item_price` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=257 DEFAULT CHARSET=utf8 COMMENT='众筹明细';

/*Table structure for table `miku_crowdfund_detail_log` */

DROP TABLE IF EXISTS `miku_crowdfund_detail_log`;

CREATE TABLE `miku_crowdfund_detail_log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `period_num` int(11) DEFAULT NULL,
  `approve_status` tinyint(4) DEFAULT NULL,
  `crowdfund_id` bigint(20) DEFAULT NULL,
  `crowdfund_log_id` bigint(20) DEFAULT NULL,
  `crowdfund_dtl_id` bigint(20) DEFAULT NULL,
  `item_id` bigint(20) DEFAULT NULL,
  `sold_num` int(11) DEFAULT NULL,
  `return_content` varchar(2500) DEFAULT NULL,
  `risk_tips` varchar(2500) DEFAULT NULL,
  `special_note` varchar(2500) DEFAULT NULL,
  `version` bigint(20) NOT NULL,
  `date_created` datetime NOT NULL,
  `last_updated` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=833 DEFAULT CHARSET=utf8 COMMENT='众筹明细期数日志';

/*Table structure for table `miku_crowdfund_log` */

DROP TABLE IF EXISTS `miku_crowdfund_log`;

CREATE TABLE `miku_crowdfund_log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `crowdfund_id` bigint(20) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL COMMENT '众筹名称',
  `pic_urls` varchar(2500) DEFAULT NULL,
  `detail` varchar(6000) DEFAULT NULL,
  `description` varchar(2500) DEFAULT NULL,
  `target_amount` bigint(20) DEFAULT NULL,
  `total_fee` bigint(20) DEFAULT NULL,
  `start_time` datetime NOT NULL,
  `end_time` datetime NOT NULL,
  `sold_num` int(11) DEFAULT NULL,
  `plus_day` int(11) NOT NULL,
  `status` tinyint(4) DEFAULT NULL COMMENT '状态(-1=无效;0=正常;1=成功;2=失败)',
  `approve_status` tinyint(4) DEFAULT NULL COMMENT '审批状态(0=隐藏；1=显示)',
  `weight` tinyint(4) DEFAULT NULL,
  `period_num` int(11) DEFAULT NULL,
  `winner_id` bigint(20) DEFAULT NULL,
  `trade_id` bigint(20) DEFAULT NULL,
  `version` bigint(20) NOT NULL,
  `date_created` datetime NOT NULL,
  `last_updated` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2711 DEFAULT CHARSET=utf8 COMMENT='众筹';

/*Table structure for table `miku_csad` */

DROP TABLE IF EXISTS `miku_csad`;

CREATE TABLE `miku_csad` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) DEFAULT NULL,
  `csad_jobnumber` varchar(50) DEFAULT NULL,
  `csad_name` varchar(50) DEFAULT NULL,
  `csad_tel` varchar(50) DEFAULT NULL,
  `csad_pic_url` varchar(500) DEFAULT NULL,
  `csad_notice_board` varchar(100) DEFAULT NULL,
  `csad_introduce` varchar(1000) DEFAULT NULL,
  `csad_speciality` varchar(500) DEFAULT NULL,
  `csad_achievement` varchar(500) DEFAULT NULL,
  `csad_level` int(11) DEFAULT NULL,
  `csad_status` tinyint(4) DEFAULT NULL,
  `csad_available` tinyint(4) DEFAULT NULL,
  `comment_count` int(11) DEFAULT NULL,
  `advice_count` int(11) DEFAULT NULL,
  `csad_clients` int(11) DEFAULT NULL,
  `version` bigint(20) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;

/*Table structure for table `miku_csad_clients` */

DROP TABLE IF EXISTS `miku_csad_clients`;

CREATE TABLE `miku_csad_clients` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `csad_id` bigint(20) unsigned DEFAULT NULL COMMENT '专家ID',
  `csad_user_id` bigint(20) unsigned DEFAULT NULL COMMENT '专家对应用户表的id',
  `client_user_id` bigint(20) unsigned DEFAULT NULL COMMENT '客户对应用户表的id',
  `client_gain_time` datetime DEFAULT NULL COMMENT '获取该客户时间',
  `version` bigint(20) unsigned DEFAULT NULL COMMENT '版本号',
  `date_created` datetime DEFAULT NULL COMMENT '创建时间',
  `last_updated` datetime DEFAULT NULL COMMENT '更新时间',
  `tags_info` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=102 DEFAULT CHARSET=utf8;

/*Table structure for table `miku_csad_evaluate` */

DROP TABLE IF EXISTS `miku_csad_evaluate`;

CREATE TABLE `miku_csad_evaluate` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) DEFAULT NULL,
  `csad_id` bigint(20) DEFAULT NULL,
  `csad_user_id` bigint(20) DEFAULT NULL,
  `csad_name` varchar(50) DEFAULT NULL,
  `evaluate_note` varchar(500) DEFAULT NULL,
  `evaluate_level` int(11) DEFAULT NULL,
  `version` bigint(20) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=243 DEFAULT CHARSET=utf8;

/*Table structure for table `miku_csad_group` */

DROP TABLE IF EXISTS `miku_csad_group`;

CREATE TABLE `miku_csad_group` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `csad_group_name` varchar(50) DEFAULT NULL,
  `csad_group_desc` varchar(200) DEFAULT NULL,
  `version` bigint(20) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;

/*Table structure for table `miku_csad_group_map` */

DROP TABLE IF EXISTS `miku_csad_group_map`;

CREATE TABLE `miku_csad_group_map` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `csad_group_id` bigint(20) DEFAULT NULL,
  `csad_id` bigint(20) DEFAULT NULL,
  `version` bigint(20) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=129 DEFAULT CHARSET=utf8;

/*Table structure for table `miku_csad_service_log` */

DROP TABLE IF EXISTS `miku_csad_service_log`;

CREATE TABLE `miku_csad_service_log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) DEFAULT NULL,
  `csad_id` bigint(20) DEFAULT NULL,
  `csad_user_id` bigint(20) DEFAULT NULL,
  `service_stime` datetime DEFAULT NULL,
  `service_etime` datetime DEFAULT NULL,
  `service_etype` tinyint(4) DEFAULT NULL,
  `version` bigint(20) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

/*Table structure for table `miku_csad_user_record` */

DROP TABLE IF EXISTS `miku_csad_user_record`;

CREATE TABLE `miku_csad_user_record` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) DEFAULT NULL COMMENT '用户id',
  `box_id` bigint(20) DEFAULT NULL COMMENT '盒子id',
  `record` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '记录信息',
  `use_time` varchar(15) DEFAULT NULL COMMENT '用户使用产品时间,格式:yyyy年-xx月-dd日',
  `box_name` varchar(50) DEFAULT NULL COMMENT '盒子名称',
  `image_urls` varchar(800) DEFAULT NULL COMMENT '相片的url',
  `version` bigint(20) DEFAULT NULL COMMENT '版本',
  `date_created` datetime DEFAULT NULL COMMENT '记录时间(发布时间)',
  `last_updated` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=544 DEFAULT CHARSET=utf8;

/*Table structure for table `miku_face_score_exchange` */

DROP TABLE IF EXISTS `miku_face_score_exchange`;

CREATE TABLE `miku_face_score_exchange` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `pic_url` varchar(200) DEFAULT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `mobile` varchar(50) DEFAULT NULL,
  `user_name` varchar(100) DEFAULT NULL,
  `age` int(11) DEFAULT NULL,
  `sex` tinyint(4) DEFAULT NULL,
  `face_score` int(11) DEFAULT NULL,
  `piont` int(11) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='颜值兑换';

/*Table structure for table `miku_friends_group` */

DROP TABLE IF EXISTS `miku_friends_group`;

CREATE TABLE `miku_friends_group` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `type` tinyint(4) DEFAULT NULL COMMENT '类型(0=普通;1=默认好友)',
  `version` bigint(20) NOT NULL,
  `date_created` datetime NOT NULL,
  `last_updated` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8 COMMENT='V1_专家好友分组';

/*Table structure for table `miku_friends_group_map` */

DROP TABLE IF EXISTS `miku_friends_group_map`;

CREATE TABLE `miku_friends_group_map` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `group_id` bigint(20) DEFAULT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `f_user_id` bigint(20) DEFAULT NULL,
  `user_name` varchar(50) DEFAULT NULL,
  `version` bigint(20) NOT NULL,
  `date_created` datetime NOT NULL,
  `last_updated` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COMMENT='V1_专家好友分组Map';

/*Table structure for table `miku_getpay` */

DROP TABLE IF EXISTS `miku_getpay`;

CREATE TABLE `miku_getpay` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `agency_id` bigint(20) DEFAULT NULL,
  `agency_nickname` varchar(255) DEFAULT NULL,
  `agency_level_name` varchar(255) DEFAULT NULL,
  `apply_date` datetime DEFAULT NULL,
  `getpay_fee` bigint(20) DEFAULT NULL,
  `getpay_type` int(11) DEFAULT NULL,
  `getpay_account` varchar(255) DEFAULT NULL,
  `getpay_user_name` varchar(255) DEFAULT NULL,
  `status` tinyint(4) DEFAULT NULL,
  `error_memo` varchar(1000) DEFAULT NULL,
  `trans_date` datetime DEFAULT NULL,
  `clerker_id` bigint(20) DEFAULT NULL,
  `clerker_user_name` varchar(255) DEFAULT NULL,
  `clerker_name` varchar(255) DEFAULT NULL,
  `version` bigint(20) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  `agency_mobile` varchar(255) DEFAULT NULL,
  `last_upated` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1015 DEFAULT CHARSET=utf8;

/*Table structure for table `miku_getpay_temp` */

DROP TABLE IF EXISTS `miku_getpay_temp`;

CREATE TABLE `miku_getpay_temp` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `agency_id` bigint(20) DEFAULT NULL,
  `agency_nickname` varchar(255) DEFAULT NULL,
  `agency_level_name` varchar(255) DEFAULT NULL,
  `apply_date` datetime DEFAULT NULL,
  `getpay_fee` bigint(20) DEFAULT NULL,
  `getpay_type` int(11) DEFAULT NULL,
  `getpay_account` varchar(255) DEFAULT NULL,
  `getpay_user_name` varchar(255) DEFAULT NULL,
  `status` tinyint(4) DEFAULT NULL,
  `error_memo` varchar(1000) DEFAULT NULL,
  `trans_date` datetime DEFAULT NULL,
  `clerker_id` bigint(20) DEFAULT NULL,
  `clerker_user_name` varchar(255) DEFAULT NULL,
  `clerker_name` varchar(255) DEFAULT NULL,
  `version` bigint(20) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  `agency_mobile` varchar(255) DEFAULT NULL,
  `last_upated` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1339 DEFAULT CHARSET=utf8;

/*Table structure for table `miku_instrument_measure_log` */

DROP TABLE IF EXISTS `miku_instrument_measure_log`;

CREATE TABLE `miku_instrument_measure_log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) NOT NULL,
  `create_day` int(5) DEFAULT NULL,
  `create_month` int(5) DEFAULT NULL,
  `create_hour` int(5) DEFAULT NULL,
  `create_week` int(5) DEFAULT NULL,
  `create_year` int(5) DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `instrument_type` tinyint(4) DEFAULT NULL,
  `last_updated` datetime NOT NULL,
  `measure_type` tinyint(4) DEFAULT NULL,
  `measure_value` decimal(7,1) DEFAULT NULL,
  `moisture_value` decimal(7,1) DEFAULT NULL,
  `oil_value` decimal(7,1) DEFAULT NULL,
  `resilience_value` decimal(7,1) DEFAULT NULL,
  `senility_value` decimal(7,1) DEFAULT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `test_position` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=994 DEFAULT CHARSET=utf8;

/*Table structure for table `miku_item_and_pitems` */

DROP TABLE IF EXISTS `miku_item_and_pitems`;

CREATE TABLE `miku_item_and_pitems` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) NOT NULL,
  `date_created` datetime DEFAULT NULL,
  `flag` tinyint(4) NOT NULL,
  `item_id` bigint(20) DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  `pitem_id` bigint(20) DEFAULT NULL,
  `postfee` bigint(20) DEFAULT NULL,
  `price` bigint(20) DEFAULT NULL,
  `uuid` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2272 DEFAULT CHARSET=utf8;

/*Table structure for table `miku_item_share_para` */

DROP TABLE IF EXISTS `miku_item_share_para`;

CREATE TABLE `miku_item_share_para` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) DEFAULT NULL,
  `scheme_name` varchar(255) DEFAULT NULL,
  `memo` varchar(1000) DEFAULT NULL,
  `item_id` bigint(20) DEFAULT NULL,
  `item_cost_fee` bigint(20) DEFAULT NULL,
  `item_profit_fee` bigint(20) DEFAULT NULL,
  `item_share_fee` bigint(20) DEFAULT NULL,
  `parameter` varchar(2000) DEFAULT NULL,
  `creator_id` bigint(20) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  `is_disable` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1708 DEFAULT CHARSET=utf8;

/*Table structure for table `miku_logs` */

DROP TABLE IF EXISTS `miku_logs`;

CREATE TABLE `miku_logs` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `userid` bigint(20) NOT NULL,
  `price` bigint(20) NOT NULL,
  `temp` varchar(255) NOT NULL,
  `date_created` datetime DEFAULT NULL,
  `openid` varchar(255) NOT NULL,
  `unionid` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `miku_mine_box_product` */

DROP TABLE IF EXISTS `miku_mine_box_product`;

CREATE TABLE `miku_mine_box_product` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `box_id` bigint(20) DEFAULT NULL,
  `prod_id` bigint(20) DEFAULT NULL COMMENT '私人定制产品id',
  `num` int(11) DEFAULT NULL COMMENT '数量',
  `version` bigint(20) NOT NULL,
  `date_created` datetime NOT NULL COMMENT '创建日期',
  `last_updated` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=363 DEFAULT CHARSET=utf8 COMMENT='V1_盒子商品';

/*Table structure for table `miku_mine_comments` */

DROP TABLE IF EXISTS `miku_mine_comments`;

CREATE TABLE `miku_mine_comments` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) DEFAULT NULL COMMENT '评论用户的id',
  `goal_type` tinyint(4) DEFAULT NULL COMMENT '对象类型:1、客服/私人管家 2、文章  3、课程  4、私人定制线下店  5、…',
  `goal_id` bigint(20) DEFAULT NULL COMMENT '文章的id',
  `comment_type` tinyint(4) DEFAULT NULL COMMENT '1、评论（针对文章等其他资源的叫评论，是附图） 2、回复（针对评论的叫回复，纯文字，不能附图',
  `content` varchar(300) DEFAULT NULL COMMENT '具体内容',
  `pic_urls` varchar(2000) DEFAULT NULL COMMENT '保存文章后面的图片云片的url （类似微信朋友圈的展现形式）',
  `csad_user_id` bigint(20) DEFAULT NULL COMMENT '专家对应userid',
  `csad_name` varchar(100) DEFAULT NULL COMMENT '专家名字',
  `evaluate_note` varchar(200) DEFAULT NULL COMMENT '评论',
  `evaluate_level` tinyint(4) DEFAULT NULL COMMENT '星级评价（10分，对应5星，可以半星）',
  `version` bigint(20) DEFAULT NULL COMMENT '版本',
  `date_created` datetime DEFAULT NULL COMMENT '创建日期',
  `last_updated` datetime DEFAULT NULL COMMENT '更新时间',
  `target_comment_id` bigint(15) DEFAULT NULL COMMENT '回复对应的评论记录id，主要是为了查找对应的用户名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1299 DEFAULT CHARSET=utf8 COMMENT='系统点评表（每新增一条评论，需要更新客服表星级）';

/*Table structure for table `miku_mine_course` */

DROP TABLE IF EXISTS `miku_mine_course`;

CREATE TABLE `miku_mine_course` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `course_name` varchar(100) DEFAULT NULL,
  `course_short_name` varchar(100) DEFAULT NULL,
  `pic_urls` varchar(500) DEFAULT NULL,
  `course_type` tinyint(4) DEFAULT NULL,
  `course_belong_userid` bigint(20) DEFAULT NULL,
  `course_period` int(11) DEFAULT NULL,
  `course_time` int(11) DEFAULT NULL,
  `course_steps` int(11) DEFAULT NULL,
  `course_played_times` int(11) DEFAULT NULL,
  `creater_id` bigint(20) DEFAULT NULL,
  `version` bigint(20) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  `course_duration` int(11) DEFAULT NULL,
  `course_introduce` varchar(255) DEFAULT NULL,
  `course_note` varchar(255) DEFAULT NULL,
  `course_property` tinyint(4) DEFAULT NULL,
  `course_sections_num` int(11) DEFAULT NULL,
  `mine_type` tinyint(4) DEFAULT NULL,
  `box_id` bigint(20) DEFAULT NULL,
  `course_user_stime` int(11) DEFAULT NULL,
  `lesson_id` bigint(20) DEFAULT NULL,
  `top_flag` tinyint(4) DEFAULT NULL,
  `course_template` tinyint(4) DEFAULT NULL,
  `subscribe_times` int(11) DEFAULT NULL,
  `course_category` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=809 DEFAULT CHARSET=utf8;

/*Table structure for table `miku_mine_course_attend_log` */

DROP TABLE IF EXISTS `miku_mine_course_attend_log`;

CREATE TABLE `miku_mine_course_attend_log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `course_id` bigint(20) DEFAULT NULL,
  `section_lesson_id` bigint(20) DEFAULT NULL,
  `section_id` bigint(20) DEFAULT NULL,
  `section_day_order` int(11) DEFAULT NULL,
  `lesson_id` bigint(20) DEFAULT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `attend_type` tinyint(4) DEFAULT NULL,
  `attend_time` datetime DEFAULT NULL,
  `attend_time_year` int(11) DEFAULT NULL,
  `attend_time_month` int(11) DEFAULT NULL,
  `attend_time_day` int(11) DEFAULT NULL,
  `attend_time_hour` int(11) DEFAULT NULL,
  `is_delete` tinyint(4) DEFAULT '0' COMMENT '是否删除:0、否（未删除）；1、是（已删除）',
  `version` bigint(20) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=126 DEFAULT CHARSET=utf8;

/*Table structure for table `miku_mine_course_sb` */

DROP TABLE IF EXISTS `miku_mine_course_sb`;

CREATE TABLE `miku_mine_course_sb` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `course_id` bigint(20) DEFAULT NULL,
  `course_type` tinyint(4) DEFAULT NULL,
  `course_property` tinyint(4) DEFAULT NULL,
  `status` tinyint(4) DEFAULT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `sb_time` datetime DEFAULT NULL,
  `user_stime` datetime DEFAULT NULL,
  `user_stime_optime` datetime DEFAULT NULL,
  `user_need_remind` tinyint(4) DEFAULT NULL,
  `version` bigint(20) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4434 DEFAULT CHARSET=utf8;

/*Table structure for table `miku_mine_course_section` */

DROP TABLE IF EXISTS `miku_mine_course_section`;

CREATE TABLE `miku_mine_course_section` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `course_id` bigint(20) DEFAULT NULL COMMENT '所属课程id',
  `box_id` bigint(20) DEFAULT NULL,
  `section_name` varchar(100) DEFAULT NULL COMMENT '阶段名',
  `section_short_name` varchar(100) DEFAULT NULL COMMENT '阶段名缩写，用作提示',
  `section_duration` int(11) DEFAULT NULL COMMENT '阶段时长（天）',
  `section_introduce` varchar(500) DEFAULT NULL COMMENT '介绍',
  `section_note` varchar(300) DEFAULT NULL COMMENT '备注',
  `section_order` varchar(50) DEFAULT NULL COMMENT '阶段编号',
  `section_sd` int(11) DEFAULT NULL COMMENT '该阶段第几天开始',
  `section_ed` int(11) DEFAULT NULL COMMENT '该阶段第几天结束',
  `version` bigint(20) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL COMMENT '创建日期',
  `last_updated` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=958 DEFAULT CHARSET=utf8 COMMENT='V1_课程阶段表';

/*Table structure for table `miku_mine_course_step` */

DROP TABLE IF EXISTS `miku_mine_course_step`;

CREATE TABLE `miku_mine_course_step` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `course_id` bigint(20) DEFAULT NULL,
  `step_name` varchar(100) DEFAULT NULL,
  `step_short_name` varchar(50) DEFAULT NULL,
  `step_order` int(11) DEFAULT NULL,
  `step_type` tinyint(4) DEFAULT NULL,
  `step_interval` int(11) DEFAULT NULL,
  `step_use_standard_frequency` tinyint(4) DEFAULT NULL,
  `step_use_standard_period` tinyint(4) DEFAULT NULL,
  `step_use_standard_condition` tinyint(4) DEFAULT NULL,
  `use_time` tinyint(4) DEFAULT NULL,
  `prod_id` bigint(20) DEFAULT NULL,
  `prod_use_remind` varchar(100) DEFAULT NULL,
  `video_name` varchar(100) DEFAULT NULL,
  `video_short_name` varchar(100) DEFAULT NULL,
  `video_url` varchar(500) DEFAULT NULL,
  `video_time` int(11) DEFAULT NULL,
  `video_use_remind` varchar(100) DEFAULT NULL,
  `version` bigint(20) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3412 DEFAULT CHARSET=utf8;

/*Table structure for table `miku_mine_cq` */

DROP TABLE IF EXISTS `miku_mine_cq`;

CREATE TABLE `miku_mine_cq` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `miku_mine_cq_questions` */

DROP TABLE IF EXISTS `miku_mine_cq_questions`;

CREATE TABLE `miku_mine_cq_questions` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `miku_mine_detect_report` */

DROP TABLE IF EXISTS `miku_mine_detect_report`;

CREATE TABLE `miku_mine_detect_report` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(10) DEFAULT NULL,
  `questionnaire_records_id` bigint(10) DEFAULT NULL,
  `sc_problem_ids` varchar(200) DEFAULT NULL,
  `expert_ids` varchar(40) DEFAULT NULL,
  `pic_urls` varchar(5000) DEFAULT NULL,
  `instrument_measure_date_include` varchar(50) DEFAULT NULL,
  `instrument_type` tinyint(4) DEFAULT NULL,
  `instrument_measure_stime` datetime DEFAULT NULL,
  `instrument_measure_etime` datetime DEFAULT NULL,
  `service_id` bigint(20) DEFAULT NULL,
  `sk_care` varchar(800) DEFAULT NULL,
  `print_time` datetime DEFAULT NULL,
  `version` bigint(20) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  `user_info` varchar(255) DEFAULT NULL,
  `suggestion_info` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=593 DEFAULT CHARSET=utf8;

/*Table structure for table `miku_mine_detectquestion_record` */

DROP TABLE IF EXISTS `miku_mine_detectquestion_record`;

CREATE TABLE `miku_mine_detectquestion_record` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(10) DEFAULT NULL COMMENT '用户id',
  `age` bigint(5) DEFAULT NULL COMMENT '用户年龄',
  `birthday` varchar(10) DEFAULT NULL COMMENT '生日',
  `mobile` varchar(20) DEFAULT NULL COMMENT '电话号码',
  `city` varchar(30) DEFAULT NULL COMMENT '常居住地',
  `is_have_healproduct` tinyint(4) DEFAULT NULL COMMENT '是否有服用保健品【1表示有 0表示无】',
  `life_and_body_condition` varchar(500) DEFAULT NULL COMMENT '生活和身体状况',
  `skin_condition` varchar(500) DEFAULT NULL COMMENT '肌肤状况,日常护理习惯',
  `demand` varchar(300) DEFAULT NULL COMMENT '需求问题',
  `expert_diagnose` varchar(255) DEFAULT NULL COMMENT '专家确诊问题',
  `date_created` datetime DEFAULT NULL COMMENT '创建时间',
  `last_updated` datetime DEFAULT NULL COMMENT '更新时间',
  `version` bigint(20) DEFAULT NULL COMMENT '版本',
  `name` varchar(15) DEFAULT NULL COMMENT '昵称',
  `status` tinyint(4) DEFAULT NULL COMMENT '1.用户已经填入信息  2.专家填完调查问卷  3.专家写完对应的报告',
  `sex` tinyint(4) DEFAULT NULL COMMENT '1男  2女',
  `imgs` varchar(500) DEFAULT NULL COMMENT '个人素颜照',
  `service_id` bigint(20) DEFAULT NULL COMMENT '专家的id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1459 DEFAULT CHARSET=utf8;

/*Table structure for table `miku_mine_expert_db` */

DROP TABLE IF EXISTS `miku_mine_expert_db`;

CREATE TABLE `miku_mine_expert_db` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `sc_problem_id` bigint(20) DEFAULT NULL,
  `sc_thinking_id` bigint(20) DEFAULT NULL,
  `skin_type_infer` varchar(500) DEFAULT NULL,
  `env_skin_type` tinyint(4) DEFAULT NULL,
  `env_age_region` tinyint(4) DEFAULT NULL,
  `env_city` varchar(100) DEFAULT NULL,
  `env_area` tinyint(4) DEFAULT NULL,
  `env_seasons` varchar(50) DEFAULT NULL,
  `step_name` varchar(50) DEFAULT NULL,
  `step_type` tinyint(4) DEFAULT NULL,
  `step_short_name` varchar(50) DEFAULT NULL,
  `step_order` int(11) DEFAULT NULL,
  `step_interval` int(11) DEFAULT NULL,
  `step_use_standard_frequency` tinyint(4) DEFAULT NULL,
  `step_use_standard_period` tinyint(4) DEFAULT NULL,
  `step_use_standard_condition` tinyint(4) DEFAULT NULL,
  `use_time` tinyint(4) DEFAULT NULL,
  `prod_id` bigint(20) DEFAULT NULL,
  `prod_use_remind` varchar(100) DEFAULT NULL,
  `video_name` varchar(100) DEFAULT NULL,
  `video_short_name` varchar(100) DEFAULT NULL,
  `video_url` varchar(500) DEFAULT NULL,
  `video_time` int(11) DEFAULT NULL,
  `video_use_remind` varchar(255) DEFAULT NULL,
  `version` bigint(20) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  `mine_type` tinyint(4) DEFAULT NULL,
  `multimedia_use_remind` varchar(255) DEFAULT NULL,
  `multimedia_resource_id` bigint(20) DEFAULT NULL,
  `env_city_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=465 DEFAULT CHARSET=utf8;

/*Table structure for table `miku_mine_iqrecords` */

DROP TABLE IF EXISTS `miku_mine_iqrecords`;

CREATE TABLE `miku_mine_iqrecords` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(10) DEFAULT NULL,
  `questionnaire_records_id` bigint(10) DEFAULT NULL,
  `sc_problem_id` bigint(10) DEFAULT NULL,
  `question_id` bigint(10) DEFAULT NULL,
  `question_name` varchar(300) DEFAULT NULL,
  `question_short_name` varchar(200) DEFAULT NULL,
  `option_id` bigint(10) DEFAULT NULL,
  `option_name` varchar(100) DEFAULT NULL,
  `option_value` varchar(100) DEFAULT NULL,
  `version` bigint(20) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1080 DEFAULT CHARSET=utf8;

/*Table structure for table `miku_mine_lesson` */

DROP TABLE IF EXISTS `miku_mine_lesson`;

CREATE TABLE `miku_mine_lesson` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `box_id` bigint(20) DEFAULT NULL COMMENT '盒子id',
  `lesson_name` varchar(100) DEFAULT NULL COMMENT '课时名',
  `lesson_short_name` varchar(100) DEFAULT NULL COMMENT '课时简称',
  `lesson_introduce` varchar(500) DEFAULT NULL COMMENT '介绍',
  `lesson_note` varchar(500) DEFAULT NULL,
  `lesson_property` tinyint(4) DEFAULT NULL COMMENT '课程属性\r\n            1、公开课程\r\n            2、系统自动生成的课时',
  `lesson_time` int(11) DEFAULT NULL COMMENT '本次课时时长',
  `lesson_steps_num` int(11) DEFAULT NULL COMMENT '本次课时步骤数',
  `version` bigint(20) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL COMMENT '创建日期',
  `last_updated` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2009 DEFAULT CHARSET=utf8 COMMENT='V1_课时表';

/*Table structure for table `miku_mine_lesson_step` */

DROP TABLE IF EXISTS `miku_mine_lesson_step`;

CREATE TABLE `miku_mine_lesson_step` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `box_id` bigint(20) DEFAULT NULL,
  `lesson_id` bigint(20) DEFAULT NULL,
  `step_name` varchar(100) DEFAULT NULL,
  `step_short_name` varchar(100) DEFAULT NULL,
  `step_introduce` varchar(500) DEFAULT NULL,
  `step_note` varchar(500) DEFAULT NULL,
  `step_order` int(11) DEFAULT NULL,
  `step_type` tinyint(4) DEFAULT NULL COMMENT '1、普通步骤\r\n            2、特效步骤',
  `step_interval` int(11) DEFAULT NULL,
  `prod_id` bigint(20) DEFAULT NULL,
  `prod_use_remind` varchar(300) DEFAULT NULL,
  `multimedia_resource_id` bigint(20) DEFAULT NULL,
  `multimedia_use_remind` varchar(300) DEFAULT NULL,
  `version` bigint(20) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL COMMENT '创建日期',
  `last_updated` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3199 DEFAULT CHARSET=utf8 COMMENT='V1_课时步骤表';

/*Table structure for table `miku_mine_multimedia_res` */

DROP TABLE IF EXISTS `miku_mine_multimedia_res`;

CREATE TABLE `miku_mine_multimedia_res` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) NOT NULL,
  `date_created` datetime NOT NULL,
  `last_updated` datetime NOT NULL,
  `mine_type` tinyint(4) DEFAULT NULL,
  `res_type` tinyint(4) DEFAULT NULL,
  `res_name` varchar(255) DEFAULT NULL,
  `res_url` varchar(2500) DEFAULT NULL,
  `res_short_name` varchar(255) DEFAULT NULL,
  `res_time` bigint(20) DEFAULT NULL,
  `res_use_remind` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=59 DEFAULT CHARSET=utf8;

/*Table structure for table `miku_mine_praise_log` */

DROP TABLE IF EXISTS `miku_mine_praise_log`;

CREATE TABLE `miku_mine_praise_log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) DEFAULT NULL COMMENT '版本',
  `date_created` datetime DEFAULT NULL COMMENT '创建日期',
  `last_updated` datetime DEFAULT NULL COMMENT '更新时间',
  `user_id` bigint(20) DEFAULT NULL COMMENT '评论用户的id',
  `goal_type` tinyint(4) DEFAULT NULL,
  `goal_id` bigint(20) DEFAULT NULL COMMENT '对象id【对应文章comtent表的id】',
  `note` varchar(200) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=856 DEFAULT CHARSET=utf8 COMMENT='点赞表';

/*Table structure for table `miku_mine_qoptions` */

DROP TABLE IF EXISTS `miku_mine_qoptions`;

CREATE TABLE `miku_mine_qoptions` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `question_id` bigint(10) DEFAULT NULL,
  `option_name` varchar(300) DEFAULT NULL,
  `option_des` varchar(500) DEFAULT NULL,
  `option_show_order` tinyint(4) DEFAULT NULL,
  `option_show_style` varchar(255) DEFAULT NULL,
  `option_pic_url` varchar(1000) DEFAULT NULL,
  `option_value` varchar(255) DEFAULT NULL,
  `creater_id` bigint(20) DEFAULT NULL,
  `version` bigint(20) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=utf8;

/*Table structure for table `miku_mine_question_options` */

DROP TABLE IF EXISTS `miku_mine_question_options`;

CREATE TABLE `miku_mine_question_options` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `miku_mine_question_records` */

DROP TABLE IF EXISTS `miku_mine_question_records`;

CREATE TABLE `miku_mine_question_records` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `miku_mine_questionnaire_records` */

DROP TABLE IF EXISTS `miku_mine_questionnaire_records`;

CREATE TABLE `miku_mine_questionnaire_records` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(10) DEFAULT NULL,
  `questionnaire_records_name` varchar(300) DEFAULT NULL,
  `sc_problem_ids` varchar(500) DEFAULT NULL,
  `age` bigint(5) DEFAULT NULL,
  `age_region` tinyint(5) DEFAULT NULL,
  `sex` varchar(4) DEFAULT NULL,
  `skin_color` varchar(255) DEFAULT NULL,
  `skin_type` tinyint(10) DEFAULT NULL,
  `bask_degree` varchar(255) DEFAULT NULL,
  `skin_sensitive` varchar(255) DEFAULT NULL,
  `skin_sensitive_frequency` varchar(255) DEFAULT NULL,
  `skin_sensitive_degree` varchar(255) DEFAULT NULL,
  `skin_redness` varchar(255) DEFAULT NULL,
  `skin_redness_degree` varchar(255) DEFAULT NULL,
  `sleep_time` varchar(255) DEFAULT NULL,
  `stress_degree` varchar(100) DEFAULT NULL,
  `env_city` varchar(100) DEFAULT NULL,
  `env_area` tinyint(10) DEFAULT NULL,
  `detailed_problem_records_id` varchar(500) DEFAULT NULL,
  `version` bigint(20) DEFAULT NULL,
  `live_env` varchar(255) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  `season` tinyint(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1192 DEFAULT CHARSET=utf8;

/*Table structure for table `miku_mine_questions` */

DROP TABLE IF EXISTS `miku_mine_questions`;

CREATE TABLE `miku_mine_questions` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `sc_problem_id` bigint(10) DEFAULT NULL,
  `question_show_order` int(4) DEFAULT NULL,
  `question_name` varchar(300) DEFAULT NULL,
  `question_short_name` varchar(200) DEFAULT NULL,
  `question_des` varchar(500) DEFAULT NULL,
  `options_selectable_type` tinyint(4) DEFAULT NULL,
  `options_selectable_maxnum` int(4) DEFAULT NULL,
  `creater_id` bigint(20) DEFAULT NULL,
  `version` bigint(20) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8;

/*Table structure for table `miku_mine_questions_route` */

DROP TABLE IF EXISTS `miku_mine_questions_route`;

CREATE TABLE `miku_mine_questions_route` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `miku_mine_recentlycontact_log` */

DROP TABLE IF EXISTS `miku_mine_recentlycontact_log`;

CREATE TABLE `miku_mine_recentlycontact_log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) DEFAULT NULL,
  `csad_id` bigint(20) DEFAULT NULL,
  `csad_user_id` bigint(20) DEFAULT NULL,
  `csad_name` varchar(50) DEFAULT NULL,
  `evaluate_note` varchar(500) DEFAULT NULL,
  `evaluate_level` int(11) DEFAULT NULL,
  `version` bigint(20) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

/*Table structure for table `miku_mine_sc_box` */

DROP TABLE IF EXISTS `miku_mine_sc_box`;

CREATE TABLE `miku_mine_sc_box` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `mine_type` tinyint(4) DEFAULT NULL,
  `pic_urls` varchar(500) DEFAULT NULL,
  `service_id` bigint(20) DEFAULT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `item_id` bigint(20) DEFAULT NULL,
  `box_name` varchar(50) DEFAULT NULL,
  `box_introduce` varchar(500) DEFAULT NULL,
  `box_note` varchar(500) DEFAULT NULL,
  `price` bigint(20) DEFAULT NULL,
  `pay_status` tinyint(4) DEFAULT NULL,
  `detect_report_id` bigint(20) DEFAULT NULL,
  `expert_db_ids` varchar(300) DEFAULT NULL,
  `sc_product_ids` varchar(300) DEFAULT NULL,
  `course_id` bigint(20) DEFAULT NULL,
  `version` bigint(20) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=686 DEFAULT CHARSET=utf8;

/*Table structure for table `miku_mine_sc_problem_item` */

DROP TABLE IF EXISTS `miku_mine_sc_problem_item`;

CREATE TABLE `miku_mine_sc_problem_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `sc_problem_name` varchar(100) DEFAULT NULL,
  `sc_problem_short_name` varchar(100) DEFAULT NULL,
  `sc_problem_note` varchar(500) DEFAULT NULL,
  `sc_problem_value` varchar(30) DEFAULT NULL,
  `version` bigint(20) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

/*Table structure for table `miku_mine_sc_product` */

DROP TABLE IF EXISTS `miku_mine_sc_product`;

CREATE TABLE `miku_mine_sc_product` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `prod_name` varchar(100) DEFAULT NULL,
  `prod_type` tinyint(4) DEFAULT NULL,
  `prod_spec` varchar(50) DEFAULT NULL,
  `prod_pack` varchar(50) DEFAULT NULL,
  `prod_ingredient` varchar(500) DEFAULT NULL,
  `prod_aim_problem_ids` varchar(500) DEFAULT NULL,
  `prod_aim_thinking_ids` varchar(500) DEFAULT NULL,
  `prod_cost_price` bigint(20) DEFAULT NULL,
  `prod_retail_price` bigint(20) DEFAULT NULL,
  `prod_note` varchar(200) DEFAULT NULL,
  `prod_skin_applys` varchar(50) DEFAULT NULL,
  `prod_show_status` varchar(50) DEFAULT NULL,
  `prod_purpose` varchar(500) DEFAULT NULL,
  `prod_use_standard_frequency` bigint(10) DEFAULT NULL,
  `prod_use_standard_period` bigint(10) DEFAULT NULL,
  `prod_use_standard_condition` bigint(10) DEFAULT NULL,
  `prod_result` varchar(500) DEFAULT NULL,
  `version` bigint(20) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  `prod_pic_urls` varchar(2500) DEFAULT NULL,
  `multimedia_res_id` bigint(20) DEFAULT NULL,
  `ming_type` tinyint(4) DEFAULT NULL,
  `mine_type` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=226 DEFAULT CHARSET=utf8;

/*Table structure for table `miku_mine_sc_thinking_item` */

DROP TABLE IF EXISTS `miku_mine_sc_thinking_item`;

CREATE TABLE `miku_mine_sc_thinking_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `sc_thinking_name` varchar(50) DEFAULT NULL,
  `sc_thinking_note` varchar(500) DEFAULT NULL,
  `sc_thinking_value` varchar(30) DEFAULT NULL,
  `version` bigint(20) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;

/*Table structure for table `miku_mine_section_lesson` */

DROP TABLE IF EXISTS `miku_mine_section_lesson`;

CREATE TABLE `miku_mine_section_lesson` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `course_id` bigint(20) DEFAULT NULL,
  `section_id` bigint(20) DEFAULT NULL,
  `box_id` bigint(20) DEFAULT NULL,
  `day_order` int(11) DEFAULT NULL COMMENT '课时表天序号\r\n            如果某天为空，则表示该天需要休息\r\n            改字段最大值不能超过section_duration的值',
  `earliesttime_in_day` time DEFAULT NULL COMMENT '最早这个课时什么时候用',
  `latestttime_in_day` time DEFAULT NULL COMMENT '最迟这个课时什么时候用',
  `suggesttime_in_day` time DEFAULT NULL COMMENT '建议这个课时什么时候开始\r\n            (如果用户在订阅表中设置了提醒，该字段用作提醒)',
  `lesson_id` bigint(20) DEFAULT NULL COMMENT '使用的课时',
  `version` bigint(20) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL COMMENT '创建日期',
  `last_updated` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4813 DEFAULT CHARSET=utf8 COMMENT='V1_阶段课时表（map表）';

/*Table structure for table `miku_mine_section_lesson_plan` */

DROP TABLE IF EXISTS `miku_mine_section_lesson_plan`;

CREATE TABLE `miku_mine_section_lesson_plan` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) DEFAULT NULL,
  `section_lesson_id` bigint(20) DEFAULT NULL,
  `course_id` bigint(20) DEFAULT NULL,
  `section_id` bigint(20) DEFAULT NULL,
  `box_id` bigint(20) DEFAULT NULL,
  `day_order` int(11) DEFAULT NULL COMMENT '课时表天序号\r\n            如果某天为空，则表示该天需要休息\r\n            改字段最大值不能超过section_duration的值',
  `earliesttime_in_day` time DEFAULT NULL COMMENT '最早这个课时什么时候用',
  `latestttime_in_day` time DEFAULT NULL COMMENT '最迟这个课时什么时候用',
  `suggesttime_in_day` time DEFAULT NULL COMMENT '建议这个课时什么时候开始\r\n            (如果用户在订阅表中设置了提醒，该字段用作提醒)',
  `lesson_id` bigint(20) DEFAULT NULL COMMENT '使用的课时',
  `study_date` datetime DEFAULT NULL,
  `send_status` tinyint(4) DEFAULT NULL,
  `version` bigint(20) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL COMMENT '创建日期',
  `last_updated` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4969 DEFAULT CHARSET=utf8 COMMENT='V1_阶段课时计划表（map表）';

/*Table structure for table `miku_mine_skincare_suggestion` */

DROP TABLE IF EXISTS `miku_mine_skincare_suggestion`;

CREATE TABLE `miku_mine_skincare_suggestion` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) NOT NULL,
  `date_created` datetime NOT NULL,
  `dietary_recommendation` varchar(255) DEFAULT NULL,
  `is_delete` tinyint(4) DEFAULT NULL,
  `last_updated` datetime NOT NULL,
  `measure_item` tinyint(4) DEFAULT NULL,
  `measure_item_level` tinyint(4) DEFAULT NULL,
  `measure_item_level_desc` varchar(255) DEFAULT NULL,
  `measure_item_level_range` varchar(255) DEFAULT NULL,
  `product_recommend_keys` varchar(255) DEFAULT NULL,
  `skin_care_recommendation` varchar(255) DEFAULT NULL,
  `skin_fact` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;

/*Table structure for table `miku_mobile_area` */

DROP TABLE IF EXISTS `miku_mobile_area`;

CREATE TABLE `miku_mobile_area` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `Mobile` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `Province` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `City` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `Corp` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `AreaCode` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `PostCode` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `miku_mobile_area_mobile` (`Mobile`(7))
) ENGINE=InnoDB AUTO_INCREMENT=327666 DEFAULT CHARSET=utf8;

/*Table structure for table `miku_msg_push` */

DROP TABLE IF EXISTS `miku_msg_push`;

CREATE TABLE `miku_msg_push` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `msg_title` varchar(150) DEFAULT NULL COMMENT '推送标题',
  `msg_content` text COMMENT '推送内容',
  `content_type` varchar(20) DEFAULT NULL COMMENT '推送内容类型(目前阶段暂不实现（20160422）)',
  `extras_content` text COMMENT '拓展键值对(目前阶段暂不实现（20160422）)',
  `offline_msg_livetime` tinyint(2) unsigned DEFAULT '5' COMMENT '离线消息保留时长:默认 86400秒 即 1 天，最长 10 天（系统默认5天）',
  `jpush_msg_id` bigint(20) unsigned DEFAULT '0' COMMENT '推送后极光返回消息ID',
  `andorid_succ_num` int(10) unsigned DEFAULT '0' COMMENT '安卓推送成功数量',
  `ios_succ_num` int(10) unsigned DEFAULT '0' COMMENT '苹果推送成功数量',
  `version` bigint(29) DEFAULT '1',
  `date_created` datetime DEFAULT NULL COMMENT '创建的时间',
  `last_updated` datetime DEFAULT NULL COMMENT '最好修改的时间',
  `andorid_succ_total_num` int(11) DEFAULT '0' COMMENT '安卓推送成功总数量',
  `ios_succ_total_num` int(11) DEFAULT '0' COMMENT '苹果推送成功总数量',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC COMMENT='极光推送表';

/*Table structure for table `miku_my_dynamic` */

DROP TABLE IF EXISTS `miku_my_dynamic`;

CREATE TABLE `miku_my_dynamic` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) DEFAULT NULL COMMENT '评论用户的id',
  `user_name` varchar(100) DEFAULT NULL COMMENT '用户名，冗余，为了用户@显示',
  `action_type` tinyint(4) DEFAULT NULL COMMENT '动作标识1、原创文章2、转发文章3、收藏内容',
  `goal_type` tinyint(4) DEFAULT NULL COMMENT '对象类型:1、客服/私人管家2、文章3、课程4、私人定制线下店5、…(action_type=1或者2   对于 2)(action_type=3   对于 2或者4)',
  `goal_id` bigint(20) DEFAULT NULL COMMENT '对象id',
  `referenced_profile_id` bigint(20) DEFAULT NULL COMMENT '被转载的是哪个用户的内容(action_type=2 有效）',
  `referenced_sns_profile_id` bigint(20) DEFAULT NULL COMMENT '被转载的是哪个用户的内容(action_type=2 有效）',
  `action_postion_type` tinyint(4) DEFAULT NULL COMMENT '1、个人主页2、圈子(action_type=1或者2的时候有效)',
  `action_postion_id` bigint(20) DEFAULT NULL COMMENT '(action_type=1或者2的时候，并且action_postion_type=2时有效）',
  `times_of_browsed` int(8) DEFAULT NULL COMMENT '浏览次数',
  `times_of_praised` int(8) DEFAULT NULL COMMENT '点赞次数',
  `times_of_referenced` int(8) DEFAULT NULL COMMENT '转载次数',
  `times_of_commented` int(8) DEFAULT NULL COMMENT '评论次数',
  `times_of_collected` int(8) DEFAULT NULL COMMENT '收藏次数',
  `top_flag` tinyint(4) DEFAULT NULL COMMENT '置顶标志：0、否1、是',
  `note` varchar(500) DEFAULT NULL COMMENT '备注',
  `is_delete` tinyint(4) DEFAULT NULL COMMENT '是否为删除',
  `version` bigint(20) DEFAULT NULL COMMENT '版本',
  `date_created` datetime DEFAULT NULL COMMENT '创建日期',
  `last_updated` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1423 DEFAULT CHARSET=utf8 COMMENT='我的动态（发布文章、发布动态、收藏….）';

/*Table structure for table `miku_one_buy` */

DROP TABLE IF EXISTS `miku_one_buy`;

CREATE TABLE `miku_one_buy` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `item_id` bigint(20) DEFAULT NULL COMMENT '商品id',
  `item_price` bigint(20) DEFAULT NULL COMMENT '商品价格',
  `times` int(11) DEFAULT NULL COMMENT '剩余人次',
  `status` tinyint(4) DEFAULT NULL COMMENT '状态（删除=0; 上架=1）',
  `periods` int(11) DEFAULT NULL COMMENT '期数',
  `date_created` datetime DEFAULT NULL COMMENT '创建日期',
  `last_updated` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='一元购';

/*Table structure for table `miku_orders_logistics` */

DROP TABLE IF EXISTS `miku_orders_logistics`;

CREATE TABLE `miku_orders_logistics` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) DEFAULT NULL,
  `logistics_id` bigint(20) DEFAULT NULL,
  `trade_id` bigint(20) DEFAULT NULL,
  `order_ids` varchar(500) DEFAULT NULL,
  `wlcompany` varchar(500) DEFAULT NULL,
  `wlnumber` varchar(500) DEFAULT NULL,
  `wlsnumber` varchar(500) DEFAULT NULL,
  `ismainc` varchar(500) DEFAULT NULL,
  `status` tinyint(4) DEFAULT NULL,
  `state` tinyint(4) DEFAULT NULL COMMENT '0：在途，即货物处于运输过程中；\r\n            1：揽件，货物已由快递公司揽收并且产生了第一条跟踪信息；\r\n            2：疑难，货物寄送过程出了问题；\r\n            3：签收，收件人已签收；\r\n            4：退签，即货物由于用户拒签、超区等原因退回，而且发件人已经签收；\r\n            5：派件，即快递正在进行同城派件；\r\n            6：退回，货物正处于退回发件人的途中；',
  `memo` varchar(500) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  `logic_specific_addr` text,
  `is_delete` tinyint(4) DEFAULT NULL,
  `istsflag` tinyint(4) DEFAULT NULL,
  `salt_code` varchar(255) DEFAULT NULL,
  `callback_url` varchar(255) DEFAULT NULL,
  `dy_info` varchar(255) DEFAULT NULL,
  `dy_status` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1575 DEFAULT CHARSET=utf8 COMMENT='多个物流单号物流信息表';

/*Table structure for table `miku_orders_logistics_test_one` */

DROP TABLE IF EXISTS `miku_orders_logistics_test_one`;

CREATE TABLE `miku_orders_logistics_test_one` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) DEFAULT NULL,
  `logistics_id` bigint(20) DEFAULT NULL,
  `trade_id` bigint(20) DEFAULT NULL,
  `order_ids` varchar(3000) DEFAULT NULL,
  `wlcompany` varchar(500) DEFAULT NULL,
  `wlnumber` varchar(500) DEFAULT NULL,
  `wlsnumber` varchar(500) DEFAULT NULL,
  `ismainc` varchar(500) DEFAULT NULL,
  `status` tinyint(4) DEFAULT NULL,
  `state` tinyint(4) DEFAULT NULL COMMENT '0：在途，即货物处于运输过程中；\r\n            1：揽件，货物已由快递公司揽收并且产生了第一条跟踪信息；\r\n            2：疑难，货物寄送过程出了问题；\r\n            3：签收，收件人已签收；\r\n            4：退签，即货物由于用户拒签、超区等原因退回，而且发件人已经签收；\r\n            5：派件，即快递正在进行同城派件；\r\n            6：退回，货物正处于退回发件人的途中；',
  `memo` varchar(500) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  `logic_specific_addr` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=546 DEFAULT CHARSET=utf8 COMMENT='多个物流单号物流信息表';

/*Table structure for table `miku_paccout_info` */

DROP TABLE IF EXISTS `miku_paccout_info`;

CREATE TABLE `miku_paccout_info` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) NOT NULL,
  `date_create` datetime DEFAULT NULL,
  `is_refund` tinyint(4) DEFAULT NULL,
  `last_update` datetime DEFAULT NULL,
  `pitem_id` bigint(20) DEFAULT NULL,
  `porder_id` bigint(20) DEFAULT NULL,
  `provider_id` bigint(20) DEFAULT NULL,
  `ptotal_fee` bigint(20) DEFAULT NULL,
  `refund_reason` varchar(255) DEFAULT NULL,
  `status` tinyint(4) DEFAULT NULL,
  `trade_id` bigint(20) DEFAULT NULL,
  `utotal_fee` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `miku_pclassify` */

DROP TABLE IF EXISTS `miku_pclassify`;

CREATE TABLE `miku_pclassify` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `change_id` bigint(20) DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `features` varchar(255) DEFAULT NULL,
  `is_delete` tinyint(4) DEFAULT NULL,
  `is_parent` tinyint(4) DEFAULT NULL,
  `last_updated` datetime NOT NULL,
  `level` bigint(20) DEFAULT NULL,
  `market` int(11) DEFAULT NULL,
  `memo` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `parent_id` bigint(20) DEFAULT NULL,
  `status` tinyint(4) DEFAULT NULL,
  `weight` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=211 DEFAULT CHARSET=utf8;

/*Table structure for table `miku_pdelivery_orders` */

DROP TABLE IF EXISTS `miku_pdelivery_orders`;

CREATE TABLE `miku_pdelivery_orders` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `date_created` datetime NOT NULL,
  `last_updated` datetime NOT NULL,
  `num` int(11) DEFAULT NULL,
  `pid` bigint(20) DEFAULT NULL,
  `pitem_id` bigint(20) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `trade_id` bigint(20) DEFAULT NULL,
  `idcard` varchar(255) DEFAULT NULL,
  `order_id` bigint(20) DEFAULT NULL,
  `total_fee` bigint(20) DEFAULT NULL,
  `is_delete` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=178 DEFAULT CHARSET=utf8;

/*Table structure for table `miku_pdelivery_trade` */

DROP TABLE IF EXISTS `miku_pdelivery_trade`;

CREATE TABLE `miku_pdelivery_trade` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `date_created` datetime NOT NULL,
  `last_updated` datetime NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `orders` varchar(255) DEFAULT NULL,
  `pay_type` tinyint(4) DEFAULT NULL,
  `status` tinyint(4) DEFAULT NULL,
  `trade_id` bigint(20) DEFAULT NULL,
  `alldonum` int(11) DEFAULT NULL,
  `do_orders` varchar(255) DEFAULT NULL,
  `donum` int(11) DEFAULT NULL,
  `logic_id` bigint(20) DEFAULT NULL,
  `total_fee` bigint(20) DEFAULT NULL,
  `buyer_message` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=965 DEFAULT CHARSET=utf8;

/*Table structure for table `miku_piteminfo` */

DROP TABLE IF EXISTS `miku_piteminfo`;

CREATE TABLE `miku_piteminfo` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `assess` varchar(255) DEFAULT NULL,
  `brand_id` bigint(20) DEFAULT NULL,
  `change_id` bigint(20) DEFAULT NULL,
  `cknum` int(11) DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `isrefund` tinyint(4) DEFAULT NULL,
  `last_updated` datetime NOT NULL,
  `logistic_destrion` varchar(255) DEFAULT NULL,
  `memo` varchar(255) DEFAULT NULL,
  `num` int(11) DEFAULT NULL,
  `pclassify_id` bigint(20) DEFAULT NULL,
  `pitem_code` varchar(255) DEFAULT NULL,
  `post_fee` bigint(20) DEFAULT NULL,
  `price` bigint(20) DEFAULT NULL,
  `rknum` int(11) DEFAULT NULL,
  `status` tinyint(4) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `area` varchar(255) DEFAULT NULL,
  `code` varchar(255) DEFAULT NULL,
  `jhprice` bigint(20) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `xsprice` bigint(20) DEFAULT NULL,
  `num_fen` int(11) DEFAULT NULL,
  `sum_fen` bigint(20) DEFAULT NULL,
  `classfi_id` bigint(20) DEFAULT NULL,
  `provider_id` bigint(20) DEFAULT NULL,
  `is_check` tinyint(4) DEFAULT NULL,
  `keyword` varchar(255) DEFAULT NULL,
  `weight` bigint(20) DEFAULT NULL,
  `version` bigint(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2397 DEFAULT CHARSET=utf8;

/*Table structure for table `miku_provider` */

DROP TABLE IF EXISTS `miku_provider`;

CREATE TABLE `miku_provider` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `accounttime` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `assess` varchar(255) DEFAULT NULL,
  `change_id` bigint(20) DEFAULT NULL,
  `code` varchar(255) DEFAULT NULL,
  `cperson` varchar(255) DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `job` varchar(255) DEFAULT NULL,
  `last_updated` datetime NOT NULL,
  `memo` varchar(255) DEFAULT NULL,
  `mobile` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `sname` varchar(255) DEFAULT NULL,
  `status` tinyint(4) DEFAULT NULL,
  `zipcode` varchar(255) DEFAULT NULL,
  `clssfiy_id` bigint(20) DEFAULT NULL,
  `is_check` tinyint(4) DEFAULT NULL,
  `qq` varchar(255) DEFAULT NULL,
  `scall` varchar(255) DEFAULT NULL,
  `scontacts` varchar(255) DEFAULT NULL,
  `fcall` varchar(255) DEFAULT NULL,
  `fcontacts` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=107 DEFAULT CHARSET=utf8;

/*Table structure for table `miku_redpacket_active` */

DROP TABLE IF EXISTS `miku_redpacket_active`;

CREATE TABLE `miku_redpacket_active` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `price` bigint(20) NOT NULL,
  `onepackstr` varchar(255) NOT NULL,
  `onepercent` bigint(20) NOT NULL,
  `num` bigint(20) NOT NULL,
  `begintime` datetime DEFAULT NULL,
  `endtime` datetime DEFAULT NULL,
  `rpmax` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

/*Table structure for table `miku_req_change_up_user` */

DROP TABLE IF EXISTS `miku_req_change_up_user`;

CREATE TABLE `miku_req_change_up_user` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) DEFAULT NULL,
  `up_mobile` varchar(30) DEFAULT NULL,
  `seq_mobiles` varchar(500) DEFAULT NULL COMMENT '申请需变更电话(多个电话以逗号分隔)',
  `mobile` varchar(30) DEFAULT NULL,
  `version` bigint(20) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='申请变更上级代理';

/*Table structure for table `miku_return_goods` */

DROP TABLE IF EXISTS `miku_return_goods`;

CREATE TABLE `miku_return_goods` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) DEFAULT NULL,
  `trade_id` bigint(20) DEFAULT NULL,
  `order_id` bigint(20) DEFAULT NULL,
  `artificial_id` bigint(20) DEFAULT NULL,
  `buyer_id` bigint(20) DEFAULT NULL,
  `num` int(11) DEFAULT NULL,
  `pic_url` varchar(2555) DEFAULT NULL,
  `price` bigint(20) DEFAULT NULL,
  `total_fee` bigint(20) DEFAULT NULL,
  `refund_fee` bigint(20) DEFAULT NULL COMMENT '退款金额',
  `status` tinyint(4) DEFAULT NULL COMMENT '状态(-1:删除;0:正常单;1:申请退货;2=退货中;3=退货完成;4=退货异常)',
  `timeout_action_time` datetime DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  `consign_time` datetime DEFAULT NULL,
  `finish_time` datetime DEFAULT NULL,
  `consignee_id` bigint(20) DEFAULT NULL,
  `buyer_memo` varchar(2000) DEFAULT NULL COMMENT '买家备注',
  `seller_memo` varchar(2000) DEFAULT NULL COMMENT '卖家备注',
  `return_reason` varchar(500) DEFAULT NULL,
  `req_examine` datetime DEFAULT NULL,
  `receipt_time` datetime DEFAULT NULL,
  `is_subsidy` tinyint(4) DEFAULT NULL,
  `subsidy_fee` bigint(20) DEFAULT NULL,
  `trade_status` tinyint(4) DEFAULT NULL,
  `end_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=608 DEFAULT CHARSET=utf8 COMMENT='V1_退货退款表';

/*Table structure for table `miku_sales_record` */

DROP TABLE IF EXISTS `miku_sales_record`;

CREATE TABLE `miku_sales_record` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `agency_id` bigint(20) DEFAULT NULL,
  `agency_level_name` varchar(255) DEFAULT NULL,
  `trade_id` bigint(20) DEFAULT NULL,
  `share_type` int(11) DEFAULT NULL,
  `up_level` bigint(20) DEFAULT NULL,
  `buyer_id` bigint(20) DEFAULT NULL,
  `buyer_name` varchar(255) DEFAULT NULL,
  `buyer_mobile` varchar(255) DEFAULT NULL,
  `item_id` bigint(20) DEFAULT NULL,
  `item_name` varchar(255) DEFAULT NULL,
  `num` int(11) DEFAULT NULL,
  `price` bigint(20) DEFAULT NULL,
  `amount` bigint(20) DEFAULT NULL,
  `pay_time` datetime DEFAULT NULL,
  `confirm_date` datetime DEFAULT NULL,
  `return_date` datetime DEFAULT NULL,
  `share_fee` bigint(20) DEFAULT NULL,
  `parameter` varchar(2000) DEFAULT NULL,
  `version` bigint(20) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  `is_getpay` tinyint(4) DEFAULT NULL,
  `return_status` tinyint(4) DEFAULT NULL COMMENT '退款状态(-1:删除;0:申请退货;1=退货中;2=退货完成)',
  `timeout_action_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=51845 DEFAULT CHARSET=utf8;

/*Table structure for table `miku_scan_code_cash` */

DROP TABLE IF EXISTS `miku_scan_code_cash`;

CREATE TABLE `miku_scan_code_cash` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) DEFAULT NULL,
  `number` varchar(30) DEFAULT NULL,
  `status` tinyint(4) DEFAULT NULL COMMENT '状态(0=已取消;1=未下单;2=未付款;3=已付款)',
  `item_id` bigint(20) DEFAULT NULL,
  `item_title` varchar(255) DEFAULT NULL,
  `pic_urls` varchar(500) DEFAULT NULL,
  `trade_id` bigint(20) DEFAULT NULL,
  `start_date` datetime DEFAULT NULL,
  `end_date` datetime DEFAULT NULL,
  `version` bigint(20) NOT NULL,
  `date_created` datetime NOT NULL,
  `last_updated` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=309 DEFAULT CHARSET=utf8 COMMENT='V1_扫码用户兑奖结果';

/*Table structure for table `miku_scan_codes` */

DROP TABLE IF EXISTS `miku_scan_codes`;

CREATE TABLE `miku_scan_codes` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `number` varchar(30) DEFAULT NULL,
  `status` tinyint(4) DEFAULT NULL COMMENT '状态(0=未使用;1=已使用)',
  `version` bigint(20) NOT NULL,
  `date_created` datetime NOT NULL,
  `last_updated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `number` (`number`)
) ENGINE=InnoDB AUTO_INCREMENT=713239 DEFAULT CHARSET=utf8 COMMENT='V1_扫码总兑奖码';

/*Table structure for table `miku_scratch_card` */

DROP TABLE IF EXISTS `miku_scratch_card`;

CREATE TABLE `miku_scratch_card` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `number` varchar(100) DEFAULT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `is_reward` tinyint(4) DEFAULT NULL COMMENT '是否中奖(0=未中奖;1=中奖)',
  `item_id` bigint(20) DEFAULT NULL,
  `item_title` varchar(255) DEFAULT NULL,
  `pic_urls` varchar(500) DEFAULT NULL,
  `status` tinyint(4) DEFAULT NULL COMMENT '状态(0=已取消;1=未下单;2=未付款;3=已付款)',
  `trade_id` bigint(20) DEFAULT NULL,
  `version` bigint(20) NOT NULL,
  `date_created` datetime NOT NULL,
  `last_updated` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4690 DEFAULT CHARSET=utf8 COMMENT='V1_刮刮卡';

/*Table structure for table `miku_sensitive_words` */

DROP TABLE IF EXISTS `miku_sensitive_words`;

CREATE TABLE `miku_sensitive_words` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) DEFAULT NULL,
  `word` varchar(200) DEFAULT NULL,
  `type` tinyint(4) DEFAULT NULL COMMENT '类型(1=需要审核;2=黑名单)',
  `status` tinyint(4) DEFAULT NULL COMMENT '状态(0=不可用;1=可用)',
  `date_created` datetime DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='V1_敏感词';

/*Table structure for table `miku_share_getpay` */

DROP TABLE IF EXISTS `miku_share_getpay`;

CREATE TABLE `miku_share_getpay` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `getpay_id` bigint(20) DEFAULT NULL,
  `sales_record_id` bigint(20) DEFAULT NULL,
  `version` bigint(20) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6694 DEFAULT CHARSET=utf8;

/*Table structure for table `miku_share_getpay_temp` */

DROP TABLE IF EXISTS `miku_share_getpay_temp`;

CREATE TABLE `miku_share_getpay_temp` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `getpay_id` bigint(20) DEFAULT NULL,
  `sales_record_id` bigint(20) DEFAULT NULL,
  `version` bigint(20) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11057 DEFAULT CHARSET=utf8;

/*Table structure for table `miku_share_level` */

DROP TABLE IF EXISTS `miku_share_level`;

CREATE TABLE `miku_share_level` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) DEFAULT NULL,
  `level_name` varchar(255) DEFAULT NULL,
  `memo` varchar(1000) DEFAULT NULL,
  `share_type` int(11) DEFAULT NULL,
  `default_share_scale` decimal(6,2) DEFAULT NULL,
  `weight` int(11) DEFAULT NULL,
  `creator_id` bigint(20) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  `is_deleted` tinyint(4) DEFAULT NULL,
  `creator_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;

/*Table structure for table `miku_skin_care_suggestion` */

DROP TABLE IF EXISTS `miku_skin_care_suggestion`;

CREATE TABLE `miku_skin_care_suggestion` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `miku_sns_circle` */

DROP TABLE IF EXISTS `miku_sns_circle`;

CREATE TABLE `miku_sns_circle` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) DEFAULT NULL COMMENT '版本',
  `date_created` datetime DEFAULT NULL COMMENT '创建日期',
  `last_updated` datetime DEFAULT NULL COMMENT '更新时间',
  `creator_profile_id` bigint(20) DEFAULT NULL COMMENT '用户id',
  `creator_sns_profile_id` bigint(20) DEFAULT NULL COMMENT '用户id',
  `circle_name` varchar(240) DEFAULT NULL COMMENT '圈子名',
  `circle_disc` varchar(240) DEFAULT NULL COMMENT '圈子描述',
  `circle_logo_url` varchar(240) DEFAULT NULL COMMENT '圈子logo在云片上的url',
  `circle_num` int(20) DEFAULT NULL COMMENT '圈子成员的总数',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=375 DEFAULT CHARSET=utf8 COMMENT='圈子';

/*Table structure for table `miku_sns_circle_members` */

DROP TABLE IF EXISTS `miku_sns_circle_members`;

CREATE TABLE `miku_sns_circle_members` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) DEFAULT NULL COMMENT '版本',
  `date_created` datetime DEFAULT NULL COMMENT '创建日期',
  `last_updated` datetime DEFAULT NULL COMMENT '更新时间',
  `circle_id` bigint(20) DEFAULT NULL COMMENT '圈子的id',
  `user_profile_id` bigint(20) DEFAULT NULL COMMENT '加入对应圈子的用户id',
  `user_sns_profile_id` bigint(20) DEFAULT NULL COMMENT '加入对应圈子的发现关联的id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=367 DEFAULT CHARSET=utf8 COMMENT='对应圈子关联关系成员表';

/*Table structure for table `miku_sns_content` */

DROP TABLE IF EXISTS `miku_sns_content`;

CREATE TABLE `miku_sns_content` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) DEFAULT NULL COMMENT '用户id',
  `user_name` varchar(100) DEFAULT NULL COMMENT '用户名，冗余，为了用户@显示',
  `content_create_type` tinyint(4) DEFAULT NULL COMMENT '文章生成类型：1、系统发布的内容2、用户发布的内容',
  `content_type` tinyint(4) DEFAULT NULL COMMENT '用户名，冗余，为了用户@显示',
  `content_title` varchar(100) DEFAULT NULL COMMENT '文章标题',
  `content_short_title` varchar(100) DEFAULT NULL COMMENT '文章标题简称',
  `content_abstract` varchar(300) DEFAULT NULL COMMENT '内容摘要（只建议 content_create_type=1  用 ）（被转发时，显示两行，一行标题，一行摘要）',
  `content_surface_pic_url` varchar(800) DEFAULT NULL COMMENT '封面图(需要小伍提供尺寸建议)',
  `conten_thumb_pic_url` varchar(500) DEFAULT NULL COMMENT '缩略图（被转发用）',
  `content` text COMMENT '具体内容',
  `pic_urls` varchar(3500) DEFAULT NULL COMMENT '保存文章后面的图片云片的url（类似微信朋友圈的展现形式）',
  `referenced_goal_type` tinyint(4) DEFAULT NULL COMMENT '被引用资源类型对象类型:1、客服/私人管家2、文章3、课程4、私人定制线下店5、…(content_from_type=2有效)',
  `referenced_goal_id` bigint(20) DEFAULT NULL COMMENT '被引用资源id',
  `author_show_name` varchar(80) DEFAULT NULL COMMENT '文章显示的作者名仅当content_create_type=1，有效',
  `special_flag` tinyint(4) DEFAULT NULL COMMENT '用于处理特殊文章：0、正常文章1、负面文章（作者可见，其它用户不可见）2、待定',
  `version` bigint(20) DEFAULT NULL COMMENT '版本',
  `date_created` datetime DEFAULT NULL COMMENT '创建日期',
  `last_updated` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=282 DEFAULT CHARSET=utf8 COMMENT='系统或者用户发布的内容表';

/*Table structure for table `miku_sns_profile` */

DROP TABLE IF EXISTS `miku_sns_profile`;

CREATE TABLE `miku_sns_profile` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `profile_id` bigint(20) NOT NULL,
  `version` bigint(20) NOT NULL,
  `date_created` datetime NOT NULL,
  `last_updated` datetime NOT NULL,
  `sex` tinyint(4) DEFAULT NULL,
  `signature` varchar(600) DEFAULT NULL,
  `user_info` varchar(2500) DEFAULT NULL,
  `creater_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=190 DEFAULT CHARSET=utf8;

/*Table structure for table `miku_sns_relation` */

DROP TABLE IF EXISTS `miku_sns_relation`;

CREATE TABLE `miku_sns_relation` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `from_profile_id` bigint(20) NOT NULL COMMENT '用户id',
  `from_sns_profile_id` bigint(20) NOT NULL COMMENT '发现id',
  `to_profile_id` bigint(20) NOT NULL COMMENT '关注者的id',
  `to_sns_profile_id` bigint(20) NOT NULL COMMENT '关注者的发现id',
  `relation_type` tinyint(4) DEFAULT NULL COMMENT '标识：1、关注粉丝2、拉黑',
  `creater_id` bigint(20) DEFAULT NULL COMMENT '录入者',
  `version` bigint(20) DEFAULT NULL COMMENT '版本',
  `date_created` datetime DEFAULT NULL COMMENT '创建日期',
  `last_updated` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=388 DEFAULT CHARSET=utf8 COMMENT='用户表关系表';

/*Table structure for table `miku_sns_remind_message` */

DROP TABLE IF EXISTS `miku_sns_remind_message`;

CREATE TABLE `miku_sns_remind_message` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `profile_id` bigint(20) DEFAULT NULL COMMENT '提醒消息的用户id',
  `sns_profile_id` bigint(20) NOT NULL COMMENT '提醒消息的用户发现关联表的id',
  `do_profile_id` bigint(20) DEFAULT NULL COMMENT '操作某个动作的用户',
  `do_sns_profile_id` bigint(20) NOT NULL COMMENT '操作某个动作的用户的关联表id',
  `flag` tinyint(4) DEFAULT NULL COMMENT '是否被读取的标示:0未读 1已读',
  `messsage_flag` tinyint(4) DEFAULT NULL COMMENT '消息体内容标示[1.关注人信息  2.单单评论文章  3.系统信息  4.点赞信息] 5.回复对应用户的评论',
  `message` varchar(300) NOT NULL COMMENT '消息的提示信息',
  `target_id` bigint(20) DEFAULT NULL COMMENT '目标体的id[根据message_flag的标示来确定:1.xxx关注你了 2.xx回复xx:content+原话  3.xx点赞+原话]',
  `version` bigint(20) DEFAULT NULL COMMENT '版本',
  `date_created` datetime DEFAULT NULL COMMENT '创建日期',
  `last_updated` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1273 DEFAULT CHARSET=utf8 COMMENT='消息提醒表';

/*Table structure for table `miku_supplier_classify` */

DROP TABLE IF EXISTS `miku_supplier_classify`;

CREATE TABLE `miku_supplier_classify` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) NOT NULL,
  `change_id` bigint(20) DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `features` varchar(255) DEFAULT NULL,
  `is_delete` tinyint(4) DEFAULT NULL,
  `is_parent` tinyint(4) DEFAULT NULL,
  `last_updated` datetime NOT NULL,
  `level` bigint(20) DEFAULT NULL,
  `market` int(11) DEFAULT NULL,
  `memo` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `parent_id` bigint(20) DEFAULT NULL,
  `status` tinyint(4) DEFAULT NULL,
  `weight` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8;

/*Table structure for table `miku_suppliy_item_goods_relation` */

DROP TABLE IF EXISTS `miku_suppliy_item_goods_relation`;

CREATE TABLE `miku_suppliy_item_goods_relation` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) NOT NULL,
  `item_id` bigint(20) DEFAULT NULL,
  `supply_goods_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `miku_survey_report` */

DROP TABLE IF EXISTS `miku_survey_report`;

CREATE TABLE `miku_survey_report` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) NOT NULL,
  `date_created` datetime NOT NULL,
  `instrument_measure_date_include` varchar(255) DEFAULT NULL,
  `instrument_measure_etime` datetime DEFAULT NULL,
  `instrument_measure_stime` datetime DEFAULT NULL,
  `instrument_type` tinyint(4) DEFAULT NULL,
  `last_updated` datetime NOT NULL,
  `money` bigint(20) DEFAULT NULL,
  `option_id` bigint(20) DEFAULT NULL,
  `option_show_style` tinyint(4) DEFAULT NULL,
  `option_value` varchar(255) DEFAULT NULL,
  `pic_urls` varchar(255) DEFAULT NULL,
  `question_id` bigint(20) DEFAULT NULL,
  `question_name` bigint(20) DEFAULT NULL,
  `question_order_inreport` varchar(255) DEFAULT NULL,
  `question_postion_inreport` varchar(255) DEFAULT NULL,
  `question_type` bigint(20) DEFAULT NULL,
  `questionnaire_id` bigint(20) DEFAULT NULL,
  `service_id` bigint(20) DEFAULT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `miku_topic_item` */

DROP TABLE IF EXISTS `miku_topic_item`;

CREATE TABLE `miku_topic_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `topic_id` bigint(20) DEFAULT NULL,
  `item_id` bigint(20) DEFAULT NULL,
  `version` bigint(20) NOT NULL,
  `date_created` datetime NOT NULL,
  `last_updated` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=647 DEFAULT CHARSET=utf8 COMMENT='专场商品关联表';

/*Table structure for table `miku_user_agency` */

DROP TABLE IF EXISTS `miku_user_agency`;

CREATE TABLE `miku_user_agency` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) DEFAULT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `level_id` bigint(20) DEFAULT NULL,
  `ceo_user_id` bigint(20) DEFAULT NULL,
  `ceo2_user_id` bigint(20) DEFAULT NULL,
  `ceo3_user_id` bigint(20) DEFAULT NULL,
  `ceo4_user_id` bigint(20) DEFAULT NULL,
  `agency_level` bigint(20) DEFAULT NULL,
  `p_user_id` bigint(20) DEFAULT NULL,
  `p2_user_id` bigint(20) DEFAULT NULL,
  `p3_user_id` bigint(20) DEFAULT NULL,
  `p4_user_id` bigint(20) DEFAULT NULL,
  `p5_user_id` bigint(20) DEFAULT NULL,
  `p6_user_id` bigint(20) DEFAULT NULL,
  `p7_user_id` bigint(20) DEFAULT NULL,
  `p8_user_id` bigint(20) DEFAULT NULL,
  `is_parent` tinyint(4) DEFAULT NULL,
  `path` varchar(255) DEFAULT NULL,
  `is_validated` tinyint(4) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  `is_deleted` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9524 DEFAULT CHARSET=utf8;

/*Table structure for table `miku_user_agency_temp` */

DROP TABLE IF EXISTS `miku_user_agency_temp`;

CREATE TABLE `miku_user_agency_temp` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) DEFAULT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `level_id` bigint(20) DEFAULT NULL,
  `ceo_user_id` bigint(20) DEFAULT NULL,
  `ceo2_user_id` bigint(20) DEFAULT NULL,
  `ceo3_user_id` bigint(20) DEFAULT NULL,
  `ceo4_user_id` bigint(20) DEFAULT NULL,
  `agency_level` bigint(20) DEFAULT NULL,
  `p_user_id` bigint(20) DEFAULT NULL,
  `p2_user_id` bigint(20) DEFAULT NULL,
  `p3_user_id` bigint(20) DEFAULT NULL,
  `p4_user_id` bigint(20) DEFAULT NULL,
  `p5_user_id` bigint(20) DEFAULT NULL,
  `p6_user_id` bigint(20) DEFAULT NULL,
  `p7_user_id` bigint(20) DEFAULT NULL,
  `p8_user_id` bigint(20) DEFAULT NULL,
  `is_parent` tinyint(4) DEFAULT NULL,
  `path` varchar(255) DEFAULT NULL,
  `is_validated` tinyint(4) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  `is_deleted` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12412 DEFAULT CHARSET=utf8;

/*Table structure for table `miku_user_one_buy` */

DROP TABLE IF EXISTS `miku_user_one_buy`;

CREATE TABLE `miku_user_one_buy` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `item_id` bigint(20) DEFAULT NULL COMMENT '商品id',
  `item_name` varchar(255) DEFAULT NULL COMMENT '商品名称',
  `one_buy_id` bigint(20) DEFAULT NULL COMMENT '一元购id',
  `user_id` bigint(20) DEFAULT NULL COMMENT '用户id',
  `start_code` bigint(20) DEFAULT NULL COMMENT '开始中奖码',
  `num` int(11) DEFAULT NULL COMMENT '购买数量',
  `periods` int(11) DEFAULT NULL COMMENT '期数',
  `status` tinyint(4) DEFAULT NULL COMMENT '状态(取消=-1,; 下单=0; 付款成功=1)',
  `is_win` tinyint(4) DEFAULT NULL COMMENT '是否中奖(否=0; 是=1)',
  `trade_id` bigint(20) DEFAULT NULL COMMENT '订单id',
  `reward_date` datetime DEFAULT NULL COMMENT '中奖时间',
  `date_created` datetime DEFAULT NULL COMMENT '创建日期',
  `last_updated` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='用户一元购';

/*Table structure for table `miku_user_vip` */

DROP TABLE IF EXISTS `miku_user_vip`;

CREATE TABLE `miku_user_vip` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) DEFAULT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `vip_level_id` bigint(20) DEFAULT NULL,
  `consume_total` bigint(20) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `miku_user_vip_log` */

DROP TABLE IF EXISTS `miku_user_vip_log`;

CREATE TABLE `miku_user_vip_log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) DEFAULT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `before_vip_name` varchar(255) DEFAULT NULL,
  `after_vip_name` varchar(255) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `miku_view_connect_info` */

DROP TABLE IF EXISTS `miku_view_connect_info`;

CREATE TABLE `miku_view_connect_info` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) NOT NULL,
  `info` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `one_level_flag` tinyint(4) DEFAULT NULL,
  `one_level_id` bigint(20) DEFAULT NULL,
  `one_level_status` tinyint(4) DEFAULT NULL,
  `two_level_id` bigint(20) DEFAULT NULL,
  `two_level_status` tinyint(4) DEFAULT NULL,
  `type` bigint(20) DEFAULT NULL,
  `view_id` bigint(20) DEFAULT NULL,
  `time` datetime DEFAULT NULL,
  `weight` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=480 DEFAULT CHARSET=utf8;

/*Table structure for table `miku_view_info` */

DROP TABLE IF EXISTS `miku_view_info`;

CREATE TABLE `miku_view_info` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) NOT NULL,
  `info` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `otherinfo` varchar(255) DEFAULT NULL,
  `status` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;

/*Table structure for table `miku_vip_level` */

DROP TABLE IF EXISTS `miku_vip_level`;

CREATE TABLE `miku_vip_level` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) DEFAULT NULL,
  `level_name` varchar(255) DEFAULT NULL,
  `memo` varchar(1000) DEFAULT NULL,
  `return_point_scale` decimal(6,2) DEFAULT NULL,
  `point_floor` bigint(20) DEFAULT NULL,
  `share_scale` decimal(6,2) DEFAULT NULL,
  `weight` int(11) DEFAULT NULL,
  `creator_id` bigint(20) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  `is_deleted` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `miku_wallet` */

DROP TABLE IF EXISTS `miku_wallet`;

CREATE TABLE `miku_wallet` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) DEFAULT NULL,
  `mobile` varchar(30) DEFAULT NULL,
  `balance_fee` bigint(20) DEFAULT NULL,
  `getpayed_fee` bigint(20) DEFAULT NULL,
  `getpaying_fee` bigint(20) DEFAULT NULL,
  `version` bigint(20) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9236 DEFAULT CHARSET=utf8 COMMENT='我的钱包';

/*Table structure for table `miku_wallet_origin` */

DROP TABLE IF EXISTS `miku_wallet_origin`;

CREATE TABLE `miku_wallet_origin` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) DEFAULT NULL,
  `type` tinyint(4) DEFAULT NULL COMMENT '来源类型(0=充值;1=退款)',
  `total_fee` bigint(20) DEFAULT NULL,
  `origin_id` bigint(20) DEFAULT NULL,
  `getpay_status` tinyint(4) DEFAULT NULL COMMENT '提现状态(-1=未提现/删除；0=提现中/待审核；1=已提现/已审核;2=提现异常)',
  `version` bigint(20) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  `orgin_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=177 DEFAULT CHARSET=utf8 COMMENT='钱包来源';

/*Table structure for table `mytestable` */

DROP TABLE IF EXISTS `mytestable`;

CREATE TABLE `mytestable` (
  `id` longblob
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `notify_config` */

DROP TABLE IF EXISTS `notify_config`;

CREATE TABLE `notify_config` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `profile_id` bigint(20) NOT NULL DEFAULT '0',
  `notify_tag` bigint(20) DEFAULT '65535',
  `community_id` bigint(20) NOT NULL DEFAULT '0',
  `building_id` bigint(20) NOT NULL DEFAULT '0',
  `date_created` datetime DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `object_tagged` */

DROP TABLE IF EXISTS `object_tagged`;

CREATE TABLE `object_tagged` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `artificial_id` bigint(20) DEFAULT NULL,
  `type` int(11) DEFAULT NULL,
  `kv` varchar(2000) DEFAULT NULL,
  `status` tinyint(11) DEFAULT NULL,
  `start_time` datetime DEFAULT NULL,
  `end_time` datetime DEFAULT NULL,
  `tag_id` bigint(20) DEFAULT NULL,
  `version` bigint(20) DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `activity_sold_num` int(11) DEFAULT NULL,
  `activity_num` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_item_status` (`artificial_id`,`status`),
  KEY `idx_type_id_status` (`type`,`artificial_id`,`status`)
) ENGINE=InnoDB AUTO_INCREMENT=4642 DEFAULT CHARSET=utf8mb4;

/*Table structure for table `order_evaluate` */

DROP TABLE IF EXISTS `order_evaluate`;

CREATE TABLE `order_evaluate` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `item_id` bigint(20) DEFAULT NULL,
  `trade_id` bigint(20) DEFAULT NULL,
  `order_id` bigint(20) DEFAULT NULL,
  `role` tinyint(4) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  `rated_nick` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `item_title` varchar(512) COLLATE utf8_unicode_ci DEFAULT NULL,
  `content` varchar(512) COLLATE utf8_unicode_ci DEFAULT NULL,
  `rate_type` tinyint(4) DEFAULT '1',
  `reply_id` bigint(20) DEFAULT '-1',
  `eval_code` tinyint(4) DEFAULT '5',
  `pics` varchar(512) COLLATE utf8_unicode_ci DEFAULT NULL,
  `anonymous` tinyint(4) DEFAULT '0',
  `rated_mobile` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_trade` (`trade_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `order_stock_recorder` */

DROP TABLE IF EXISTS `order_stock_recorder`;

CREATE TABLE `order_stock_recorder` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `item_id` bigint(20) DEFAULT NULL,
  `order_id` bigint(20) DEFAULT NULL,
  `status` int(11) DEFAULT '1',
  `date_created` datetime DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  `version` bigint(20) DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Table structure for table `out_excel_model` */

DROP TABLE IF EXISTS `out_excel_model`;

CREATE TABLE `out_excel_model` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) NOT NULL,
  `buye_mobile` varchar(255) DEFAULT NULL,
  `buyer_addr` varchar(255) DEFAULT NULL,
  `buyer_area` varchar(255) DEFAULT NULL,
  `buyer_city` varchar(255) DEFAULT NULL,
  `buyer_name` varchar(255) DEFAULT NULL,
  `buyer_province` varchar(255) DEFAULT NULL,
  `buyerid` varchar(255) DEFAULT NULL,
  `create_time` varchar(255) DEFAULT NULL,
  `data_json` varchar(255) DEFAULT NULL,
  `item_msg` varchar(255) DEFAULT NULL,
  `item_num` varchar(255) DEFAULT NULL,
  `item_one_price` varchar(255) DEFAULT NULL,
  `itemcode` varchar(255) DEFAULT NULL,
  `logistics_company` varchar(255) DEFAULT NULL,
  `logistics_wu_liu_code` varchar(255) DEFAULT NULL,
  `order_strs` varchar(255) DEFAULT NULL,
  `outtradeid` varchar(255) DEFAULT NULL,
  `tradeid` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `pmf_bill` */

DROP TABLE IF EXISTS `pmf_bill`;

CREATE TABLE `pmf_bill` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) DEFAULT NULL,
  `arrears` int(11) DEFAULT NULL,
  `building_id` bigint(20) DEFAULT NULL,
  `community_id` bigint(20) DEFAULT NULL,
  `trade_id` bigint(20) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `start_time` datetime DEFAULT NULL,
  `deadline` datetime DEFAULT NULL,
  `months` int(11) DEFAULT NULL,
  `has_penalty_fee` tinyint(4) DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  `penalty_fee` int(11) DEFAULT NULL,
  `remind_count` int(11) DEFAULT NULL,
  `trade_status` tinyint(4) DEFAULT NULL,
  `payment` bigint(20) DEFAULT NULL,
  `status` tinyint(11) DEFAULT NULL,
  `unit_price` bigint(20) DEFAULT NULL,
  `category_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `point_account` */

DROP TABLE IF EXISTS `point_account`;

CREATE TABLE `point_account` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL COMMENT '用户ID',
  `version` bigint(20) NOT NULL,
  `attributes` varchar(255) DEFAULT NULL COMMENT '账户属性',
  `available_balance` bigint(20) DEFAULT NULL COMMENT '可用余额',
  `frozen_balance` bigint(20) DEFAULT NULL COMMENT '冻结余额',
  `date_created` datetime NOT NULL,
  `last_updated` datetime NOT NULL,
  `status` tinyint(4) DEFAULT NULL COMMENT '账户状态',
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=50840 DEFAULT CHARSET=utf8mb4;

/*Table structure for table `point_record` */

DROP TABLE IF EXISTS `point_record`;

CREATE TABLE `point_record` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '积分流水ID',
  `version` bigint(20) DEFAULT NULL,
  `account_id` bigint(20) DEFAULT NULL COMMENT '账户ID',
  `action_id` bigint(20) DEFAULT NULL COMMENT '互动行为触发的积分改变',
  `user_id` bigint(20) DEFAULT NULL COMMENT '用户ID',
  `amount` bigint(20) DEFAULT NULL COMMENT '变更积分数量',
  `type` int(11) DEFAULT NULL COMMENT '变更类型',
  `from` int(11) DEFAULT NULL COMMENT '变更来源',
  `trade_id` bigint(20) DEFAULT NULL COMMENT '交易ID',
  `available_balance` bigint(20) DEFAULT NULL COMMENT '变更后余额',
  `memo` varchar(255) DEFAULT NULL COMMENT '变更备注',
  `attributes` varchar(2000) DEFAULT NULL COMMENT '变更属性',
  `date_created` datetime DEFAULT NULL COMMENT '记录创建时间',
  `last_updated` datetime DEFAULT NULL COMMENT '记录最后修改时间',
  PRIMARY KEY (`id`),
  KEY `idx_userId_type` (`user_id`,`type`)
) ENGINE=InnoDB AUTO_INCREMENT=261975 DEFAULT CHARSET=utf8mb4;

/*Table structure for table `pro_fit_get_pay` */

DROP TABLE IF EXISTS `pro_fit_get_pay`;

CREATE TABLE `pro_fit_get_pay` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) NOT NULL,
  `agency_id` bigint(20) DEFAULT NULL,
  `agency_level_name` varchar(255) DEFAULT NULL,
  `agency_mobile` varchar(255) DEFAULT NULL,
  `agency_nickname` varchar(255) DEFAULT NULL,
  `apply_date` datetime DEFAULT NULL,
  `clerker_id` bigint(20) DEFAULT NULL,
  `clerker_name` varchar(255) DEFAULT NULL,
  `clerker_user_name` varchar(255) DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `getpay_account` varchar(255) DEFAULT NULL,
  `getpay_fee` bigint(20) DEFAULT NULL,
  `getpay_type` bigint(20) DEFAULT NULL,
  `getpay_user_name` varchar(255) DEFAULT NULL,
  `last_upated` datetime DEFAULT NULL,
  `status` tinyint(4) NOT NULL,
  `trans_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `profile` */

DROP TABLE IF EXISTS `profile`;

CREATE TABLE `profile` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `birthday` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `identity_card` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `installed_app` tinyint(4) DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  `lemon_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `mobile` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `nickname` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `profile_pic` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `real_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `status` tinyint(4) DEFAULT NULL,
  `last_login_building` bigint(20) DEFAULT '-1',
  `diploma` tinyint(4) DEFAULT '0',
  `type` tinyint(4) DEFAULT '-1',
  `last_community` bigint(20) DEFAULT NULL,
  `is_agency` tinyint(4) DEFAULT NULL,
  `wx_qrcode_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '微信二维码',
  `Province` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `City` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `Corp` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `AreaCode` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `PostCode` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `em_user_name` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `em_user_pw` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_expert` tinyint(4) DEFAULT '0',
  `sex` tinyint(4) DEFAULT NULL,
  `age_group` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_mobile_status` (`mobile`,`status`),
  KEY `idx_mobile` (`mobile`)
) ENGINE=InnoDB AUTO_INCREMENT=79130 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `profile_coop` */

DROP TABLE IF EXISTS `profile_coop`;

CREATE TABLE `profile_coop` (
  `id` bigint(11) unsigned NOT NULL AUTO_INCREMENT,
  `openid` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nickname` varchar(512) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sex` varchar(16) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `city` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `headimgurl` varchar(512) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `privilege` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mobile` varchar(16) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `version` bigint(20) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `province` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `synchron` tinyint(11) DEFAULT '-1',
  `access_token` varchar(1024) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `expires_in` int(11) DEFAULT NULL,
  `refresh_token` varchar(1024) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `scope` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `union_id` varchar(512) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `subscribe_time` bigint(20) DEFAULT NULL,
  `subscribe` tinyint(1) DEFAULT NULL,
  `language` varchar(16) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` tinyint(4) DEFAULT NULL,
  `user_id` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_openid` (`openid`)
) ENGINE=InnoDB AUTO_INCREMENT=10842 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `profile_ext` */

DROP TABLE IF EXISTS `profile_ext`;

CREATE TABLE `profile_ext` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `login_time` datetime DEFAULT NULL,
  `device_id` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `os` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `plateform` varchar(16) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ip` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `os_version` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `profile_id` bigint(20) NOT NULL,
  `scale` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `use_times` bigint(20) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  `version` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `build_version` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_profileId` (`profile_id`)
) ENGINE=InnoDB AUTO_INCREMENT=15843 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `profile_temp` */

DROP TABLE IF EXISTS `profile_temp`;

CREATE TABLE `profile_temp` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `mobile` varchar(255) NOT NULL,
  `invite_id` bigint(20) DEFAULT '0',
  `pid` bigint(20) NOT NULL,
  `status` tinyint(4) DEFAULT '0',
  `date_created` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=603 DEFAULT CHARSET=utf8;

/*Table structure for table `profile_wechat` */

DROP TABLE IF EXISTS `profile_wechat`;

CREATE TABLE `profile_wechat` (
  `id` bigint(11) unsigned NOT NULL AUTO_INCREMENT,
  `openid` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nickname` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sex` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `city` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `headimgurl` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `privilege` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mobile` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `version` bigint(20) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `province` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `synchron` tinyint(11) DEFAULT '-1',
  `access_token` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `expires_in` int(11) DEFAULT NULL,
  `refresh_token` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `scope` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `union_id` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `subscribe_time` bigint(20) DEFAULT NULL,
  `subscribe` tinyint(1) DEFAULT NULL,
  `language` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_login_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_openid` (`openid`)
) ENGINE=InnoDB AUTO_INCREMENT=77209 DEFAULT CHARSET=utf8mb4;

/*Table structure for table `pur_price` */

DROP TABLE IF EXISTS `pur_price`;

CREATE TABLE `pur_price` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) NOT NULL,
  `date_created` datetime NOT NULL,
  `last_updated` datetime NOT NULL,
  `purchase_id` bigint(20) DEFAULT NULL,
  `spec_num` bigint(20) DEFAULT NULL,
  `status` tinyint(4) NOT NULL,
  `unit_price` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `purchase` */

DROP TABLE IF EXISTS `purchase`;

CREATE TABLE `purchase` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) NOT NULL,
  `category_name` varchar(255) DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `item_id` bigint(20) DEFAULT NULL,
  `last_updated` datetime NOT NULL,
  `memo` varchar(255) DEFAULT NULL,
  `number` varchar(255) DEFAULT NULL,
  `pictured` tinyint(4) NOT NULL,
  `price` bigint(20) DEFAULT NULL,
  `reference_price` bigint(20) DEFAULT NULL,
  `source` varchar(255) DEFAULT NULL,
  `spec_num` bigint(20) DEFAULT NULL,
  `specification` varchar(255) DEFAULT NULL,
  `status` tinyint(4) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `unit_price` bigint(20) DEFAULT NULL,
  `variation` tinyint(4) NOT NULL,
  `yesterday_price` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `qrtz_blob_triggers` */

DROP TABLE IF EXISTS `qrtz_blob_triggers`;

CREATE TABLE `qrtz_blob_triggers` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `TRIGGER_NAME` varchar(120) NOT NULL,
  `TRIGGER_GROUP` varchar(120) NOT NULL,
  `BLOB_DATA` blob,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  CONSTRAINT `qrtz_blob_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `qrtz_calendars` */

DROP TABLE IF EXISTS `qrtz_calendars`;

CREATE TABLE `qrtz_calendars` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `CALENDAR_NAME` varchar(120) NOT NULL,
  `CALENDAR` blob NOT NULL,
  PRIMARY KEY (`SCHED_NAME`,`CALENDAR_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `qrtz_cron_triggers` */

DROP TABLE IF EXISTS `qrtz_cron_triggers`;

CREATE TABLE `qrtz_cron_triggers` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `TRIGGER_NAME` varchar(120) NOT NULL,
  `TRIGGER_GROUP` varchar(120) NOT NULL,
  `CRON_EXPRESSION` varchar(120) NOT NULL,
  `TIME_ZONE_ID` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  CONSTRAINT `qrtz_cron_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `qrtz_fired_triggers` */

DROP TABLE IF EXISTS `qrtz_fired_triggers`;

CREATE TABLE `qrtz_fired_triggers` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `ENTRY_ID` varchar(95) NOT NULL,
  `TRIGGER_NAME` varchar(120) NOT NULL,
  `TRIGGER_GROUP` varchar(120) NOT NULL,
  `INSTANCE_NAME` varchar(120) NOT NULL,
  `FIRED_TIME` bigint(13) NOT NULL,
  `SCHED_TIME` bigint(13) NOT NULL,
  `PRIORITY` int(11) NOT NULL,
  `STATE` varchar(16) NOT NULL,
  `JOB_NAME` varchar(120) DEFAULT NULL,
  `JOB_GROUP` varchar(120) DEFAULT NULL,
  `IS_NONCONCURRENT` varchar(1) DEFAULT NULL,
  `REQUESTS_RECOVERY` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`SCHED_NAME`,`ENTRY_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `qrtz_job_details` */

DROP TABLE IF EXISTS `qrtz_job_details`;

CREATE TABLE `qrtz_job_details` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `JOB_NAME` varchar(120) NOT NULL,
  `JOB_GROUP` varchar(120) NOT NULL,
  `DESCRIPTION` varchar(250) DEFAULT NULL,
  `JOB_CLASS_NAME` varchar(250) NOT NULL,
  `IS_DURABLE` varchar(1) NOT NULL,
  `IS_NONCONCURRENT` varchar(1) NOT NULL,
  `IS_UPDATE_DATA` varchar(1) NOT NULL,
  `REQUESTS_RECOVERY` varchar(1) NOT NULL,
  `JOB_DATA` blob,
  PRIMARY KEY (`SCHED_NAME`,`JOB_NAME`,`JOB_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `qrtz_locks` */

DROP TABLE IF EXISTS `qrtz_locks`;

CREATE TABLE `qrtz_locks` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `LOCK_NAME` varchar(40) NOT NULL,
  PRIMARY KEY (`SCHED_NAME`,`LOCK_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `qrtz_paused_trigger_grps` */

DROP TABLE IF EXISTS `qrtz_paused_trigger_grps`;

CREATE TABLE `qrtz_paused_trigger_grps` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `TRIGGER_GROUP` varchar(120) NOT NULL,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `qrtz_scheduler_state` */

DROP TABLE IF EXISTS `qrtz_scheduler_state`;

CREATE TABLE `qrtz_scheduler_state` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `INSTANCE_NAME` varchar(120) NOT NULL,
  `LAST_CHECKIN_TIME` bigint(13) NOT NULL,
  `CHECKIN_INTERVAL` bigint(13) NOT NULL,
  PRIMARY KEY (`SCHED_NAME`,`INSTANCE_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `qrtz_simple_triggers` */

DROP TABLE IF EXISTS `qrtz_simple_triggers`;

CREATE TABLE `qrtz_simple_triggers` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `TRIGGER_NAME` varchar(120) NOT NULL,
  `TRIGGER_GROUP` varchar(120) NOT NULL,
  `REPEAT_COUNT` bigint(7) NOT NULL,
  `REPEAT_INTERVAL` bigint(12) NOT NULL,
  `TIMES_TRIGGERED` bigint(10) NOT NULL,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  CONSTRAINT `qrtz_simple_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `qrtz_simprop_triggers` */

DROP TABLE IF EXISTS `qrtz_simprop_triggers`;

CREATE TABLE `qrtz_simprop_triggers` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `TRIGGER_NAME` varchar(120) NOT NULL,
  `TRIGGER_GROUP` varchar(120) NOT NULL,
  `STR_PROP_1` varchar(512) DEFAULT NULL,
  `STR_PROP_2` varchar(512) DEFAULT NULL,
  `STR_PROP_3` varchar(512) DEFAULT NULL,
  `INT_PROP_1` int(11) DEFAULT NULL,
  `INT_PROP_2` int(11) DEFAULT NULL,
  `LONG_PROP_1` bigint(20) DEFAULT NULL,
  `LONG_PROP_2` bigint(20) DEFAULT NULL,
  `DEC_PROP_1` decimal(13,4) DEFAULT NULL,
  `DEC_PROP_2` decimal(13,4) DEFAULT NULL,
  `BOOL_PROP_1` varchar(1) DEFAULT NULL,
  `BOOL_PROP_2` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  CONSTRAINT `qrtz_simprop_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `qrtz_triggers` */

DROP TABLE IF EXISTS `qrtz_triggers`;

CREATE TABLE `qrtz_triggers` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `TRIGGER_NAME` varchar(120) NOT NULL,
  `TRIGGER_GROUP` varchar(120) NOT NULL,
  `JOB_NAME` varchar(120) NOT NULL,
  `JOB_GROUP` varchar(120) NOT NULL,
  `DESCRIPTION` varchar(250) DEFAULT NULL,
  `NEXT_FIRE_TIME` bigint(13) DEFAULT NULL,
  `PREV_FIRE_TIME` bigint(13) DEFAULT NULL,
  `PRIORITY` int(11) DEFAULT NULL,
  `TRIGGER_STATE` varchar(16) NOT NULL,
  `TRIGGER_TYPE` varchar(8) NOT NULL,
  `START_TIME` bigint(13) NOT NULL,
  `END_TIME` bigint(13) DEFAULT NULL,
  `CALENDAR_NAME` varchar(120) DEFAULT NULL,
  `MISFIRE_INSTR` smallint(2) DEFAULT NULL,
  `JOB_DATA` blob,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  KEY `SCHED_NAME` (`SCHED_NAME`,`JOB_NAME`,`JOB_GROUP`),
  CONSTRAINT `qrtz_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`) REFERENCES `qrtz_job_details` (`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `role` */

DROP TABLE IF EXISTS `role`;

CREATE TABLE `role` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `date_created` datetime NOT NULL,
  `last_updated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_8sewwnpamngi6b1dwaa88askk` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `role_permissions` */

DROP TABLE IF EXISTS `role_permissions`;

CREATE TABLE `role_permissions` (
  `role_id` bigint(20) DEFAULT NULL,
  `permissions_string` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  KEY `FK_d4atqq8ege1sij0316vh2mxfu` (`role_id`),
  CONSTRAINT `FK_d4atqq8ege1sij0316vh2mxfu` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `search_item` */

DROP TABLE IF EXISTS `search_item`;

CREATE TABLE `search_item` (
  `id` bigint(20) NOT NULL,
  `version` bigint(20) NOT NULL,
  `category1_id` bigint(20) DEFAULT NULL,
  `category2_id` bigint(20) DEFAULT NULL,
  `category_id` bigint(20) DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `last_updated` datetime NOT NULL,
  `online_end_time` bigint(20) DEFAULT NULL,
  `online_start_time` bigint(20) DEFAULT NULL,
  `price` bigint(20) DEFAULT NULL,
  `promotion_price` bigint(20) DEFAULT NULL,
  `rank` int(11) DEFAULT NULL,
  `sold_count` int(11) DEFAULT NULL,
  `status` tinyint(4) DEFAULT NULL,
  `tag_id` bigint(20) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `type` int(11) DEFAULT NULL,
  `shop_id` bigint(20) DEFAULT NULL,
  `features` varchar(2000) DEFAULT NULL,
  `item_last_updated` bigint(20) DEFAULT NULL,
  `item_date_created` bigint(20) DEFAULT NULL,
  `brand_id` bigint(20) DEFAULT NULL,
  `base_sold_quantity` int(11) DEFAULT NULL,
  `weight` int(11) DEFAULT NULL,
  `num` int(11) DEFAULT NULL,
  `brand_name` varchar(255) DEFAULT NULL,
  `isrefund` tinyint(4) DEFAULT NULL,
  `key_word` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `seller_profile` */

DROP TABLE IF EXISTS `seller_profile`;

CREATE TABLE `seller_profile` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `birthday` varchar(255) DEFAULT NULL,
  `community_id` bigint(20) DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `identity_card` varchar(255) DEFAULT NULL,
  `last_updated` datetime NOT NULL,
  `lemon_name` varchar(255) DEFAULT NULL,
  `mobile` varchar(255) NOT NULL,
  `nickname` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `profile_pic` varchar(255) DEFAULT NULL,
  `real_name` varchar(255) DEFAULT NULL,
  `shop_id` bigint(20) DEFAULT NULL,
  `status` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Table structure for table `seller_shop` */

DROP TABLE IF EXISTS `seller_shop`;

CREATE TABLE `seller_shop` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `community_id` bigint(20) DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `last_updated` datetime NOT NULL,
  `seller_id` bigint(20) DEFAULT NULL,
  `shop_id` bigint(20) DEFAULT NULL,
  `status` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Table structure for table `service_config` */

DROP TABLE IF EXISTS `service_config`;

CREATE TABLE `service_config` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `community_id` bigint(20) DEFAULT NULL,
  `service_id` tinyint(4) DEFAULT NULL,
  `service_name` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `community_pic` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `last_update` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `shop` */

DROP TABLE IF EXISTS `shop`;

CREATE TABLE `shop` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `shop_id` bigint(20) DEFAULT NULL,
  `city_id` bigint(20) DEFAULT NULL,
  `version` bigint(20) NOT NULL,
  `bulletin` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `last_updated` datetime NOT NULL,
  `pic_path` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `score_id` bigint(20) DEFAULT NULL,
  `seller_id` bigint(20) DEFAULT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `status` tinyint(4) DEFAULT NULL,
  `approve_status` tinyint(4) DEFAULT NULL,
  `promoted_status` tinyint(4) DEFAULT NULL,
  `product_count` int(11) DEFAULT NULL,
  `domain` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `key_biz` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `theme` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `service_clause` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `tfs_path` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `seller_type` tinyint(4) DEFAULT NULL,
  `alipay_account` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `type` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_city_shop` (`city_id`,`shop_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1039 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `shop_recommend` */

DROP TABLE IF EXISTS `shop_recommend`;

CREATE TABLE `shop_recommend` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) NOT NULL,
  `item_id` bigint(20) DEFAULT NULL,
  `shop_id` bigint(20) DEFAULT NULL,
  `status` tinyint(4) DEFAULT NULL,
  `category_id` bigint(20) DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `last_updated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_shopId_categoryId` (`shop_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `shop_score` */

DROP TABLE IF EXISTS `shop_score`;

CREATE TABLE `shop_score` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) NOT NULL,
  `deliver_score` bigint(20) DEFAULT NULL,
  `item_score` bigint(20) DEFAULT NULL,
  `service_score` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `snapshot` */

DROP TABLE IF EXISTS `snapshot`;

CREATE TABLE `snapshot` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `detail` varchar(20000) COLLATE utf8_unicode_ci DEFAULT NULL,
  `detail_path` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  `order_id` bigint(20) DEFAULT NULL,
  `trade_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9732 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `t_order` */

DROP TABLE IF EXISTS `t_order`;

CREATE TABLE `t_order` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `trade_id` bigint(20) DEFAULT NULL,
  `version` bigint(20) DEFAULT NULL,
  `adjust_fee` bigint(20) DEFAULT NULL,
  `artificial_id` bigint(20) DEFAULT NULL,
  `bind_oid` bigint(20) DEFAULT NULL,
  `buyer_id` bigint(20) DEFAULT NULL,
  `buyer_rate` tinyint(4) DEFAULT NULL,
  `category_id` bigint(20) DEFAULT NULL,
  `community_id` bigint(20) DEFAULT NULL,
  `consign_time` datetime DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `discount_fee` bigint(20) DEFAULT NULL,
  `end_time` datetime DEFAULT NULL,
  `invoice_no` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `is_oversold` tinyint(4) DEFAULT NULL,
  `is_service_order` tinyint(4) DEFAULT NULL,
  `item_meal_id` bigint(20) DEFAULT NULL,
  `item_meal_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  `logistics_company` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `num` int(11) DEFAULT '0',
  `order_from` tinyint(4) DEFAULT NULL,
  `outer_id` bigint(20) DEFAULT NULL,
  `outer_sku_id` bigint(20) DEFAULT NULL,
  `payment` bigint(20) DEFAULT NULL,
  `pic_url` varchar(2555) COLLATE utf8_unicode_ci DEFAULT NULL,
  `price` bigint(20) DEFAULT NULL,
  `refund_id` bigint(20) DEFAULT NULL,
  `refund_status` tinyint(4) DEFAULT NULL,
  `seller_id` bigint(20) DEFAULT NULL,
  `seller_rate` tinyint(4) DEFAULT NULL,
  `seller_type` tinyint(11) DEFAULT NULL,
  `shipping_type` int(11) DEFAULT NULL,
  `sku_id` bigint(20) DEFAULT NULL,
  `sku_properties_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `snapshot` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `snapshot_id` bigint(20) DEFAULT NULL,
  `status` tinyint(11) DEFAULT NULL,
  `store_code` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `timeout_action_time` datetime DEFAULT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `total_fee` bigint(20) DEFAULT NULL,
  `is_activity` tinyint(4) DEFAULT NULL COMMENT '是否活动商品订单',
  `profit_parameter` varchar(2000) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '商品分润参数',
  `item_cost_fee` bigint(20) DEFAULT NULL,
  `item_profit_fee` bigint(20) DEFAULT NULL,
  `item_share_fee` bigint(20) DEFAULT NULL,
  `return_status` tinyint(4) DEFAULT NULL COMMENT '退款状态(-1:删除;0:申请退货;1=退货中;2=退货完成)',
  `has_panic_tag` tinyint(4) DEFAULT NULL,
  `is_return_profit` tinyint(4) DEFAULT NULL,
  `topic_id` bigint(20) DEFAULT NULL,
  `topic_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `topic_parameter` varchar(1000) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_trade_id` (`trade_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10830 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `tag_item` */

DROP TABLE IF EXISTS `tag_item`;

CREATE TABLE `tag_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `date_created` datetime NOT NULL,
  `item_id` bigint(20) DEFAULT NULL,
  `last_updated` datetime NOT NULL,
  `show_status` tinyint(4) NOT NULL,
  `status` tinyint(4) NOT NULL,
  `tag_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `tags` */

DROP TABLE IF EXISTS `tags`;

CREATE TABLE `tags` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) DEFAULT NULL,
  `tag_id` varchar(255) DEFAULT NULL,
  `name` varchar(64) DEFAULT NULL,
  `kv` varchar(2000) DEFAULT NULL,
  `bit` bigint(64) DEFAULT NULL,
  `pic` varchar(255) DEFAULT NULL,
  `status` tinyint(4) DEFAULT NULL,
  `type` int(9) DEFAULT NULL,
  `weight` int(11) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_bit` (`bit`)
) ENGINE=InnoDB AUTO_INCREMENT=2035 DEFAULT CHARSET=utf8mb4;

/*Table structure for table `test_miku_user_agency` */

DROP TABLE IF EXISTS `test_miku_user_agency`;

CREATE TABLE `test_miku_user_agency` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) DEFAULT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `agency_level` bigint(20) DEFAULT NULL,
  `p_user_id` bigint(20) DEFAULT NULL,
  `p2_user_id` bigint(20) DEFAULT NULL,
  `p3_user_id` bigint(20) DEFAULT NULL,
  `p4_user_id` bigint(20) DEFAULT NULL,
  `p5_user_id` bigint(20) DEFAULT NULL,
  `is_parent` tinyint(4) DEFAULT NULL,
  `path` varchar(255) DEFAULT NULL,
  `is_validated` tinyint(4) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  `is_deleted` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=98801 DEFAULT CHARSET=utf8;

/*Table structure for table `test_profile` */

DROP TABLE IF EXISTS `test_profile`;

CREATE TABLE `test_profile` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `birthday` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `identity_card` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `installed_app` tinyint(4) DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  `lemon_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `mobile` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `nickname` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `password` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `profile_pic` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `real_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `status` tinyint(4) DEFAULT NULL,
  `last_login_building` bigint(20) DEFAULT '-1',
  `diploma` tinyint(4) DEFAULT '0',
  `type` tinyint(4) DEFAULT '-1',
  `last_community` bigint(20) DEFAULT NULL,
  `is_agency` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_mobile_status` (`mobile`,`status`),
  KEY `idx_mobile` (`mobile`)
) ENGINE=InnoDB AUTO_INCREMENT=123237 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `test_profile_wechat` */

DROP TABLE IF EXISTS `test_profile_wechat`;

CREATE TABLE `test_profile_wechat` (
  `id` bigint(11) unsigned NOT NULL AUTO_INCREMENT,
  `openid` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nickname` varchar(512) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sex` varchar(16) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `city` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `headimgurl` varchar(512) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `privilege` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mobile` varchar(16) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `version` bigint(20) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `province` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `synchron` tinyint(11) DEFAULT '-1',
  `access_token` varchar(1024) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `expires_in` int(11) DEFAULT NULL,
  `refresh_token` varchar(1024) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `scope` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `union_id` varchar(512) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `subscribe_time` bigint(20) DEFAULT NULL,
  `subscribe` tinyint(1) DEFAULT NULL,
  `language` varchar(16) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_login_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_openid` (`openid`)
) ENGINE=InnoDB AUTO_INCREMENT=123237 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `test_wechat_profile` */

DROP TABLE IF EXISTS `test_wechat_profile`;

CREATE TABLE `test_wechat_profile` (
  `id` bigint(11) unsigned NOT NULL AUTO_INCREMENT,
  `profile_id` bigint(20) DEFAULT NULL,
  `wechat_id` bigint(20) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  `status` tinyint(4) DEFAULT '1',
  `version` bigint(20) DEFAULT '1',
  `union_id` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_wechatid_profileid` (`profile_id`,`wechat_id`),
  KEY `idx_uid` (`union_id`)
) ENGINE=InnoDB AUTO_INCREMENT=123237 DEFAULT CHARSET=utf8mb4;

/*Table structure for table `trade` */

DROP TABLE IF EXISTS `trade`;

CREATE TABLE `trade` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) DEFAULT NULL,
  `adjust_fee` bigint(20) DEFAULT NULL,
  `alipay_no` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `alipay_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `alipay_warn_msg` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `arrive_cut_time` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `arrive_interval` int(11) DEFAULT NULL,
  `artificial_id` bigint(20) DEFAULT NULL,
  `async_modified` datetime DEFAULT NULL,
  `available_confirm_fee` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `building_id` bigint(20) DEFAULT NULL,
  `buyer_alipay_account` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `buyer_cod_fee` bigint(20) DEFAULT NULL,
  `buyer_memo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `buyer_message` varchar(512) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `buyer_obtain_point_fee` bigint(20) DEFAULT NULL,
  `buyer_rate` tinyint(4) DEFAULT '0',
  `can_rate` tinyint(4) DEFAULT NULL,
  `category_id` bigint(20) DEFAULT NULL,
  `cod_fee` bigint(20) DEFAULT NULL,
  `cod_status` tinyint(255) DEFAULT NULL,
  `community_id` bigint(20) DEFAULT NULL,
  `consign_interval` int(11) DEFAULT NULL,
  `courier` bigint(20) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `discount_fee` bigint(20) DEFAULT NULL,
  `e_ticket_ext` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `end_time` datetime DEFAULT NULL,
  `express_agency_fee` bigint(20) DEFAULT NULL,
  `has_buyer_message` tinyint(4) DEFAULT NULL,
  `has_post_fee` tinyint(4) DEFAULT NULL,
  `invoice_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `invoice_type` tinyint(4) DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  `mark_desc` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `num` int(11) DEFAULT NULL,
  `orders` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pay_time` datetime DEFAULT NULL,
  `pay_type` tinyint(4) DEFAULT NULL,
  `payment` bigint(20) DEFAULT NULL,
  `pic_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `point_fee` bigint(20) DEFAULT NULL,
  `post_fee` bigint(20) DEFAULT NULL,
  `price` bigint(20) DEFAULT NULL,
  `promotion` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `promotion_id` bigint(20) DEFAULT NULL,
  `real_point_fee` int(11) DEFAULT NULL,
  `received_payment` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `seller_can_rate` tinyint(4) DEFAULT NULL,
  `seller_cod_fee` bigint(20) DEFAULT NULL,
  `seller_id` bigint(20) DEFAULT NULL,
  `seller_mobile` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `seller_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `seller_phone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `seller_rate` tinyint(4) DEFAULT NULL,
  `seller_type` tinyint(4) DEFAULT NULL,
  `send_time` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `shipping_type` tinyint(4) DEFAULT NULL,
  `status` tinyint(4) DEFAULT NULL,
  `step_paid_fee` bigint(20) DEFAULT NULL,
  `step_trade_status` tinyint(4) DEFAULT NULL,
  `timeout_action_time` datetime DEFAULT NULL,
  `title` varchar(1024) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `total_fee` bigint(20) DEFAULT NULL,
  `trade_from` tinyint(4) DEFAULT NULL,
  `trade_memo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `trade_source` tinyint(4) DEFAULT NULL,
  `type` tinyint(4) DEFAULT NULL,
  `value_added_orders` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `zero_purchase` tinyint(4) DEFAULT NULL,
  `buyer_id` bigint(20) DEFAULT NULL,
  `appoint_delivery_time` datetime DEFAULT NULL,
  `consign_time` datetime DEFAULT NULL,
  `confirm_time` datetime DEFAULT NULL,
  `shop_id` bigint(20) DEFAULT NULL,
  `consignee_id` bigint(20) DEFAULT '-1',
  `trade_id` bigint(20) DEFAULT NULL,
  `is_profit` tinyint(4) DEFAULT NULL COMMENT '是否分润',
  `return_status` tinyint(4) DEFAULT '0',
  `crowdfund_id` bigint(20) DEFAULT NULL,
  `crowdfund_detail_id` bigint(20) DEFAULT NULL,
  `crowdfund_refund_status` tinyint(4) DEFAULT NULL,
  `period_num` int(11) DEFAULT NULL,
  `is_win` tinyint(4) DEFAULT '0',
  `has_return_goods` tinyint(4) DEFAULT NULL,
  `p_user_id` bigint(20) DEFAULT NULL,
  `full_cut_fee` bigint(20) DEFAULT NULL,
  `detect_report_id` bigint(20) DEFAULT NULL,
  `mine_sc_box_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_buyerId_status` (`buyer_id`,`status`),
  KEY `idx_timeout_status` (`timeout_action_time`,`status`),
  KEY `idx_buyerId` (`buyer_id`),
  KEY `idx_buyerId_time_create` (`buyer_id`,`date_created`),
  KEY `idx_trade_id` (`trade_id`),
  KEY `idx_status_date_created` (`status`,`date_created`),
  KEY `idx_status_last_updated` (`status`,`last_updated`)
) ENGINE=InnoDB AUTO_INCREMENT=6896 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `trade_courier` */

DROP TABLE IF EXISTS `trade_courier`;

CREATE TABLE `trade_courier` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) NOT NULL,
  `community_id` bigint(20) DEFAULT NULL,
  `confirm_time` datetime DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `employee_id` bigint(20) DEFAULT NULL,
  `end_time` datetime DEFAULT NULL,
  `last_updated` datetime NOT NULL,
  `status` tinyint(4) NOT NULL,
  `trade_created` datetime DEFAULT NULL,
  `trade_id` bigint(20) DEFAULT NULL,
  `type` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_community_id` (`community_id`),
  KEY `idx_employee_id` (`employee_id`),
  KEY `idx_trade_id` (`trade_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Table structure for table `trade_employee` */

DROP TABLE IF EXISTS `trade_employee`;

CREATE TABLE `trade_employee` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) NOT NULL,
  `date_created` datetime NOT NULL,
  `employee_id` bigint(20) DEFAULT NULL,
  `last_updated` datetime NOT NULL,
  `status` tinyint(4) NOT NULL,
  `trade_id` bigint(20) DEFAULT NULL,
  `type` tinyint(4) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4;

/*Table structure for table `trade_search` */

DROP TABLE IF EXISTS `trade_search`;

CREATE TABLE `trade_search` (
  `id` bigint(20) NOT NULL,
  `address` varchar(255) DEFAULT NULL,
  `buyer_id` bigint(20) DEFAULT NULL,
  `buyer_mobile` varchar(255) DEFAULT NULL,
  `buyer_name` varchar(255) DEFAULT NULL,
  `community_id` bigint(20) DEFAULT NULL,
  `consignee_id` bigint(20) DEFAULT NULL,
  `consignee_mobile` varchar(255) DEFAULT NULL,
  `consignee_name` varchar(255) DEFAULT NULL,
  `date_created` bigint(20) DEFAULT NULL,
  `pay_type` int(11) DEFAULT NULL,
  `shipping_type` int(11) DEFAULT NULL,
  `shop_id` bigint(20) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `total_fee` bigint(20) DEFAULT NULL,
  `type` int(11) DEFAULT NULL,
  `appoint_delivery_time` bigint(20) DEFAULT NULL,
  `latitude` double DEFAULT NULL,
  `longitude` double DEFAULT NULL,
  `daily_delivery_time` bigint(20) DEFAULT NULL,
  `lbs` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Table structure for table `trans_check` */

DROP TABLE IF EXISTS `trans_check`;

CREATE TABLE `trans_check` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `num` bigint(20) DEFAULT '0',
  `date_created` datetime DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

/*Table structure for table `use_promotion` */

DROP TABLE IF EXISTS `use_promotion`;

CREATE TABLE `use_promotion` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `trade_id` bigint(20) DEFAULT NULL,
  `type` int(20) DEFAULT NULL,
  `promotion_id` bigint(20) DEFAULT NULL,
  `version` bigint(20) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_trade` (`trade_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2913 DEFAULT CHARSET=utf8mb4;

/*Table structure for table `user_coupon` */

DROP TABLE IF EXISTS `user_coupon`;

CREATE TABLE `user_coupon` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `action_id` bigint(20) DEFAULT NULL COMMENT '互动行为触发领取优惠券',
  `user_id` bigint(20) DEFAULT NULL,
  `coupon_id` bigint(20) DEFAULT NULL COMMENT '优惠券Id',
  `coupon_type` int(11) DEFAULT NULL COMMENT '优惠券类型，15抵用，16满减',
  `pick_time` datetime DEFAULT NULL COMMENT '领取时间',
  `start_time` datetime DEFAULT NULL COMMENT '开始时间',
  `end_time` datetime DEFAULT NULL COMMENT '结束时间',
  `status` tinyint(4) DEFAULT NULL COMMENT '状态',
  `attributes` varchar(255) DEFAULT NULL COMMENT '属性',
  `version` bigint(20) DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_user_id_status` (`user_id`,`status`)
) ENGINE=InnoDB AUTO_INCREMENT=56712 DEFAULT CHARSET=utf8mb4;

/*Table structure for table `user_interaction_records` */

DROP TABLE IF EXISTS `user_interaction_records`;

CREATE TABLE `user_interaction_records` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '用户与平台互动活动记录ID',
  `user_id` bigint(20) NOT NULL COMMENT '用户ID',
  `type` int(11) DEFAULT NULL COMMENT '互动类型',
  `from` int(11) DEFAULT NULL COMMENT '互动来源',
  `value` int(11) DEFAULT NULL COMMENT '计数',
  `target_id` varchar(20) DEFAULT NULL COMMENT '互动目标ID（可能是订单也可能是商品等）',
  `destination` varchar(255) DEFAULT NULL COMMENT '互动出口ID',
  `status` tinyint(4) DEFAULT NULL COMMENT '记录状态',
  `version` bigint(20) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL COMMENT '记录创建时间',
  `last_updated` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_user_id_type_status` (`user_id`,`type`,`status`),
  KEY `idx_userId_type_targetId` (`user_id`,`type`,`target_id`),
  KEY `idx_date_created` (`date_created`)
) ENGINE=InnoDB AUTO_INCREMENT=689955 DEFAULT CHARSET=utf8mb4;

/*Table structure for table `user_property` */

DROP TABLE IF EXISTS `user_property`;

CREATE TABLE `user_property` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `community_id` bigint(20) DEFAULT NULL,
  `building_id` bigint(20) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `status` tinyint(4) DEFAULT NULL,
  `version` bigint(20) NOT NULL,
  `consignee_ids` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `value_added_order` */

DROP TABLE IF EXISTS `value_added_order`;

CREATE TABLE `value_added_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) NOT NULL,
  `buyer_id` bigint(20) NOT NULL,
  `community_id` bigint(20) NOT NULL,
  `item_order_id` bigint(20) NOT NULL,
  `num` int(11) NOT NULL,
  `payment` bigint(20) NOT NULL,
  `pic_path` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `price` bigint(20) NOT NULL,
  `refund_id` bigint(20) NOT NULL,
  `seller_id` bigint(20) NOT NULL,
  `seller_type` tinyint(4) NOT NULL,
  `service_id` bigint(20) NOT NULL,
  `snapshot` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `snapshot_id` bigint(20) NOT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `total_fee` bigint(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `wechat_profile` */

DROP TABLE IF EXISTS `wechat_profile`;

CREATE TABLE `wechat_profile` (
  `id` bigint(11) unsigned NOT NULL AUTO_INCREMENT,
  `profile_id` bigint(20) DEFAULT NULL,
  `wechat_id` bigint(20) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  `status` tinyint(4) DEFAULT '1',
  `version` bigint(20) DEFAULT '1',
  `union_id` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_wechatid_profileid` (`profile_id`,`wechat_id`),
  KEY `idx_uid` (`union_id`)
) ENGINE=InnoDB AUTO_INCREMENT=58523 DEFAULT CHARSET=utf8mb4;

/*Table structure for table `weixin_back` */

DROP TABLE IF EXISTS `weixin_back`;

CREATE TABLE `weixin_back` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `appid` varchar(32) DEFAULT NULL,
  `mch_id` varchar(32) DEFAULT NULL,
  `device_info` varchar(32) DEFAULT NULL,
  `nonce_str` varchar(32) DEFAULT NULL,
  `sign` varchar(32) DEFAULT NULL,
  `result_code` varchar(16) DEFAULT NULL,
  `err_code` varchar(32) DEFAULT NULL,
  `err_code_des` varchar(128) DEFAULT NULL,
  `openid` varchar(128) DEFAULT NULL,
  `is_subscribe` varchar(1) DEFAULT NULL,
  `trade_type` varchar(16) DEFAULT NULL,
  `bank_type` varchar(16) DEFAULT NULL,
  `total_fee` int(11) DEFAULT NULL,
  `fee_type` varchar(8) DEFAULT NULL,
  `cash_fee` int(11) DEFAULT NULL,
  `cash_fee_type` varchar(16) DEFAULT NULL,
  `coupon_fee` int(11) DEFAULT NULL,
  `coupon_count` int(11) DEFAULT NULL,
  `coupon_batch_id_n` varchar(20) DEFAULT NULL,
  `coupon_id_n` varchar(20) DEFAULT NULL,
  `coupon_fee_n` int(11) DEFAULT NULL,
  `transaction_id` varchar(32) DEFAULT NULL,
  `out_trade_no` varchar(32) DEFAULT NULL,
  `attach` varchar(128) DEFAULT NULL,
  `time_end` varchar(14) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  `return_code` varchar(16) DEFAULT NULL,
  `return_msg` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_out_trade_no` (`out_trade_no`)
) ENGINE=InnoDB AUTO_INCREMENT=30180 DEFAULT CHARSET=utf8mb4;

/* Function  structure for function  `getCidList` */

/*!50003 DROP FUNCTION IF EXISTS `getCidList` */;
DELIMITER $$

/*!50003 CREATE DEFINER=`unes`@`%` FUNCTION `getCidList`(mobileNum bigint) RETURNS text CHARSET utf8
BEGIN 
       DECLARE sTemp text; 
       DECLARE sTempChd text; 
       DECLARE userid bigint;
       DECLARE i int;

	   select id into userid from profile where mobile=mobileNum;
     
       SET sTemp = ''; 
       SET sTempChd =cast(userid as CHAR); 

	   SET i=0; 
     
       WHILE sTempChd is not null DO 
		 if i=0 then
           SET sTemp = concat(sTempChd);
		 else
           SET sTemp = concat(sTemp,',',sTempChd); 
         end if; 
		 SET i=i+1;

         SELECT group_concat(user_id) INTO sTempChd FROM miku_user_agency where FIND_IN_SET(p_user_id,sTempChd)>0; 

       END WHILE; 

       RETURN sTemp; 
END */$$
DELIMITER ;

/* Procedure structure for procedure `createCidListTemp` */

/*!50003 DROP PROCEDURE IF EXISTS  `createCidListTemp` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`unes`@`%` PROCEDURE `createCidListTemp`(userid bigint, ll bigint)
BEGIN
	declare b int default 0;
	DECLARE agencyid bigint;
	DECLARE agencys CURSOR FOR SELECT user_id FROM miku_user_agency where p_user_id=userid;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET b = 1;

	insert into miku_cid_tmp values (userid,ll);

	OPEN agencys;

	FETCH agencys INTO agencyid;	
    REPEAT
		insert into miku_cid_tmp values(agencyid,0);
		CALL createCidListTemp(agencyid,0);
		FETCH agencys INTO agencyid;
	UNTIL b=1 END REPEAT;

	CLOSE agencys;

END */$$
DELIMITER ;

/* Procedure structure for procedure `insertUserInteractionRecords` */

/*!50003 DROP PROCEDURE IF EXISTS  `insertUserInteractionRecords` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`unes`@`%` PROCEDURE `insertUserInteractionRecords`(IN `times` int,IN `userId` bigint)
BEGIN
	#Routine body goes here...
	declare num int; 
	set num=1; 
	while num < times do 
		INSERT into user_interaction_records(user_id, type, `status`, version, date_created, last_updated)
		VALUES(userId, 300002, 1, 1, NOW(), NOW()); 
		set num=num+1;
	end while;
END */$$
DELIMITER ;

/* Procedure structure for procedure `itemNumUpdate` */

/*!50003 DROP PROCEDURE IF EXISTS  `itemNumUpdate` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`unes`@`%` PROCEDURE `itemNumUpdate`(IN `id` bigint)
BEGIN
	#Routine body goes here...
	
  	select id,num from item where id = 7691 for update ;
  	Update item  set num=num-1 where id=7691 ;  
	Commit;
END */$$
DELIMITER ;

/* Procedure structure for procedure `miku_scan_codes` */

/*!50003 DROP PROCEDURE IF EXISTS  `miku_scan_codes` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`unes`@`%` PROCEDURE `miku_scan_codes`()
BEGIN  
	
	  
	  DECLARE v1 INT DEFAULT 1000000;
	  DECLARE v2 INT DEFAULT 16;
	  DECLARE s1 VARCHAR(1);
	  DECLARE s2 VARCHAR(16);
	  
 
	  WHILE v1 > 0 DO
		SET v2 = 16;
		SET s2 = '';
		
		WHILE v2 > 0 DO
			
			SET s1 = SUBSTRING('1234567890', FLOOR(RAND()*10)+1 ,1);
			SET s2 = CONCAT(s2,s1);
			
			SET v2 = v2 - 1;
		END WHILE;
		
		INSERT  INTO `miku_scan_codes`(`number`,`status`,`version`,`date_created`,`last_updated`) VALUES (s2,0,1,'2016-07-06 15:06:23','2016-07-06 15:06:23');
		
				
	    SET v1 = v1 - 1;
	  END WHILE;
	 
	
    END */$$
DELIMITER ;

/* Procedure structure for procedure `moveAgency` */

/*!50003 DROP PROCEDURE IF EXISTS  `moveAgency` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`unes`@`%` PROCEDURE `moveAgency`(mobileNum bigint)
    DETERMINISTIC
BEGIN
	DECLARE sTemp VARCHAR(1000); 
	DECLARE sTempChd VARCHAR(1000); 
    DECLARE userid bigint;
    DECLARE i int;

	select id into userid from profile where mobile=mobileNum;
     
    SET sTemp = ''; 
    SET sTempChd =cast(userid as CHAR); 

	SET i=0; 

	#create temp table
	CREATE TEMPORARY TABLE if not exists temp_cid_list (  
		cid bigint
	);
	truncate TABLE temp_cid_list;
	
     
    WHILE sTempChd is not null DO 

        SELECT group_concat(user_id) INTO sTempChd FROM miku_user_agency where FIND_IN_SET(p_user_id,sTempChd)>0; 

    END WHILE; 

END */$$
DELIMITER ;

/* Procedure structure for procedure `showCidList` */

/*!50003 DROP PROCEDURE IF EXISTS  `showCidList` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`unes`@`%` PROCEDURE `showCidList`(mobileNum bigint)
BEGIN
	DECLARE userid bigint;

	CREATE TEMPORARY TABLE IF NOT EXISTS cidList_tmp(id bigint,depth bigint);
	truncate TABLE cidList_tmp;

	select id into userid from profile where mobile=mobileNum;

	CALL createCidListTemp(userid,0);

	#select count(*) from cidList_tmp;

END */$$
DELIMITER ;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
