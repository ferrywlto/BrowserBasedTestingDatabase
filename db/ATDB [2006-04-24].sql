CREATE TABLE RecordLock (
  idRecordLock VARCHAR(20) NOT NULL,
  rlTable VARCHAR(20) NOT NULL,
  rlTester VARCHAR(5) NOT NULL,
  rlDate DATETIME NOT NULL,
  PRIMARY KEY(idRecordLock, rlTable)
);

CREATE TABLE Phone (
  idPhone INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  pHardwareNumber VARCHAR(10) NOT NULL,
  pDesc VARCHAR(255) NULL,
  PRIMARY KEY(idPhone)
);

CREATE TABLE SupplementaryService (
  idSupplementaryService INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  ssName VARCHAR(30) NOT NULL,
  ssDesc VARCHAR(255) NULL,
  PRIMARY KEY(idSupplementaryService)
);

CREATE TABLE SoftwareVersion (
  idSoftwareVersion INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  svName VARCHAR(30) NOT NULL,
  svDesc TEXT NULL,
  PRIMARY KEY(idSoftwareVersion)
);

CREATE TABLE Severity (
  idSeverity INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  sName VARCHAR(20) NOT NULL,
  sDesc VARCHAR(255) NULL,
  PRIMARY KEY(idSeverity)
);

CREATE TABLE ResultType (
  idResultType INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  rtName VARCHAR(50) NOT NULL,
  rtDesc VARCHAR(255) NULL,
  PRIMARY KEY(idResultType)
);

CREATE TABLE Testers (
  idTester VARCHAR(5) NOT NULL,
  tName VARCHAR(50) NOT NULL,
  tDesc VARCHAR(255) NULL,
  tPassword VARCHAR(10) NOT NULL,
  PRIMARY KEY(idTester)
);

CREATE TABLE BandType (
  idBandType INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  btName VARCHAR(20) NOT NULL,
  btDesc VARCHAR(255) NULL,
  PRIMARY KEY(idBandType)
);

CREATE TABLE Category (
  idCategory INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  cName VARCHAR(50) NOT NULL,
  cDesc VARCHAR(255) NULL,
  PRIMARY KEY(idCategory)
);

CREATE TABLE TestType (
  idTestType INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  ttName VARCHAR(20) NOT NULL,
  ttDesc VARCHAR(255) NULL,
  PRIMARY KEY(idTestType)
);

CREATE TABLE Operator (
  idOperator INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  oName VARCHAR(30) NOT NULL,
  oMSMailbox VARCHAR(10) NULL,
  oSLMailbox VARCHAR(10) NULL,
  PRIMARY KEY(idOperator)
);

CREATE TABLE TestPlanStatus (
  idTestPlanStatus INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  tps_Name VARCHAR(15) NULL,
  tps_Desc VARCHAR(50) NULL,
  PRIMARY KEY(idTestPlanStatus)
);

CREATE TABLE SubCategory (
  idSubCategory INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  scParentCategory INTEGER UNSIGNED NOT NULL,
  scName VARCHAR(50) NOT NULL,
  scDesc VARCHAR(255) NULL,
  PRIMARY KEY(idSubCategory),
  INDEX SubCategory_FKIndex1(scParentCategory),
  FOREIGN KEY(scParentCategory)
    REFERENCES Category(idCategory)
      ON DELETE RESTRICT
      ON UPDATE CASCADE
);

CREATE TABLE TrafficCharge (
  idTrafficCharge INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  tcOperator INTEGER UNSIGNED NOT NULL,
  tcName VARCHAR(50) NULL,
  tcVoice VARCHAR(50) NULL,
  tcDataFax VARCHAR(50) NULL,
  tcGPRS VARCHAR(50) NULL,
  tcSMS VARCHAR(50) NULL,
  tcMMS VARCHAR(50) NULL,
  tcConferenceCall VARCHAR(50) NULL,
  tcPushSMS VARCHAR(50) NULL,
  PRIMARY KEY(idTrafficCharge),
  INDEX TrafficCharge_FKIndex1(tcOperator),
  FOREIGN KEY(tcOperator)
    REFERENCES Operator(idOperator)
      ON DELETE RESTRICT
      ON UPDATE CASCADE
);

