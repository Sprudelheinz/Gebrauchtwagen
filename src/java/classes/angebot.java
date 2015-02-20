package classes;

import static classes.db.CONNECTIONSTRING;
import static classes.db.PASSWORDDB;
import static classes.db.USERDB;
import com.sun.org.apache.xerces.internal.impl.dv.util.Base64;
import java.sql.*;
import java.util.Date;

public class angebot
{
    public boolean Neu;
    public boolean Motorrad;
    public boolean notvisible;
    public int EZMonat;
    public int EZJahr;
    public float Preis;
    public boolean TUV;
    public String TUVDatum;
    public int KM;
    public int UserID;
    public byte[] photo;
    public Date Einstelldatum;
    public String Beschreibung;
    public String ModellID;
    public String MarkeID;
    public int TUVMonat;
    public int TUVJahr;
    public String Marke;
    public String Modell;
    public String Kraftstoff;
    public String AnzTueren;
    public int Hubraum;
    public int PS;
    
    public angebot()
    {}
    public void getDataFromDB(int AngebotsID)
    {
        try
        {
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection(CONNECTIONSTRING,USERDB,PASSWORDDB);
            Statement stmt = conn.createStatement();
            String sql;
            sql = "SELECT * FROM angebot WHERE AngebotID ="+AngebotsID;
            ResultSet rs = stmt.executeQuery(sql);
            
            while(rs.next())
            {
                MarkeID = rs.getString("MarkeID");
                ModellID = rs.getString("ModellID");
                Neu = rs.getBoolean("Neu");
                EZMonat = rs.getInt("EZMonat");
                EZJahr = rs.getInt("EZJahr");
                Preis = rs.getFloat("Preis");
                KM = rs.getInt("KM");
                Kraftstoff = rs.getString("Kraftstoff");
                Hubraum = rs.getInt("Hubraum");                 
                PS = rs.getInt("PS");
                AnzTueren = rs.getString("AnzTuere");
                TUV = rs.getBoolean("TUEV");
                TUVDatum = rs.getString("TUEVDate");
                photo = rs.getBytes("photo");
                Einstelldatum = rs.getDate("Einstelldatum");
                UserID = rs.getInt("UserID");
                Beschreibung = rs.getString("Beschreibung");
                Motorrad = rs.getBoolean("Motorrad");
                notvisible = rs.getBoolean("NichtSichtbar");
                if(TUV)
                {
                    TUVMonat = Integer.parseInt(TUVDatum.split("/")[0]);
                    TUVJahr = Integer.parseInt(TUVDatum.split("/")[1]);
                }
            }           
            rs.close();
            stmt.close();
            Statement stmt2 = conn.createStatement();
            if(Motorrad)
            {
                sql = "SELECT * FROM markemotorrad INNER JOIN modellmotorrad WHERE markemotorrad.MotoMarkeID = modellmotorrad.MotoMarkeID";
                ResultSet rs2 = stmt2.executeQuery(sql);
                while(rs2.next())
                {
                    if(MarkeID.equals(rs2.getString("MotoMarkeID")) && ModellID.equals(rs2.getString("MotoModellID")))
                    {
                        Marke = rs2.getString("Motorradmarkename");
                        Modell = rs2.getString("MotorradModellName");
                    }
                }
                rs2.close();
            }
            else
            {
                sql = "SELECT * FROM marke INNER JOIN modell WHERE marke.MarkeID = modell.MarkeID";
                ResultSet rs2 = stmt2.executeQuery(sql);
                while(rs2.next())
                {
                    if(MarkeID.equals(rs2.getString("MarkeID")) && ModellID.equals(rs2.getString("ModellID")))
                    {
                        Marke = rs2.getString("Markenname");
                        Modell = rs2.getString("Modellname");
                    }
                }
                rs2.close();
            }
            
            stmt2.close();
            conn.close();          
        }
        catch(Exception ex)
        {
            System.out.println(ex);
        }
    }
    
