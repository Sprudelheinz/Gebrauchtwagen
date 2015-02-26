<%@ page import ="java.sql.*,classes.db" %>
<%
    String user = request.getParameter("uname");   
    String pwd = request.getParameter("pass");
    String fname = request.getParameter("fname");
    String lname = request.getParameter("lname");
    String email = request.getParameter("email");
    String stadt = request.getParameter("stadt");
    String telefonnummer = request.getParameter("telefonnummer");
    String s ="";
    try
    {
        if(fname.equals(""))
            throw new Exception("Vorname nicht angegeben");
        if(user.equals(""))
            throw new Exception("User nicht angegeben");
        if(lname.equals(""))
            throw new Exception("Nachname nicht angegeben");
        if(email.equals(""))
            throw new Exception("E-Mail nicht angegeben");    
        if(!email.matches("^[\\w\\.=-]+@[\\w\\.-]+\\.[\\w]{2,4}$"))
            throw new Exception("Ungültige E-Mail Adresse angegeben");
        if(stadt.equals(""))
            throw new Exception("Stadt nicht angegeben");
        if(telefonnummer.equals(""))
            throw new Exception("Telefonnummer nicht angegeben");
        if(!telefonnummer.matches("(\\+|0)?\\d([/ -]?\\d)+"))
            throw new Exception("Telefonnummer ist nicht korrekt");
        if(pwd.equals(""))
            throw new Exception("Kein Passwort angegeben");

        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection(db.CONNECTIONSTRING,db.USERDB,db.PASSWORDDB);
        Statement st = con.createStatement();
        st.executeUpdate("insert into users(isadmin,vorname, nachname, email, username, password, stadt, telefonnummer, registdate) values (\"0\",'" + fname + "','" + lname + "','" + email + "','" + user + "','" + pwd + "','" + stadt + "','" + telefonnummer + "', CURDATE())");
        session.setAttribute("Vorname",null);
        session.setAttribute("Nachname",null);
        session.setAttribute("Stadt",null);
        session.setAttribute("EMail",null);
        session.setAttribute("Telefon",null);
        session.setAttribute("User",null);
        response.sendRedirect("index.jsp");
    }
    catch(Exception ex)
    {
        session.setAttribute("Vorname",fname);
        session.setAttribute("Nachname",lname);
        session.setAttribute("Stadt",stadt);
        session.setAttribute("EMail",email);
        session.setAttribute("Telefon",telefonnummer);
        session.setAttribute("User",user);
        if(ex.getMessage().contains("Duplicate"))
            response.sendRedirect("reg.jsp?errormessage=Username schon vorhanden");
        else
            response.sendRedirect("reg.jsp?errormessage="+ex.getMessage()+"");     
    }

%>