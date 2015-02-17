<%
    String logout = request.getParameter("logout");
    session.setAttribute("userid", null);
    session.setAttribute("username", null);
    session.invalidate();
    response.sendRedirect(logout);
%>