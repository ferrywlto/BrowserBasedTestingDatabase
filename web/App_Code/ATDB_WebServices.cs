using System;
using System.Data;
using System.Collections;
using System.Collections.Generic;
using System.Configuration;
using System.Web;
using System.Web.Services;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Web.SessionState;
using System.Text.RegularExpressions;
using System.Xml;

using MySql.Data.MySqlClient;

[WebService(Namespace = "Com.WE3Technology.ATDB", Name = "WE3 Technology ATDB Web Service", Description = "Web services for ATDB")]
public class ATDB_WebServices : System.Web.Services.WebService
{
    protected MySQLDBConnector dbc = new MySQLDBConnector();

    [WebMethod]
    public Boolean Login(string username, string password)
    {
        bool result = false;
        if (dbc == null)
            dbc = new MySQLDBConnector();

        string sqlStr = "select count(*) from testers where idTester = '"+username+"' and tpassword = '"+password+"'";

        MySqlDataReader reader = dbc.ExecuteQuery(sqlStr);
        if (reader.HasRows)
        {
            reader.Read();
            if (reader.GetInt16(0) == 1) { result = true; }
            else { result = false; }
        }
        dbc.CloseDBC();
        return result;
    }
    

    #region UPDATE RECORDS

    [WebMethod]
    public Boolean Update_Tester(string name, string desc, string id, string tEmail)
    {
        return ExecNonQuerySQL("UPDATE Testers SET tName = '"+name+"', tDesc = '"+desc+"', tEmail = '"+tEmail+"' WHERE idTester = '"+id+"'");
    }
    #endregion

    #region DELETE RECORDS
    /// <summary>
    /// This method should not be called directly from flash client.
    /// This is because the testcases are no longer should be deleted.
    /// The existence of this function was giving a last resort to the 
    /// user to delete records when really needed.
    /// </summary>
    /// <param name="id"></param>
    /// <param name="version">version number</param>
    /// <returns>a boolean indicate the result of this delete process.</returns>
    [WebMethod]
    public Boolean Delete_TestCase(string id, int version)
    {
        return ExecNonQuerySQL("DELETE FROM TestCase WHERE idTestCase = '" + id + "' AND tcVersionID = "+ version);
    }    
    [WebMethod]
    public Boolean Delete_Tester(string id)
    {
        return ExecNonQuerySQL("DELETE FROM Testers WHERE idTester = '"+id+"'");
    }
    #endregion



    #region GET_ONE_RECORD
    [WebMethod]
    public ArrayList Get_Test_By_ID(string value)
    {
        string SQL = "";
        SQL += "SELECT idTest, svName, tCreator, tDateStart, tDateEnd, tDesc, tps_Name ";
        SQL += "FROM Test, SoftwareVersion, TestPlanStatus ";
        SQL += "WHERE idTest = '" + value + "' AND tSoftwareVersion = idSoftwareVersion AND tStatus = idTestPlanStatus LIMIT 1";

        MySqlDataReader reader = dbc.ExecuteQuery(SQL);
        if (reader.HasRows)
        {
            ArrayList results = new ArrayList();
            reader.Read();
            string[] fields = new string[reader.FieldCount];
            fields[0] = reader.GetString(0);
            fields[1] = reader.GetString(1);
            fields[2] = reader.GetString(2);

            if (reader.IsDBNull(3))
                fields[3] = "";
            else
                fields[3] = reader.GetDateTime(3).ToString();

            if (reader.IsDBNull(4))
                fields[4] = "";
            else
                fields[4] = reader.GetDateTime(4).ToString();

            fields[5] = reader.GetString(5);
            fields[6] = reader.GetString(6);
            results.Add(fields);

            dbc.CloseDBC();
            return results;
        }
        else
        {
            dbc.CloseDBC();
            return new ArrayList();
        }
    }

    [WebMethod]
    public ArrayList Get_All_Test()
    {
        string SQL = "";
        SQL += "SELECT idTest From Test";
        MySqlDataReader reader = dbc.ExecuteQuery(SQL);
        ArrayList results = new ArrayList();
        while (reader.Read())
        {
            string[] fields = new string[reader.FieldCount];
            fields[0] = reader.GetString(0);
            results.Add(fields);
        }
        dbc.CloseDBC();
        return results;
    }

    [WebMethod]
    public ArrayList Get_TestRecord(string test, string testcase, string version, string tester)
    {
        string SQL = "SELECT pHardwareNumber,sName,scPhoneNum, tName,rtName, trComment, trDDTS, trTimeUsed, trSuccCount ";
        SQL += "FROM Testrecords, Phone, Severity, SIMCard, Testers, ResultType ";
        SQL += "where trPhone = idPhone ";
        SQL += "AND trSeverity = idSeverity ";
        SQL += "AND trSimCard = idSIMCard ";
        SQL += "AND trTester = idTester ";
        SQL += "AND trResultType = idResultType ";
        SQL += "AND tr_tpl_TID = '"+test+"' ";
        SQL += "AND tr_tpl_TCID = '"+testcase+"' ";
        SQL += "AND tr_tpl_TCVID = "+version+" ";
        SQL += "AND trTester = '"+tester+"'";

        MySqlDataReader reader = dbc.ExecuteQuery(SQL);
        ArrayList results = new ArrayList();
        while (reader.Read())
        {
            string[] fields = new string[reader.FieldCount];
            fields[0] = reader.GetString(0);
            fields[1] = reader.GetString(1);
            fields[2] = reader.GetString(2);
            fields[3] = reader.GetString(3);
            fields[4] = reader.GetString(4);
            fields[5] = reader.GetString(5);
            fields[6] = reader.GetString(6);
            fields[7] = reader.GetString(7).ToString();
            fields[8] = reader.GetUInt16(8).ToString();
            results.Add(fields);
        }
        dbc.CloseDBC();
        return results;
    }

    [WebMethod]
    public ArrayList Get_TestRecord_IndexOnly(string test, string testcase, string version, string tester)
    {
        string SQL = "SELECT trPhone,trSeverity,trSimCard, trResultType, trComment, trDDTS, trTimeUsed, trSuccCount ";
        SQL += "FROM Testrecords ";
        SQL += "WHERE tr_tpl_TID = '" + test + "' ";
        SQL += "AND tr_tpl_TCID = '" + testcase + "' ";
        SQL += "AND tr_tpl_TCVID = " + version + " ";

        MySqlDataReader reader = dbc.ExecuteQuery(SQL);
        ArrayList results = new ArrayList();
        while (reader.Read())
        {
            string[] fields = new string[reader.FieldCount];
            /*
            if (!reader.IsDBNull(0))
               
            else
                fields[0] = "";
            */
            //if(
            for(int i=0; i<8; i++)
            {
                if (!reader.IsDBNull(i))
                    fields[i] = reader.GetString(i);
                else
                    fields[i] = "";
            }

            //fields[6] = reader.GetString(6).ToString();
            //fields[7] = reader.GetString(7).ToString();
            results.Add(fields);
        }
        dbc.CloseDBC();
        return results;
    }

    [WebMethod]
    public ArrayList Get_TestCase_By_ID_VERSION(string value, int version)
    {
        string SQL = "";
        SQL += "SELECT * ";
        SQL += "FROM testcase ";
        SQL += "WHERE idTestcase ='" + value + "' AND tcVersionID = "+version;

        MySqlDataReader reader = dbc.ExecuteQuery(SQL);
        if (reader.HasRows)
        {
            ArrayList results = new ArrayList();
            reader.Read();
            string[] fields = new string[reader.FieldCount];
            // idTestCase, tcVersionID, tcTester, tcSubCategory, tcCategory, tcScript, tcTestType, tcDescription, tcProcedure, tcExpectResult, tcSanity, tcManTestCount, tcCreateDate
            fields[0] = reader.GetString(0);
            fields[1] = reader.GetInt16(1).ToString();
            fields[2] = reader.GetString(2);
            fields[3] = reader.GetString(3);
            fields[4] = reader.GetString(4);
            fields[5] = reader.GetString(5);
            fields[6] = reader.GetString(6);
            fields[7] = reader.GetString(7);
            fields[8] = reader.GetString(8);
            fields[9] = reader.GetString(9);
            fields[10] = reader.GetBoolean(10).ToString();
            fields[11] = reader.GetInt16(11).ToString();
            fields[12] = reader.GetDateTime(12).ToString();
            results.Add(fields);
            
            dbc.CloseDBC();
            return results;
        }
        else
        {
            dbc.CloseDBC();
            return new ArrayList();
        }
    }
    #endregion

    #region SEARCH RECORDS
    [WebMethod]
    public Boolean checkTestScriptID(string ID)
    {
        string SQL = "SELECT count(*) FROM testscript where idTestScript = '" + ID + "'";
        MySqlDataReader reader = dbc.ExecuteQuery(SQL);
        bool result = false;

        if (reader.HasRows)
        {
            reader.Read();
            if (reader.GetInt16(0) == 1) { result = true; }
            else { result = false; }
        }
        else { result = false; }
        dbc.CloseDBC();
        return result;
    }
    [WebMethod]
    public Boolean checkTestCaseID(string ID)
    {
        string SQL = "SELECT count(*) FROM testcase where idTestCase = '"+ID+"'";
        MySqlDataReader reader = dbc.ExecuteQuery(SQL);
        bool result = false;

        if (reader.HasRows)
        {
            reader.Read();
            if (reader.GetInt16(0) == 0) {result = true; }
            else { result = false; }
        }
        else { result = false; }

        dbc.CloseDBC();
        return result;
    }
    [WebMethod]
    public Boolean checkTestID(string ID)
    {
        string SQL = "SELECT count(*) FROM test where idTest = '" + ID + "'";
        MySqlDataReader reader = dbc.ExecuteQuery(SQL);
        bool result = false;

        if (reader.HasRows)
        {
            reader.Read();
            if (reader.GetInt16(0) == 0) { result = true; } // Means no duplicate found
            else { result = false; }
        }
        else { result = false; }

        dbc.CloseDBC();
        return result;
    }


