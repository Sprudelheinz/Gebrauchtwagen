<%@ page import ="java.sql.*,classes.db" %>
<%
    String userid = request.getParameter("uname");   
    String pwd = request.getParameter("pass");
    String seite = request.getParameter("login");
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection(db.CONNECTIONSTRING,db.USERDB,db.PASSWORDDB);
    Statement st = con.createStatement();
    ResultSet rs = st.executeQuery("select * from users where username='" + userid + "' and password='" + pwd + "'");
    if(seite.equals(""))
    {
        seite = "index.jsp";
    }
    if (rs.next()) {
        session.setAttribute("userid",rs.getString("userid"));
        session.setAttribute("username",userid);
        response.sendRedirect(seite);
    } else {
        response.sendRedirect(seite+"?loginerror=\"true\"");
    }
    con.close();
    st.close();
    rs.close();
%>