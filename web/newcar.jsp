<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ page import="java.io.*,java.util.*,java.sql.*,java.text.*,java.util.Date,classes.angebot"%>

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
                 Nicht eingeloggt. Bitte melden Sie sich an.
                 <% } else { %>
                <article>
                    <% 
                         if(request.getParameter("errorreg") != null) {out.println(request.getParameter("errorreg"));} 
                         angebot a = new angebot();
                         boolean edit = false;
                         if(request.getParameter("edit") != null)
                         {
                             edit = true;
                             a.getDataFromDB(Integer.parseInt(request.getParameter("edit")));
                         }
                    %>
                    
                    <form name="newcar" method="post"  action="">
                        <% if(edit){ %>
                        <input type="hidden" name="edit" value="<%=request.getParameter("edit")%>">
                        <% }%>
                        <div id="divrund">
                            <table>                               
                                <tr>
                                    <th>Fahrzeugdaten:</th>
                                </tr>
                                <tr>
                                    <td>Typ</td>
                                    <td>
                                        <select name="typ" onchange="document.newcar.submit()">
                                            <option <%if(request.getParameter("typ")!=null&&request.getParameter("typ").equals("0")){out.print("selected");}%> value="0">Auto</option>
                                            <option <%if(request.getParameter("typ")!=null&&request.getParameter("typ").equals("1")){out.print("selected");}%> value="1">Motorrad</option>    
                                        </select>
                                    <td>
                                </tr>
                                <tr>
                                    <td>Fahrzeugzustand</td>
                                    <td>
                                    <% String neu = request.getParameter("new"); %>     
                                    <input type="checkbox" <%if(neu!=null || (a.Neu&&edit)) out.print("checked"); %> name="new" id="new" onchange="document.newcar.submit()" />Neu
                                    </td>
                                </tr>
                                <tr>                                                                  
                                    <td>Marke:*</td>                             
                                    <td>
                                        <jsp:useBean id="dropdown" class="classes.dropdownlist" scope="request" />                               
                                        <%
                                            String typ="";
                                            if(request.getParameter("typ") != null)
                                                typ = request.getParameter("typ");
                                            if((typ.equals("") || typ.equals("0")) && !edit)
                                                out.println(dropdown.ddmarke(request.getParameter("Marke"),"newcar"));
                                            if((typ.equals("") || typ.equals("0")) && edit)
                                                out.println(dropdown.ddmarke(a.MarkeID,"newcar"));
                                            if(typ.equals("1") && !edit)
                                                out.println(dropdown.ddmarkemotorrad(request.getParameter("Marke"),"newcar"));
                                            if(typ.equals("1") && edit)
                                                out.println(dropdown.ddmarkemotorrad(a.MarkeID,"newcar"));
                                            Date date = new Date();
                                            SimpleDateFormat output = new SimpleDateFormat("yyyy");
                                        %>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Modell:*</td>
                                    <td>
                                        <%
                                            if((typ.equals("") || typ.equals("0")) && !edit )
                                                out.println(dropdown.ddmodell(request.getParameter("Marke"),request.getParameter("Modell")));
                                            if((typ.equals("") || typ.equals("0")) && edit )
                                                out.println(dropdown.ddmodell(a.MarkeID,a.ModellID));
                                            if(typ.equals("1") && !edit)
                                                out.println(dropdown.ddmodellmotorrad(request.getParameter("Marke"),request.getParameter("Modell")));
                                            if(typ.equals("1") && edit)
                                                out.println(dropdown.ddmodellmotorrad(a.MarkeID,a.ModellID));
                                        %>
                                    </td>
                                </tr>
                                <% if(neu == null){ %>
                                 
                                <tr>                         
                                    <td>Erstzulassung:*</td>
                                    <td>
                                    <select id="EZMonat" name="EZMonat">
                                        <option value="1">Januar</option> 
                                        <option value="2">Februar</option> 
                                        <option value="3">März</option> 
                                        <option value="4">April</option> 
                                        <option value="5">Mai</option> 
                                        <option value="6">Juni</option> 
                                        <option value="7">Juli</option> 
                                        <option value="8">August</option> 
                                        <option value="9">September</option>
                                        <option value="10">Oktober</option> 
                                        <option value="11">November</option> 
                                        <option value="12">Dezember</option> 
                                    </select>                                     
                                        <input type="number" name="EZJahr" min="1900" max="<%= output.format(date) %>" value="<%=a.EZJahr%>" />
                                    </td>
                                </tr>
                                
                                <%}%>
                                <tr>
                                    <td>Preis:*</td>
                                    <td><input type="text" name="preis" value="<%=a.Preis%>"></td>
                                </tr>
                                <% if(neu == null){ %>
                                <tr>
                                    <td>Kilometer:*</td>
                                    <td><input type="number" name="KM" min="0" max="99999999" value="<%=a.KM%>"></td>
                                </tr> 
                                <%}%>                               
                                <tr>
                                    <td>Kraftstoffart:*</td>
                                    <td>
                                        <select id="kraftstoffart" name="kraftstoffart">
                                            <option value="Benzin">Benzin</option>
                                            <option value="Diesel">Diesel</option>
                                            <option value="Elektro">Elektro</option>
                                            <option value="Gas">Gas</option>
                                            <option value="Hybrid">Hybrid</option>
                                        </select>
                                    </td>
                                </tr> 
                                
                                <tr>
                                    <td>Hubraum:*</td>
                                    <td><input type="number" name="hubraum" min="0" max="99999999" value="<%=a.Hubraum%>"></td>
                                </tr>
                                <tr>
                                    <td>Leistung (PS):*</td>
                                    <td><input type="number" name="PS" min="0" max="99999999" value="<%=a.PS%>"></td>
                                </tr>
                                <% if(typ.equals("") || typ.equals("0") ) { %>
                                <tr>
                                    <td>Anzahl der Türen:</td>
                                    <td>
                                        <select id="anzturen" name="anzturen">
                                            <option value="2/3">2/3</option>
                                            <option value="4/5">4/5</option>
                                            <option value="6/7">6/7</option>
                                        </select>
                                    </td>
                                </tr>  
                                <% } %>
                                <tr>
                                    <td>TÜV</td>
                                    <td><input type="checkbox" name="tuv" <% if(a.TUV)out.print("checked"); %>></td>
                                </tr>
                                <tr>                         
                                    <td>TÜV bis:</td>
                                    <td>
                                        <select id="TUVMonat" name="TUVMonat">
                                            <option value="1">Januar</option> 
                                            <option value="2">Februar</option> 
                                            <option value="3">März</option> 
                                            <option value="4">April</option> 
                                            <option value="5">Mai</option> 
                                            <option value="6">Juni</option> 
                                            <option value="7">Juli</option> 
                                            <option value="8">August</option> 
                                            <option value="9">September</option>
                                            <option value="10">Oktober</option> 
                                            <option value="11">November</option> 
                                            <option value="12">Dezember</option> 
                                        </select>
                                   
                                        <input type="number" name="TUVJahr" min="<%= output.format(date) %>" max="2500" value="<%if(a.TUVJahr!=0){out.print(a.TUVJahr);}%>" />
                                    </td>
                                </tr> 
                                <tr>
                                    <td>Sichtbar in Suche</td>
                                    <td><input type="checkbox" name="notvisible" <% if(!a.notvisible){out.print("checked");} %>></td>
                                </tr>
                                <tr>
                                    <td>Beschreibung:</td>
                                    <td><textarea name="beschreibung" cols="27" rows="10"><%=a.Beschreibung%></textarea></td>
                                </tr>
                            <tr>
                                <td><input type="submit" value="senden" formaction="newcardatatodb"></td>
                            <tr>
                            </table>
                         </div>
                        <script type="text/javascript">
                               document.getElementById("EZMonat").value = <%=a.EZMonat%>;
                               document.getElementById("kraftstoffart").value="<%=a.Kraftstoff%>";
                               document.getElementById("anzturen").value="<%=a.AnzTueren%>";
                               document.getElementById("TUVMonat").value="<%=a.TUVMonat%>";
                        </script>
                    </form>
                </article>
                  <% }     %>             
            </section>
            <footer>
                
            </footer>
        </div>
       
    </h:body>
    
</html>