    public String showAngeboteliste(int AngebotsID)
    {       
        try
        {
            getDataFromDB(AngebotsID);
            String ausgabe ="";
            ausgabe += "<div id=\"divrund\"><div id=\"left\">\n";
            String encodedImage = Base64.encode(photo);           
            if(!encodedImage.equals(""))
                ausgabe += "<img src=\"data:image/png;base64,"+encodedImage+"\" width=\"200\" alt=\"auto\"></div><div id=\"right\">\n";
            else
                ausgabe += "<img src=\"img/keinbild.png\" alt=\"auto\"></div><div id=\"right\">\n";
            ausgabe += Marke +"  "+  Modell + "  Preis: "+ Preis + "<br>\n";           
            if(Neu == true)
                ausgabe += "Neufahrzeug<br>\n";
            else
               ausgabe += "Gebrauchtfahrzeug<br>\n";
            ausgabe += "Erstzulassung/Baujahr: "+EZMonat+"/"+EZJahr+"<br>\n";
            ausgabe += "Hubraum: "+Hubraum+" <br>\n";
            ausgabe += "PS: "+PS +"<br>\n";
            ausgabe += "Anzahl Türen: "+AnzTueren +"<br>\n";
            ausgabe += "KM: "+KM +"<br>\n";
            ausgabe += "Kraftstoff: "+Kraftstoff +"<br>\n";
            if(TUV)
                ausgabe += "TÜV bis: "+ TUVDatum +"<br>\n";
            else
                ausgabe += "Kein TÜV <br>\n";
            ausgabe += "<a href=\"angebot.jsp?AngebotID="+AngebotsID+"\">Angebotsseite</a>";
            ausgabe += "</div></div>\n";
            return ausgabe;
        }
        catch(Exception ex)
        {
            return ex.toString();
        }
    }
    public String showAngebot(int AngebotsID)
    {       
       
        try
        {
            getDataFromDB(AngebotsID);
            user Kontakt = new user();
            if(UserID != 0)
            { 
                Kontakt.user(UserID);
                Kontakt.vname += " "+Kontakt.nachname;
            }
            String ausgabe ="";
            ausgabe += "<div id=\"divangebot\"><div id=\"left\">\n";
            String encodedImage = Base64.encode(photo);           
            if(!encodedImage.equals(""))
                ausgabe += "<img src=\"data:image/png;base64,"+encodedImage+"\" height=\"200\" alt=\"auto\"></div><div id=\"rightangebot\">\n";
            else
                ausgabe += "<img src=\"img/keinbild.png\" alt=\"auto\"></div><div id=\"rightangebot\">\n";
            ausgabe +="<h3> "+ Marke +"  "+  Modell + "</h3> <br><h4> Preis: "+ Preis + "  EUR</h4><br>\n";           
            if(Neu == true)
                ausgabe += "Neufahrzeug<br>\n";
            else
               ausgabe += "Gebrauchtfahrzeug<br>\n";
            ausgabe += "Erstzulassung/Baujahr: "+EZMonat+"/"+EZJahr+"<br>\n";
            ausgabe += "Hubraum: "+Hubraum+" cm³ <br>\n";
            ausgabe +=   (int)(PS * 0.73) +" kW ("+ PS +") PS<br>\n";
            ausgabe += "Anzahl Türen: "+AnzTueren +"<br>\n";
            ausgabe +=  KM +" km<br>\n";
            ausgabe += "Kraftstoff: "+Kraftstoff +"<br>\n";
            if(TUV)
                ausgabe += "TÜV bis: "+ TUVDatum +"<br>\n";
            else
                ausgabe += "Kein TÜV <br>\n";
            ausgabe += "</div><h3>Beschreibung:</h3><br>"+Beschreibung+" </div>";
            ausgabe += "<div id=\"kontakt\"><h3>Kontakt</h3>";
            ausgabe += "Name: "+ Kontakt.vname + "<br>E-Mail: <a href=\"mailto:" + Kontakt.email + "\">"+Kontakt.email + "</a> <br>Stadt: " + Kontakt.stadt + "<br>Telefonnummer: " + Kontakt.telefonnummer;
            ausgabe += "</div></div>\n";
            return ausgabe;
        }
        catch(Exception ex)
        {
            return ex.toString();
        }               
    }
    public String deleteoffer(int AngebotID)
    {
        try
        {
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection(CONNECTIONSTRING,USERDB,PASSWORDDB);
            Statement stmt = conn.createStatement();
            String sql;
            sql = "DELETE FROM angebot WHERE AngebotID ="+AngebotID;
            stmt.executeUpdate(sql);
            stmt.close();
            conn.close();
            return "Erfolgreich gelöscht!";
        }
        catch(Exception ex)
        {
            return ex.toString();
        }
 
    }
    
}
