package classes;

import java.lang.Object;
import java.util.Properties;

public class db 
{
    public static String CONNECTIONSTRING ="";
    public static String USERDB = "";
    public static String PASSWORDDB = "";
//Daten für die DB werden hier gespeichert
    public db()
    {
        Properties properties = new Properties();
        try
        {
            properties.load(Thread.currentThread().getContextClassLoader().getResourceAsStream("config.properties"));
            
            CONNECTIONSTRING = properties.getProperty("jdbc.url");
            USERDB = properties.getProperty("jdbc.username");
            PASSWORDDB = properties.getProperty("jdbc.password");
        }
        catch(Exception ex)
        {
            System.out.println(ex);
        }
    }
    
    
    
}
