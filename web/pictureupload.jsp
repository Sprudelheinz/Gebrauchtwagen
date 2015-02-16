
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <link type="text/css" href="css/1.css" rel="stylesheet" media="screen" />
    <head>  
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
     <h:body>
        <div id="container">
            <header>
                <h1>Gebrauchtwagenbörse</h1>
            </header>
            <nav>
                
            </nav>
            <aside>
                
            </aside>
            <section id="content">
                <% 
                if(session.getAttribute("AngebotID") != null)
                { %>
                   <form method="post" action="uploadServlet" enctype="multipart/form-data">
                       <input type="hidden" name="AngebotID" value="<%out.print(session.getAttribute("AngebotID"));%>" />
                       <table border="0">
                            <tr>
                                <td>Angebot Photo: </td>
                                <td><input type="file" name="photo" size="50"/></td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <input type="submit" value="Save">
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
