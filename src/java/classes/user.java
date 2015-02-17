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
    
    public String getVname()
    {
        return vname;
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
                vname=rs.getString("vorname");
                nachname=rs.getString("nachname");
                email=rs.getString("email");
                username=rs.getString("username");
                stadt=rs.getString("stadt");
                telefonnummer=rs.getString("telefonnummer"); 
            }
            rs.close();
            conn.close();
            stmt.close();
        }
        catch(Exception ex)
        {}
    }
}
