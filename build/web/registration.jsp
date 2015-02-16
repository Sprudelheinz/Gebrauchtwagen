<%@ page import ="java.sql.*,classes.db" %>
<%
    String user = request.getParameter("uname");   
    String pwd = request.getParameter("pass");
    String fname = request.getParameter("fname");
    String lname = request.getParameter("lname");
    String email = request.getParameter("email");
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection(db.CONNECTIONSTRING,db.USERDB,db.PASSWORDDB);
    Statement st = con.createStatement();
    if(user != null && pwd != null && fname != null && lname != null && email != null && email.matches("^[\\w\\.=-]+@[\\w\\.-]+\\.[\\w]{2,4}$"))
    {
        try
        {
            st.executeUpdate("insert into users(vorname, nachname, email, username, password, registdate) values ('" + fname + "','" + lname + "','" + email + "','" + user + "','" + pwd + "', CURDATE())");
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