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

    private boolean edit = false;
    private String AngebotID = "";
    
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
            Statement editoffer = con.createStatement();  
            HttpSession session = request.getSession(true);            
            
            if(request.getParameter("edit") != null)
            {
                edit = true;
                AngebotID = request.getParameter("edit");
            }
            if(!edit)
            {
                if(request.getParameter("Marke").equals("1"))
                    throw new Exception("Marke nicht angegeben");              
                if(request.getParameter("Modell") == null || request.getParameter("Modell").equals("0"))
                    throw new Exception("Modell nicht angegeben");
            }
            int  newcarbool = 0;
            if(request.getParameter("new") != null)
                newcarbool = 1;
            String ezmonat = "0";
            String ezjahr = "0";
            if(newcarbool == 0)
            {               
                ezmonat = request.getParameter("EZMonat");               
                if(request.getParameter("EZJahr")!=null && !request.getParameter("EZJahr").equals(""))
                    ezjahr=request.getParameter("EZJahr");
                else
                    throw new Exception("Erstzulassungsjahr nicht angegeben");
            }
            String preis = request.getParameter("preis");
            if(preis.equals(""))
                throw new Exception("Preis nicht angegeben");
            String km = "0";
            if(request.getParameter("KM") != null)
                km = request.getParameter("KM");
            if(km.equals("0") && newcarbool == 0)
                throw new Exception("KM nicht angegeben");
            String kraftstoffart = request.getParameter("kraftstoffart");
            String hubraum = request.getParameter("hubraum");
            if(hubraum.equals(""))
                throw new Exception("Hubraum nicht angegeben");
            String ps = request.getParameter("PS");
            if(ps.equals(""))
                throw new Exception("PS nicht angegeben");
            int  tuvbool = 0;
            if(request.getParameter("tuv") != null)
                tuvbool = 1;
            String TUVMonat = request.getParameter("TUVMonat");
            String TUVJahr = request.getParameter("TUVJahr");
            String AnzTuren = request.getParameter("anzturen");
            String tuvbis = "";
            if(tuvbool == 1)
                tuvbis = TUVMonat+"/"+TUVJahr;
            String beschreibung = "Keine Beschreibung";
            String typ = request.getParameter("typ");
            if(request.getParameter("beschreibung") != null)
            {
                byte tmp[] = request.getParameter("beschreibung").getBytes("ISO-8859-1");
                beschreibung = new String(tmp,"UTF-8");
            }
            int UserID = Integer.parseInt(session.getAttribute("userid").toString());
            int notvisible = 0;
            if(request.getParameter("notvisible")==null)
              notvisible=1;  
            String ausstattung="",farbe="",schadstoffklasse="";
            int sitz=0,metallic=0;
            if(request.getParameter("ausstattung")!=null)
                ausstattung = request.getParameter("ausstattung");
            if(request.getParameter("farbe")!=null)
                farbe = request.getParameter("farbe");
            if(request.getParameter("schadstklasse")!=null)
                schadstoffklasse = request.getParameter("schadstklasse");
            if(request.getParameter("metallic")!=null)
                metallic = 1;
            if(request.getParameter("sitz")!=null)
                sitz = Integer.parseInt(request.getParameter("sitz"));
            if(!edit)
            {
                String marke = request.getParameter("Marke");       
                String modell = request.getParameter("Modell");
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
                String sql = "insert into angebot(AngebotID,MarkeID,ModellID,UserID,Neu,Motorrad,EZMonat,EZJahr,Preis,KM,Kraftstoff,Hubraum,PS,AnzTuere,TUEV,TUEVDate,Einstelldatum,Beschreibung,NichtSichtbar,Farbe,Metallic,Sitz,Schadstoffklasse,Ausstattung) "
                           + "values ('" + i + "','" + marke + "','" + modell + "','" + UserID + "','" + newcarbool + "','" + typ + "','" + ezmonat + "','" + ezjahr + "','" + preis + "','" + km + "','" + kraftstoffart + "','" + hubraum + "','" + ps + "','" + AnzTuren + "','" + tuvbool + "','" + tuvbis + "','"+ currentTime + "','"+ beschreibung + "','"+ notvisible + "','"+ farbe + "','"+ metallic + "','"+ sitz + "','"+ schadstoffklasse + "','"+ ausstattung + "')"; 
                stupdatecar.executeUpdate(sql);
                stupdatecar.close();
                response.sendRedirect("pictureupload.jsp?AngebotID="+i);
            }
            else
            {
                String sql;
                sql = "UPDATE angebot SET EZMonat='"+ezmonat+"',EZJahr='"+ezjahr+"',Preis='"+preis+"',KM='"+km+"',Kraftstoff='"+kraftstoffart+"',Hubraum='"+hubraum+"',PS='"+ps+"',AnzTuere='"+AnzTuren+"',TUEV='"+tuvbool+"',TUEVDate='"+tuvbis+"',Beschreibung='"+beschreibung+"',NichtSichtbar='"+notvisible+"',Farbe='"+farbe+"',Metallic='"+metallic+"',Sitz='"+sitz+"',Schadstoffklasse='"+schadstoffklasse+"',Ausstattung='"+ausstattung+"' WHERE AngebotID = "+AngebotID;
                editoffer.executeUpdate(sql);
                editoffer.close();
                response.sendRedirect("angebot.jsp?AngebotID="+AngebotID);
            }
           
        }
        catch(Exception ex)
        {
            if(!edit)
                response.sendRedirect("newcar.jsp?errorreg="+ ex.getMessage());
            if(edit)
                response.sendRedirect("newcar.jsp?edit="+AngebotID +"&errorreg="+ ex.getMessage());
        }
    }

}
