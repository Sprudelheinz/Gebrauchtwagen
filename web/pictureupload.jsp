
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <link type="text/css" href="css/1.css" rel="stylesheet" media="screen" />
    <head>  
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Gebrauchtwagenbörse</title>
        <link type="text/css" href="css/1.css" rel="stylesheet" media="screen" />
        <link rel="shortcut icon" href="img/favicon.ico">
    </head>
     <h:body>
        <div id="container">
            <header>
                <h1>Gebrauchtwagenbörse</h1>
            </header>
            <nav>
                <div id="navdiv"><a href="index.jsp">Startseite</a></div>  
            </nav>
             <aside>                 
                 <%@include file="aside.jsp" %>
             </aside>
            <section id="content">
                <% 
                if(request.getParameter("Message") != null)
                    out.println(request.getParameter("Message"));
                if(request.getParameter("AngebotID") != null)
                { %>
                   <form method="post" action="uploadServlet" enctype="multipart/form-data">
                       <input type="hidden" name="AngebotID" value="<%out.print(request.getParameter("AngebotID"));%>" />
                       <table border="0">
                            <tr>
                                <td>Angebot Photo: </td>
                                <td><input type="file" name="photo0" size="50"/></td>
                            </tr>
                            <tr>
                                <td>Angebot Photo 2: </td>
                                <td><input type="file" name="photo1" size="50"/></td>
                            </tr>
                            <tr>
                                <td>Angebot Photo 3: </td>
                                <td><input type="file" name="photo2" size="50"/></td>
                            </tr>
                            <tr>
                                <td>Angebot Photo 4: </td>
                                <td><input type="file" name="photo3" size="50"/></td>
                            </tr>
                            <tr>
                                <td>Angebot Photo 5: </td>
                                <td><input type="file" name="photo4" size="50"/></td>
                            </tr>
                            
                            <tr>
                                <td colspan="2">
                                    <input type="submit" value="Bild speichern">
                                </td>
                            </tr>
                        </table>
                    </form>                              
                <% }
                %>          
            </section>
            <footer>               
            </footer>
        </div>
        
    </h:body>
</html>
