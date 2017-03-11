DELIMITER $$
DROP PROCEDURE IF EXISTS `we3_atdb`.`getBandType`$$
CREATE PROCEDURE `we3_atdb`.`getBandType` (IN field, IN value)
BEGIN
SELECT * FROM BandType WHERE field == value;

END$$

DELIMITER ;

SELECT * FROM BandType

SELECT  * FROM BandType WHERE  idBandType ==


/**/
SELECT * FROM Category
SELECT * FROM MS_CSD_Profile
SELECT * FROM MS_GPRS_Profile
SELECT * FROM MS_MMS_Profile
SELECT * FROM Operator
SELECT * FROM PC_CSD_Profile
SELECT * FROM PC_GPRS_Profile
SELECT * FROM Phone
SELECT * FROM ResultType
SELECT * FROM Severity
SELECT * FROM SIMCard
SELECT * FROM SIMType
SELECT * FROM SIMTypeServiceLink
SELECT * FROM SoftwareVersion
SELECT * FROM SubCategory
SELECT * FROM SupplementaryService
SELECT * FROM Test
SELECT * FROM Testcase
SELECT * FROM Testers
SELECT * FROM TestRecords
SELECT * FROM TestScript
SELECT * FROM TestType
SELECT * FROM TrafficCharge

DELETE FROM BandType              WHERE
DELETE FROM Category              WHERE
DELETE FROM MS_CSD_Profile        WHERE
DELETE FROM MS_GPRS_Profile       WHERE
DELETE FROM MS_MMS_Profile        WHERE
DELETE FROM Operator              WHERE
DELETE FROM PC_CSD_Profile        WHERE
DELETE FROM PC_GPRS_Profile       WHERE
DELETE FROM Phone                 WHERE
DELETE FROM ResultType            WHERE
DELETE FROM Severity              WHERE
DELETE FROM SIMCard               WHERE
DELETE FROM SIMType               WHERE
DELETE FROM SIMTypeServiceLink    WHERE
DELETE FROM SoftwareVersion       WHERE
DELETE FROM SubCategory           WHERE
DELETE FROM SupplementaryService  WHERE
DELETE FROM Test                  WHERE
DELETE FROM Testcase              WHERE
DELETE FROM Testers               WHERE
DELETE FROM TestRecords           WHERE
DELETE FROM TestScript            WHERE
DELETE FROM TestType              WHERE
DELETE FROM TrafficCharge         WHERE

UPDATE BandType                   SET
UPDATE Category                   SET
UPDATE MS_CSD_Profile             SET
UPDATE MS_GPRS_Profile            SET
UPDATE MS_MMS_Profile             SET
UPDATE Operator                   SET
UPDATE PC_CSD_Profile             SET
UPDATE PC_GPRS_Profile            SET
UPDATE Phone                      SET
UPDATE ResultType                 SET
UPDATE Severity                   SET
UPDATE SIMCard                    SET
UPDATE SIMType                    SET
UPDATE SIMTypeServiceLink         SET
UPDATE SoftwareVersion            SET
UPDATE SubCategory                SET
UPDATE SupplementaryService       SET
UPDATE Test                       SET
UPDATE Testcase                   SET
UPDATE Testers                    SET
UPDATE TestRecords                SET
UPDATE TestScript                 SET
UPDATE TestType                   SET
UPDATE TrafficCharge              SET

INSERT INTO BandType              VALUES  (null,"btNname","btDesc");
INSERT INTO Category              VALUES  (null,"cName","cDesc");
INSERT INTO MS_CSD_Profile        VALUES  (null,mcpOperator,"mcpName","mcpWAP_URL","mcpWAP_IP","mcpWAP_Port","mcpDialUp","mcpUsername","mcpPassword","mcpSpeed","mcpLineType");
INSERT INTO MS_GPRS_Profile       VALUES  (null,mgpOperator,"mgpName","mgpWAP_URL","mgpWAP_IP","mgpWAP_Port","mgpDialUp","mgpAPN","mgpUsername","mgpPassword");
INSERT INTO MS_MMS_Profile        VALUES  (null,mmpOperator,"mmpName","mmpMMS_URL","mmpMMS_IP","mmpMMS_Port","mmpGPRS_APN","mmpUsername","mmpPassword","mmpMMS_ServerName");
INSERT INTO Operator              VALUES  (null,"oName","oMSMailbox","oSMMailbox");
INSERT INTO PC_CSD_Profile        VALUES  (null,pcpOperator,"pcpName","pcpDialUp","pcpRoaming","pcpUsername","pcpPassword");
INSERT INTO PC_GPRS_Profile       VALUES  (null,pgpOperator,"pgpName","pgpTool","pgpGPRS_APN","pgpGPRS_Dialup","pgpUsername","pgpPassword","pgpHotline","pgpOperatorURL");
INSERT INTO Phone                 VALUES  (null,"pHardwareNumber","pDesc");
INSERT INTO ResultType            VALUES  (null,"rtName","rtDesc");
INSERT INTO Severity              VALUES  (null,"sName","sDesc");
INSERT INTO SIMCard               VALUES  (null,scSIMType,scTrafficCharge,scMS_GPRS_Profile,scMS_MMS_Profile,scMS_CSD_Profile,scPC_GPRS_Profile,scPC_CSD_Profile,scOperator,"scPhoneNum","scMobileFaxNum","scDataNum","scPIM","scStatus","scBarring","scPIN","scPUK","scPUK2","scFaxLinkNum","scConferenceCall","scDataRoamName","scVMailPass");
INSERT INTO SIMType               VALUES  (null,stBand,stGPRS,stLiveCall);
INSERT INTO SIMTypeServiceLink    VALUES  (lnkType,lnkService);
INSERT INTO SoftwareVersion       VALUES  (null,"svName","svDesc");
INSERT INTO SubCategory           VALUES  (null,scParentCategory,"scName","scDesc");
INSERT INTO SupplementaryService  VALUES  (null,"ssName","ssDesc");
INSERT INTO Test                  VALUES  ("idTest",tSoftwareVersion,"tCreator",tDateStart,tDateEnd,"tDesc");
INSERT INTO Testcase              VALUES  ("idTestCase","tcScript",tcCategory,tcTestType,"tcDescription","tcProcedure","tcExpectResult",tcSanity,tcManTestCount);
INSERT INTO Testers               VALUES  ("idTester","tName","tDesc","tPassword");
INSERT INTO TestRecords           VALUES  ("trTestCaseID","trTestID",trPhone,trSeverity,trSIMCard,trTester,trResultType,trComment,trDDTS,trTimeUsed,trSuccCount);
INSERT INTO TestScript            VALUES  ("idTestScript","tsVaildator","tsSubmitter","tsFilePath",tsSubmitDate);
INSERT INTO TestType              VALUES  (null,"ttName","ttDesc");
INSERT INTO TrafficCharge         VALUES  (null,tcOperator,"tcName","tcVoice","tcDataFax","tcGPRS","tcSMS","tcMMS","tcConferenceCall","tcPushSMS");