CREATE TABLE MS_MMS_Profile (
  idMS_MMS_Profile INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  mmpOperator INTEGER UNSIGNED NOT NULL,
  mmpName VARCHAR(50) NULL,
  mmpMMS_URL VARCHAR(100) NULL,
  mmpMMS_IP VARCHAR(20) NULL,
  mmpMMS_Port VARCHAR(10) NULL,
  mmpGPRS_APN VARCHAR(50) NULL,
  mmpUsername VARCHAR(10) NULL,
  mmpPassword VARCHAR(10) NULL,
  mmpMMS_ServerName VARCHAR(50) NULL,
  PRIMARY KEY(idMS_MMS_Profile),
  INDEX MS_MMS_Profile_FKIndex1(mmpOperator),
  FOREIGN KEY(mmpOperator)
    REFERENCES Operator(idOperator)
      ON DELETE RESTRICT
      ON UPDATE CASCADE
);

CREATE TABLE PC_CSD_Profile (
  idPC_CSD_Profile INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  pcpOperator INTEGER UNSIGNED NOT NULL,
  pcpName VARCHAR(50) NULL,
  pcpDialUp VARCHAR(20) NULL,
  pcpRoaming VARCHAR(20) NULL,
  pcpUsername VARCHAR(10) NULL,
  pcpPassword VARCHAR(10) NULL,
  PRIMARY KEY(idPC_CSD_Profile),
  INDEX PC_CSD_Profile_FKIndex1(pcpOperator),
  FOREIGN KEY(pcpOperator)
    REFERENCES Operator(idOperator)
      ON DELETE RESTRICT
      ON UPDATE CASCADE
);

CREATE TABLE MS_CSD_Profile (
  idMS_CSD_Profile INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  mcpOperator INTEGER UNSIGNED NOT NULL,
  mcpName VARCHAR(50) NULL,
  mcpWAP_URL VARCHAR(100) NULL,
  mcpWAP_IP VARCHAR(20) NULL,
  mcpWAP_Port VARCHAR(10) NULL,
  mcpDialUp VARCHAR(10) NULL,
  mcpUsername VARCHAR(10) NULL,
  mcpPassword VARCHAR(10) NULL,
  mcpSpeed VARCHAR(10) NULL,
  mcpLineType VARCHAR(10) NULL,
  PRIMARY KEY(idMS_CSD_Profile),
  INDEX MS_CSD_Profile_FKIndex1(mcpOperator),
  FOREIGN KEY(mcpOperator)
    REFERENCES Operator(idOperator)
      ON DELETE RESTRICT
      ON UPDATE CASCADE
);

CREATE TABLE MS_GPRS_Profile (
  idMS_GPRS_Profile INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  mgpOperator INTEGER UNSIGNED NOT NULL,
  mgpName VARCHAR(50) NULL,
  mgpWAP_URL VARCHAR(100) NULL,
  mgpWAP_IP VARCHAR(20) NULL,
  mgpWAP_Port VARCHAR(10) NULL,
  mgpDialUp VARCHAR(10) NULL,
  mgpAPN VARCHAR(50) NULL,
  mgpUsername VARCHAR(10) NULL,
  mgpPassword VARCHAR(10) NULL,
  PRIMARY KEY(idMS_GPRS_Profile),
  INDEX MS_GPRS_Profile_FKIndex1(mgpOperator),
  FOREIGN KEY(mgpOperator)
    REFERENCES Operator(idOperator)
      ON DELETE RESTRICT
      ON UPDATE CASCADE
);

CREATE TABLE PC_GPRS_Profile (
  idPC_GPRS_Profile INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  pgpOperator INTEGER UNSIGNED NOT NULL,
  pgpName VARCHAR(50) NULL,
  pgpTool VARCHAR(50) NULL,
  pgpGPRS_APN VARCHAR(50) NULL,
  pgpGPRS_Dialup VARCHAR(20) NULL,
  pgpUsername VARCHAR(10) NULL,
  pgpPassword VARCHAR(10) NULL,
  pgpHotline VARCHAR(20) NULL,
  pgpOperatorURL VARCHAR(100) NULL,
  PRIMARY KEY(idPC_GPRS_Profile),
  INDEX PC_GPRS_Profile_FKIndex1(pgpOperator),
  FOREIGN KEY(pgpOperator)
    REFERENCES Operator(idOperator)
      ON DELETE RESTRICT
      ON UPDATE CASCADE
);