    [WebMethod]
    public ArrayList Search_TestCase(string fieldname, string value)
    {
        string SQL = "";
        SQL += "SELECT idTestCase,tcVersionID, Testers.tName, scName, cName, tcScript, ttName, tcDescription, tcProcedure, tcExpectResult, tcSanity, tcManTestCount,tcCreateDate ";
        SQL += "FROM testcase, category, subcategory, testtype, testers ";
        SQL += "WHERE tcSubCategory = idSubCategory AND tcCategory = idCategory AND idTester = tcTester ";
        SQL += "AND tcTestType = idTestType AND "+fieldname+" LIKE '%"+value+"%' LIMIT 2500";
        
        MySqlDataReader reader = dbc.ExecuteQuery(SQL);
        if (reader.HasRows)
        {
            ArrayList results = new ArrayList();
            while (reader.Read())
            {
                string[] fields = new string[reader.FieldCount];
                // idTestCase, tcVersionID, tcTester, tcSubCategory, tcCategory, tcScript, tcTestType, tcDescription, tcProcedure, tcExpectResult, tcSanity, tcManTestCount, tcCreateDate
                fields[0] = reader.GetString(0);
                fields[1] = reader.GetInt16(1).ToString();
                fields[2] = reader.GetString(2); 
                fields[3] = reader.GetString(3); 
                fields[4] = reader.GetString(4);
                fields[5] = reader.GetString(5);
                fields[6] = reader.GetString(6);
                fields[7] = reader.GetString(7);
                fields[8] = reader.GetString(8);
                fields[9] = reader.GetString(9);
                fields[10] = reader.GetBoolean(10).ToString();
                fields[11] = reader.GetInt16(11).ToString();
                fields[12] = reader.GetDateTime(12).ToString();
                results.Add(fields);
            }
            dbc.CloseDBC();
            return results;
        }
        else
        {
            return new ArrayList();
        }
    }
    [WebMethod]
    public ArrayList Search_TestCase_Latest(string fieldname, string value)
    {
        string SQL = "";
        SQL += "SELECT idTestCase,MAX(tcVersionID), Testers.tName, scName, cName, tcScript, ttName, tcDescription, tcProcedure, tcExpectResult, tcSanity, tcManTestCount,tcCreateDate ";
        SQL += "FROM testcase, category, subcategory, testtype, testers ";
        SQL += "WHERE tcSubCategory = idSubCategory AND tcCategory = idCategory AND idTester = tcTester ";
        SQL += "AND tcTestType = idTestType AND " + fieldname + " LIKE '%" + value + "%' GROUP BY idTestCase LIMIT 5000";

        MySqlDataReader reader = dbc.ExecuteQuery(SQL);
        if (reader.HasRows)
        {
            ArrayList results = new ArrayList();
            while (reader.Read())
            {
                string[] fields = new string[reader.FieldCount];
                // idTestCase, tcVersionID, tcTester, tcSubCategory, tcCategory, tcScript, tcTestType, tcDescription, tcProcedure, tcExpectResult, tcSanity, tcManTestCount, tcCreateDate
                fields[0] = reader.GetString(0);
                fields[1] = reader.GetInt16(1).ToString();
                fields[2] = reader.GetString(2);
                fields[3] = reader.GetString(3);
                fields[4] = reader.GetString(4);
                fields[5] = reader.GetString(5);
                fields[6] = reader.GetString(6);
                fields[7] = reader.GetString(7);
                fields[8] = reader.GetString(8);
                fields[9] = reader.GetString(9);
                fields[10] = reader.GetBoolean(10).ToString();
                fields[11] = reader.GetInt16(11).ToString();
                fields[12] = reader.GetDateTime(12).ToString();
                results.Add(fields);
            }
            dbc.CloseDBC();
            return results;
        }
        else
        {
            return new ArrayList();
        }
    }
    [WebMethod]
    public ArrayList Search_Tester(string fieldname, string value)
    {
        MySqlDataReader reader = dbc.ExecuteQuery("SELECT * FROM Testers WHERE "+fieldname+" LIKE '%"+value+"%'");
        if (reader.HasRows)
        {
            ArrayList results = new ArrayList();
            while (reader.Read())
            {
                string[] fields = new string[reader.FieldCount];

                fields[0] = reader.GetString(0); // idTester
                fields[1] = reader.GetString(1); // tName
                fields[2] = reader.GetString(2); // tDesc
                //fields[3] = reader.GetString(3); // tPassword;
                fields[3] = reader.GetString(4); // tEmail;
                results.Add(fields);
            }
            dbc.CloseDBC();
            return results;           
        }
        else
        {
           dbc.CloseDBC();
           return new ArrayList();
        }
    }

    [WebMethod]
    public ArrayList Get_TestersName()
    {
        MySqlDataReader reader = dbc.ExecuteQuery("SELECT idTester, tName FROM Testers");
        if (reader.HasRows)
        {
            ArrayList results = new ArrayList();
            while (reader.Read())
            {
                string[] fields = new string[reader.FieldCount];

                fields[0] = reader.GetString(0); // idTester
                fields[1] = reader.GetString(1); // tName
                results.Add(fields);
            }
            dbc.CloseDBC();
            return results;
        }
        else
        {
            dbc.CloseDBC();
            return new ArrayList();
        }
    }
    [WebMethod]
    public ArrayList Search_Test(string fieldname, string value)
    {

        string SQL = "";
        SQL += "SELECT idTest, svName, Testers.tName, tDateStart, tDateEnd, Test.tDesc, tps_Name ";
        SQL += "FROM Test, SoftwareVersion, TestPlanStatus, Testers ";
        SQL += "WHERE tSoftwareVersion = idSoftwareVersion AND tStatus = idTestPlanStatus AND tCreator = idTester AND ";
        SQL += fieldname + " LIKE '%" + value + "%'";


        MySqlDataReader reader = dbc.ExecuteQuery(SQL);
        if (reader.HasRows)
        {
            ArrayList results = new ArrayList();
            while (reader.Read())
            {
                string[] fields = new string[reader.FieldCount];

                fields[0] = reader.GetString(0);    // idTest
                fields[1] = reader.GetString(1);     // tName
                fields[2] = reader.GetString(2);    // tTester


                if (reader.IsDBNull(3))
                    fields[3] = "";
                else
                    fields[3] = reader.GetDateTime(3).ToString();  // StartDate

                if (reader.IsDBNull(4))
                    fields[4] = "";
                else
                    fields[4] = reader.GetDateTime(4).ToString();  // EndDate

                if (reader.GetString(5) == null)
                    fields[5] = "";
                else
                    fields[5] = reader.GetString(5);    // tDesc

                fields[6] = reader.GetString(6);    // tDesc
                results.Add(fields);
            }
            dbc.CloseDBC();
            return results;
        }
        else
        {
            dbc.CloseDBC();
            return new ArrayList();
        }
    }
    #endregion


    #region INSERT NEW RECORDS SECTION

