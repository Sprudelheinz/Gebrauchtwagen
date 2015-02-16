package classes;

import static classes.db.CONNECTIONSTRING;
import static classes.db.PASSWORDDB;
import static classes.db.USERDB;
import com.sun.org.apache.xerces.internal.impl.dv.util.Base64;
import java.sql.*;
import java.util.Date;


public class angebot extends kfz
{
    public boolean Neu;
    public String Erstzulassung;
    public String Baujahr;
    public float Preis;
    public boolean TUV;
    public String TUVDatum;
    public int KM;
    public byte[] photo;
    public Date Einstelldatum;
    
    public angebot()
    {}
    private void getDataFromDB(int AngebotsID)
    {
        try
        {
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection(CONNECTIONSTRING,USERDB,PASSWORDDB);
            Statement stmt = conn.createStatement();
            String sql;
            sql = "SELECT * FROM angebot WHERE AngebotID ="+AngebotsID;
            ResultSet rs = stmt.executeQuery(sql);
            String tmpMarke="",tmpModell="";
            
            while(rs.next())
            {
                tmpMarke = rs.getString("MarkeID");
                tmpModell = rs.getString("ModellID");
                Neu = rs.getBoolean("Neu");
                Erstzulassung = rs.getString("Erstzulassung");
                Baujahr = rs.getString("Baujahr");
                Preis = rs.getFloat("Preis");
                KM = rs.getInt("KM");
                Kraftstoff = rs.getString("Kraftstoff");
                Hubraum = rs.getInt("Hubraum");                 
                PS = rs.getInt("PS");
                TUV = rs.getBoolean("TUEV");
                TUVDatum = rs.getString("TUEVDate");
                photo = rs.getBytes("photo");
                Einstelldatum = rs.getDate("Einstelldatum");
            }           
            rs.close();
            stmt.close();
            Statement stmt2 = conn.createStatement();
            sql = "SELECT * FROM marke INNER JOIN modell WHERE marke.MarkeID = modell.MarkeID";
            ResultSet rs2 = stmt2.executeQuery(sql);
            while(rs2.next())
            {
                if(tmpMarke.equals(rs2.getString("MarkeID")) && tmpModell.equals(rs2.getString("ModellID")))
                {
                    Marke = rs2.getString("Markenname");
                    Modell = rs2.getString("Modellname");
                }
            }
            rs2.close();
            stmt2.close();
            conn.close();          
        }
        catch(Exception ex)
        {
            System.out.println(ex);
        }
    }
    
    public String showAngebot(int AngebotsID)
    {
        
        try
        {
            getDataFromDB(AngebotsID);
            String ausgabe ="";
            ausgabe += "<article>\n";
            ausgabe += Marke +"  "+  Modell + "  Preis: "+ Preis + "<br>\n";
            String encodedImage = Base64.encode(photo);           
            ausgabe += "<img src=\"data:image/png;base64,"+encodedImage+"\" alt=\"auto\"><br>\n";
            if(Neu == true)
                ausgabe += "Neufahrzeug<br>\n";
            else
               ausgabe += "Gebrauchtfahrzeug<br>\n";
            ausgabe += "Erstzulassung/Baujahr: "+Erstzulassung+"/"+Baujahr+"<br>\n";
            ausgabe += "Hubraum: "+Hubraum+" <br>\n";
            ausgabe += "PS: "+PS +"<br>\n";
            ausgabe += "KM: "+KM +"<br>\n";
            ausgabe += "Kraftstoff: "+Kraftstoff +"<br>\n";
            if(TUV)
                ausgabe += "TÜV bis: "+ TUVDatum +"<br>\n";
            else
                ausgabe += "Kein TÜV: <br>\n";
            ausgabe += "</article>\n";
            return ausgabe;
        }
        catch(Exception ex)
        {
            return null;
        }
        
        
    }
    
}