CREATE TABLE SIMType (
  idSIMType INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  stBand INTEGER UNSIGNED NOT NULL,
  stGPRS BOOL NOT NULL,
  stLiveCall BOOL NOT NULL,
  PRIMARY KEY(idSIMType),
  INDEX SIMType_FKIndex1(stBand),
  FOREIGN KEY(stBand)
    REFERENCES BandType(idBandType)
      ON DELETE RESTRICT
      ON UPDATE CASCADE
);

CREATE TABLE SIMTypeServiceLink (
  lnkType INTEGER UNSIGNED NOT NULL,
  lnkService INTEGER UNSIGNED NOT NULL,
  PRIMARY KEY(lnkType, lnkService),
  INDEX SIMTypeServiceLink_FKIndex1(lnkService),
  INDEX SIMTypeServiceLink_FKIndex2(lnkType),
  FOREIGN KEY(lnkService)
    REFERENCES SupplementaryService(idSupplementaryService)
      ON DELETE RESTRICT
      ON UPDATE CASCADE,
  FOREIGN KEY(lnkType)
    REFERENCES SIMType(idSIMType)
      ON DELETE RESTRICT
      ON UPDATE CASCADE
);

CREATE TABLE TestScript (
  idTestScript VARCHAR(20) NOT NULL,
  tsVaildator VARCHAR(5) NOT NULL,
  tsSubmitter VARCHAR(5) NOT NULL,
  tsFilePath VARCHAR(255) NOT NULL,
  tsSubmitDate DATETIME NOT NULL,
  PRIMARY KEY(idTestScript),
  INDEX TestScript_FKIndex1(tsSubmitter),
  INDEX TestScript_FKIndex2(tsVaildator),
  FOREIGN KEY(tsSubmitter)
    REFERENCES Testers(idTester)
      ON DELETE RESTRICT
      ON UPDATE CASCADE,
  FOREIGN KEY(tsVaildator)
    REFERENCES Testers(idTester)
      ON DELETE RESTRICT
      ON UPDATE CASCADE
);

CREATE TABLE Test (
  idTest VARCHAR(20) NOT NULL,
  tStatus INTEGER UNSIGNED NOT NULL,
  tSoftwareVersion INTEGER UNSIGNED NOT NULL,
  tCreator VARCHAR(5) NOT NULL,
  tDateStart DATETIME NULL,
  tDateEnd DATETIME NULL,
  tDesc VARCHAR(255) NULL,
  PRIMARY KEY(idTest),
  INDEX Test_FKIndex1(tCreator),
  INDEX Test_FKIndex2(tSoftwareVersion),
  INDEX Test_FKIndex3(tStatus),
  FOREIGN KEY(tCreator)
    REFERENCES Testers(idTester)
      ON DELETE RESTRICT
      ON UPDATE CASCADE,
  FOREIGN KEY(tSoftwareVersion)
    REFERENCES SoftwareVersion(idSoftwareVersion)
      ON DELETE RESTRICT
      ON UPDATE CASCADE,
  FOREIGN KEY(tStatus)
    REFERENCES TestPlanStatus(idTestPlanStatus)
      ON DELETE RESTRICT
      ON UPDATE CASCADE
);