    [WebMethod]
    public bool Add_BandType(string btName, string btDesc)
    {
        return ExecNonQuerySQL("INSERT INTO BandType VALUES  (null,'"+btName+"','"+btDesc+"')");
    }
    [WebMethod]
    public bool Add_Category(string cName, string cDesc)
    {
        return ExecNonQuerySQL("INSERT INTO Category VALUES  (null,'"+cName+"','"+cDesc+"')");
    }
    [WebMethod]
    public bool Add_Phone(string pHardwareNumber, string pDesc)
    {
        return ExecNonQuerySQL("INSERT INTO Phone VALUES  (null,'"+pHardwareNumber+"','"+pDesc+"')");
    }
    [WebMethod]
    public bool Add_ResultType(string rtName, string rtDesc)
    {
        return ExecNonQuerySQL("INSERT INTO ResultType VALUES  (null,'"+rtName+"','"+rtDesc+"')");
    }
    [WebMethod]
    public bool Add_Severity(string sName, string sDesc)
    {
        return ExecNonQuerySQL("INSERT INTO Severity VALUES  (null,'"+sName+"','"+sDesc+"')");
    }
    [WebMethod]
    public bool Add_SoftwareVersion(string svName, string svDesc)
    {
        return ExecNonQuerySQL("INSERT INTO SoftwareVersion VALUES  (null,'"+svName+"','"+svDesc+"')");
    }
    [WebMethod]
    public bool Add_SupplementaryService(string ssName, string ssDesc)
    {
        return ExecNonQuerySQL("INSERT INTO SupplementaryService VALUES  (null,'"+ssName+"','"+ssDesc+"')");
    }
    [WebMethod]
    public bool Add_TestType(string ttName, string ttDesc)
    {
        return ExecNonQuerySQL("INSERT INTO TestType VALUES  (null,'" + ttName + "','" + ttDesc + "')");
    }
    [WebMethod]
    public bool Add_Testers(string idTester, string tName, string tDesc, string tPassword, string tEmail)
    {
       return ExecNonQuerySQL("INSERT INTO Testers VALUES  ('"+idTester+"','"+tName+"','"+tDesc+"','"+tPassword+"','"+tEmail+"')");
    }
    [WebMethod]
    public bool Add_Operator(string oName, string oMSMailbox, string oSMMailbox)
    {
        return ExecNonQuerySQL("INSERT INTO Operator VALUES  (null,'"+oName+"','"+oMSMailbox+"','"+oSMMailbox+"')");
    }
    [WebMethod]
    public bool Add_SIMType(int stBand, bool stGPRS, bool stLiveCall)
    {
        return ExecNonQuerySQL("INSERT INTO SIMType VALUES  (null,"+stBand+","+stGPRS+","+stLiveCall+")");
    }
    [WebMethod]
    public bool Add_SubCategory(int scParentCategory, string scName, string scDesc)
    {
       return ExecNonQuerySQL("INSERT INTO SubCategory VALUES  (null,"+scParentCategory+",'"+scName+"','"+scDesc+"')");
    }
    [WebMethod]
    public bool Add_MS_CSD_Profile(int mcpOperator,string mcpName, string mcpWAP_URL, string mcpWAP_IP, string mcpWAP_Port, string mcpDialUp, string mcpUsername, string mcpPassword, string mcpSpeed, string mcpLineType)
    {
        return ExecNonQuerySQL("INSERT INTO MS_CSD_Profile VALUES (null,"+mcpOperator+",'"+mcpName+"','"+mcpWAP_URL+"','"+mcpWAP_IP+"','"+mcpWAP_Port+"','"+mcpDialUp+"','"+mcpUsername+"','"+mcpPassword+"','"+mcpSpeed+"','"+mcpLineType+"')");
    }
    [WebMethod]
    public bool Add_MS_GPRS_Profile(int mgpOperator,string mgpName, string mgpWAP_URL, string mgpWAP_IP, string mgpWAP_Port, string mgpDialUp, string mgpAPN, string mgpUsername, string mgpPassword)
    {
        return ExecNonQuerySQL("INSERT INTO MS_GPRS_Profile VALUES (null,"+mgpOperator+",'"+mgpName+"','"+mgpWAP_URL+"','"+mgpWAP_IP+"','"+mgpWAP_Port+"','"+mgpDialUp+"','"+mgpAPN+"','"+mgpUsername+"','"+mgpPassword+"')");
    }
    [WebMethod]
    public bool Add_MS_MMS_Profile(int mmpOperator,string mmpName, string mmpMMS_URL, string mmpMMS_IP, string mmpMMS_Port, string mmpGPRS_APN, string mmpUsername, string mmpPassword, string mmpMMS_ServerName)
    {
        return ExecNonQuerySQL("INSERT INTO MS_MMS_Profile VALUES (null,"+mmpOperator+",'"+mmpName+"','"+mmpMMS_URL+"','"+mmpMMS_IP+"','"+mmpMMS_Port+"','"+mmpGPRS_APN+"','"+mmpUsername+"','"+mmpPassword+"','"+mmpMMS_ServerName+"')");
    }
    [WebMethod]
    public bool Add_PC_GPRS_Profile(int pgpOperator,string pgpName, string pgpTool, string pgpGPRS_APN, string pgpGPRS_Dialup, string pgpUsername, string pgpPassword, string pgpHotline, string pgpOperatorURL)
    {
        return ExecNonQuerySQL("INSERT INTO PC_GPRS_Profile VALUES (null,"+pgpOperator+",'"+pgpName+"','"+pgpTool+"','"+pgpGPRS_APN+"','"+pgpGPRS_Dialup+"','"+pgpUsername+"','"+pgpPassword+"','"+pgpHotline+"','"+pgpOperatorURL+"')");
    }
    [WebMethod]
    public bool Add_PC_CSD_Profile(int pcpOperator,string pcpName, string pcpDialUp, string pcpRoaming, string pcpUsername, string pcpPassword)
    {
        return ExecNonQuerySQL("INSERT INTO PC_CSD_Profile  VALUES (null,"+pcpOperator+",'"+pcpName+"','"+pcpDialUp+"','"+pcpRoaming+"','"+pcpUsername+"','"+pcpPassword+"')");
    }
    [WebMethod]
    public bool Add_TrafficCharge(int tcOperator, string tcName, string tcVoice, string tcDataFax, string tcGPRS, string tcSMS, string tcMMS, string tcConferenceCall, string tcPushSMS)
    {
        return ExecNonQuerySQL("INSERT INTO TrafficCharge VALUES (null,"+tcOperator+",'"+tcName+"','"+tcVoice+"','"+tcDataFax+"','"+tcGPRS+"','"+tcSMS+"','"+tcMMS+"','"+tcConferenceCall+"','"+tcPushSMS+"')");
    }
    [WebMethod]
    public bool Add_SIMCard(int scSIMType, int scTrafficCharge, int scMS_GPRS_Profile, int scMS_MMS_Profile, int scMS_CSD_Profile, int scPC_GPRS_Profile, int scPC_CSD_Profile, int scOperator, string scPhoneNum, string scMobileFaxNum, string scDataNum, string scPIM, string scStatus, string scBarring, string scPIN, string scPUK, string scPUK2, string scFaxLinkNum, string scConferenceCall, string scDataRoamName, string scVMailPass)
    {
        return ExecNonQuerySQL("INSERT INTO SIMCard VALUES  (null,"+scSIMType+","+scTrafficCharge+","+scMS_GPRS_Profile+","+scMS_MMS_Profile+","+scMS_CSD_Profile+","+scPC_GPRS_Profile+","+scPC_CSD_Profile+","+scOperator+",'"+scPhoneNum+"','"+scMobileFaxNum+"','"+scDataNum+"','"+scPIM+"','"+scStatus+"','"+scBarring+"','"+scPIN+"','"+scPUK+"','"+scPUK2+"','"+scFaxLinkNum+"','"+scConferenceCall+"','"+scDataRoamName+"','"+scVMailPass+"')");
    }
    [WebMethod]
    public bool Add_SIMTypeServiceLink(int lnkType,int lnkService)
    {
        return ExecNonQuerySQL("INSERT INTO SIMTypeServiceLink VALUES  ("+lnkType+","+lnkService+")");
    }
    [WebMethod]
    public bool Add_TestScript(string idTestScript, string tsVaildator, string tsSubmitter, string tsFilePath, DateTime tsSubmitDate)
    {
        return ExecNonQuerySQL("INSERT INTO TestScript VALUES  ('"+idTestScript+"','"+tsVaildator+"','"+tsSubmitter+"','"+tsFilePath+"','"+tsSubmitDate+")");
    }
    [WebMethod]
    public bool Add_TestRecords(string trTestCaseID, string trTestID, int trPhone, int trSeverity, int trSIMCard, string trTester, int trResultType, string trComment, string trDDTS, int trTimeUsed, int trSuccCount)
    {
        return ExecNonQuerySQL("INSERT INTO TestRecords VALUES  ('"+trTestCaseID+"','"+trTestID+"',"+trPhone+","+trSeverity+","+trSIMCard+",'"+trTester+"',"+trResultType+",'"+trComment+"','"+trDDTS+"',"+trTimeUsed+","+trSuccCount+")");
    }
    [WebMethod]
    public bool Add_Test(string idTest, int tSoftwareVersion, string tCreator, string tDesc)
    {
        return ExecNonQuerySQL("INSERT INTO Test VALUES  ('" + idTest + "'," + tSoftwareVersion + ",'" + tCreator + "',null,null,'" + tDesc + "',1)");
    }
    
    #endregion


    #region Special Code Region for Testcase Archive Purposes

    [WebMethod]
    public bool Update_Testcase(int subCategory, int category, string script, int type, string desc, string proc, string result, bool sanity, int count, string id, string creator)
    {
        //if (script == "") script = "null";
       // else script = "'" + script + "'";

        string oSQL = "SELECT MAX(tcVersionID) FROM testcase WHERE idTestcase = '" + id + "'";
        // idTestCase, tcVersionID, tcTester, tcSubCategory, tcCategory, tcScript, tcTestType, tcDescription, tcProcedure, tcExpectResult, tcSanity, tcManTestCount, tcCreateDate
        MySqlDataReader reader = dbc.ExecuteQuery(oSQL);
        int oVersion=0;

        if (reader.HasRows)
        {
            reader.Read();
            oVersion = reader.GetInt16(0);
        }
        dbc.CloseDBC();

        #region old non-used code
        /*
        string SQL = "INSERT INTO Testcase VALUES ('";
        SQL += id + "',";           // Testcase ID
        SQL += oVersion + 1 + ",'";            // Version ID
        SQL += creator + "',";           // Creator
        SQL += subCategory + ",";            // Sub Cat
        SQL += category + ",'";            // Cat
        SQL += script + "',";  // Script
        SQL += type + ",'"; // TestType
        SQL += desc + "','"; //Desc
        SQL += proc + "','"; //Proc
        SQL += result + "',"; //Expect
        SQL += sanity + ","; //Sanity
        SQL += count + ",'"; // Count
        SQL += getMySQLTodayDate() + "')"; // Date
        */
        //SQL += "Update TestCase SET tcSubCategory = "+subCategory+", tcCategory = "+category+",";
        //SQL += "tcScript = "+script+", tcTestType = "+type+", tcDescription = '"+desc+"',";
        //SQL += "tcProcedure = '"+proc+"', tcExpectResult = '"+result+"', tcSanity = "+sanity+", tcManTestCount = "+count+" WHERE idTestCase = '"+id+"' AND ";
        //return ExecNonQuerySQL(SQL);
        #endregion

        return Add_Testcase(id, subCategory, category, script, type, desc, proc, result, sanity, count, creator, oVersion + 1);
    }


    [WebMethod]
    public bool Add_Testcase(string idTestCase,int tcSubCategory, int tcCategory, string tcScript, int tcTestType, string tcDescription, string tcProcedure, string tcExpectResult, bool tcSanity, int tcManTestCount, string tcTester, int version)
    {
        if (tcScript == "")
            tcScript = "NULL";
        else
            tcScript = "'" + tcScript + "'";
        // idTestCase, tcVersionID, tcTester, tcSubCategory, tcCategory, tcScript, tcTestType, tcDescription, tcProcedure, tcExpectResult, tcSanity, tcManTestCount, tcCreateDate
        return ExecNonQuerySQL("INSERT INTO Testcase VALUES  ('"+idTestCase+"',"+version+",'"+tcTester+"',"+tcSubCategory+","+tcCategory+","+tcScript+","+tcTestType+",'"+tcDescription+"','"+tcProcedure+"','"+tcExpectResult+"',"+tcSanity+","+tcManTestCount+",'"+getMySQLTodayDate()+"')");
    }
    
