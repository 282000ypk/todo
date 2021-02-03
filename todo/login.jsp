<%@page language="java" import="java.io.*"%>
<%@page language="java" import="java.sql.*"%>
<%@page language="java" import="java.util.*"%>
<%
    String uname=request.getParameter("uname");
    String pass=request.getParameter("pass");
    String re=request.getParameter("check");
    boolean flag=false;
    Connection con;
    Statement st;
    ResultSet rs;
    try
    {
        Class.forName("org.postgresql.Driver");
        con=DriverManager.getConnection("jdbc:postgresql://ec2-54-160-120-28.compute-1.amazonaws.com/deo9lklvpqmcj0","sctialzdhovxkq","9261bbeee7ad3bc2ea836532f43ad2ec8d9eb986fa6e272a9ed55d514a83eab8");
        st=con.createStatement();
        rs=st.executeQuery("select password from login where id='"+uname+"'");
            while(rs.next())
            {
                if(rs.getString(1).equals(pass))
                {
                    flag=!flag;
                    HttpSession hs=request.getSession(true);
                    hs.setAttribute("name",uname);
                }
            }
        con.close();
    }
    catch(Exception e)
    {
        response.sendRedirect("error.html");
    }
    if(flag)
    {
        
        response.sendRedirect("dashboard.jsp");
    }
%>
<!DOCTYPE html>    
<html>    
<head>    
	<meta charset="utf-8" name="viewport" content="width=device-width,initial-scale=1.0">
    <title>Login Form</title>    
    <link rel="stylesheet" type="text/css" href="style.css">    
</head>    
<body>    
    <h2>WELCOME TO MY TO-DO LIST</h2><br>    
    <div class="login">    
    <form method="post" action="login.jsp">    
        <span style="color: red;">Invalid Id or Password</span><br>
        <label><b>USER  
        </br>    
        </label>    
        <input type="text" name="uname" id="Uname" placeholder="Username" required="">    
        <br><br>    
        <label><b>PASSWORD  
        </b>    
        </label>    
        <input type="Password" name="pass" id="Pass" placeholder="Password" required="">    
        <br><br>    
        <input type="submit" name="log" id="log" value="Login">       
        <br><br>    
        <input type="checkbox" id="check" name="check">    
        <span>REMEMBER ME</span>    
    </form>     
</div>    
</body>    