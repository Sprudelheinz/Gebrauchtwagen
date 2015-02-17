package servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.sql.*; 
import java.util.Date;
import classes.db;

public class newcardatatodbServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException 
    {       
       try
        {
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection(db.CONNECTIONSTRING,db.USERDB,db.PASSWORDDB);
            Statement stupdatecar = con.createStatement();
            Statement stgetmaxid = con.createStatement();
            Statement stgetmaxkontaktid = con.createStatement();
            Statement createnewcontact = con.createStatement();
            
            HttpSession session = request.getSession(true);            
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
            int  newcarbool = 0;
            int  tuvbool = 0; 
            if(request.getParameter("new") != null)
                newcarbool = 1;
            if(request.getParameter("tuv") != null)
                tuvbool = 1;
            int UserID = 0;
            int KontaktID = 0;
            if(session.getAttribute("userid") != null)
            {
                UserID = Integer.parseInt(session.getAttribute("userid").toString());
            }
            else
            {
                ResultSet rs = stgetmaxid.executeQuery("select max(KontaktID) as maxID  from kontakt");
                while(rs.next())
                {
                    if(rs.getString("maxID") != null)
                        KontaktID = Integer.parseInt(rs.getString("maxID"));
                }
                KontaktID=KontaktID+1;
                String name = request.getParameter("name");
                String stadt = request.getParameter("stadt");
                String telefon = request.getParameter("telefonnummer");
                String email = request.getParameter("email"); 
                if(name != null && stadt != null && telefon != null && email != null)
                {
                    String sql = "insert into kontakt(KontaktID,Name,Stadt,Telefonnummer,Email,Registdate) values ('" + KontaktID + "','" + name + "','" + stadt + "','" + telefon + "','" + email + "',CURDATE())";
                    createnewcontact.executeUpdate(sql);
                }
                else
                    response.sendRedirect("newcar.jsp?errorreg=\"true\"");
            }
                                          
            if(marke != null && !modell.equals("0") && erstzulassung != null && baujahr != null && km != null && kraftstoffart != null && hubraum != null && ps != null && preis != null)
            {      
                int i = 0;
                ResultSet rs = stgetmaxid.executeQuery("select max(AngebotID) as maxID  from angebot");
                while(rs.next())
                {
                    if(rs.getString("maxID") != null)
                        i = Integer.parseInt(rs.getString("maxID"));
                }
                i=i+1;
                Date d = new Date();
                java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                String currentTime = sdf.format(d);
                String sql = "insert into angebot(AngebotID,MarkeID,ModellID,UserID,KontaktID,Neu,Erstzulassung,Baujahr,Preis,KM,Kraftstoff,Hubraum,PS,TUEV,TUEVDate,Einstelldatum) "
                           + "values ('" + i + "','" + marke + "','" + modell + "','" + UserID + "','" + KontaktID + "','" + newcarbool + "','" + erstzulassung + "','" + baujahr + "','" + preis + "','" + km + "','" + kraftstoffart + "','" + hubraum + "','" + ps + "','" + tuvbool + "','" + tuvbis + "','"+ currentTime + "')"; 
                stupdatecar.executeUpdate(sql);
                response.sendRedirect("pictureupload.jsp?AngebotID="+i);
            }       
            else
                response.sendRedirect("newcar.jsp?errorreg=\"true\"");
        }
        catch(Exception ex)
        {
            response.sendRedirect("newcar.jsp?errorreg=\"true"+ ex +"\"");
        }
    }

}
