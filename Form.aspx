<%@ Page Language="C#" %>
<%@ Import Namespace="System.Net.Mail" %>

<!DOCTYPE html>
<html>
<head>
    <title>Contact Form</title>
</head>
<body>
    <% 
        string to = "your.email@gmail.com";
        string username = "your.email@gmail.com";
        string password = "your-gmail-password";

    if (Request.HttpMethod == "POST")
    {
        string name = Request.Form["name"];
        string email = Request.Form["email"];
        string message = Request.Form["message"];

        string headers = "From: " + name + " <" + email + ">\r\n";
        headers += "Reply-To: " + email + "\r\n";
        headers += "MIME-Version: 1.0\r\n";
        headers += "Content-type: text/html; charset=iso-8859-1\r\n";
        string subject = "New message from " + name;
        string body = "<p>" + message + "</p>";

        SmtpClient client = new SmtpClient("smtp.gmail.com", 587);
        client.EnableSsl = true;
        client.Credentials = new System.Net.NetworkCredential(username, password);

        MailMessage msg = new MailMessage();
        msg.From = new MailAddress(username);
        msg.To.Add(to);
        msg.Subject = subject;
        msg.Body = body;
        msg.IsBodyHtml = true;

        try
        {
            client.Send(msg);
            Response.Write("<p>Thank you for your message, " + name + "! We will get back to you at " + email + " as soon as possible.</p>");
        }
        catch (Exception ex)
        {
            Response.Write("<p>There was an error sending your message. Please try again later.</p>");
        }
    }
%>

<form method="post">
    <label for="name">Name:</label>
    <input type="text" id="name" name="name" required /><br />

    <label for="email">Email:</label>
    <input type="email" id="email" name="email" required /><br />

    <label for="message">Message:</label>
    <textarea id="message" name="message" required></textarea><br />

    <button type="submit">Send</button>
</form>
</body>
</html>
