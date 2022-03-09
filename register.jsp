<%@page language="java" import="java.sql.*"%>
<%
String name=request.getParameter("name");
String id=request.getParameter("id");
String pass=request.getParameter("password");
Connection con;
    Statement st;
    ResultSet rs;
    try
    {
        Class.forName("org.postgresql.Driver");
        con=DriverManager.getConnection("jdbc:postgresql://ec2-54-160-120-28.compute-1.amazonaws.com/deo9lklvpqmcj0","sctialzdhovxkq","9261bbeee7ad3bc2ea836532f43ad2ec8d9eb986fa6e272a9ed55d514a83eab8");
        st=con.createStatement();
        try{
        rs=st.executeQuery("insert into login values('"+id+"','"+pass+"');insert into customer values('"+name+"','"+id+"')");
    	}
    	catch(Exception ee)
    	{

    	}
    	con.close();
    	out.print("closed");
    	response.sendRedirect("login.html");
    }
    catch(Exception e)
    {
    	out.print(e);
    }
//out.print(name+" "+id+" "+pass);
%>