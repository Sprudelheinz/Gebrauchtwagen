<div id="divrund">
    <%

        String uri = request.getRequestURI();
        String pageName = uri.substring(uri.lastIndexOf("/")+1);
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
                <tr>
                    <td colspan="2"><a href="reg.jsp">Registrieren</a></td>
                </tr>
                <% 
                if (request.getParameter("loginerror") != null)
                    out.println("Falsche Anmeldedaten");
                %>
            </tbody>
            </table>
        </center>
    </form>
    <% } else {%>Hallo <%=session.getAttribute("username")%>
        <a href='logout.jsp?logout=<%=pageName %>'>Log out</a><br>
        <a href='settings.jsp'>Einstellungen</a><br>
        <a href='myoffers.jsp'>Meine Angebote</a><br><br>

    <%}%>
    <a href="newcar.jsp">Neues Angebot</a>
</div>