<div id="divrund">
    <%

        String uri = request.getRequestURI();
        String pageName = uri.substring(uri.lastIndexOf("/")+1);
        if(pageName.equals("angebot.jsp"))
        {
           pageName +="?AngebotID="+request.getParameter("AngebotID");
        }
        if ((session.getAttribute("userid") == null) || (session.getAttribute("userid") == "")) {
    %>
    <form method="post" action="login.jsp">
     <input type="hidden" name="login" value="<%=pageName %>"/>
       <center>
        <table border="0" width="30%" cellpadding="3">
            <thead>
                <tr>
                    <th colspan="2">Login</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>User</td>
                    <td><input type="text" name="uname" style="width:100px;height:25px;" value="" /></td>
                </tr>
                <tr>
                    <td>Passwort</td>
                    <td><input type="password" name="pass" style="width:100px;height:25px;" value="" /></td>
                </tr>
                <tr>
                    <td><input type="submit" value="Login" /></td>
                </tr>
                            
                <% 
                if (session.getAttribute("error") != null)
                {
                    out.println("Falsche Anmeldedaten");
                    session.setAttribute("error",null);
                }
                %>
            </tbody>
            </table>
            <div id="navdiv"><a href="reg.jsp">Registrieren</a></div>
        </center>
    </form>
    <% } else {%>Hallo <%=session.getAttribute("username")%>
              
        
        <% 
        if(session.getAttribute("admin") != null && session.getAttribute("admin").equals("1")){            
        %>
        <div id="navdiv"><a href='adminoffers.jsp'>Admin Angebote</a></div>
        <div id="navdiv"><a href='adminuser.jsp'>Admin User</a></div>
         <%}else {%> 
         <div id="navdiv"><a href='myoffers.jsp'>Meine Angebote</a></div>
         <div id="navdiv"><a href='myparkplatz.jsp'>Mein Parkplatz</a></div>
        <div id="navdiv"><a href="newcar.jsp">Neues Angebot</a></div><br><br>
        <%}%>
        <div id="navdiv"><a href='settings.jsp'>Einstellungen</a></div>
        <div id="navdiv"><a href='logout.jsp?logout=<%=pageName %>'>Logout</a></div>
        
    <%}%>
    
</div>