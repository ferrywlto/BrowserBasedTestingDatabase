using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

/// <summary>
/// Summary description for Class1
/// </summary>
public class TestType
{
    int idTextType;
    string ttName, ttDesc;

	public TestType(int id, string name, string desc)
	{
        this.idTextType = id;
        this.ttName = name;
        this.ttDesc = desc;
	}
}

public class ResultType
{
    int idResultType;
    string rtName, rtDesc;

    public ResultType(int id, string name, string desc)
    {
        this.idResultType = id;
        this.rtName = name;
        this.rtDesc = desc;
    }
}

public class Category
{
    int idCategory;
    string cName, cDesc;

    public Category(int id, string name, string desc)
    {
        this.idCategory = id;
        this.cName = name;
        this.cDesc = desc;
    }
}

public class Testers
{
    string idTester, tName, tDesc;
    public Testers(string id, string name, string desc)
    {
        this.idTester = id;
        this.tName = name;
        this.tDesc = desc;
    }
}

public class SubCategory
{
    int idSubCategory;
    string scName, scDesc, scParentCategory;
    public SubCategory(int id, string name, string desc, string parent)
    {
        this.idSubCategory = id;
        this.scName = name;
        this.scDesc = desc;
        this.scParentCategory = parent;
    }
}

public class Test
{
    string idTest, tDesc, tCreatedBy;
    DateTime tDateStart, tDateEnd;
    public Test(string id, string createdby, string desc, DateTime start, DateTime end)
    {
        this.idTest = id;
        this.tCreatedBy = createdby;
        this.tDesc = desc;
        this.tDateStart = start;
        this.tDateEnd = end;
    }
}

public class TestCase
{
    string idTestCase, tcProcedure, tcDescription, tcExpectResult;
    int tcScript, tcCategory, tcTestType;
    bool tcSanity;

    public TestCase(string id, string proc, string desc, string result, int script, int category, int testtype, bool sanity)
    {
        this.idTestCase = id;
        this.tcProcedure = proc;
        this.tcDescription = desc;
        this.tcExpectResult = result;
        this.tcScript = script;
        this.tcCategory = category;
        this.tcTestType = testtype;
        this.tcSanity = sanity;
    }
}

public class TestScript
{
    string idTestScript, tsVaildatedBy, tsSubmittedBy, tsFilePath;
    DateTime tsSubmitDate;

    public TestScript(string id, string vaildate, string submit, string path, DateTime date)
    {
        this.idTestScript = id;
        this.tsVaildatedBy = vaildate;
        this.tsSubmittedBy = submit;
        this.tsFilePath = path;
        this.tsSubmitDate = date;
    }
}

public class TestRecords
{
    int trResultType;
    string trTestCaseID, trTestID, trTester, trComment;

    public TestRecords(string test, string testcase, string tester, int result, string comment)
    {
        this.trTestID = test;
        this.trTestCaseID = testcase;
        this.trTester = tester;
        this.trResultType = result;
        this.trComment = comment;
    }
}