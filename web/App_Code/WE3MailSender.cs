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
/// <summary>
/// Summary description for WE3MailSender
/// </summary>
public class WE3MailSender
{
    protected static string ServerAddress = "192.168.2.233";

    protected MailMessage mail;

    public static void setSMTP_Server(string serverAddress)
    {
        ServerAddress = serverAddress;
    }

    public void setSender(string emailAddress, string displayName)
    {
        if (mail == null) mail = new MailMessage();

        mail.From = new MailAddress(emailAddress, displayName);
    }
    public void addRecipient(string emailAddress, string displayName)
    {
        if(mail == null) mail = new MailMessage();

        mail.To.Add(new MailAddress(emailAddress, displayName));
    }

    public void sendMail(string subject, string content)
    {
        if (mail == null) mail = new MailMessage();

        else if (mail.To == null || mail.From == null) return;

        else
        {
            mail.Subject = subject;
            mail.Body = content;
            SmtpClient smtpClient = new SmtpClient(ServerAddress);
            smtpClient.Send(mail);
        }
    }

    public void flushMail()
    {
        mail.To.Clear();
        mail.From = null;
    }

	public WE3MailSender(){mail = new MailMessage();}
}
