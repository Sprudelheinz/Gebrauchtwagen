<%@ page import ="java.sql.*,classes.db" %>
<%
    String userid = request.getParameter("uname");   
    String pwd = request.getParameter("pass");
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection(db.CONNECTIONSTRING,db.USERDB,db.PASSWORDDB);
    Statement st = con.createStatement();
    ResultSet rs = st.executeQuery("select * from users where username='" + userid + "' and password='" + pwd + "'");
    if (rs.next()) {
        session.setAttribute("userid",rs.getString("userid"));
        session.setAttribute("username",userid);
        response.sendRedirect("index.jsp");
    } else {
        response.sendRedirect("index.jsp?loginerror=\"true\"");
    }
    con.close();
    st.close();
    rs.close();
%>