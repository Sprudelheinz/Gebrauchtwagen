package classes;

import static classes.db.CONNECTIONSTRING;
import static classes.db.PASSWORDDB;
import static classes.db.USERDB;
import java.sql.*;

public class search
{
    public search()
    {}
    public String showSearchResult(String neu,String marke,String modell,String minmz,String maxmil)
    {
        String sql = "SELECT AngebotID  FROM Angebot WHERE";
        String ausgabe = "";
        if(neu.equals("on"))
            sql += " Neu = 1 ";
        if(neu.equals(""))
            sql += " Neu = 0 ";
        if(!marke.equals("1") && modell.equals("0") )
        {
            sql += " AND MarkeID = "+marke;
        }
        if(!marke.equals("1") && !modell.equals("0") )
        {
            sql += " AND MarkeID = "+marke+" AND ModellID = "+modell;
        }
        if(!minmz.equals("0"))
            sql+=" AND EZJahr >= "+ minmz;
        if(!maxmil.equals("0"))
            sql+=" AND KM <= "+ maxmil;
        try
        {
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection(CONNECTIONSTRING,USERDB,PASSWORDDB);
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(sql);          
            while(rs.next())
            {
                angebot a = new angebot();
                ausgabe += a.showAngeboteliste(rs.getInt("AngebotID"));             
            }
            return ausgabe;
        }
        catch(Exception ex)
        {
            System.out.println(ex);
            return null;
        }
        
    }
    
    public String showMyOffers(String UserID)
    {
        String sql = "SELECT AngebotID FROM Angebot WHERE UserID ="+UserID;
        String ausgabe = "";
        try
        {
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection(CONNECTIONSTRING,USERDB,PASSWORDDB);
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(sql);          
            while(rs.next())
            {
                angebot a = new angebot();
                ausgabe += "<div id=\"divrund\">Angebot <a href=\"deleteoffer.jsp?AngebotID="+rs.getInt("AngebotID")+"\">Löschen</a></div>";
                ausgabe += a.showAngeboteliste(rs.getInt("AngebotID")) + "<br><br>";
            }
            return ausgabe;
        }
        catch(Exception ex)
        {
            System.out.println(ex);
            return null;
        }
        
    }
}
