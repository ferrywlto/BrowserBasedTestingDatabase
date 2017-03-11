-- MySQL Administrator dump 1.4
--
-- ------------------------------------------------------
-- Server version	5.0.19-nt


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


--
-- Create schema we3_atdb
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ we3_atdb;
USE we3_atdb;

--
-- Table structure for table `we3_atdb`.`bandtype`
--

DROP TABLE IF EXISTS `bandtype`;
CREATE TABLE `bandtype` (
  `idBandType` int(10) unsigned NOT NULL auto_increment,
  `btName` varchar(20) NOT NULL,
  `btDesc` varchar(255) default NULL,
  PRIMARY KEY  (`idBandType`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `we3_atdb`.`bandtype`
--

/*!40000 ALTER TABLE `bandtype` DISABLE KEYS */;
INSERT INTO `bandtype` (`idBandType`,`btName`,`btDesc`) VALUES 
 (1,'GSM','GSM'),
 (2,'newBT','test'),
 (3,'asdasd','...'),
 (4,'.','.'),
 (5,'ertfyguhj',''),
 (6,'sfgsg',''),
 (7,'',''),
 (8,'',''),
 (9,'3G','Third generation network'),
 (10,'3G','Third generation network'),
 (11,'asdasd','');
/*!40000 ALTER TABLE `bandtype` ENABLE KEYS */;


--
-- Table structure for table `we3_atdb`.`category`
--

DROP TABLE IF EXISTS `category`;
CREATE TABLE `category` (
  `idCategory` int(10) unsigned NOT NULL auto_increment,
  `cName` varchar(50) NOT NULL,
  `cDesc` varchar(255) default NULL,
  PRIMARY KEY  (`idCategory`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `we3_atdb`.`category`
--

/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` (`idCategory`,`cName`,`cDesc`) VALUES 
 (1,'Main Menu','Main Menu'),
 (2,'Idle Screen','Idle Screen'),
 (3,'Camera','Camera'),
 (4,'Ringtone','Ringtone'),
 (5,'Connectivity','Connectivity'),
 (6,'Settings','Settings'),
 (7,'Phonebook','Phonebook'),
 (8,'Accessory','Accessory'),
 (9,'USB','USB'),
 (10,'Recent Calls','Recent Calls'),
 (11,'Multimedia','Multimedia'),
 (12,'Message','Message'),
 (13,'Internet','Internet'),
 (14,'Media Player','Media Player'),
 (15,'Game','Game');
/*!40000 ALTER TABLE `category` ENABLE KEYS */;


--
-- Table structure for table `we3_atdb`.`ms_csd_profile`
--

DROP TABLE IF EXISTS `ms_csd_profile`;
CREATE TABLE `ms_csd_profile` (
  `idMS_CSD_Profile` int(10) unsigned NOT NULL auto_increment,
  `mcpOperator` int(10) unsigned NOT NULL,
  `mcpName` varchar(50) default NULL,
  `mcpWAP_URL` varchar(100) default NULL,
  `mcpWAP_IP` varchar(20) default NULL,
  `mcpWAP_Port` varchar(10) default NULL,
  `mcpDialUp` varchar(10) default NULL,
  `mcpUsername` varchar(10) default NULL,
  `mcpPassword` varchar(10) default NULL,
  `mcpSpeed` varchar(10) default NULL,
  `mcpLineType` varchar(10) default NULL,
  PRIMARY KEY  (`idMS_CSD_Profile`),
  KEY `MS_CSD_Profile_FKIndex1` (`mcpOperator`),
  CONSTRAINT `ms_csd_profile_ibfk_1` FOREIGN KEY (`mcpOperator`) REFERENCES `operator` (`idOperator`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `we3_atdb`.`ms_csd_profile`
--

/*!40000 ALTER TABLE `ms_csd_profile` DISABLE KEYS */;
INSERT INTO `ms_csd_profile` (`idMS_CSD_Profile`,`mcpOperator`,`mcpName`,`mcpWAP_URL`,`mcpWAP_IP`,`mcpWAP_Port`,`mcpDialUp`,`mcpUsername`,`mcpPassword`,`mcpSpeed`,`mcpLineType`) VALUES 
 (1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `ms_csd_profile` ENABLE KEYS */;


--
-- Table structure for table `we3_atdb`.`ms_gprs_profile`
--

DROP TABLE IF EXISTS `ms_gprs_profile`;
CREATE TABLE `ms_gprs_profile` (
  `idMS_GPRS_Profile` int(10) unsigned NOT NULL auto_increment,
  `mgpOperator` int(10) unsigned NOT NULL,
  `mgpName` varchar(50) default NULL,
  `mgpWAP_URL` varchar(100) default NULL,
  `mgpWAP_IP` varchar(20) default NULL,
  `mgpWAP_Port` varchar(10) default NULL,
  `mgpDialUp` varchar(10) default NULL,
  `mgpAPN` varchar(50) default NULL,
  `mgpUsername` varchar(10) default NULL,
  `mgpPassword` varchar(10) default NULL,
  PRIMARY KEY  (`idMS_GPRS_Profile`),
  KEY `MS_GPRS_Profile_FKIndex1` (`mgpOperator`),
  CONSTRAINT `ms_gprs_profile_ibfk_1` FOREIGN KEY (`mgpOperator`) REFERENCES `operator` (`idOperator`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `we3_atdb`.`ms_gprs_profile`
--

/*!40000 ALTER TABLE `ms_gprs_profile` DISABLE KEYS */;
INSERT INTO `ms_gprs_profile` (`idMS_GPRS_Profile`,`mgpOperator`,`mgpName`,`mgpWAP_URL`,`mgpWAP_IP`,`mgpWAP_Port`,`mgpDialUp`,`mgpAPN`,`mgpUsername`,`mgpPassword`) VALUES 
 (1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `ms_gprs_profile` ENABLE KEYS */;


--
-- Table structure for table `we3_atdb`.`ms_mms_profile`
--

DROP TABLE IF EXISTS `ms_mms_profile`;
CREATE TABLE `ms_mms_profile` (
  `idMS_MMS_Profile` int(10) unsigned NOT NULL auto_increment,
  `mmpOperator` int(10) unsigned NOT NULL,
  `mmpName` varchar(50) default NULL,
  `mmpMMS_URL` varchar(100) default NULL,
  `mmpMMS_IP` varchar(20) default NULL,
  `mmpMMS_Port` varchar(10) default NULL,
  `mmpGPRS_APN` varchar(50) default NULL,
  `mmpUsername` varchar(10) default NULL,
  `mmpPassword` varchar(10) default NULL,
  `mmpMMS_ServerName` varchar(50) default NULL,
  PRIMARY KEY  (`idMS_MMS_Profile`),
  KEY `MS_MMS_Profile_FKIndex1` (`mmpOperator`),
  CONSTRAINT `ms_mms_profile_ibfk_1` FOREIGN KEY (`mmpOperator`) REFERENCES `operator` (`idOperator`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `we3_atdb`.`ms_mms_profile`
--

/*!40000 ALTER TABLE `ms_mms_profile` DISABLE KEYS */;
INSERT INTO `ms_mms_profile` (`idMS_MMS_Profile`,`mmpOperator`,`mmpName`,`mmpMMS_URL`,`mmpMMS_IP`,`mmpMMS_Port`,`mmpGPRS_APN`,`mmpUsername`,`mmpPassword`,`mmpMMS_ServerName`) VALUES 
 (1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `ms_mms_profile` ENABLE KEYS */;


--
-- Table structure for table `we3_atdb`.`operator`
--

DROP TABLE IF EXISTS `operator`;
CREATE TABLE `operator` (
  `idOperator` int(10) unsigned NOT NULL auto_increment,
  `oName` varchar(30) NOT NULL,
  `oMSMailbox` varchar(10) default NULL,
  `oSLMailbox` varchar(10) default NULL,
  PRIMARY KEY  (`idOperator`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `we3_atdb`.`operator`
--

/*!40000 ALTER TABLE `operator` DISABLE KEYS */;
INSERT INTO `operator` (`idOperator`,`oName`,`oMSMailbox`,`oSLMailbox`) VALUES 
 (1,'Orange','12345678','12345678');
/*!40000 ALTER TABLE `operator` ENABLE KEYS */;


--
-- Table structure for table `we3_atdb`.`pc_csd_profile`
--

DROP TABLE IF EXISTS `pc_csd_profile`;
CREATE TABLE `pc_csd_profile` (
  `idPC_CSD_Profile` int(10) unsigned NOT NULL auto_increment,
  `pcpOperator` int(10) unsigned NOT NULL,
  `pcpName` varchar(50) default NULL,
  `pcpDialUp` varchar(20) default NULL,
  `pcpRoaming` varchar(20) default NULL,
  `pcpUsername` varchar(10) default NULL,
  `pcpPassword` varchar(10) default NULL,
  PRIMARY KEY  (`idPC_CSD_Profile`),
  KEY `PC_CSD_Profile_FKIndex1` (`pcpOperator`),
  CONSTRAINT `pc_csd_profile_ibfk_1` FOREIGN KEY (`pcpOperator`) REFERENCES `operator` (`idOperator`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `we3_atdb`.`pc_csd_profile`
--

/*!40000 ALTER TABLE `pc_csd_profile` DISABLE KEYS */;
INSERT INTO `pc_csd_profile` (`idPC_CSD_Profile`,`pcpOperator`,`pcpName`,`pcpDialUp`,`pcpRoaming`,`pcpUsername`,`pcpPassword`) VALUES 
 (1,1,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `pc_csd_profile` ENABLE KEYS */;


--
-- Table structure for table `we3_atdb`.`pc_gprs_profile`
--

DROP TABLE IF EXISTS `pc_gprs_profile`;
CREATE TABLE `pc_gprs_profile` (
  `idPC_GPRS_Profile` int(10) unsigned NOT NULL auto_increment,
  `pgpOperator` int(10) unsigned NOT NULL,
  `pgpName` varchar(50) default NULL,
  `pgpTool` varchar(50) default NULL,
  `pgpGPRS_APN` varchar(50) default NULL,
  `pgpGPRS_Dialup` varchar(20) default NULL,
  `pgpUsername` varchar(10) default NULL,
  `pgpPassword` varchar(10) default NULL,
  `pgpHotline` varchar(20) default NULL,
  `pgpOperatorURL` varchar(100) default NULL,
  PRIMARY KEY  (`idPC_GPRS_Profile`),
  KEY `PC_GPRS_Profile_FKIndex1` (`pgpOperator`),
  CONSTRAINT `pc_gprs_profile_ibfk_1` FOREIGN KEY (`pgpOperator`) REFERENCES `operator` (`idOperator`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `we3_atdb`.`pc_gprs_profile`
--

/*!40000 ALTER TABLE `pc_gprs_profile` DISABLE KEYS */;
INSERT INTO `pc_gprs_profile` (`idPC_GPRS_Profile`,`pgpOperator`,`pgpName`,`pgpTool`,`pgpGPRS_APN`,`pgpGPRS_Dialup`,`pgpUsername`,`pgpPassword`,`pgpHotline`,`pgpOperatorURL`) VALUES 
 (1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `pc_gprs_profile` ENABLE KEYS */;


--
-- Table structure for table `we3_atdb`.`phone`
--

DROP TABLE IF EXISTS `phone`;
CREATE TABLE `phone` (
  `idPhone` int(10) unsigned NOT NULL auto_increment,
  `pHardwareNumber` varchar(10) NOT NULL,
  `pDesc` varchar(255) default NULL,
  PRIMARY KEY  (`idPhone`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `we3_atdb`.`phone`
--

/*!40000 ALTER TABLE `phone` DISABLE KEYS */;
INSERT INTO `phone` (`idPhone`,`pHardwareNumber`,`pDesc`) VALUES 
 (1,'T0001','T0001');
/*!40000 ALTER TABLE `phone` ENABLE KEYS */;


--
-- Table structure for table `we3_atdb`.`resulttype`
--

DROP TABLE IF EXISTS `resulttype`;
CREATE TABLE `resulttype` (
  `idResultType` int(10) unsigned NOT NULL auto_increment,
  `rtName` varchar(50) NOT NULL,
  `rtDesc` varchar(255) default NULL,
  PRIMARY KEY  (`idResultType`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `we3_atdb`.`resulttype`
--

/*!40000 ALTER TABLE `resulttype` DISABLE KEYS */;
INSERT INTO `resulttype` (`idResultType`,`rtName`,`rtDesc`) VALUES 
 (1,'Pass','Pass'),
 (2,'Fail','Fail'),
 (3,'Can Not Test','Can Not Test'),
 (4,'Not Yet Test','Not Yet Test');
/*!40000 ALTER TABLE `resulttype` ENABLE KEYS */;


--
-- Table structure for table `we3_atdb`.`severity`
--

DROP TABLE IF EXISTS `severity`;
CREATE TABLE `severity` (
  `idSeverity` int(10) unsigned NOT NULL auto_increment,
  `sName` varchar(20) NOT NULL,
  `sDesc` varchar(255) default NULL,
  PRIMARY KEY  (`idSeverity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `we3_atdb`.`severity`
--

/*!40000 ALTER TABLE `severity` DISABLE KEYS */;
INSERT INTO `severity` (`idSeverity`,`sName`,`sDesc`) VALUES 
 (1,'1','1'),
 (2,'2','2'),
 (3,'3','3'),
 (4,'4','4'),
 (5,'5','5');
/*!40000 ALTER TABLE `severity` ENABLE KEYS */;


--
-- Table structure for table `we3_atdb`.`simcard`
--

DROP TABLE IF EXISTS `simcard`;
CREATE TABLE `simcard` (
  `idSimCard` int(10) unsigned NOT NULL auto_increment,
  `scSIMType` int(10) unsigned NOT NULL,
  `scTrafficCharge` int(10) unsigned NOT NULL,
  `scMS_GPRS_Profile` int(10) unsigned NOT NULL,
  `scMS_MMS_Profile` int(10) unsigned NOT NULL,
  `scMS_CSD_Profile` int(10) unsigned NOT NULL,
  `scPC_GPRS_Profile` int(10) unsigned NOT NULL,
  `scPC_CSD_Profile` int(10) unsigned NOT NULL,
  `scOperator` int(10) unsigned NOT NULL,
  `scPhoneNum` varchar(20) NOT NULL,
  `scMobileFaxNum` varchar(20) default NULL,
  `scDataNum` varchar(20) default NULL,
  `scPIM` varchar(25) NOT NULL,
  `scStatus` varchar(20) NOT NULL,
  `scBarring` varchar(10) default NULL,
  `scPIN` varchar(10) NOT NULL,
  `scPUK` varchar(10) default NULL,
  `scPUK2` varchar(10) default NULL,
  `scFaxLinkNum` varchar(20) default NULL,
  `scConferenceCall` varchar(15) default NULL,
  `scDataRoamName` varchar(30) default NULL,
  `scVMailPass` varchar(10) default NULL,
  PRIMARY KEY  (`idSimCard`),
  KEY `SimCard_FKIndex1` (`scTrafficCharge`),
  KEY `SimCard_FKIndex2` (`scPC_CSD_Profile`),
  KEY `SimCard_FKIndex3` (`scPC_GPRS_Profile`),
  KEY `SimCard_FKIndex4` (`scMS_CSD_Profile`),
  KEY `SimCard_FKIndex5` (`scMS_MMS_Profile`),
  KEY `SimCard_FKIndex6` (`scMS_GPRS_Profile`),
  KEY `SimCard_FKIndex7` (`scOperator`),
  KEY `SimCard_FKIndex8` (`scSIMType`),
  CONSTRAINT `simcard_ibfk_1` FOREIGN KEY (`scOperator`) REFERENCES `operator` (`idOperator`) ON UPDATE CASCADE,
  CONSTRAINT `simcard_ibfk_2` FOREIGN KEY (`scTrafficCharge`) REFERENCES `trafficcharge` (`idTrafficCharge`) ON UPDATE CASCADE,
  CONSTRAINT `simcard_ibfk_3` FOREIGN KEY (`scPC_CSD_Profile`) REFERENCES `pc_csd_profile` (`idPC_CSD_Profile`) ON UPDATE CASCADE,
  CONSTRAINT `simcard_ibfk_4` FOREIGN KEY (`scPC_GPRS_Profile`) REFERENCES `pc_gprs_profile` (`idPC_GPRS_Profile`) ON UPDATE CASCADE,
  CONSTRAINT `simcard_ibfk_5` FOREIGN KEY (`scMS_CSD_Profile`) REFERENCES `ms_csd_profile` (`idMS_CSD_Profile`) ON UPDATE CASCADE,
  CONSTRAINT `simcard_ibfk_6` FOREIGN KEY (`scMS_MMS_Profile`) REFERENCES `ms_mms_profile` (`idMS_MMS_Profile`) ON UPDATE CASCADE,
  CONSTRAINT `simcard_ibfk_7` FOREIGN KEY (`scMS_GPRS_Profile`) REFERENCES `ms_gprs_profile` (`idMS_GPRS_Profile`) ON UPDATE CASCADE,
  CONSTRAINT `simcard_ibfk_8` FOREIGN KEY (`scSIMType`) REFERENCES `simtype` (`idSIMType`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `we3_atdb`.`simcard`
--

/*!40000 ALTER TABLE `simcard` DISABLE KEYS */;
INSERT INTO `simcard` (`idSimCard`,`scSIMType`,`scTrafficCharge`,`scMS_GPRS_Profile`,`scMS_MMS_Profile`,`scMS_CSD_Profile`,`scPC_GPRS_Profile`,`scPC_CSD_Profile`,`scOperator`,`scPhoneNum`,`scMobileFaxNum`,`scDataNum`,`scPIM`,`scStatus`,`scBarring`,`scPIN`,`scPUK`,`scPUK2`,`scFaxLinkNum`,`scConferenceCall`,`scDataRoamName`,`scVMailPass`) VALUES 
 (1,1,1,1,1,1,1,1,1,'12345678','12345678','12345678','12345678','Live','12356789','12345678','12345678','12345678','12345678','12345678','12345678','12345678');
/*!40000 ALTER TABLE `simcard` ENABLE KEYS */;


--
-- Table structure for table `we3_atdb`.`simtype`
--

DROP TABLE IF EXISTS `simtype`;
CREATE TABLE `simtype` (
  `idSIMType` int(10) unsigned NOT NULL auto_increment,
  `stBand` int(10) unsigned NOT NULL,
  `stGPRS` tinyint(1) NOT NULL,
  `stLiveCall` tinyint(1) NOT NULL,
  PRIMARY KEY  (`idSIMType`),
  KEY `SIMType_FKIndex1` (`stBand`),
  CONSTRAINT `simtype_ibfk_1` FOREIGN KEY (`stBand`) REFERENCES `bandtype` (`idBandType`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `we3_atdb`.`simtype`
--

/*!40000 ALTER TABLE `simtype` DISABLE KEYS */;
INSERT INTO `simtype` (`idSIMType`,`stBand`,`stGPRS`,`stLiveCall`) VALUES 
 (1,1,1,1);
/*!40000 ALTER TABLE `simtype` ENABLE KEYS */;


--
-- Table structure for table `we3_atdb`.`simtypeservicelink`
--

DROP TABLE IF EXISTS `simtypeservicelink`;
CREATE TABLE `simtypeservicelink` (
  `lnkType` int(10) unsigned NOT NULL,
  `lnkService` int(10) unsigned NOT NULL,
  PRIMARY KEY  (`lnkType`,`lnkService`),
  KEY `SIMTypeServiceLink_FKIndex1` (`lnkService`),
  KEY `SIMTypeServiceLink_FKIndex2` (`lnkType`),
  CONSTRAINT `simtypeservicelink_ibfk_1` FOREIGN KEY (`lnkService`) REFERENCES `supplementaryservice` (`idSupplementaryService`) ON UPDATE CASCADE,
  CONSTRAINT `simtypeservicelink_ibfk_2` FOREIGN KEY (`lnkType`) REFERENCES `simtype` (`idSIMType`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `we3_atdb`.`simtypeservicelink`
--

/*!40000 ALTER TABLE `simtypeservicelink` DISABLE KEYS */;
INSERT INTO `simtypeservicelink` (`lnkType`,`lnkService`) VALUES 
 (1,1);
/*!40000 ALTER TABLE `simtypeservicelink` ENABLE KEYS */;


--
-- Table structure for table `we3_atdb`.`softwareversion`
--

DROP TABLE IF EXISTS `softwareversion`;
CREATE TABLE `softwareversion` (
  `idSoftwareVersion` int(10) unsigned NOT NULL auto_increment,
  `svName` varchar(30) NOT NULL,
  `svDesc` text,
  PRIMARY KEY  (`idSoftwareVersion`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `we3_atdb`.`softwareversion`
--

/*!40000 ALTER TABLE `softwareversion` DISABLE KEYS */;
INSERT INTO `softwareversion` (`idSoftwareVersion`,`svName`,`svDesc`) VALUES 
 (1,'WE3220-V_01.01.06_R','WE3220-V_01.01.06_R'),
 (2,'WE3220-V_01.01.05_R','WE3220-V_01.01.05_R');
/*!40000 ALTER TABLE `softwareversion` ENABLE KEYS */;


--
-- Table structure for table `we3_atdb`.`subcategory`
--

DROP TABLE IF EXISTS `subcategory`;
CREATE TABLE `subcategory` (
  `idSubCategory` int(10) unsigned NOT NULL auto_increment,
  `scParentCategory` int(10) unsigned NOT NULL,
  `scName` varchar(50) NOT NULL,
  `scDesc` varchar(255) default NULL,
  PRIMARY KEY  (`idSubCategory`),
  KEY `SubCategory_FKIndex1` (`scParentCategory`),
  CONSTRAINT `subcategory_ibfk_1` FOREIGN KEY (`scParentCategory`) REFERENCES `category` (`idCategory`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `we3_atdb`.`subcategory`
--

/*!40000 ALTER TABLE `subcategory` DISABLE KEYS */;
INSERT INTO `subcategory` (`idSubCategory`,`scParentCategory`,`scName`,`scDesc`) VALUES 
 (1,15,'Auto Invocation Security Setting ','Auto Invocation Security Setting '),
 (2,15,'Install An Application','Install An Application'),
 (3,15,'Multimedia Recording Security Setting ','Multimedia Recording Security Setting '),
 (4,15,'Network Access Security Setting ','Network Access Security Setting '),
 (5,15,'OTA Download 3 games (reliability test)','OTA Download 3 games (reliability test)'),
 (6,15,'OTA Download Game','OTA Download Game'),
 (7,15,'OTA download maximun game','OTA download maximun game'),
 (8,15,'SMS Access Security Setting','SMS Access Security Setting'),
 (9,14,'Playback Function','Playback Function'),
 (10,14,'Playlist Function','Playlist Function'),
 (11,12,'Cell Broadcast','Cell Broadcast'),
 (12,12,'Draft','Draft'),
 (13,12,'Inbox','Inbox'),
 (14,12,'Info-Service','Info-Service'),
 (15,12,'Memory Status','Memory Status'),
 (16,12,'Message','Message'),
 (17,12,'New Message','New Message'),
 (18,12,'Outbox','Outbox');
INSERT INTO `subcategory` (`idSubCategory`,`scParentCategory`,`scName`,`scDesc`) VALUES 
 (19,12,'Setting','Setting'),
 (20,12,'Voice Mail','Voice Mail'),
 (21,12,'信息','信息'),
 (22,12,'信息 - 彩信','信息 - 彩信'),
 (23,12,'信息- 短信','信息- 短信'),
 (24,12,'信息- 小区广播','信息- 小区广播'),
 (25,13,'Internet','Internet'),
 (26,1,'Menu','Menu'),
 (27,7,'Phonebook','Phonebook'),
 (28,2,'★电话功能','★电话功能'),
 (29,2,'Applications','Applications'),
 (30,2,'Audio','Audio'),
 (31,2,'Call','Call'),
 (32,2,'CIT','CIT'),
 (33,2,'Idle Screen','Idle Screen'),
 (34,2,'Others','Others'),
 (35,2,'Startup','Startup'),
 (36,2,'TI Charger','TI Charger'),
 (37,2,'电话功能','电话功能'),
 (38,2,'电话本','电话本'),
 (39,8,'Alarm','Alarm'),
 (40,8,'Calculator','Calculator'),
 (41,8,'Calender','Calender'),
 (42,8,'Countdown Timer','Countdown Timer'),
 (43,8,'STK','STK'),
 (44,8,'Stopwatch','Stopwatch'),
 (45,8,'Voice Recording','Voice Recording'),
 (46,8,'WorldTime','WorldTime');
INSERT INTO `subcategory` (`idSubCategory`,`scParentCategory`,`scName`,`scDesc`) VALUES 
 (47,4,'Ringtone','Ringtone'),
 (48,14,'Media Player','Media Player'),
 (49,11,'Multimedia','Multimedia'),
 (50,6,'Auto Key Lock','Auto Key Lock'),
 (51,6,'Call Barring','Call Barring'),
 (52,6,'Call Divert','Call Divert'),
 (53,6,'Call Waiting','Call Waiting'),
 (54,6,'Display','Display'),
 (55,6,'Hide Phone Number','Hide Phone Number'),
 (56,6,'Keypad Backlight','Keypad Backlight'),
 (57,6,'Language, Input Method','Language, Input Method'),
 (58,6,'Network','Network'),
 (59,6,'Others','Others'),
 (60,6,'Restore','Restore'),
 (61,6,'Security','Security'),
 (62,6,'Time and Date','Time and Date'),
 (63,6,'Voice Mail','Voice Mail'),
 (64,5,'BT Settings','BT Settings'),
 (65,5,'Find Handsfree','Find Handsfree'),
 (66,5,'Find Me','Find Me'),
 (67,5,'My Devices','My Devices'),
 (68,5,'Power','Power'),
 (69,5,'Re-link','Re-link'),
 (70,3,'Camera','Camera'),
 (71,9,'USB','USB'),
 (72,10,'Recent Calls','Recent Calls');
/*!40000 ALTER TABLE `subcategory` ENABLE KEYS */;


--
-- Table structure for table `we3_atdb`.`supplementaryservice`
--

DROP TABLE IF EXISTS `supplementaryservice`;
CREATE TABLE `supplementaryservice` (
  `idSupplementaryService` int(10) unsigned NOT NULL auto_increment,
  `ssName` varchar(30) NOT NULL,
  `ssDesc` varchar(255) default NULL,
  PRIMARY KEY  (`idSupplementaryService`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `we3_atdb`.`supplementaryservice`
--

/*!40000 ALTER TABLE `supplementaryservice` DISABLE KEYS */;
INSERT INTO `supplementaryservice` (`idSupplementaryService`,`ssName`,`ssDesc`) VALUES 
 (1,'Roaming','Roaming');
/*!40000 ALTER TABLE `supplementaryservice` ENABLE KEYS */;


--
-- Table structure for table `we3_atdb`.`test`
--

DROP TABLE IF EXISTS `test`;
CREATE TABLE `test` (
  `idTest` varchar(20) NOT NULL,
  `tSoftwareVersion` int(10) unsigned NOT NULL,
  `tCreator` varchar(5) NOT NULL,
  `tDateStart` datetime default NULL,
  `tDateEnd` datetime default NULL,
  `tDesc` varchar(255) default NULL,
  PRIMARY KEY  (`idTest`),
  KEY `Test_FKIndex1` (`tCreator`),
  KEY `Test_FKIndex2` (`tSoftwareVersion`),
  CONSTRAINT `test_ibfk_1` FOREIGN KEY (`tCreator`) REFERENCES `testers` (`idTester`) ON UPDATE CASCADE,
  CONSTRAINT `test_ibfk_2` FOREIGN KEY (`tSoftwareVersion`) REFERENCES `softwareversion` (`idSoftwareVersion`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `we3_atdb`.`test`
--

/*!40000 ALTER TABLE `test` DISABLE KEYS */;
INSERT INTO `test` (`idTest`,`tSoftwareVersion`,`tCreator`,`tDateStart`,`tDateEnd`,`tDesc`) VALUES 
 ('T01',1,'TE001','2006-01-01 00:00:00','2006-01-10 00:00:00','First Test'),
 ('T02',2,'TE001','2006-02-01 00:00:00','2006-02-10 00:00:00','Second Test');
/*!40000 ALTER TABLE `test` ENABLE KEYS */;


--
-- Table structure for table `we3_atdb`.`testcase`
--

DROP TABLE IF EXISTS `testcase`;
CREATE TABLE `testcase` (
  `idTestCase` varchar(20) NOT NULL,
  `tcScript` varchar(20) default NULL,
  `tcCategory` int(10) unsigned NOT NULL,
  `tcTestType` int(10) unsigned NOT NULL,
  `tcDescription` text NOT NULL,
  `tcProcedure` text NOT NULL,
  `tcExpectResult` text NOT NULL,
  `tcSanity` tinyint(1) NOT NULL,
  `tcManTestCount` int(10) unsigned NOT NULL,
  PRIMARY KEY  (`idTestCase`),
  KEY `TestCase_FKIndex1` (`tcCategory`),
  KEY `TestCase_FKIndex2` (`tcTestType`),
  KEY `TestCase_FKIndex3` (`tcScript`),
  CONSTRAINT `testcase_ibfk_1` FOREIGN KEY (`tcCategory`) REFERENCES `subcategory` (`idSubCategory`) ON UPDATE CASCADE,
  CONSTRAINT `testcase_ibfk_2` FOREIGN KEY (`tcTestType`) REFERENCES `testtype` (`idTestType`) ON UPDATE CASCADE,
  CONSTRAINT `testcase_ibfk_3` FOREIGN KEY (`tcScript`) REFERENCES `testscript` (`idTestScript`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `we3_atdb`.`testcase`
--

/*!40000 ALTER TABLE `testcase` DISABLE KEYS */;
INSERT INTO `testcase` (`idTestCase`,`tcScript`,`tcCategory`,`tcTestType`,`tcDescription`,`tcProcedure`,`tcExpectResult`,`tcSanity`,`tcManTestCount`) VALUES 
 ('MS_228',NULL,16,1,'Send the SMS/EMS while low battery condition','At the low battery state 1. Send SMS/EMS','Far side receive the SMS/EMS',0,1),
 ('MS_229',NULL,16,1,'Send the MMS while low battery condition','At the low battery state 1. Send MMS','Far side receive the MMS',0,1),
 ('MS_230',NULL,16,1,'Receive the MMS while low battery condition','At the low battery state1. receive MMS','Success to receive MMS',0,1),
 ('MS_231',NULL,16,1,'Send the SMS/EMS while in call','In call condition1. send SMS/EMS','Far side receive the SMS/EMS',0,1),
 ('MS_232',NULL,16,1,'Receive the SMS/EMS while in call','In call condition1. receive SMS/EMS','Suceess to receive SMS/EMS',0,1),
 ('MS_233',NULL,16,1,'Send the MMS while in call','In call condition1. send MMS','Far  side receive the MMS',0,1),
 ('MS_234',NULL,16,1,'Receive the MMS while in call','In call condition1. receive MMS','Suceess to receive MMS',0,1),
 ('MS_235',NULL,16,1,'Send the SMS/EMS while enable the alert mode','In alert mode1. send SMS/EMS','Far side receive the SMS/EMS',0,1);
INSERT INTO `testcase` (`idTestCase`,`tcScript`,`tcCategory`,`tcTestType`,`tcDescription`,`tcProcedure`,`tcExpectResult`,`tcSanity`,`tcManTestCount`) VALUES 
 ('MS_236',NULL,16,1,'Receive the SMS/EMS while enablethe alert mode','In alert mode1. receive SMS/EMS','Suceess to receive SMS/EMS',0,1),
 ('MS_237',NULL,16,1,'Send the MMS while enable the alert mode','In alert mode1. send MMS','Far side receive the MMS',0,1),
 ('MS_238',NULL,16,1,'Receive the MMS while enable thealert mode','In alert mode1. receive MMS','Suceess to receive MMS',0,1),
 ('MS_239',NULL,16,1,'Send the SMS/EMS while plug in USB at modem mode','While plug in the USB1. send SMS/EMS','Far side receive the SMS/EMS',0,1),
 ('MS_240',NULL,16,1,'Receive the SMS/EMS while plug in USB at modem mode','While plug in the USB1. receive SMS/EMS','Success to receive SMS/EMS',0,1),
 ('MS_241',NULL,16,1,'Send the MMS while plug in USB at modem mode','While plug in the USB1. send MMS','Far side receive the MMS',0,1),
 ('MS_242',NULL,16,1,'Receive the MMS while plug in USB at modem mode','While plug in the USB1. receive MMS','Success to receive MMS',0,1),
 ('MS_243',NULL,16,1,'Send the SMS/EMS while plug in USB at flash mode','While plug in the USB1. send SMS/EMS','Far side receive the SMS/EMS',0,1);
INSERT INTO `testcase` (`idTestCase`,`tcScript`,`tcCategory`,`tcTestType`,`tcDescription`,`tcProcedure`,`tcExpectResult`,`tcSanity`,`tcManTestCount`) VALUES 
 ('MS_244',NULL,16,1,'Receive the SMS/EMS while plug in USB at flash mode','While plug in the USB1. receive SMS/EMS','Success to receive SMS/EMS',0,1),
 ('MS_245',NULL,16,1,'Send the MMS while plug in USB at flash mode','While plug in the USB1. send MMS','Far side receive the MMS',0,1),
 ('MS_246',NULL,16,1,'Receive the MMS while plug in USB at flash mode','While plug in the USB1. receive MMS','Success to receive MMS',0,1),
 ('MS_247',NULL,16,2,'send SMS which contain 765 characters','send SMS which contain 765 characters','Far side receive the SMS',0,1),
 ('MS_248',NULL,16,2,'receive SMS which contain 765 characters','receive SMS which contain 765 characters','Suceess to receive SMS',0,1),
 ('MS_249',NULL,16,2,'send the MMS with picture,sound,text','send the MMS with picture,sound,text','Far side receive the MMS and get the picture,sound and text',0,1),
 ('MS_250',NULL,16,2,'receive the MMS with picture,sound,text','receive the MMS with picture,sound,text','Suceess to receive MMS get the picture,sound and text',0,1);
INSERT INTO `testcase` (`idTestCase`,`tcScript`,`tcCategory`,`tcTestType`,`tcDescription`,`tcProcedure`,`tcExpectResult`,`tcSanity`,`tcManTestCount`) VALUES 
 ('MS_254',NULL,16,2,'Send MMS which contain 10 or more than 10 slides','Send MMS which contain 10 or more than 10 slides and each slide contain one picture','Success to send MMS',0,1);
/*!40000 ALTER TABLE `testcase` ENABLE KEYS */;


--
-- Table structure for table `we3_atdb`.`testers`
--

DROP TABLE IF EXISTS `testers`;
CREATE TABLE `testers` (
  `idTester` varchar(5) NOT NULL,
  `tName` varchar(50) NOT NULL,
  `tDesc` varchar(255) default NULL,
  `tPassword` varchar(10) NOT NULL,
  PRIMARY KEY  (`idTester`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `we3_atdb`.`testers`
--

/*!40000 ALTER TABLE `testers` DISABLE KEYS */;
INSERT INTO `testers` (`idTester`,`tName`,`tDesc`,`tPassword`) VALUES 
 ('TE001','Ferry Clone 2','Seed Ferry2','x'),
 ('TE009','我是一個大蘋果','哈哈哈, 測試中...','xxx'),
 ('WE001','WE001','yyyyyyy','x'),
 ('WE008','asdasd','assad','asdas');
/*!40000 ALTER TABLE `testers` ENABLE KEYS */;


--
-- Table structure for table `we3_atdb`.`testrecords`
--

DROP TABLE IF EXISTS `testrecords`;
CREATE TABLE `testrecords` (
  `trTestCaseID` varchar(20) NOT NULL,
  `trTestID` varchar(20) NOT NULL,
  `trPhone` int(10) unsigned NOT NULL,
  `trSeverity` int(10) unsigned NOT NULL,
  `trSimCard` int(10) unsigned NOT NULL,
  `trTester` varchar(5) NOT NULL,
  `trResultType` int(10) unsigned NOT NULL,
  `trComment` text,
  `trDDTS` varchar(20) default NULL,
  `trTimeUsed` int(10) unsigned default NULL,
  `trSuccCount` int(10) unsigned default NULL,
  PRIMARY KEY  (`trTestCaseID`,`trTestID`),
  KEY `TestRecords_FKIndex1` (`trTestID`),
  KEY `TestRecords_FKIndex2` (`trTestCaseID`),
  KEY `TestRecords_FKIndex3` (`trResultType`),
  KEY `TestRecords_FKIndex4` (`trTester`),
  KEY `TestRecords_FKIndex5` (`trSimCard`),
  KEY `TestRecords_FKIndex6` (`trSeverity`),
  KEY `TestRecords_FKIndex7` (`trPhone`),
  CONSTRAINT `testrecords_ibfk_1` FOREIGN KEY (`trTestID`) REFERENCES `test` (`idTest`) ON UPDATE CASCADE,
  CONSTRAINT `testrecords_ibfk_2` FOREIGN KEY (`trTestCaseID`) REFERENCES `testcase` (`idTestCase`) ON UPDATE CASCADE,
  CONSTRAINT `testrecords_ibfk_3` FOREIGN KEY (`trResultType`) REFERENCES `resulttype` (`idResultType`) ON UPDATE CASCADE,
  CONSTRAINT `testrecords_ibfk_4` FOREIGN KEY (`trTester`) REFERENCES `testers` (`idTester`) ON UPDATE CASCADE,
  CONSTRAINT `testrecords_ibfk_5` FOREIGN KEY (`trSimCard`) REFERENCES `simcard` (`idSimCard`) ON UPDATE CASCADE,
  CONSTRAINT `testrecords_ibfk_6` FOREIGN KEY (`trSeverity`) REFERENCES `severity` (`idSeverity`) ON UPDATE CASCADE,
  CONSTRAINT `testrecords_ibfk_7` FOREIGN KEY (`trPhone`) REFERENCES `phone` (`idPhone`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `we3_atdb`.`testrecords`
--

/*!40000 ALTER TABLE `testrecords` DISABLE KEYS */;
INSERT INTO `testrecords` (`trTestCaseID`,`trTestID`,`trPhone`,`trSeverity`,`trSimCard`,`trTester`,`trResultType`,`trComment`,`trDDTS`,`trTimeUsed`,`trSuccCount`) VALUES 
 ('MS_228','T01',1,1,1,'TE001',1,NULL,NULL,NULL,NULL),
 ('MS_228','T02',1,1,1,'TE001',1,NULL,NULL,NULL,NULL),
 ('MS_229','T01',1,1,1,'TE001',1,NULL,NULL,NULL,NULL),
 ('MS_229','T02',1,1,1,'TE001',1,NULL,NULL,NULL,NULL),
 ('MS_230','T01',1,1,1,'TE001',1,NULL,NULL,NULL,NULL),
 ('MS_230','T02',1,1,1,'TE001',1,NULL,NULL,NULL,NULL),
 ('MS_231','T01',1,1,1,'TE001',1,NULL,NULL,NULL,NULL),
 ('MS_231','T02',1,1,1,'TE001',2,NULL,NULL,NULL,NULL),
 ('MS_232','T01',1,1,1,'TE001',1,NULL,NULL,NULL,NULL),
 ('MS_232','T02',1,1,1,'TE001',2,NULL,NULL,NULL,NULL),
 ('MS_233','T01',1,1,1,'TE001',2,NULL,NULL,NULL,NULL),
 ('MS_233','T02',1,1,1,'TE001',1,NULL,NULL,NULL,NULL),
 ('MS_234','T01',1,1,1,'TE001',2,NULL,NULL,NULL,NULL),
 ('MS_234','T02',1,1,1,'TE001',1,NULL,NULL,NULL,NULL),
 ('MS_235','T01',1,1,1,'TE001',1,NULL,NULL,NULL,NULL),
 ('MS_235','T02',1,1,1,'TE001',2,NULL,NULL,NULL,NULL),
 ('MS_236','T01',1,1,1,'TE001',2,NULL,NULL,NULL,NULL);
INSERT INTO `testrecords` (`trTestCaseID`,`trTestID`,`trPhone`,`trSeverity`,`trSimCard`,`trTester`,`trResultType`,`trComment`,`trDDTS`,`trTimeUsed`,`trSuccCount`) VALUES 
 ('MS_236','T02',1,1,1,'TE001',1,NULL,NULL,NULL,NULL),
 ('MS_237','T01',1,1,1,'TE001',1,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `testrecords` ENABLE KEYS */;


--
-- Table structure for table `we3_atdb`.`testscript`
--

DROP TABLE IF EXISTS `testscript`;
CREATE TABLE `testscript` (
  `idTestScript` varchar(20) NOT NULL,
  `tsVaildator` varchar(5) NOT NULL,
  `tsSubmitter` varchar(5) NOT NULL,
  `tsFilePath` varchar(255) NOT NULL,
  `tsSubmitDate` datetime NOT NULL,
  PRIMARY KEY  (`idTestScript`),
  KEY `TestScript_FKIndex1` (`tsSubmitter`),
  KEY `TestScript_FKIndex2` (`tsVaildator`),
  CONSTRAINT `testscript_ibfk_1` FOREIGN KEY (`tsSubmitter`) REFERENCES `testers` (`idTester`) ON UPDATE CASCADE,
  CONSTRAINT `testscript_ibfk_2` FOREIGN KEY (`tsVaildator`) REFERENCES `testers` (`idTester`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `we3_atdb`.`testscript`
--

/*!40000 ALTER TABLE `testscript` DISABLE KEYS */;
/*!40000 ALTER TABLE `testscript` ENABLE KEYS */;


--
-- Table structure for table `we3_atdb`.`testtype`
--

DROP TABLE IF EXISTS `testtype`;
CREATE TABLE `testtype` (
  `idTestType` int(10) unsigned NOT NULL auto_increment,
  `ttName` varchar(20) NOT NULL,
  `ttDesc` varchar(255) default NULL,
  PRIMARY KEY  (`idTestType`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `we3_atdb`.`testtype`
--

/*!40000 ALTER TABLE `testtype` DISABLE KEYS */;
INSERT INTO `testtype` (`idTestType`,`ttName`,`ttDesc`) VALUES 
 (1,'Interactive','Interactive'),
 (2,'Boundary','Boundary'),
 (3,'Funcational','Funcational'),
 (4,'Issue','Issue');
/*!40000 ALTER TABLE `testtype` ENABLE KEYS */;


--
-- Table structure for table `we3_atdb`.`trafficcharge`
--

DROP TABLE IF EXISTS `trafficcharge`;
CREATE TABLE `trafficcharge` (
  `idTrafficCharge` int(10) unsigned NOT NULL auto_increment,
  `tcOperator` int(10) unsigned NOT NULL,
  `tcName` varchar(50) default NULL,
  `tcVoice` varchar(50) default NULL,
  `tcDataFax` varchar(50) default NULL,
  `tcGPRS` varchar(50) default NULL,
  `tcSMS` varchar(50) default NULL,
  `tcMMS` varchar(50) default NULL,
  `tcConferenceCall` varchar(50) default NULL,
  `tcPushSMS` varchar(50) default NULL,
  PRIMARY KEY  (`idTrafficCharge`),
  KEY `TrafficCharge_FKIndex1` (`tcOperator`),
  CONSTRAINT `trafficcharge_ibfk_1` FOREIGN KEY (`tcOperator`) REFERENCES `operator` (`idOperator`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `we3_atdb`.`trafficcharge`
--

/*!40000 ALTER TABLE `trafficcharge` DISABLE KEYS */;
INSERT INTO `trafficcharge` (`idTrafficCharge`,`tcOperator`,`tcName`,`tcVoice`,`tcDataFax`,`tcGPRS`,`tcSMS`,`tcMMS`,`tcConferenceCall`,`tcPushSMS`) VALUES 
 (1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `trafficcharge` ENABLE KEYS */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
