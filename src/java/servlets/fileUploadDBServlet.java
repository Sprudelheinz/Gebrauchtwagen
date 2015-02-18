package servlets;


import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
 
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
        if (filePart != null) 
        {
            System.out.println(filePart.getName());
            System.out.println(filePart.getSize());
            System.out.println(filePart.getContentType());
            inputStream = filePart.getInputStream();
        }         
        Connection conn = null; 
        String message = null;         
        try 
        {
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
        } 
        catch (SQLException ex) 
        {
            message = "Fehler: " + ex.getMessage();
            ex.printStackTrace();
        } 
        finally 
        {
            if (conn != null) 
            {
                try 
                {
                    conn.close();
                } 
                catch (SQLException ex) 
                {
                    ex.printStackTrace();
                }
            }
            request.setAttribute("Message", message);
            response.sendRedirect("angebot.jsp?AngebotID="+AngebotID);
        }
    }
}