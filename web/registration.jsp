<%@ page import ="java.sql.*,classes.db" %>
<%
    String user = request.getParameter("uname");   
    String pwd = request.getParameter("pass");
    String fname = request.getParameter("fname");
    String lname = request.getParameter("lname");
    String email = request.getParameter("email");
    String stadt = request.getParameter("stadt");
    String telefonnummer = request.getParameter("telefonnummer");
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection(db.CONNECTIONSTRING,db.USERDB,db.PASSWORDDB);
    Statement st = con.createStatement();
    if(stadt!= null && telefonnummer != null && user != null && pwd != null && fname != null && lname != null && email != null && email.matches("^[\\w\\.=-]+@[\\w\\.-]+\\.[\\w]{2,4}$") && telefonnummer != null && telefonnummer.matches("(\\+|0)?\\d([/ -]?\\d)+"))
    {
        try
        {
            st.executeUpdate("insert into users(vorname, nachname, email, username, password, stadt, telefonnummer, registdate) values ('" + fname + "','" + lname + "','" + email + "','" + user + "','" + pwd + "','" + stadt + "','" + telefonnummer + "', CURDATE())");
            response.sendRedirect("index.jsp");
        }
        catch(Exception ex)
        {
            response.sendRedirect("reg.jsp?errorreg=\"true\"");
        }
    }
    else
        response.sendRedirect("reg.jsp?errorreg=\"true\"");
%>