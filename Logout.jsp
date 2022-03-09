<%@page language="java" import="java.io.*"%>
<%@page language="java" import="java.sql.*"%>
<%@page language="java" import="java.util.*"%>
<%
	HttpSession hs=request.getSession();
	hs.invalidate();
	response.sendRedirect("login.html");
%>