    #endregion

    [WebMethod]
    public string[] Get_AllTesterName()
    {
        dbc = new MySQLDBConnector();
        ArrayList results = new ArrayList();
        string sqlStr = "SELECT tName FROM Testers";

        MySqlDataReader reader = dbc.ExecuteQuery(sqlStr);
        if (reader.HasRows)
        {
            while (reader.Read())
            {
                results.Add(reader.GetString(0));
            }
            dbc.CloseDBC();
            return makeStrArray(results);

        }
        dbc.CloseDBC();
        return new string[0];
    }
    // Temp SQL Area
    /*
     * SELECT * FROM Testcase WHERE fieldname LIKE '%value%' AND (idTestcase,tcVersionID) NOT IN (SELECT tpl_TCID, tpl_TCVID FROM TestPlanLink WHERE tp_TID = testid)
     * 
     * SELECT * FROM TestPlanLink WHERE tpl_TID = value AND (tpl_TCID,tpl_TCVID) NOT IN (SELECT tr_tpl_TCID, tr_tpl_TCVID, FROM TestRecord WHERE tr_tpl_TID = testid)
     * 
     * INSERT INTO TestPlanLink VALUES (tcvid,tcid,tid)
     * 
     * INSERT INTO TestRecord VALUES ()
     */

    #region For Test Plan Operations

    [WebMethod]
    public ArrayList Search_AvailableTestCases(string fieldname, string value, string testid)
    {
        string SQL = "";
        SQL += "SELECT idTestCase,tcVersionID, Testers.tName, scName, cName, tcScript, ttName, tcDescription, tcProcedure, tcExpectResult, tcSanity, tcManTestCount,tcCreateDate ";
        SQL += "FROM testcase, category, subcategory, testtype, testers ";
        SQL += "WHERE tcSubCategory = idSubCategory AND tcCategory = idCategory AND idTester = tcTester ";
        SQL += "AND tcTestType = idTestType AND "+fieldname+" LIKE '%"+value+"%' ";
        SQL += "AND (idTestcase,tcVersionID) NOT IN (SELECT tpl_TCID, tpl_TCVID FROM TestPlanLink WHERE tpl_TID = '"+testid+"') LIMIT 5000";
        
        MySqlDataReader reader = dbc.ExecuteQuery(SQL);
        if (reader.HasRows)
        {
            ArrayList results = new ArrayList();
            while (reader.Read())
            {
                string[] fields = new string[reader.FieldCount];
                // idTestCase, tcVersionID, tcTester, tcSubCategory, tcCategory, tcScript, tcTestType, tcDescription, tcProcedure, tcExpectResult, tcSanity, tcManTestCount, tcCreateDate
                fields[0] = reader.GetString(0);
                fields[1] = reader.GetInt16(1).ToString();
                fields[2] = reader.GetString(2); 
                fields[3] = reader.GetString(3); 
                fields[4] = reader.GetString(4);
                fields[5] = reader.GetString(5);
                fields[6] = reader.GetString(6);
                fields[7] = reader.GetString(7);
                fields[8] = reader.GetString(8);
                fields[9] = reader.GetString(9);
                fields[10] = reader.GetBoolean(10).ToString();
                fields[11] = reader.GetInt16(11).ToString();
                fields[12] = reader.GetDateTime(12).ToString();
                results.Add(fields);
            }
            dbc.CloseDBC();
            return results;
        }
        else
        {
            return new ArrayList();
        }
    }
    [WebMethod]
    public ArrayList Search_AvailableTestCases_Latest(string fieldname, string value, string testid)
    {
        string SQL = "";
        SQL += "SELECT idTestCase,MAX(tcVersionID), Testers.tName, scName, cName, tcScript, ttName, tcDescription, tcProcedure, tcExpectResult, tcSanity, tcManTestCount,tcCreateDate ";
        SQL += "FROM testcase, category, subcategory, testtype, testers ";
        SQL += "WHERE tcSubCategory = idSubCategory AND tcCategory = idCategory AND idTester = tcTester ";
        SQL += "AND tcTestType = idTestType AND " + fieldname + " LIKE '%" + value + "%' ";
        SQL += "AND (idTestcase,tcVersionID) NOT IN (SELECT tpl_TCID, tpl_TCVID FROM TestPlanLink WHERE tpl_TID = '" + testid + "') GROUP BY idTestCase LIMIT 5000";

        MySqlDataReader reader = dbc.ExecuteQuery(SQL);
        if (reader.HasRows)
        {
            ArrayList results = new ArrayList();
            while (reader.Read())
            {
                string[] fields = new string[reader.FieldCount];
                // idTestCase, tcVersionID, tcTester, tcSubCategory, tcCategory, tcScript, tcTestType, tcDescription, tcProcedure, tcExpectResult, tcSanity, tcManTestCount, tcCreateDate
                fields[0] = reader.GetString(0);
                fields[1] = reader.GetInt16(1).ToString();
                fields[2] = reader.GetString(2);
                fields[3] = reader.GetString(3);
                fields[4] = reader.GetString(4);
                fields[5] = reader.GetString(5);
                fields[6] = reader.GetString(6);
                fields[7] = reader.GetString(7);
                fields[8] = reader.GetString(8);
                fields[9] = reader.GetString(9);
                fields[10] = reader.GetBoolean(10).ToString();
                fields[11] = reader.GetInt16(11).ToString();
                fields[12] = reader.GetDateTime(12).ToString();
                results.Add(fields);
            }
            dbc.CloseDBC();
            return results;
        }
        else
        {
            return new ArrayList();
        }
    }
    [WebMethod]
    public ArrayList Search_AddedTestCases(string testid)
    {
        string SQL = "";
        SQL += "SELECT idTestCase,tcVersionID, Testers.tName, scName, cName, tcScript, ttName, tcDescription, tcProcedure, tcExpectResult, tcSanity, tcManTestCount,tcCreateDate ";
        SQL += "FROM testcase, category, subcategory, testtype, testers ";
        SQL += "WHERE tcSubCategory = idSubCategory AND tcCategory = idCategory AND idTester = tcTester ";
        SQL += "AND tcTestType = idTestType "; //AND " + fieldname + " LIKE '%" + value + "%' ";
        SQL += "AND (idTestcase,tcVersionID) IN (SELECT tpl_TCID, tpl_TCVID FROM TestPlanLink WHERE tpl_TID = '" + testid + "') LIMIT 5000";

        MySqlDataReader reader = dbc.ExecuteQuery(SQL);
        if (reader.HasRows)
        {
            ArrayList results = new ArrayList();
            while (reader.Read())
            {
                string[] fields = new string[reader.FieldCount];
                // idTestCase, tcVersionID, tcTester, tcSubCategory, tcCategory, tcScript, tcTestType, tcDescription, tcProcedure, tcExpectResult, tcSanity, tcManTestCount, tcCreateDate
                fields[0] = reader.GetString(0);
                fields[1] = reader.GetInt16(1).ToString();
                fields[2] = reader.GetString(2);
                fields[3] = reader.GetString(3);
                fields[4] = reader.GetString(4);
                fields[5] = reader.GetString(5);
                fields[6] = reader.GetString(6);
                fields[7] = reader.GetString(7);
                fields[8] = reader.GetString(8);
                fields[9] = reader.GetString(9);
                fields[10] = reader.GetBoolean(10).ToString();
                fields[11] = reader.GetInt16(11).ToString();
                fields[12] = reader.GetDateTime(12).ToString();
                results.Add(fields);
            }
            dbc.CloseDBC();
            return results;
        }
        else
        {
            return new ArrayList();
        }
    }
    [WebMethod]
    public ArrayList Get_TestCase_By_Test_Tester(string testplanID,string testerID)
    {
        string SQL = "";

        SQL += "SELECT idTestCase,tcVersionID, Testers.tName, scName, cName, tcScript, ttName, ";
        SQL += "tcDescription, tcProcedure, tcExpectResult, tcSanity, tcManTestCount,tcCreateDate, A.rtName ";

        SQL += "FROM Testcase,Category, Subcategory, Testtype, Testers, ";

        SQL += "(SELECT tr_tpl_TCID, tr_tpl_TCVID, rtName ";
        SQL += "FROM TestRecords, ResultType ";
        SQL += "WHERE tr_tpl_TID = '"+testplanID+"' AND trTester = '"+testerID+"' AND trResultType = idResultType) AS A ";

        SQL += "WHERE idTestCase = A.tr_tpl_TCID AND tcVersionID = A.tr_tpl_TCVID ";

        SQL += "AND tcSubCategory = idSubCategory ";
        SQL += "AND tcCategory = idCategory ";
        SQL += "AND idTester = tcTester ";
        SQL += "AND tcTestType = idTestType";

        MySqlDataReader reader = dbc.ExecuteQuery(SQL);
        if (reader.HasRows)
        {
            ArrayList results = new ArrayList();
            while (reader.Read())
            {
                string[] fields = new string[reader.FieldCount];
                // idTestCase, tcVersionID, tcTester, tcSubCategory, tcCategory, tcScript, tcTestType, tcDescription, tcProcedure, tcExpectResult, tcSanity, tcManTestCount, tcCreateDate
                fields[0] = reader.GetString(0);
                fields[1] = reader.GetInt16(1).ToString();
                fields[2] = reader.GetString(2);
                fields[3] = reader.GetString(3);
                fields[4] = reader.GetString(4);
                fields[5] = reader.GetString(5);
                fields[6] = reader.GetString(6);
                fields[7] = reader.GetString(7);
                fields[8] = reader.GetString(8);
                fields[9] = reader.GetString(9);
                fields[10] = reader.GetBoolean(10).ToString();
                fields[11] = reader.GetInt16(11).ToString();
                fields[12] = reader.GetDateTime(12).ToString();
                fields[13] = reader.GetString(13);
                results.Add(fields);
            }
            dbc.CloseDBC();
            return results;
        }
        else
        {
            return new ArrayList();
        }
    }
    [WebMethod]
    public ArrayList Get_TestCase_By_Test_Tester_Filter(string testplanID, string testerID)
    {
        string SQL = "";

        SQL += "SELECT idTestCase,tcVersionID, Testers.tName, scName, cName, tcScript, ttName, ";
        SQL += "tcDescription, tcProcedure, tcExpectResult, tcSanity, tcManTestCount,tcCreateDate, A.rtName ";

        SQL += "FROM Testcase,Category, Subcategory, Testtype, Testers, ";

        SQL += "(SELECT tr_tpl_TCID, tr_tpl_TCVID, rtName ";
        SQL += "FROM TestRecords, ResultType ";
        SQL += "WHERE tr_tpl_TID = '" + testplanID + "' AND trTester = '" + testerID + "' AND trResultType = 4 AND trResultType = idResultType) AS A ";
        
        SQL += "WHERE idTestCase = A.tr_tpl_TCID AND tcVersionID = A.tr_tpl_TCVID ";

        SQL += "AND tcSubCategory = idSubCategory ";
        SQL += "AND tcCategory = idCategory ";
        SQL += "AND idTester = tcTester ";
        SQL += "AND tcTestType = idTestType ";

        MySqlDataReader reader = dbc.ExecuteQuery(SQL);
        if (reader.HasRows)
        {
            ArrayList results = new ArrayList();
            while (reader.Read())
            {
                string[] fields = new string[reader.FieldCount];
                // idTestCase, tcVersionID, tcTester, tcSubCategory, tcCategory, tcScript, tcTestType, tcDescription, tcProcedure, tcExpectResult, tcSanity, tcManTestCount, tcCreateDate
                fields[0] = reader.GetString(0);
                fields[1] = reader.GetInt16(1).ToString();
                fields[2] = reader.GetString(2);
                fields[3] = reader.GetString(3);
                fields[4] = reader.GetString(4);
                fields[5] = reader.GetString(5);
                fields[6] = reader.GetString(6);
                fields[7] = reader.GetString(7);
                fields[8] = reader.GetString(8);
                fields[9] = reader.GetString(9);
                fields[10] = reader.GetBoolean(10).ToString();
                fields[11] = reader.GetInt16(11).ToString();
                fields[12] = reader.GetDateTime(12).ToString();
                fields[13] = reader.GetString(13);
                results.Add(fields);
            }
            dbc.CloseDBC();
            return results;
        }
        else
        {
            return new ArrayList();
        }
    }
    
