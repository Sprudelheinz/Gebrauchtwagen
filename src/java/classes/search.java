package classes;

import static classes.db.CONNECTIONSTRING;
import static classes.db.PASSWORDDB;
import static classes.db.USERDB;
import java.sql.*;
import java.util.*;

public class search
{
    public search()
    {}
    
    public String showRandomOffer()
    {
        String sql = "SELECT AngebotID FROM Angebot WHERE NichtSichtbar = 0";
        String ausgabe = "";
        List<Integer> anz = new ArrayList<Integer>();
        try
        {
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection(CONNECTIONSTRING,USERDB,PASSWORDDB);
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(sql);          
            while(rs.next())
            {
                anz.add(rs.getInt("AngebotID"));                           
            }            
            Random rn = new Random();
            int randomNum = rn.nextInt(anz.size());          
            angebot a = new angebot();
            ausgabe += a.showAngeboteliste(anz.get(randomNum));
            return ausgabe;
        }
        catch(Exception ex)
        {
            System.out.println(ex);
            return null;
        }
        
    }
    
    public String countSearchResults(String neu,String marke,String modell,String minmz,String maxmil,String ks,String typ)
    {
        String sql = "SELECT COUNT(AngebotID) AS Anzahl  FROM Angebot WHERE";
        String ausgabe = "";
        if(neu.equals("on"))
            sql += " Neu = 1 ";
        if(neu.equals(""))
            sql += " Neu = 0 ";
        if(!marke.equals("1") && (modell.equals("0") || modell.equals("")))
        {
            sql += " AND MarkeID = "+marke;
        }
        if(!marke.equals("1") && !modell.equals("0") && !modell.equals("") )
        {
            sql += " AND MarkeID = "+marke+" AND ModellID = "+modell;
        }
        if(!minmz.equals("0"))
            sql+=" AND EZJahr >= "+ minmz;
        if(!maxmil.equals("0"))
            sql+=" AND KM <= "+ maxmil;
        if(!ks.equals("0"))
            sql+=" AND Kraftstoff = '"+ks+"'";
        if(typ.equals("0"))
            sql+=" AND Motorrad = 0";
        if(typ.equals("1"))
            sql+=" AND Motorrad = 1";
        sql+=" AND NichtSichtbar = 0 ORDER BY Einstelldatum DESC ";
        try
        {
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection(CONNECTIONSTRING,USERDB,PASSWORDDB);
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(sql);          
            int i=0;
            while(rs.next())
            {   
                i = rs.getInt("Anzahl");
            }
            if(i==0)
                return "Keine Ergebnisse entsprechend ihrer Suche gefunden";
            ausgabe = i+" Ergebnisse";
            return ausgabe;
        }
        catch(Exception ex)
        {
            System.out.println(ex);
            return null;
        }
        
    }
    
    
    public String showSearchResult(String neu,String marke,String modell,String minmz,String maxmil,String ks,String typ)
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
        if(!ks.equals("0"))
            sql+=" AND Kraftstoff = '"+ks+"'";
        if(typ.equals("0"))
            sql+=" AND Motorrad = 0";
        if(typ.equals("1"))
            sql+=" AND Motorrad = 1";
        sql+=" AND NichtSichtbar = 0 ORDER BY Einstelldatum DESC ";
        try
        {
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection(CONNECTIONSTRING,USERDB,PASSWORDDB);
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(sql);          
            int i=0;
            while(rs.next())
            {
                angebot a = new angebot();
                ausgabe += a.showAngeboteliste(rs.getInt("AngebotID"));    
                i++;
            }
            if(i==0)
                return "Keine Ergebnisse entsprechend ihrer Suche gefunden";
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
        String sql = "SELECT AngebotID FROM Angebot WHERE UserID ="+UserID+" ORDER BY Einstelldatum DESC";
        String ausgabe = "";
        try
        {
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection(CONNECTIONSTRING,USERDB,PASSWORDDB);
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(sql);          
            int i=0;
            while(rs.next())
            {
                angebot a = new angebot();
                ausgabe += "<div id=\"divrund\">Angebot <a href=\"deleteoffer.jsp?AngebotID="+rs.getInt("AngebotID")+"\">Löschen</a> "
                        + " <a href=\"newcar.jsp?edit="+rs.getInt("AngebotID")+"\">Bearbeiten</a> "
                        + " <a href=\"pictureupload.jsp?AngebotID="+rs.getInt("AngebotID")+"\">Bild ändern</a></div>";
                ausgabe += a.showAngeboteliste(rs.getInt("AngebotID")) + "<br><br>";
                i++;
            }
            if(i==0)
                return "Sie haben keine Angebote eingestellt";
            return ausgabe;
        }
        catch(Exception ex)
        {
            System.out.println(ex);
            return null;
        }
        
    }
}
