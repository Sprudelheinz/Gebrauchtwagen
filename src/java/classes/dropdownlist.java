package classes;

import java.sql.*;

public class dropdownlist extends db
{
    public dropdownlist()
    {}
    public String marke ="";
    
    public String ddmarke(String s,String seite)
    {
        try
        {
            if(s != null)
                marke = s;
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection(CONNECTIONSTRING,USERDB,PASSWORDDB);
            Statement stmt = conn.createStatement();
            String sql;
            sql = "SELECT * FROM marke";
            ResultSet rs = stmt.executeQuery(sql);
            String output = "<select name=Marke onchange=\"document."+seite+".submit()\">";
            while (rs.next()) {                               
                String mid = rs.getString("MarkeID");
                if(marke.equals(mid))
                    output += "<option selected=\"selected\" value=" + rs.getString("MarkeID") + ">" + rs.getString("Markenname") + "</option>\n";
                else                         
                    output += "<option value=" + rs.getString("MarkeID") + ">" + rs.getString("Markenname") + "</option>\n";
            }
            output += "</select>";
            rs.close(); 
            stmt.close();
            conn.close();
            return output;
        }
        catch(Exception ex)
        {
            return ex.toString();
        }
    }
    public String ddmodell(String s,String modell)
    {
        try
        {
            if (s != null && !(s.equals("1")))
            {
                Class.forName("com.mysql.jdbc.Driver");
                Connection conn = DriverManager.getConnection(CONNECTIONSTRING,USERDB,PASSWORDDB);
                Statement stmt = conn.createStatement();
                String sql;
                marke = s;
                sql = "SELECT * FROM modell WHERE " + marke +" = MarkeID ";
                ResultSet rs = stmt.executeQuery(sql);
                String output = "<select name=Modell>";                            
                output += "<option value=\"0\">Beliebig</option>\n";
                while (rs.next()) 
                {                                                                                         
                    if(modell != null && modell.equals(rs.getString("ModellID")))
                        output += "<option selected=\"selected\" value="  + rs.getString("ModellID") + ">" + rs.getString("Modellname") + "</option>\n";
                    else
                        output += "<option value=" + rs.getString("ModellID") + ">" + rs.getString("Modellname") + "</option>\n";
                }
            output += "</select>";
            rs.close(); 
            stmt.close();
            conn.close();
            return output;
            }
            else
                return "<select name=\"Modell\" disabled=\"disabled\"></select>";
        }
        catch(Exception ex)
        {
            return ex.toString();
        }
    }
    
}