    [WebMethod]
    public ArrayList Get_TestCase_By_Test_Tester_Field_Value(string testplanID, string testerID, string field, string value)
    {
        string SQL = "";

        SQL += "SELECT idTestCase,tcVersionID, Testers.tName, scName, cName, tcScript, ttName, ";
        SQL += "tcDescription, tcProcedure, tcExpectResult, tcSanity, tcManTestCount,tcCreateDate, A.rtName ";

        SQL += "FROM Testcase,Category, Subcategory, Testtype, Testers, ";

        SQL += "(SELECT tr_tpl_TCID, tr_tpl_TCVID, rtName ";
        SQL += "FROM TestRecords, ResultType ";
        SQL += "WHERE tr_tpl_TID = '" + testplanID + "' AND trTester = '" + testerID + "' AND trResultType = idResultType) AS A ";

        SQL += "WHERE idTestCase = A.tr_tpl_TCID AND tcVersionID = A.tr_tpl_TCVID ";

        SQL += "AND tcSubCategory = idSubCategory ";
        SQL += "AND tcCategory = idCategory ";
        SQL += "AND idTester = tcTester ";
        SQL += "AND tcTestType = idTestType ";
        SQL += "AND " + field + " LIKE '%" + value + "%'";

        MySqlDataReader reader = dbc.ExecuteQuery(SQL);
        if (reader.HasRows)
        {
            ArrayList results = new ArrayList();
            while (reader.Read())
            {
                string[] fields = new string[reader.FieldCount];
                // idTestCase, tcVersionID, tcTester, tcSubCategory, tcCategory, tcScript, tcTestType, tcDescription, tcProcedure, tcExpectResult, tcSanity, tcManTestCount, tcCreateDate
                fields[0] = reader.GetString(0);
                fields[1] = reader.GetInt16(1).ToString();
                fields[2] = reader.GetString(2);
                fields[3] = reader.GetString(3);
                fields[4] = reader.GetString(4);
                fields[5] = reader.GetString(5);
                fields[6] = reader.GetString(6);
                fields[7] = reader.GetString(7);
                fields[8] = reader.GetString(8);
                fields[9] = reader.GetString(9);
                fields[10] = reader.GetBoolean(10).ToString();
                fields[11] = reader.GetInt16(11).ToString();
                fields[12] = reader.GetDateTime(12).ToString();
                fields[13] = reader.GetString(13);
                results.Add(fields);
            }
            dbc.CloseDBC();
            return results;
        }
        else
        {
            return new ArrayList();
        }
    }
    [WebMethod]
    public ArrayList Get_TestCase_By_Test_Tester_Field_Value2(string testplanID, string testerID, string field, string value)
    {
        string SQL = "";

        SQL += "SELECT idTestCase,tcVersionID, Testers.tName, scName, cName, tcScript, ttName, ";
        SQL += "tcDescription, tcProcedure, tcExpectResult, tcSanity, tcManTestCount,tcCreateDate, A.rtName ";

        SQL += "FROM Testcase,Category, Subcategory, Testtype, Testers, ";

        SQL += "(SELECT tr_tpl_TCID, tr_tpl_TCVID, rtName ";
        SQL += "FROM TestRecords, ResultType ";
        SQL += "WHERE tr_tpl_TID = '" + testplanID + "' AND trTester = '" + testerID + "' AND trResultType <> 4 AND trResultType = idResultType) AS A ";

        SQL += "WHERE idTestCase = A.tr_tpl_TCID AND tcVersionID = A.tr_tpl_TCVID ";

        SQL += "AND tcSubCategory = idSubCategory ";
        SQL += "AND tcCategory = idCategory ";
        SQL += "AND idTester = tcTester ";
        SQL += "AND tcTestType = idTestType ";
        SQL += "AND " + field + " LIKE '%" + value + "%'";

        MySqlDataReader reader = dbc.ExecuteQuery(SQL);
        if (reader.HasRows)
        {
            ArrayList results = new ArrayList();
            while (reader.Read())
            {
                string[] fields = new string[reader.FieldCount];
                // idTestCase, tcVersionID, tcTester, tcSubCategory, tcCategory, tcScript, tcTestType, tcDescription, tcProcedure, tcExpectResult, tcSanity, tcManTestCount, tcCreateDate
                fields[0] = reader.GetString(0);
                fields[1] = reader.GetInt16(1).ToString();
                fields[2] = reader.GetString(2);
                fields[3] = reader.GetString(3);
                fields[4] = reader.GetString(4);
                fields[5] = reader.GetString(5);
                fields[6] = reader.GetString(6);
                fields[7] = reader.GetString(7);
                fields[8] = reader.GetString(8);
                fields[9] = reader.GetString(9);
                fields[10] = reader.GetBoolean(10).ToString();
                fields[11] = reader.GetInt16(11).ToString();
                fields[12] = reader.GetDateTime(12).ToString();
                fields[13] = reader.GetString(13);
                results.Add(fields);
            }
            dbc.CloseDBC();
            return results;
        }
        else
        {
            return new ArrayList();
        }
    }
    [WebMethod]
    public ArrayList Get_AssignableTestCase(string testplanID)
    {
        string SQL = "";

        SQL += "SELECT idTestCase,tcVersionID, Testers.tName, scName, cName, tcScript, ttName, ";
        SQL += "tcDescription, tcProcedure, tcExpectResult, tcSanity, tcManTestCount,tcCreateDate ";
        SQL += "FROM TestCase,category, subcategory, testtype, testers, ( ";
        SQL += "SELECT tpl_TCVID, tpl_TCID FROM TestPlanLink WHERE tpl_TID = '"+testplanID+"' AND (tpl_TCVID,tpl_TCID) ";
        SQL += "NOT IN (SELECT tr_tpl_TCVID, tr_tpl_TCID FROM TestRecords WHERE tr_tpl_TID = '"+testplanID+"')) AS A ";
        SQL += "WHERE idTestCase = A.tpl_TCID AND tcVersionID = A.tpl_TCVID AND tcSubCategory = idSubCategory ";
        SQL += "AND tcCategory = idCategory AND idTester = tcTester AND tcTestType = idTestType ";

        //SQL += "SELECT idTestCase,tcVersionID, Testers.tName, scName, cName, tcScript, ttName, tcDescription, tcProcedure, tcExpectResult, tcSanity, tcManTestCount,tcCreateDate ";
        //SQL += "FROM testcase, category, subcategory, testtype, testers, TestPlanLink ";
        //SQL += "WHERE tcSubCategory = idSubCategory AND tcCategory = idCategory AND idTester = tcTester ";
        //SQL += "AND tcTestType = idTestType ";
        //SQL += "AND tpl_TID = '" + testplanID + "' AND (tpl_TCID,tpl_TCVID) ";
        //SQL += "NOT IN (SELECT tr_tpl_TCID, tr_tpl_TCVID FROM TestRecords WHERE tr_tpl_TID = '" + testplanID + "') LIMIT 2500";

        MySqlDataReader reader = dbc.ExecuteQuery(SQL);
        if (reader.HasRows)
        {
            ArrayList results = new ArrayList();
            while (reader.Read())
            {
                string[] fields = new string[reader.FieldCount];
                // idTestCase, tcVersionID, tcTester, tcSubCategory, tcCategory, tcScript, tcTestType, tcDescription, tcProcedure, tcExpectResult, tcSanity, tcManTestCount, tcCreateDate
                fields[0] = reader.GetString(0);
                fields[1] = reader.GetInt16(1).ToString();
                fields[2] = reader.GetString(2);
                fields[3] = reader.GetString(3);
                fields[4] = reader.GetString(4);
                fields[5] = reader.GetString(5);
                fields[6] = reader.GetString(6);
                fields[7] = reader.GetString(7);
                fields[8] = reader.GetString(8);
                fields[9] = reader.GetString(9);
                fields[10] = reader.GetBoolean(10).ToString();
                fields[11] = reader.GetInt16(11).ToString();
                fields[12] = reader.GetDateTime(12).ToString();
                results.Add(fields);
            }
            dbc.CloseDBC();
            return results;
        }
        else
        {
            return new ArrayList();
        }
    }
    [WebMethod]
    public ArrayList Get_AssignedTestCase(string testplanID, string testerID)
    {
        string SQL = "";

        SQL += "SELECT idTestCase,tcVersionID, Testers.tName, scName, cName, tcScript, ttName, tcDescription, ";
        SQL += "tcProcedure, tcExpectResult, tcSanity, tcManTestCount,tcCreateDate ";
        SQL += "FROM TestCase,category, subcategory, testtype, testers, ";
        SQL += "(SELECT tr_tpl_TID,tr_tpl_TCID,tr_tpl_TCVID FROM TestRecords WHERE tr_tpl_TID = '"+testplanID+"' AND trTester = '"+testerID+"') AS A ";
        SQL += "WHERE idTestCase = A.tr_tpl_TCID AND tcVersionID = A.tr_tpl_TCVID ";
        SQL += "AND tcSubCategory = idSubCategory ";
        SQL += "AND tcCategory = idCategory ";
        SQL += "AND idTester = tcTester ";
        SQL += "AND tcTestType = idTestType";

        MySqlDataReader reader = dbc.ExecuteQuery(SQL);
        if (reader.HasRows)
        {
            ArrayList results = new ArrayList();
            while (reader.Read())
            {
                string[] fields = new string[reader.FieldCount];
                // idTestCase, tcVersionID, tcTester, tcSubCategory, tcCategory, tcScript, tcTestType, tcDescription, tcProcedure, tcExpectResult, tcSanity, tcManTestCount, tcCreateDate
                fields[0] = reader.GetString(0);
                fields[1] = reader.GetInt16(1).ToString();
                fields[2] = reader.GetString(2);
                fields[3] = reader.GetString(3);
                fields[4] = reader.GetString(4);
                fields[5] = reader.GetString(5);
                fields[6] = reader.GetString(6);
                fields[7] = reader.GetString(7);
                fields[8] = reader.GetString(8);
                fields[9] = reader.GetString(9);
                fields[10] = reader.GetBoolean(10).ToString();
                fields[11] = reader.GetInt16(11).ToString();
                fields[12] = reader.GetDateTime(12).ToString();
                results.Add(fields);
            }
            dbc.CloseDBC();
            return results;
        }
        else
        {
            return new ArrayList();
        }
    }
    [WebMethod]
    public ArrayList Get_TestPlanInfo(string id)
    {
        dbc = new MySQLDBConnector();
        ArrayList results = new ArrayList();
        string SQL = "SELECT idTest,tSoftwareVersion,tName,tDateStart,tDateEnd,Test.tDesc,tps_Name ";
        SQL += "FROM Test,Testers,TestPlanStatus ";
        SQL += "WHERE idTest = '" + id + "' AND tStatus = idTestPlanStatus AND tCreator = idTester";
        MySqlDataReader reader = dbc.ExecuteQuery(SQL);

        if (reader.HasRows)
        {
            while (reader.Read())
            {
                string[] fields = new string[reader.FieldCount];
                fields[0] = reader.GetString(0);
                fields[1] = reader.GetInt16(1).ToString();
                fields[2] = reader.GetString(2);
                if (reader.IsDBNull(3))
                    fields[3] = "";
                else
                    fields[3] = reader.GetDateTime(3).ToString();

                if (reader.IsDBNull(4))
                    fields[4] = "";
                else
                    fields[4] = reader.GetDateTime(4).ToString();

                if (reader.IsDBNull(5))
                    fields[5] = "";
                else
                    fields[5] = reader.GetString(5);

                fields[6] = reader.GetString(6);
                results.Add(fields);
            }
        }
        dbc.CloseDBC();

        return results;
    }
    [WebMethod]
    public ArrayList Get_Test_By_Tester(string testerID)
    {
        string SQL = "SELECT DISTINCT tr_tpl_TID FROM TestRecords,(SELECT idTest AS TID FROM Test WHERE tStatus = 2) AS T1 WHERE tr_tpl_TID = T1.TID AND trTester = '" + testerID + "'";

        //string SQL2 = "SELECT DISTINCT tr_tpl_TID           FROM TestRecords       WHERE                                         trTester = '" + testerID + "'";

        MySqlDataReader reader = dbc.ExecuteQuery(SQL);
        ArrayList result = new ArrayList();
        while (reader.Read())
        {
            string[] fields = new string[1];
            fields[0] = reader.GetString(0);
            result.Add(fields);
        }
        return result;
    }
    [WebMethod]
    public ATDB_Err Add_TestCaseToTestPlan(TestPlanLinkObj[] arr)
    {
        bool result = true;
        for (int i = 0; i < arr.Length; i++)
        {
            result = ExecNonQuerySQL("INSERT INTO TestPlanLink VALUES (" + arr[i].TCVID + ",'" + arr[i].TCID + "','" + arr[i].TID + "')");
            if (!result)
                return new ATDB_Err(1, "Record insertion Fail. Please check and try again.");
        }
        return new ATDB_Err(0, "");
    }
    [WebMethod]
    public ATDB_Err Add_TestCaseToTester(TestPlanLinkObj[] arr, string testerID)
    {
        bool result = true;
        for (int i = 0; i < arr.Length; i++)
        {
            result = ExecNonQuerySQL("INSERT INTO TestRecords VALUES ('" + arr[i].TID + "','" + arr[i].TCID + "'," + arr[i].TCVID + ",null,null,null,'" + testerID + "',4,null,null,null,null)");
            if (!result)
                return new ATDB_Err(1, "Record insertion Fail. Please check and try again.");
        }
        return new ATDB_Err(0, "");
    }
    [WebMethod]
    public ATDB_Err Delete_TestCaseFromTestPlan(TestPlanLinkObj[] arr)
    {
        bool result = true;
        for (int i = 0; i < arr.Length; i++)
        {
            result = ExecNonQuerySQL("DELETE FROM TestPlanLink WHERE tpl_TCVID = '" + arr[i].TCVID + "' AND tpl_TCID = '" + arr[i].TCID + "' AND tpl_TID = '" + arr[i].TID + "'");
            if (!result)
                return new ATDB_Err(1, "Record deletion fail. Please check and try again.");
        }
        return new ATDB_Err(0, "");
    }
    [WebMethod]
    public ATDB_Err Delete_TestCaseFromTester(TestPlanLinkObj[] arr, string testerID)
    {
        bool result = true;
        for (int i = 0; i < arr.Length; i++)
        {
            result = ExecNonQuerySQL("DELETE FROM TestRecords WHERE tr_tpl_TID = '" + arr[i].TID + "' AND tr_tpl_TCID = '" + arr[i].TCID + "' AND tr_tpl_TCVID = '" + arr[i].TCVID + "' AND trTester = '" + testerID + "'");
            if (!result)
                return new ATDB_Err(1, "Record deletion Fail. Please check and try again.");
        }
        return new ATDB_Err(0, "");
    }    
    [WebMethod]
    public ATDB_Err Update_TestPlan_SV_DESC(string testID, int svIndex, string desc)
    {
        if (ExecNonQuerySQL("UPDATE Test SET tSoftwareVersion = " + svIndex + " , tDesc = '" + desc + "' WHERE idTest = '" + testID + "'"))
        {
            return new ATDB_Err(0, "");
        }
        else
        {
            return new ATDB_Err(1, "Update Error! Please check and try again.");
        }
    }
    [WebMethod]
    public ATDB_Err Start_TestPlan(string testID,string testerID)
    {
        bool resultX = true;

        resultX = ExecNonQuerySQL("UPDATE Test SET tStatus = 2, tDateStart = '" + getMySQLTodayDate() + "' WHERE idTest = '" + testID + "'");
        if (!resultX)
            return new ATDB_Err(1, "Record update fail. Please check and try again.");
        else
        {
            /*
            string SQL = "";
            SQL += "SELECT idTest, svName, tName, tDateStart, t.tDesc ";
            SQL += "FROM test t, softwareversion, testers ";
            SQL += "WHERE tCreator = idTester AND tSoftwareVersion = idSoftwareVersion AND idTest = '"+testID+"'";
            
            WE3MailSender mailer = new WE3MailSender();
            MySqlDataReader reader = dbc.ExecuteQuery(SQL);
            reader.Read();
            string testName = reader.GetString(0);
            string softwareName = reader.GetString(1);
            string creatorName = reader.GetString(2);
            string dateStart = reader.GetDateTime(3).ToLongDateString();
            string testDesc = reader.GetString(4);
            dbc.CloseDBC();

            string SQL2 = "";
            SQL2 += "SELECT DISTINCT trTester,tName,tEmail ";
            SQL2 += "FROM testrecords, testers ";
            SQL2 += "WHERE tr_tpl_TID = '"+testID+"' ";
            SQL2 += "AND trTester = idTester ";

            reader = dbc.ExecuteQuery(SQL2);
            ArrayList result = new ArrayList();
            while (reader.Read())
            {
                string[] names = new string[3];
                names[0] = reader.GetString(0);
                names[1] = reader.GetString(1);
                names[2] = reader.GetString(2);
                result.Add(names);
            }
            dbc.CloseDBC();

            for (int i = 0; i < result.Count; i++)
            {
                string[] tmp = (string[])result[i];
                string SQL3 = "";
                SQL3 += "SELECT tr_tpl_TCID, tr_tpl_TCVID ";
                SQL3 += "FROM testrecords, testers ";
                SQL3 += "WHERE tr_tpl_TID = '"+testID+"' ";
                SQL3 += "AND trTester = idTester AND trTester = '"+tmp[0]+"'";

                string subject = "New test plan created";
                string content = "Hello! "+tmp[1]+ ". Here is the details about this test plan: \n";
                content += "Test plan ID: " + testName + "\n";
                content += "Test leader: " + creatorName + "\n";
                content += "Test created date: " + dateStart + "\n";
                content += "Test description: " + testDesc + "\n\n";
                content += "Below is the test cases assigned to you: \n";
                
                reader = dbc.ExecuteQuery(SQL3);
                while(reader.Read())
                {
                    content += "Test case: "+reader.GetString(0) + " Version: " + reader.GetString(1) + "\n";
                }
                dbc.CloseDBC();



                mailer.setSender("atdb@we3technology.com", "Testing database system");
                mailer.addRecipient(tmp[2], tmp[1]);
                mailer.sendMail(subject, content);
                mailer.flushMail();
            }
*/
            return new ATDB_Err(0, "");
        }
    }
    [WebMethod]
    public ATDB_Err Close_TestPlan(string testID, string testerID)
    {
        bool resultX = true;

        resultX = ExecNonQuerySQL("UPDATE Test SET tStatus = 3, tDateEnd = '" + getMySQLTodayDate() + "' WHERE idTest = '" + testID + "' AND tCreator = '"+testerID+"'");
        if (!resultX)
        {
            return new ATDB_Err(1, "Record update fail. Please check and try again.");
        }
        else
        {
            return new ATDB_Err(0, "");
        }
    }
    