CREATE TABLE TestCase (
  idTestCase VARCHAR(20) NOT NULL,
  tcVersionID INTEGER UNSIGNED NOT NULL,
  tcTester VARCHAR(5) NOT NULL,
  tcSubCategory INTEGER UNSIGNED NOT NULL,
  tcCategory INTEGER UNSIGNED NOT NULL,
  tcScript VARCHAR(20) NULL,
  tcTestType INTEGER UNSIGNED NOT NULL,
  tcDescription TEXT NOT NULL,
  tcProcedure TEXT NOT NULL,
  tcExpectResult TEXT NOT NULL,
  tcSanity BOOL NOT NULL,
  tcManTestCount INTEGER UNSIGNED NOT NULL,
  tcCreateDate DATETIME NULL,
  PRIMARY KEY(idTestCase, tcVersionID),
  INDEX TestCase_FKIndex1(tcSubCategory),
  INDEX TestCase_FKIndex2(tcTestType),
  INDEX TestCase_FKIndex3(tcScript),
  INDEX TestCase_FKIndex4(tcCategory),
  INDEX TestCase_FKIndex5(tcTester),
  FOREIGN KEY(tcSubCategory)
    REFERENCES SubCategory(idSubCategory)
      ON DELETE RESTRICT
      ON UPDATE CASCADE,
  FOREIGN KEY(tcTestType)
    REFERENCES TestType(idTestType)
      ON DELETE RESTRICT
      ON UPDATE CASCADE,
  FOREIGN KEY(tcScript)
    REFERENCES TestScript(idTestScript)
      ON DELETE RESTRICT
      ON UPDATE CASCADE,
  FOREIGN KEY(tcCategory)
    REFERENCES Category(idCategory)
      ON DELETE RESTRICT
      ON UPDATE CASCADE,
  FOREIGN KEY(tcTester)
    REFERENCES Testers(idTester)
      ON DELETE RESTRICT
      ON UPDATE CASCADE
);

CREATE TABLE SimCard (
  idSimCard INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  scSIMType INTEGER UNSIGNED NOT NULL,
  scTrafficCharge INTEGER UNSIGNED NOT NULL,
  scMS_GPRS_Profile INTEGER UNSIGNED NOT NULL,
  scMS_MMS_Profile INTEGER UNSIGNED NOT NULL,
  scMS_CSD_Profile INTEGER UNSIGNED NOT NULL,
  scPC_GPRS_Profile INTEGER UNSIGNED NOT NULL,
  scPC_CSD_Profile INTEGER UNSIGNED NOT NULL,
  scOperator INTEGER UNSIGNED NOT NULL,
  scPhoneNum VARCHAR(20) NOT NULL,
  scMobileFaxNum VARCHAR(20) NULL,
  scDataNum VARCHAR(20) NULL,
  scPIM VARCHAR(25) NOT NULL,
  scStatus VARCHAR(20) NOT NULL,
  scBarring VARCHAR(10) NULL,
  scPIN VARCHAR(10) NOT NULL,
  scPUK VARCHAR(10) NULL,
  scPUK2 VARCHAR(10) NULL,
  scFaxLinkNum VARCHAR(20) NULL,
  scConferenceCall VARCHAR(15) NULL,
  scDataRoamName VARCHAR(30) NULL,
  scVMailPass VARCHAR(10) NULL,
  PRIMARY KEY(idSimCard),
  INDEX SimCard_FKIndex1(scTrafficCharge),
  INDEX SimCard_FKIndex2(scPC_CSD_Profile),
  INDEX SimCard_FKIndex3(scPC_GPRS_Profile),
  INDEX SimCard_FKIndex4(scMS_CSD_Profile),
  INDEX SimCard_FKIndex5(scMS_MMS_Profile),
  INDEX SimCard_FKIndex6(scMS_GPRS_Profile),
  INDEX SimCard_FKIndex7(scOperator),
  INDEX SimCard_FKIndex8(scSIMType),
  FOREIGN KEY(scOperator)
    REFERENCES Operator(idOperator)
      ON DELETE RESTRICT
      ON UPDATE CASCADE,
  FOREIGN KEY(scTrafficCharge)
    REFERENCES TrafficCharge(idTrafficCharge)
      ON DELETE RESTRICT
      ON UPDATE CASCADE,
  FOREIGN KEY(scPC_CSD_Profile)
    REFERENCES PC_CSD_Profile(idPC_CSD_Profile)
      ON DELETE RESTRICT
      ON UPDATE CASCADE,
  FOREIGN KEY(scPC_GPRS_Profile)
    REFERENCES PC_GPRS_Profile(idPC_GPRS_Profile)
      ON DELETE RESTRICT
      ON UPDATE CASCADE,
  FOREIGN KEY(scMS_CSD_Profile)
    REFERENCES MS_CSD_Profile(idMS_CSD_Profile)
      ON DELETE RESTRICT
      ON UPDATE CASCADE,
  FOREIGN KEY(scMS_MMS_Profile)
    REFERENCES MS_MMS_Profile(idMS_MMS_Profile)
      ON DELETE RESTRICT
      ON UPDATE CASCADE,
  FOREIGN KEY(scMS_GPRS_Profile)
    REFERENCES MS_GPRS_Profile(idMS_GPRS_Profile)
      ON DELETE RESTRICT
      ON UPDATE CASCADE,
  FOREIGN KEY(scSIMType)
    REFERENCES SIMType(idSIMType)
      ON DELETE RESTRICT
      ON UPDATE CASCADE
);

