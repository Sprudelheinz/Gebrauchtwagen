<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ page import="classes.search"%>
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
                <h1><a href="index.jsp">Gebrauchtwagenbörse</a></h1>
            </header>
            <nav>
                <div id="navdiv"><a href="index.jsp">Startseite</a></div>  
            </nav>
             <aside>                 
                <%@include file="aside.jsp" %>
             </aside>
            <section id="content">
                 <%
                if ((session.getAttribute("userid") == null) || (session.getAttribute("userid") == "")) {
                %>
                Nicht angemeldet. Bitte melden sie sich an
                <% } 
                else  
                {                                
                    search s = new search();
                    out.print(s.showMyOffers(session.getAttribute("userid").toString()));      
                }                                                      
                %>               
            </section>
            <footer>
                
            </footer>
        </div>
        
    </h:body>
</html>