    #endregion

    [WebMethod]
    public ATDB_Err Update_TestRecord(TestRecordObj tr)
    {
        string SQL = "Update TestRecords ";
        SQL += "SET trPhone = " + tr.Phone + ", trSeverity = " + tr.Severity + ", trSimCard = " + tr.SimCard + ", ";
        SQL += "trResultType = " + tr.ResultType + ", trComment = '" + tr.Comment + "', trTimeUsed = " + tr.Time + ", ";
        SQL += "trDDTS = '" + tr.DDTS + "', trSuccCount = " + tr.SuccCount + " ";
        SQL += "WHERE tr_tpl_TID = '" + tr.TID + "' AND tr_tpl_TCID = '" + tr.TCID + "' AND tr_tpl_TCVID = '" + tr.TCVID + "' AND trTester = '" + tr.Tester + "'";
        bool result = true;
        result = ExecNonQuerySQL(SQL);
        if (result)
            return new ATDB_Err(0, "");
        else
            return new ATDB_Err(1, "Error occured when updating record.");
    }

    

    #region For Simple Value Pairs which used for loading into combo boxes

    [WebMethod]
    public ArrayList Get_Phone()
    {
        MySqlDataReader reader = dbc.ExecuteQuery("SELECT idPhone, pHardwareNumber FROM phone");
        ArrayList result = new ArrayList();
        if (reader.HasRows)
        {
            while (reader.Read())
            {
                string[] fields = new string[2];
                fields[0] = reader.GetString(0);
                fields[1] = reader.GetString(1);
                result.Add(fields);
            }
        }
        return result;
    }
    [WebMethod]
    public ArrayList Get_Phone2()
    {
       // MySqlDataReader reader = dbc.ExecuteQuery("SELECT idPhone, pHardwareNumber FROM phone");
        ArrayList result = new ArrayList();
        //if (reader.HasRows)
        //{
           // while (reader.Read())
           // {
                string[] fields = new string[2];
               // fields[0] = reader.GetString(0);
               // fields[1] = reader.GetString(1);
                result.Add(fields);
          //  }
        //}
        return result;
    }
    [WebMethod]
    public ArrayList getFeedItemType()
    {
        ArrayList resultList = new ArrayList();

        //DataSet ds = dbc.ExecuteQuery("SELECT * FROM FeedItemType");
        //DataTable dt = ds.Tables[0];
        //string[] resultsX = new string[2];
        int[] resultsX = new int[2];
        resultsX[0] = 1;
        resultsX[1] = 2;
        //resultList.Add(resultsX);
        string[] fbe = new string[2];
        fbe[0] = "aaa";
        fbe[1] = "bbb";
        resultList.Add(1);
        resultList.Add("str");
        resultList.Add(fbe);
        return resultList;
    }
    [WebMethod]
    public ArrayList Get_SIMCard()
    {
        MySqlDataReader reader = dbc.ExecuteQuery(" SELECT idSimCard, scPhoneNum FROM SimCard");
        ArrayList result = new ArrayList();
        if (reader.HasRows)
        {
            while (reader.Read())
            {
                string[] fields = new string[2];
                fields[0] = reader.GetString(0);
                fields[1] = reader.GetString(1);
                result.Add(fields);
            }
        }
        return result;
    }