CREATE TABLE TestPlanLink (
  tpl_TCVID INTEGER UNSIGNED NOT NULL,
  tpl_TCID VARCHAR(20) NOT NULL,
  tpl_TID VARCHAR(20) NOT NULL,
  PRIMARY KEY(tpl_TCVID, tpl_TCID, tpl_TID),
  INDEX Table_26_FKIndex1(tpl_TCID, tpl_TCVID),
  INDEX Table_26_FKIndex2(tpl_TID),
  FOREIGN KEY(tpl_TCID, tpl_TCVID)
    REFERENCES TestCase(idTestCase, tcVersionID)
      ON DELETE RESTRICT
      ON UPDATE CASCADE,
  FOREIGN KEY(tpl_TID)
    REFERENCES Test(idTest)
      ON DELETE RESTRICT
      ON UPDATE CASCADE
);

CREATE TABLE TestRecords (
  tr_tpl_TID VARCHAR(20) NOT NULL,
  tr_tpl_TCID VARCHAR(20) NOT NULL,
  tr_tpl_TCVID INTEGER UNSIGNED NOT NULL,
  trPhone INTEGER UNSIGNED NOT NULL,
  trSeverity INTEGER UNSIGNED NOT NULL,
  trSimCard INTEGER UNSIGNED NOT NULL,
  trTester VARCHAR(5) NOT NULL,
  trResultType INTEGER UNSIGNED NOT NULL,
  trComment TEXT NULL,
  trDDTS VARCHAR(20) NULL,
  trTimeUsed INTEGER UNSIGNED NULL,
  trSuccCount INTEGER UNSIGNED NULL,
  PRIMARY KEY(tr_tpl_TID, tr_tpl_TCID, tr_tpl_TCVID),
  INDEX TestRecords_FKIndex3(trResultType),
  INDEX TestRecords_FKIndex4(trTester),
  INDEX TestRecords_FKIndex5(trSimCard),
  INDEX TestRecords_FKIndex6(trSeverity),
  INDEX TestRecords_FKIndex7(trPhone),
  INDEX TestRecords_FKIndex6(tr_tpl_TCVID, tr_tpl_TCID, tr_tpl_TID),
  FOREIGN KEY(trResultType)
    REFERENCES ResultType(idResultType)
      ON DELETE RESTRICT
      ON UPDATE CASCADE,
  FOREIGN KEY(trTester)
    REFERENCES Testers(idTester)
      ON DELETE RESTRICT
      ON UPDATE CASCADE,
  FOREIGN KEY(trSimCard)
    REFERENCES SimCard(idSimCard)
      ON DELETE RESTRICT
      ON UPDATE CASCADE,
  FOREIGN KEY(trSeverity)
    REFERENCES Severity(idSeverity)
      ON DELETE RESTRICT
      ON UPDATE CASCADE,
  FOREIGN KEY(trPhone)
    REFERENCES Phone(idPhone)
      ON DELETE RESTRICT
      ON UPDATE CASCADE,
  FOREIGN KEY(tr_tpl_TCVID, tr_tpl_TCID, tr_tpl_TID)
    REFERENCES TestPlanLink(tpl_TCVID, tpl_TCID, tpl_TID)
      ON DELETE RESTRICT
      ON UPDATE CASCADE
);


