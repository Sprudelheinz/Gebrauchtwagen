package classes;

import static classes.db.CONNECTIONSTRING;
import static classes.db.PASSWORDDB;
import static classes.db.USERDB;
import com.sun.org.apache.xerces.internal.impl.dv.util.Base64;
import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.InputStream;
import java.sql.*;
import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.util.Date;
import java.util.Locale;
import javax.imageio.ImageIO;

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
    public byte[][] photos = new byte[5][];
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
    public String Farbe;
    public String Schadstoffklasse;
    public String Ausstattung;
    public boolean Metallic;
    public int Sitz;
    private NumberFormat df = DecimalFormat.getCurrencyInstance(Locale.GERMANY);
    private int anzphotos;
    
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
                Farbe = rs.getString("Farbe");
                Ausstattung = rs.getString("Ausstattung");
                Schadstoffklasse = rs.getString("Schadstoffklasse");
                Sitz = rs.getInt("Sitz");
                Metallic = rs.getBoolean("Metallic");
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
            Statement stmtphotos = conn.createStatement();
            sql = "SELECT * FROM photos WHERE AngebotID = "+AngebotsID;
            ResultSet rsphotos = stmtphotos.executeQuery(sql);
            anzphotos =0;
            int i=0;
            while(rsphotos.next())
            {               
                while(i < 5)
                {
                    if(rsphotos.getBytes("p"+anzphotos) == null)
                        break;
                    photos[anzphotos] =  rsphotos.getBytes("p"+anzphotos);
                    anzphotos++;
                    i++;
                }                                      
            }
            rsphotos.close();
            stmtphotos.close();
            conn.close();          
        }
        catch(Exception ex)
        {
            System.out.println(ex);
        }
    }
    
    private boolean isonparkplatz(int AngebotID,String UserID)
    {
        try
        {
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection(CONNECTIONSTRING,USERDB,PASSWORDDB);
            Statement stmt = conn.createStatement();
            String sql = "SELECT * FROM parkplatz WHERE AngebotID = "+AngebotID+" AND UserID = "+UserID;
            ResultSet rs = stmt.executeQuery(sql);          
            while(rs.next())
            {
                return true;
            }
            return false;
        }
        catch(Exception ex)
        {
            System.out.println(ex.getMessage());
            return false;
        }       
    }
    
    private boolean ismyoffer(int AngebotID,String UserID)
    {
        try
        {
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection(CONNECTIONSTRING,USERDB,PASSWORDDB);
            Statement stmt = conn.createStatement();
            String sql = "SELECT * FROM angebot WHERE AngebotID = "+AngebotID+" AND UserID = "+UserID;
            ResultSet rs = stmt.executeQuery(sql);          
            while(rs.next())
            {
                return true;
            }
            return false;
        }
        catch(Exception ex)
        {
            System.out.println(ex.getMessage());
            return false;
        }       
    }
    
    public String showAngeboteliste(int AngebotsID)
    {       
        try
        {
            getDataFromDB(AngebotsID);
            String ausgabe ="";
            ausgabe += "<div id=\"divrundangebot\"><div id=\"left\">\n";
            String encodedImage = Base64.encode(photos[0]);           
            if(encodedImage != null)
                ausgabe += "<a href=\"angebot.jsp?AngebotID="+AngebotsID+"\"><img src=\"data:image/png;base64,"+encodedImage+"\" id=\"img\"/></a></div><div id=\"right\">\n";
            else
                ausgabe += "<a href=\"angebot.jsp?AngebotID="+AngebotsID+"\"><img src=\"img/keinbild.png\" id=\"img\" /></a></div><div id=\"right\">\n";
            ausgabe += "<b>"+Marke +"  "+  Modell + "  Preis: "+ df.format(Preis) + "</b><br>\n";           
            if(Neu == true)
                ausgabe += "Neufahrzeug<br>\n";
            else
            {
               ausgabe += "Gebrauchtfahrzeug<br>\n";
               ausgabe += "Erstzulassung/Baujahr: "+EZMonat+"/"+EZJahr+"<br>\n";
               ausgabe += "KM: "+KM +" km<br>\n";
            }
            ausgabe += "Hubraum: "+Hubraum+" cm³<br>\n";
            ausgabe += (int)(PS * 0.73) +" kW ("+ PS +") PS<br>\n";
            if(!Motorrad)
                ausgabe += "Anzahl Türen: "+AnzTueren +"<br>\n";           
            ausgabe += "Kraftstoff: "+Kraftstoff +"<br>\n";
            if(TUV)
                ausgabe += "TÜV bis: "+ TUVDatum +"<br>\n";
            ausgabe += "<div id=\"navdiv\"><a href=\"angebot.jsp?AngebotID="+AngebotsID+"\">Angebotsseite</a></div>";
            ausgabe += "</div></div>\n";
            return ausgabe;
        }
        catch(Exception ex)
        {
            return ex.toString();
        }
    }
    public String showAngebot(int AngebotsID,String Pfad,String userid)
    {       
        String parkplatz = "";
        try
        {
            if(!userid.equals("") )
            {
                if(isonparkplatz(AngebotsID, userid) && !ismyoffer(AngebotsID,userid))
                {
                    parkplatz = "<div id=\"navdiv\"><a href='angebot.jsp?AngebotID="+AngebotsID+"&Parkplatz=delete'>Von meinem Parkplatz entfernen</a></div>";
                }
                if(!isonparkplatz(AngebotsID, userid) && !ismyoffer(AngebotsID,userid))
                {
                    parkplatz = "<div id=\"navdiv\"><a href='angebot.jsp?AngebotID="+AngebotsID+"&Parkplatz=add'>Meinem Parkplatz hinzufügen</a></div>";
                }
                if(ismyoffer(AngebotsID,userid))
                    parkplatz = "<div id=\"navdiv\">Eigenes Angebot</div>";
            }
            
            File path = new File(Pfad+"tmp\\");
            path.mkdir();
            for (File file : path.listFiles()) 
            {
                if (file.toString().endsWith(".png")) 
                {
                    file.delete();
                }
            }
            getDataFromDB(AngebotsID);
            user Kontakt = new user();
            String ausgabe ="";
            String tmp = Marke+Modell+Ausstattung;
            String auto = tmp.replaceAll("[^a-zA-Z]", ""); 
            String beschr = Beschreibung.replaceAll("\n","<br>");
            if(UserID != 0)
            { 
                Kontakt.user(UserID);
                Kontakt.vname += " "+Kontakt.nachname;
            }
            for(int i=0; i<anzphotos;i++)
            {
                InputStream in = new ByteArrayInputStream(photos[i]);
                BufferedImage bImageFromConvert = ImageIO.read(in);
                ImageIO.write(bImageFromConvert, "png", new File(Pfad+"tmp\\"+auto+i+".png"));
            }          
            ausgabe += "<div id=\"divangebot\"><div id=\"divrund\"><h3> "+ Marke +"  "+  Modell + " " + Ausstattung +"</h3> "+ parkplatz +"</div><div id=\"leftangebot\">\n";
            if(anzphotos > 0)
            {
                ausgabe += "<a href=\"tmp/"+auto+"0.png\" rel=\"shadowbox[galerie]\" title=\""+ Marke +"  "+  Modell + " " + Ausstattung +"\"><img src=\"tmp/"+auto+"0.png\" id=\"bigImage\" /></a><br>";
                for(int i=1;i<anzphotos;i++)
                {
                    ausgabe += "<a href=\"tmp/"+auto+i+".png\" rel=\"shadowbox[galerie]\" title=\""+ Marke +"  "+  Modell + " " + Ausstattung +"\"><img src=\"tmp/"+auto+i+".png\"  id=\"img\" width=\"75\" onmouseover=\"changeImage('tmp/"+auto+i+".png')\" onmouseout=\"changeImage('tmp/"+auto+"0.png')\"/></a>";
                }
            }
            else
                ausgabe += "<img src=\"img/keinbild.png\" alt=\"auto\">\n";
            
            ausgabe += "</div><div id=\"rightangebot\">\n<h4> Preis: "+ df.format(Preis) + "</h4><br>\n";           
            if(Neu == true)
                ausgabe += "Neufahrzeug<br>\n";
            else
            {
               ausgabe += "Gebrauchtfahrzeug<br>\n";
               ausgabe += "Erstzulassung/Baujahr: "+EZMonat+"/"+EZJahr+"<br>\n";
               ausgabe += "KM: "+ KM +" km<br>\n";
            }
            if(Hubraum != 0)
                ausgabe += "Hubraum: "+Hubraum+" cm³ <br>\n";
            ausgabe +=   (int)(PS * 0.73) +" kW ("+ PS +") PS<br>\n";
            if(!Motorrad)
                ausgabe += "Anzahl Türen: "+AnzTueren +"<br>\n";         
            ausgabe += "Kraftstoff: "+Kraftstoff +"<br>\n";
            if(TUV)
                ausgabe += "TÜV bis: "+ TUVDatum +"<br>\n";
            if(Farbe != null)
                ausgabe += "Farbe: "+Farbe+ " ";
            if(Metallic)
                ausgabe += "Metallic<br>";
            else
                ausgabe += "<br>";
            if(Sitz != 0)
                ausgabe += "Anzahl Sitze: "+Sitz+"<br";
            if(!Schadstoffklasse.equals(""))
                 ausgabe += "Schadstoffklasse: "+Schadstoffklasse+"<br>";
            ausgabe += "</div><br><h3>Beschreibung:</h3><br>"+beschr+" </div>";
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
    
     public void addtopark(int AngebotID,String UserID)
    {
        try
        {
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection(CONNECTIONSTRING,USERDB,PASSWORDDB);
            Statement stmt = conn.createStatement();
            String sql;
            sql = "INSERT INTO parkplatz (AngebotID,UserID) VALUES ("+AngebotID+","+UserID+")";
            stmt.executeUpdate(sql);
            stmt.close();           
            conn.close();
        }
        catch(Exception ex)
        {
            System.out.print(ex);
        }
 
    }
    public void deletefrompark(int AngebotID,String UserID)
    {
        try
        {
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection(CONNECTIONSTRING,USERDB,PASSWORDDB);
            Statement stmt = conn.createStatement();
            String sql;
            sql = "DELETE FROM parkplatz WHERE AngebotID ="+AngebotID+" AND UserID="+UserID;
            stmt.executeUpdate(sql);
            stmt.close();
            conn.close();
        }
        catch(Exception ex)
        {
            System.out.print(ex);
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
            Statement stmt2 = conn.createStatement();
            sql = "DELETE FROM photos WHERE AngebotID ="+AngebotID;
            stmt2.executeUpdate(sql);
            stmt2.close();
            
            conn.close();
            return "Erfolgreich gelöscht!";
        }
        catch(Exception ex)
        {
            return ex.toString();
        }
 
    }
    
   
    
}
