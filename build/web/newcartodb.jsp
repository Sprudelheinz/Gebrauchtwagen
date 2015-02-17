<%@ page import ="java.sql.*" %>
<%@ page import ="java.util.Date,classes.db"%>

<%  
    try
    {
        String marke = request.getParameter("Marke");
        String modell = request.getParameter("Modell");
        String erstzulassung = request.getParameter("erstzulassung");
        String baujahr = request.getParameter("baujahr");
        String preis = request.getParameter("preis");
        String km = request.getParameter("KM");
        String kraftstoffart = request.getParameter("kraftstoffart");
        String hubraum = request.getParameter("hubraum");
        String ps = request.getParameter("PS");
        String tuvbis = request.getParameter("tuvbis");
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection(db.CONNECTIONSTRING,db.USERDB,db.PASSWORDDB);
        Statement st = con.createStatement();
        Statement st2 = con.createStatement();
        int  newcarbool = 0;
        int  tuvbool = 0; 
        if(request.getParameter("new") != null)
            newcarbool = 1;
        if(request.getParameter("tuv") != null)
            tuvbool = 1;
        if(marke != null && !modell.equals("0") && erstzulassung != null && baujahr != null && km != null && kraftstoffart != null && hubraum != null && ps != null && preis != null)
        {      
            int i = 0;
            ResultSet rs = st2.executeQuery("select max(AngebotID) as maxID  from angebot");
            while(rs.next())
            {
                if(rs.getString("maxID") != null)
                    i = Integer.parseInt(rs.getString("maxID"));
            }
            i=i+1;
            Date d = new Date();
            java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            String currentTime = sdf.format(d);
            String sql = "insert into angebot(AngebotID,MarkeID,ModellID,Neu,Erstzulassung,Baujahr,Preis,KM,Kraftstoff,Hubraum,PS,TUEV,TUEVDate,Einstelldatum) values ('" + i + "','" + marke + "','" + modell + "','" + newcarbool + "','" + erstzulassung + "','" + baujahr + "','" + preis + "','" + km + "','" + kraftstoffart + "','" + hubraum + "','" + ps + "','" + tuvbool + "','" + tuvbis + "','"+ currentTime + "')"; 
            st.executeUpdate(sql);
            session.setAttribute("AngebotID",i);
            response.sendRedirect("pictureupload.jsp");
        }       
        else
            response.sendRedirect("newcar.jsp?errorreg=\"true\"");
    }
    catch(Exception ex)
    {
        response.sendRedirect("newcar.jsp?errorreg=\"true"+ ex +"\"");
    }
%>