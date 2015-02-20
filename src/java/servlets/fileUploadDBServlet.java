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
         
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
    {       
        InputStream inputStream = null;
        String AngebotID = "";
        if(request.getParameter("AngebotID") != null)
             AngebotID = request.getParameter("AngebotID");
        Part filePart = request.getPart("photo");           
        Connection conn = null; 
        String message = null;         
        try 
        {
            if (filePart != null) 
            {
                String mimetype = filePart.getContentType();
                inputStream = filePart.getInputStream();
                String type = mimetype.split("/")[0];
                if(!type.equals("image"))
                    throw new Exception("Kein Bild");
            }
            else
                throw new Exception("Datei ist leer");
            DriverManager.registerDriver(new com.mysql.jdbc.Driver());
            conn = DriverManager.getConnection(db.CONNECTIONSTRING, db.USERDB, db.PASSWORDDB);
            String sql = "UPDATE angebot SET photo = (?) WHERE AngebotID = '" +AngebotID + "'";
            PreparedStatement statement = conn.prepareStatement(sql);            
            if (inputStream != null) 
            {
               statement.setBlob(1, inputStream);
            }
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