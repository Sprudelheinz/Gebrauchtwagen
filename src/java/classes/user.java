package classes;

import java.sql.*;


public class user extends db
{
    public String vname;
    public String nachname;
    public String email;
    public String username;
    public String stadt;
    public String telefonnummer;
    public String pass;
    public int userid;
    
    public String getVname()
    {
        return vname;
    }
    public int getUserID()
    {
        return userid;
    }
    public String getNachname()
    {
        return nachname;
    }
    public String getEmail()
    {
        return email;
    }
    public String getUsername()
    {
        return username;
    }
    public String getStadt()
    {
        return stadt;
    }
    public String getTelefonnummer()
    {
        return telefonnummer;
    }
    public String getPass()
    {
        return pass;
    }
    
    public void user(int i)
    {
        try
        {
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection(CONNECTIONSTRING,USERDB,PASSWORDDB);
            Statement stmt = conn.createStatement();
            String sql;
            sql = "SELECT * FROM users WHERE userid ="+i;
            ResultSet rs = stmt.executeQuery(sql);
            while(rs.next())
            {
                userid=rs.getInt("userid");
                vname=rs.getString("vorname");
                nachname=rs.getString("nachname");
                email=rs.getString("email");
                username=rs.getString("username");
                stadt=rs.getString("stadt");
                telefonnummer=rs.getString("telefonnummer");
                pass = rs.getString("password");
            }
            rs.close();
            conn.close();
            stmt.close();
        }
        catch(Exception ex)
        {}
    }
  
    public String changeuserdata(String userneu,String fnameneu,String lnamev,String emailneu,String stadtneu,String telefonnummerneu,String passold,String passnew)
    {
        String sql = "update users set ";
        if(fnameneu.equals(""))
            return "Vorname nicht angegeben";
        sql += " vorname = '"+ fnameneu + "',";
        if(userneu.equals(""))
            return "User nicht angegeben";
        sql += " username = '"+ userneu + "',";
        if(lnamev.equals(""))
            return "Nachname nicht angegeben";
        sql += " nachname = '"+ lnamev + "',";
        if(emailneu.equals(""))
            return "E-Mail nicht angegeben";    
        if(!emailneu.matches("^[\\w\\.=-]+@[\\w\\.-]+\\.[\\w]{2,4}$"))
            return "Ungültige E-Mail Adresse angegeben";
        sql += " email = '"+ emailneu + "',";
        if(stadtneu.equals(""))
            return "Stadt nicht angegeben";
        sql += " stadt = '"+ stadtneu + "',";
        if(telefonnummerneu.equals(""))
            return "Telefonnummer nicht angegeben";
        if(!telefonnummerneu.matches("(\\+|0)?\\d([/ -]?\\d)+"))
            return "Telefonnummer ist nicht korrekt";
        sql += " telefonnummer = '"+ telefonnummerneu + "'";
        if(!passold.equals("") && !pass.equals(passold))
            return "Altes Passwort falsch";
        if(passnew.equals("") && !passold.equals(""))
            return "Kein neues Passwort angegeben";
        if(!passnew.equals("") && !passold.equals(""))
            sql += " ,password = '"+ passnew + "'";
        try
        {
            sql += " WHERE userid="+userid;
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection(db.CONNECTIONSTRING,db.USERDB,db.PASSWORDDB);
            Statement st = con.createStatement();
            int row = st.executeUpdate(sql);
            if (row > 0)
            {
                st.close();
                con.close();
                user(userid);
                return "Daten erfolgreich aktualisiert";
            }
            else
                return "Keine Daten verändert";
        }
        catch(Exception ex)
        {
            return ex.toString();
                    
        }        
    }
    public String deleteuser(int UserID)
    {
        try
        {
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection(CONNECTIONSTRING,USERDB,PASSWORDDB);
            Statement stmt = conn.createStatement();
            Statement stmt2 = conn.createStatement();
            String sql;
            sql = "DELETE FROM users WHERE userid ="+UserID;
            stmt.executeUpdate(sql);
            sql = "DELETE FROM angebot WHERE UserID = "+UserID;
            stmt2.executeUpdate(sql);
            stmt.close();
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
