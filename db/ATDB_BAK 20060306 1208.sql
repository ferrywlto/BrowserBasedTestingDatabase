-- MySQL Administrator dump 1.4
--
-- ------------------------------------------------------
-- Server version	5.0.18-debug


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
 (4,'GSM','GSM'),
 (5,'GSM','GSM'),
 (6,'3G','3rd Generation Network'),
 (7,'3G','3rd Generation Network');
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
 (1,'cName','cDesc');
/*!40000 ALTER TABLE `category` ENABLE KEYS */;


--
-- Table structure for table `we3_atdb`.`ms_csd_profile`
--

DROP TABLE IF EXISTS `ms_csd_profile`;
CREATE TABLE `ms_csd_profile` (
  `idMS_CSD_Profile` int(10) unsigned NOT NULL auto_increment,
  `mcpOperator` int(10) unsigned NOT NULL,
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
/*!40000 ALTER TABLE `ms_csd_profile` ENABLE KEYS */;


--
-- Table structure for table `we3_atdb`.`ms_gprs_profile`
--

DROP TABLE IF EXISTS `ms_gprs_profile`;
CREATE TABLE `ms_gprs_profile` (
  `idMS_GPRS_Profile` int(10) unsigned NOT NULL auto_increment,
  `mgpOperator` int(10) unsigned NOT NULL,
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
/*!40000 ALTER TABLE `ms_gprs_profile` ENABLE KEYS */;


--
-- Table structure for table `we3_atdb`.`ms_mms_profile`
--

DROP TABLE IF EXISTS `ms_mms_profile`;
CREATE TABLE `ms_mms_profile` (
  `idMS_MMS_Profile` int(10) unsigned NOT NULL auto_increment,
  `mmpOperator` int(10) unsigned NOT NULL,
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
 (1,'oName','oMSMailbox','oSMMailbox');
/*!40000 ALTER TABLE `operator` ENABLE KEYS */;


--
-- Table structure for table `we3_atdb`.`pc_csd_profile`
--

DROP TABLE IF EXISTS `pc_csd_profile`;
CREATE TABLE `pc_csd_profile` (
  `idPC_CSD_Profile` int(10) unsigned NOT NULL auto_increment,
  `pcpOperator` int(10) unsigned NOT NULL,
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
/*!40000 ALTER TABLE `pc_csd_profile` ENABLE KEYS */;


--
-- Table structure for table `we3_atdb`.`pc_gprs_profile`
--

DROP TABLE IF EXISTS `pc_gprs_profile`;
CREATE TABLE `pc_gprs_profile` (
  `idPC_GPRS_Profile` int(10) unsigned NOT NULL auto_increment,
  `pgpOperator` int(10) unsigned NOT NULL,
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
 (1,'rtName','rtDesc');
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
 (1,'sName','sDesc');
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
/*!40000 ALTER TABLE `simtypeservicelink` ENABLE KEYS */;


--
-- Table structure for table `we3_atdb`.`softwareversion`
--

DROP TABLE IF EXISTS `softwareversion`;
CREATE TABLE `softwareversion` (
  `idSoftwareVersion` int(10) unsigned NOT NULL auto_increment,
  `svName` varchar(30) NOT NULL,
  `scDesc` text NOT NULL,
  PRIMARY KEY  (`idSoftwareVersion`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 PACK_KEYS=1;

--
-- Dumping data for table `we3_atdb`.`softwareversion`
--

/*!40000 ALTER TABLE `softwareversion` DISABLE KEYS */;
INSERT INTO `softwareversion` (`idSoftwareVersion`,`svName`,`scDesc`) VALUES 
 (1,'svName','svDesc');
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
 (1,'ssName','ssDesc');
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
 ('TE001','tmp','tmp','tmp'),
 ('TE003','Ferry To','Whole Year Placement Student','ferryto'),
 ('TE004','temp','temp','temp'),
 ('TE005','Ferry To','Whole Year Placement Student','ferryto');
/*!40000 ALTER TABLE `testers` ENABLE KEYS */;


--
-- Table structure for table `we3_atdb`.`testrecords`
--

DROP TABLE IF EXISTS `testrecords`;
CREATE TABLE `testrecords` (
  `trTestCaseID` varchar(255) NOT NULL,
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
 (1,'ttName','ttDesc');
/*!40000 ALTER TABLE `testtype` ENABLE KEYS */;


--
-- Table structure for table `we3_atdb`.`trafficcharge`
--

DROP TABLE IF EXISTS `trafficcharge`;
CREATE TABLE `trafficcharge` (
  `idTrafficCharge` int(10) unsigned NOT NULL auto_increment,
  `tcOperator` int(10) unsigned NOT NULL,
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
/*!40000 ALTER TABLE `trafficcharge` ENABLE KEYS */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
