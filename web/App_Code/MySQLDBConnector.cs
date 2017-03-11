using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using MySql.Data.MySqlClient;

/// <summary>
/// Summary description for MySQLDBConnector
/// </summary>
public class MySQLDBConnector
{
    protected MySqlConnection conn; 
    protected MySqlCommand cmd;
    protected MySqlDataReader reader;
    protected string connStr = "Database=we3_atdb;Data Source=localhost;User Id=root;Password=estpolis";
    private string connStr_Database = "we3_atdb";
    private string connStr_DataSource = "localhost";
    private string connStr_UserID = "root";
    private string connStr_Password = "estpolis";

    #region For Database Connection and Connection String
    public void setDatabaseName(string databaseName)
    {
        connStr_Database = databaseName;
    }
    public string getDatabaseName()
    {
        return connStr_Database;
    }

    public void setDataSourceName(string dataSource)
    {
        connStr_DataSource = dataSource;
    }
    public string getDataSourceName()
    {
        return connStr_DataSource;
    }

    public void setUserID(string userID)
    {
        connStr_UserID = userID;
    }
    public string getUserID()
    {
        return connStr_UserID;
    }

    public void setPassword(string password)
    {
        connStr_Password = password;
    }
    public string getPassword()
    {
        return connStr_Password;
    }

    public void setConnectionString(string databaseName, string dataSourceName, string userID, string password)
    {
        setDatabaseName(databaseName);
        setDataSourceName(dataSourceName);
        setUserID(userID);
        setPassword(password);
    }

    public string getConnectionString()
    {
        return "Database=" + getDatabaseName() + ";Data Source=" + getDataSourceName() + ";User Id=" + getUserID() + ";Password=" + getPassword();
    }

    #endregion

    public MySQLDBConnector()
    {
        OpenDBC(this.connStr);
    }

    // Overloaded constructor
    public MySQLDBConnector(string connStr)
    {
        this.connStr = connStr;
        OpenDBC(this.connStr);
    }

    protected void OpenDBC(string connStr)
    {
        conn = new MySqlConnection(connStr);
        conn.Open();
    }

    protected void CheckDBC()
    {
        if (conn == null || conn.State == ConnectionState.Closed)
            OpenDBC(this.connStr);
    }

    public MySqlDataReader ExecuteQuery(string sqlStr)
    {
        CheckDBC();
        cmd = new MySqlCommand(sqlStr, conn);
        reader = cmd.ExecuteReader();
        return reader;
    }

    /// <summary>
    /// [2006/03/03]
    /// Make use of transaction roll back in future version,
    /// no transaction support in this version due to the slow of the transaction process
    /// </summary>
    /// <param name="sqlStr"></param>
    /// <returns></returns>
    public int ExecuteNonQuery(string sqlStr)
    {
        int resultCount = 0;

        CheckDBC();

        try
        {
            cmd = new MySqlCommand(sqlStr, conn);
            resultCount = cmd.ExecuteNonQuery();
        }
        catch (Exception)
        {
            resultCount = 0;
        }

        return resultCount;
    }


    public void execute(string SQL)
    {
        //MySqlConnection connection = new MySqlConnection(
        //MySqlCommandBuilder builder = new MySqlCommandBuilder(
        //MySqlCommand cmdd = new MySqlCommand(
        //MySqlDataReader reader = dbc
        //MySqlDataAdapter adapter =
    }

    public object ExecuteScalar(string sqlStr)
    {
        CheckDBC();
        cmd = new MySqlCommand(sqlStr, conn);
        return cmd.ExecuteScalar();
    }

    public void CloseDBC()
    {
        if (reader != null)
            reader.Close();

        if(conn != null)
            conn.Close();
    }

}
