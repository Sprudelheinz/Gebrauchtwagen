<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="classes.angebot" %>

<!DOCTYPE html>
<html>
    <link type="text/css" href="css/1.css" rel="stylesheet" media="screen" />
    <head>  
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Gebrauchtwagenbörse</title>
        <link rel="shortcut icon" href="img/favicon.ico">
        <link rel="stylesheet" type="text/css" href="shadowbox/shadowbox.css">
        <script type="text/javascript" src="js/jquery.min.js"></script>
        <script type="text/javascript" src="shadowbox/shadowbox.js"></script>
        <script type="text/javascript">
            Shadowbox.init();
        </script>
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
                if(request.getParameter("AngebotID") != null)
                {
                    String Pfad = request.getServletContext().getRealPath("/");
                    angebot a = new angebot();
                    int AngebotID = Integer.parseInt(request.getParameter("AngebotID"));
                    out.print(a.showAngebot(AngebotID,Pfad));
                }
                else
                    out.print("Kein Angebot ausgewählt");
                %>
                
            </section>
            <footer>
                
            </footer>
        </div>
        
    </h:body>
</html>
