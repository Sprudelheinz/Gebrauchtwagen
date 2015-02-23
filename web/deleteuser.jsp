
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ page import="classes.user"%>

<html>
    <link type="text/css" href="css/1.css" rel="stylesheet" media="screen" />
    <head>  
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Gebrauchtwagenbörse</title>
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
                if(request.getParameter("Delete") == null && request.getParameter("UserID") == null && session.getAttribute("admin") == null && session.getAttribute("userid") != null)
                { %>
                   <form method="get" action="">
                       <input type="hidden" name="Delete" value="<%out.print(session.getAttribute("userid"));%>" />
                       <table border="0">
                            <tr>
                                <td>Ihren Account und alle ihre Angebote endgültig löschen?</td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <input type="submit" value="Account löschen">
                                </td>
                            </tr>
                        </table>
                    </form>                              
                <% 
                }                
                if(request.getParameter("Delete") == null && request.getParameter("UserID")!=null && session.getAttribute("admin") != null)
                { %>
                   <form method="get" action="">
                       <input type="hidden" name="Delete" value="<%request.getParameter("UserID");%>" />
                       <table border="0">
                            <tr>
                                <td>Den ausgewählten Account und alle zugehörigen Angebote endgültig löschen?</td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <input type="submit" value="Account löschen">
                                </td>
                            </tr>
                        </table>
                    </form>                              
                <% 
                } 
                if(request.getParameter("Delete") == null && request.getParameter("UserID") == null && session.getAttribute("admin") != null)
                { %>
                   Admin Account kann nicht gelöscht werden.                  
                <% } %>
                <% 
                if(request.getParameter("Delete") != null) 
                {
                    user a = new user();
                    out.print(a.deleteuser(Integer.parseInt(request.getParameter("Delete"))));
                    session.setAttribute("userid", null);
                    session.setAttribute("username", null);
                    session.invalidate();
                }
                %>          
            </section>
            <footer>               
            </footer>
        </div>
        
    </h:body>
</html>
