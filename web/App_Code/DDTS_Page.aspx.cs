/// <summary>
/// Summary description for DDTS_Util
/// </summary>
/// 
using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Net.Mail;
using MySql.Data.MySqlClient;

public partial class DDTS_Page : System.Web.UI.Page
{
    protected MySQLDBConnector mysql;
    protected MySqlDataReader reader;

    public DDTS_Page() {}

    public void ShowMsgBox(System.Web.UI.Page apage, string msg)
    {
        string alertScript = "";
        alertScript += "<script language=JavaScript>";
        alertScript += "alert('" + msg + "');";
        alertScript += "</script>";
        if (!apage.ClientScript.IsClientScriptBlockRegistered("alert"))
            apage.ClientScript.RegisterClientScriptBlock(apage.GetType(), "alert", alertScript);
    }

    public Boolean checkLoginSession()
    {
        if (Session["username"] == null)
        {
            Response.Redirect("login.aspx");
            return false;
        }
        else
            return true;
    }

    public string toMySQLDateString(DateTime date)
    {
        return date.Year + "-" + date.Month + "-" + date.Day;
    }

    public void fillDropDownList(string SQL, string textField, string valueField, DropDownList ddlist)
    {
        mysql = new MySQLDBConnector();
        reader = mysql.ExecuteQuery(SQL);
        ddlist.DataSource = reader;
        ddlist.DataTextField = textField;
        ddlist.DataValueField = valueField;
        ddlist.DataBind();
        reader.Close();
        mysql.CloseDBC();
    }

    public string getSimpleSingalField(string SQL)
    {
        string str;
        mysql = new MySQLDBConnector();
        reader = mysql.ExecuteQuery(SQL);
        if (reader.HasRows)
        {
            reader.Read();
            str = reader.GetString(0);
        }
        else 
            str = "Not Assigned";

        reader.Close();
        mysql.CloseDBC();
        
        return str;
    }

    public void SendMailToProjectMembers(string projectID, string subject, string body)
    {
        mysql = new MySQLDBConnector();
        reader = mysql.ExecuteQuery("SELECT CONCAT(SEFN,' ',SELN) AS fullname , SEM FROM Staff WHERE SID IN ( SELECT SID FROM project_mailinglist WHERE PID = '" + projectID + "')");
        if (reader.HasRows)
        {
            //Send Notification Email
            MailMessage email = new MailMessage();
            MailAddress from = new MailAddress("we3ddts@we3tech.com", "Defects Detection And Tracking System (DDTS)");
            while (reader.Read())
            {
                MailAddress to = new MailAddress(reader.GetString(1), reader.GetString(0));
                email.To.Add(to);
            }
            email.From = from;
            email.Subject = subject;
            email.Body = body;
  
            SmtpClient smtp = new SmtpClient("smtp.we3tech.com");
            smtp.Send(email);
        }
        reader.Close();
        mysql.CloseDBC();
    }
}
