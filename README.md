

  ```
  
  
  <%@ page import="java.util.Properties" %>
<%@ page import="javax.mail.*" %>
<%@ page import="javax.mail.internet.*" %>

<!DOCTYPE html>
<html>
<head>
  <title>Contact Form</title>
</head>
<body>
<%
String to = "your.email@gmail.com";
String username = "your.email@gmail.com";
String password = "your-gmail-password";
if (request.getMethod().equals("POST")) {
  String name = request.getParameter("name");
  String email = request.getParameter("email");
  String message = request.getParameter("message");

  String headers = "From: " + name + " <" + email + ">\r\n";
  headers += "Reply-To: " + email + "\r\n";
  headers += "MIME-Version: 1.0\r\n";
  headers += "Content-type: text/html; charset=iso-8859-1\r\n";
  String subject = "New message from " + name;
  String body = "<p>" + message + "</p>";

  Properties props = new Properties();
  props.put("mail.smtp.auth", "true");
  props.put("mail.smtp.starttls.enable", "true");
  props.put("mail.smtp.host", "smtp.gmail.com");
  props.put("mail.smtp.port", "587");

  Session session = Session.getInstance(props, new javax.mail.Authenticator() {
      protected PasswordAuthentication getPasswordAuthentication() {
          return new PasswordAuthentication(username, password);
      }
  });

  try {
      Message msg = new MimeMessage(session);
      msg.setFrom(new InternetAddress(username));
      msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
      msg.setSubject(subject);
      msg.setContent(body, "text/html");
      Transport.send(msg);
      out.println("<p>Thank you for your message, " + name + "! We will get back to you at " + email + " as soon as possible.</p>");
  } catch (MessagingException e) {
      out.println("<p>There was an error sending your message. Please try again later.</p>");
  }
}
%>

  <form method="post">
    <label for="name">Name:</label>
    <input type="text" id="name" name="name" required><br>
      <label for="email">Email:</label>
<input type="email" id="email" name="email" required><br>

<label for="message">Message:</label>
<textarea id="message" name="message" required></textarea><br>

<button type="submit">Send</button>

  </form>
</body>
</html>


```
