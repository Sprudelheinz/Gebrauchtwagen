package servlets;


import java.io.IOException;
import java.io.InputStream;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import classes.db;
 
@WebServlet("/uploadServlet")
@MultipartConfig(maxFileSize = 16177215) 
public class fileUploadDBServlet extends HttpServlet {
    private int anz = 5;
    //Upload von Dateien in die Datenbank
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
    {       
        InputStream inputStream[] = new InputStream[anz];
        String AngebotID = "";
        int i=0,j=0;
        
        if(request.getParameter("AngebotID") != null)
             AngebotID = request.getParameter("AngebotID");              
        
        while(request.getPart("photo"+i) != null)
        {
            Part filePart = request.getPart("photo"+i);
            String mimetype = filePart.getContentType();
            String type = mimetype.split("/")[0];
            if(!type.equals("image"))
            {               
                i++;
                continue;
            }
            if(filePart.getInputStream() != null)
            {
                inputStream[j] = filePart.getInputStream();
                j++;
            }
            i++;
        }
                    
        Connection conn = null; 
        String message = null;         
        try 
        {
            DriverManager.registerDriver(new com.mysql.jdbc.Driver());
            conn = DriverManager.getConnection(db.CONNECTIONSTRING, db.USERDB, db.PASSWORDDB);
            Statement stmtphotos = conn.createStatement();
            String sql = "SELECT * FROM photos WHERE AngebotID = "+AngebotID;
            ResultSet rsphotos = stmtphotos.executeQuery(sql);
            PreparedStatement statement;
            if(!rsphotos.next())
            {
                sql = "INSERT INTO photos (AngebotID,p0,p1,p2,p3,p4) VALUES (?,?,?,?,?,?)";
                statement = conn.prepareStatement(sql);  
                statement.setString(1,AngebotID);
                int k=2;
                for(j=0;j<anz;j++)
                {
                    statement.setBlob(k,inputStream[j]);
                    k++;
                }
            }
            else
            {
                sql = "UPDATE photos SET p0=?,p1=?,p2=?,p3=?,p4=? WHERE AngebotID = "+AngebotID;
                statement = conn.prepareStatement(sql);
                for(j=1;j<=anz;j++)
                {
                    statement.setBlob(j,inputStream[j-1]);
                }
            }
            rsphotos.close();
            stmtphotos.close();         
            int row = statement.executeUpdate();
            if (row > 0) 
                message = "Datei erfolgreich hochgeladen";
            else              
                throw new Exception("Fehler beim hochladen");
            conn.close();
            response.sendRedirect("angebot.jsp?AngebotID="+AngebotID);
        } 
        catch (Exception ex) 
        {
            message = "Fehler: " + ex.getMessage();
            response.sendRedirect("pictureupload.jsp?AngebotID="+AngebotID+"&Message="+message);
        } 
    }
}