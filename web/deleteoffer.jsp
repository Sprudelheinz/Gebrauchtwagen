
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ page import="classes.angebot"%>

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
                <div id="navdiv"><a href="index.jsp">Startseite</a></div>  
            </nav>
             <aside>                 
                 <%@include file="aside.jsp" %>
             </aside>
            <section id="content">
                <% 
                if(request.getParameter("AngebotID") != null)
                { %>
                   <form method="get" action="">
                       <input type="hidden" name="Delete" value="<%out.print(request.getParameter("AngebotID"));%>" />
                       <table border="0">
                            <tr>
                                <td>Angebot endgültig löschen?</td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <input type="submit" value="Angebot löschen">
                                </td>
                            </tr>
                        </table>
                    </form>                              
                <% } 
                else 
                {
                    angebot a = new angebot();
                    out.print(a.deleteoffer(Integer.parseInt(request.getParameter("Delete"))));
                }
                %>          
            </section>
            <footer>               
            </footer>
        </div>
        
    </h:body>
</html>