    [WebMethod]
    public ArrayList Get_ResultType()
    {
        MySqlDataReader reader = dbc.ExecuteQuery(" SELECT idResultType, rtName FROM resulttype WHERE idResultType <> 4");
        ArrayList result = new ArrayList();
        if (reader.HasRows)
        {
            while (reader.Read())
            {
                string[] fields = new string[2];
                fields[0] = reader.GetString(0);
                fields[1] = reader.GetString(1);
                result.Add(fields);
            }
        }
        return result;
    }

    [WebMethod]
    public ArrayList Get_Severity()
    {
        MySqlDataReader reader = dbc.ExecuteQuery(" SELECT idSeverity, sName FROM severity");
        ArrayList result = new ArrayList();
        if (reader.HasRows)
        {
            while (reader.Read())
            {
                string[] fields = new string[2];
                fields[0] = reader.GetString(0);
                fields[1] = reader.GetString(1);
                result.Add(fields);
            }
        }
        return result;
    }

    [WebMethod]
    public ArrayList Get_SoftwareVersion()
    {
        string SQL = "SELECT idSoftwareVersion, svName FROM SoftwareVersion";
        MySqlDataReader reader = dbc.ExecuteQuery(SQL);
        ArrayList results = new ArrayList();
        if (reader.HasRows)
        {
            while (reader.Read())
            {
                string[] tmpStr = new string[2];
                tmpStr[0] = reader.GetInt16(0).ToString();
                tmpStr[1] = reader.GetString(1);
                results.Add(tmpStr);
            }
        }
        dbc.CloseDBC();
        return results;
    }

    [WebMethod]
    public ArrayList Get_Category()
    {
        string SQL = "SELECT idCategory, cName FROM Category";
        MySqlDataReader reader = dbc.ExecuteQuery(SQL);
        ArrayList results = new ArrayList();
        if (reader.HasRows)
        {
            while (reader.Read())
            {
                string[] tmpStr = new string[2];
                tmpStr[0] = reader.GetInt16(0).ToString();
                tmpStr[1] = reader.GetString(1);
                results.Add(tmpStr);
            }
        }
        dbc.CloseDBC();
        return results;
    }

    [WebMethod]
    public ArrayList Get_TestType()
    {
        string SQL = "SELECT idTestType, ttName FROM TestType";
        MySqlDataReader reader = dbc.ExecuteQuery(SQL);
        ArrayList results = new ArrayList();
        if (reader.HasRows)
        {
            while (reader.Read())
            {
                string[] tmpStr = new string[2];
                tmpStr[0] = reader.GetInt16(0).ToString();
                tmpStr[1] = reader.GetString(1);
                results.Add(tmpStr);
            }
        }
        dbc.CloseDBC();
        return results;
    }

    [WebMethod]
    public ArrayList Get_SubCategory(int parent)
    {
        string SQL = "SELECT idSubCategory, scName FROM SubCategory WHERE scParentCategory = " + parent;
        MySqlDataReader reader = dbc.ExecuteQuery(SQL);
        ArrayList results = new ArrayList();
        if (reader.HasRows)
        {
            while (reader.Read())
            {
                string[] tmpStr = new string[2];
                tmpStr[0] = reader.GetInt16(0).ToString();
                tmpStr[1] = reader.GetString(1);
                results.Add(tmpStr);
            }
        }
        dbc.CloseDBC();
        return results;
    }

    [WebMethod]
    public string[] Get_Table_Fields(string tablename)
    {
        MySqlDataReader reader = dbc.ExecuteQuery("SELECT * FROM " + tablename + " LIMIT 0");
        string[] fields = new string[reader.FieldCount];
        for (int i = 0; i < reader.FieldCount; i++)
        {
            fields[i] = reader.GetName(i);
        }
        dbc.CloseDBC();
        return fields;
    }

    #endregion


    #region CONCURRENT_ACCESS_CONTROL

    public enum LOCK_STATE { LOCK_NOT_EXIST, LOCK_EXPIRE_SAME_ID, LOCK_EXPIRE_DIFF_ID, LOCK_NOT_EXPIRE_SAME_ID, LOCK_NOT_EXPIRE_DIFF_ID };

    [WebMethod]
    public LOCK_STATE isRecordLocked(string id, string table, string tester)
    {
        string SQL = "SELECT * FROM RecordLock WHERE idRecordLock = '" + id + "' AND rlTable = '" + table + "' LIMIT 1";
        MySqlDataReader reader = dbc.ExecuteQuery(SQL);
        LOCK_STATE result;

        if (reader.HasRows) // If record lock exist
        {
            reader.Read();
            if (((TimeSpan)(DateTime.Now - reader.GetDateTime(3))).Minutes > 15) // If record locked more than 15 mins
            {
                if (reader.GetString(2) == tester) // locked more than 15 mins and same tester
                {
                    result = LOCK_STATE.LOCK_EXPIRE_SAME_ID;
                }
                else // locked more than 15 mins and different tester
                {
                    result = LOCK_STATE.LOCK_EXPIRE_DIFF_ID;
                }
            }
            else // If record exist but locked less than 15 mins, nothing happen
            {
                if (reader.GetString(2) == tester) // locked less than 15 mins and same tester
                {
                    result = LOCK_STATE.LOCK_NOT_EXPIRE_SAME_ID;
                }
                else // locked less than 15 mins and different tester
                {
                    result = LOCK_STATE.LOCK_NOT_EXPIRE_DIFF_ID;
                }
            }
        }
        else // If record lock not exist
        {
            result = LOCK_STATE.LOCK_NOT_EXIST;
        }
        dbc.CloseDBC();
        return result;
    }
    [WebMethod]
    public ATDB_Err lockRecord(string id, string table, string tester)
    {
        string SQL;
        string date = getMySQLTodayDate();

        LOCK_STATE lockState = isRecordLocked(id, table, tester);

        if (lockState == LOCK_STATE.LOCK_NOT_EXPIRE_DIFF_ID || lockState == LOCK_STATE.LOCK_NOT_EXPIRE_SAME_ID) // Record lock exist and not expired
        {
            return new ATDB_Err(1, "This record is currently locked by " + tester);
        }
        else if (lockState == LOCK_STATE.LOCK_NOT_EXIST) // Record lock not exist
        {
            SQL = "INSERT INTO RecordLock VALUES('" + id + "','" + table + "','" + tester + "','" + date + "')";

            if (ExecNonQuerySQL(SQL))
            {
                return new ATDB_Err(0, "");
            }
            else
            {
                return new ATDB_Err(2, "System tried to lock record but failed");
            }
        }
        else if (lockState == LOCK_STATE.LOCK_EXPIRE_DIFF_ID || lockState == LOCK_STATE.LOCK_EXPIRE_SAME_ID) // Record lock exist and expired
        {
            // Gaining ownership
            SQL = "UPDATE RecordLock SET rlTester = '" + tester + "', rlDate = '" + date + "' WHERE idRecordLock = '" + id + "' AND rlTable = '" + table + "'";

            if (ExecNonQuerySQL(SQL))
            {
                return new ATDB_Err(0, "");
            }
            else
            {
                return new ATDB_Err(2, "System tried to lock record but failed");
            }
        }
        else
        {
            return new ATDB_Err(5, "Unknown Error Occured");
        }
    }
    [WebMethod]
    public ATDB_Err unlockRecord(string id, string table, string tester)
    {
        string SQL;
        LOCK_STATE result = isRecordLocked(id, table, tester);

        if (result == LOCK_STATE.LOCK_NOT_EXPIRE_SAME_ID)
        {
            SQL = "DELETE FROM RecordLock WHERE idRecordLock = '" + id + "' AND rlTable = '" + table + "' AND rlTester = '" + tester + "'";

            if (ExecNonQuerySQL(SQL))
            {
                return new ATDB_Err(0, "");
            }
            else
            {
                return new ATDB_Err(2, "System tried to unlock record but failed");
            }
        }
        else if (result == LOCK_STATE.LOCK_NOT_EXPIRE_DIFF_ID)
        {
            return new ATDB_Err(3, "Why would you want to unlock other tester lock?");
        }
        else if (result == LOCK_STATE.LOCK_EXPIRE_DIFF_ID || result == LOCK_STATE.LOCK_NOT_EXPIRE_SAME_ID)
        {
            return new ATDB_Err(4, "This lock is not functioning as it expired alreday.");
        }
        else if (result == LOCK_STATE.LOCK_NOT_EXIST)
        {
            return new ATDB_Err(1, "This record hasn't locked.");
        }
        else
        {
            return new ATDB_Err(5, "Unknown Error Occured.");
        }
    }

    #endregion

    #region Utilies Methods and Misc Codes that are useful

    protected string[] makeStrArray(ArrayList list)
    {
        string[] results = new string[list.Count];
        for (int i = 0; i < results.Length; i++)
        {
            results[i] = (string)list[i];
        }
        return results;
    }

    public string toMySQLDateTime(DateTime date)
    {
        return date.Year + "/" + date.Month + "/" + date.Day + " " + date.Hour + ":" + date.Minute + ":" + date.Second;
    }

    public string getMySQLTodayDate()
    {
        return DateTime.Today.Year + "/" + DateTime.Today.Month + "/" + DateTime.Today.Day + " " + DateTime.Now.Hour + ":" + DateTime.Now.Minute + ":" + DateTime.Now.Second;
    }

    public class ATDB_Err
    {
        public int code;
        public string msg;
        public ATDB_Err() { code = 0; msg = ""; }
        public ATDB_Err(int c, string m) { code = c; msg = m; }
    }

    protected bool ExecNonQuerySQL(string SQL)
    {
        if (dbc == null)
            dbc = new MySQLDBConnector();

        int resultCount = dbc.ExecuteNonQuery(SQL);

        dbc.CloseDBC();

        if (resultCount == 1) return true; else return false;
    }

    #endregion

    #region Custom Data Transfer Objects

    public class TestPlanLinkObj
    {
        public string TID;
        public string TCID;
        public int TCVID;
    }

    public class transferObj
    {
        public string ID;
        public int Software_Version;
        public string Creator;
        public DateTime Start_Date;
        public DateTime End_Date;
        public string Description;
        public int Status;
    }

    public class TestRecordObj
    {
        public string TID;
        public string TCID;
        public string TCVID;
        public string Phone;
        public string Tester;
        public string Comment;
        public string DDTS;

        public int ResultType;
        public int Severity;
        public int SimCard;
        public int SuccCount;
        public int Time;
    }

    #endregion

    
    #region Program fragments that were no longer used

    /// <summary>
    /// Used to check whether the SQL statement contains  ' which will cause exception and corrupt the original SQL
    /// </summary>
    /// <param name="SQL"></param>
    /// <returns></returns>
    protected bool vaildateInsertSQL(string SQL)
    {
        int startIndex = SQL.IndexOf("(");
        int lastIndex = SQL.LastIndexOf(")");
        string tmp = SQL.Substring(startIndex+1,lastIndex-startIndex-1);
        string[] strs = tmp.Split(',');
        for (int i = 0; i < strs.Length; i++)
        {
            if (strs[i] != "''")
            {
                if (strs[i].StartsWith("'") && strs[i].EndsWith("'"))
                {
                    if (strs[i].Substring(1, strs[i].Length - 2).Contains("'"))
                        return false;
                }
                else if (!strs[i].StartsWith("'") && !strs[i].EndsWith("'"))
                {
                    if (strs[i].Contains("'"))
                        return false;
                }
                else
                {
                    return false;
                }
            }
        }
        return true;
    }

    /// <summary>
    /// just used to test for the pure xml object return from calling a web service
    /// </summary>
    /// <returns>just a sample xml output from web service</returns>
    [WebMethod]
    public XmlDocument testDict()
    {
        XmlDocument x = new XmlDocument();
        x.CreateTextNode("<a>" + "x" + "</a>");
        x.CreateTextNode("<b>" + "1" + "</b>");
        x.CreateTextNode("<c>" + "true" + "</c>");
        return x;
    }

    /// <summary>
    /// This method was used to test
    /// </summary>
    /// <param name="arr"></param>
    /// <returns></returns>
    [WebMethod]
    public bool testArray(string[] arr)
    {
        for (int i = 0; i < arr.Length; i++)
            if (ExecNonQuerySQL("INSERT INTO recordlock VALUES ('" + arr[i] + "','testArray','te001','" + getMySQLTodayDate() + "')") == false)
                return false;

        return true;
    }

    public class ABC
    {
        public string X;
        public int Y;
        public bool Z;

        public ABC()
        {
            X = "xxx";
            Y = 1;
            Z = true;
        }
        public ABC(string x, int y, bool z)
        {
            X = x;
            Y = y;
            Z = z;
        }
    }

    [WebMethod]
    public ABC getABC()
    {
        return new ABC("aaa", 10, false);
    }

    [WebMethod]
    public ArrayList TestDraw()
    {
        string SQL = "";
        SQL += "SELECT idTest, svName, (SELECt Count(*)FROM testrecords WHERE trTestID = idTest)  as TestCaseNum, ";
        SQL += "(SELECt Count(*)FROM testrecords WHERE trTestID = idTest AND trResultType = 1)  as TestCaseSucc ";
        SQL += "FROM test as t, softwareversion as sv WHERE idSoftwareVersion = tSoftwareVersion";
        MySqlDataReader reader = dbc.ExecuteQuery(SQL);
        ArrayList tmpList = new ArrayList(2);
        reader.Read();
        string[] tmpStrs = new string[4];
        tmpStrs[0] = reader.GetString(0);
        tmpStrs[1] = reader.GetString(1);
        tmpStrs[2] = reader.GetInt16(2).ToString();
        tmpStrs[3] = reader.GetInt16(3).ToString();
        tmpList.Add(tmpStrs);
        reader.Read();
        tmpStrs = new string[4];
        tmpStrs[0] = reader.GetString(0);
        tmpStrs[1] = reader.GetString(1);
        tmpStrs[2] = reader.GetInt16(2).ToString();
        tmpStrs[3] = reader.GetInt16(3).ToString();
        tmpList.Add(tmpStrs);
        dbc.CloseDBC();
        return tmpList;
    }

    [WebMethod]
    public void Add_Dummy_TestCaseRecords()
    {
        for (int i = 0; i < 10000; i++)
        {
            ExecNonQuerySQL("INSERT INTO TestCase VALUES ('" + i + "',0,'TE001',26,1,NULL,1,'Dummy Description','Dummy Procedure','Dummy Result',1,1,'" + getMySQLTodayDate() + "')");
        }
    }
    #endregion
}