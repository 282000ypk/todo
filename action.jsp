<%@page language="java" import="java.sql.*"%>
<%
String tid=request.getParameter("tid");
char op=request.getParameter("op").charAt(0);
    Connection con;
    Statement st;
    ResultSet rs;
    try
    {
        Class.forName("org.postgresql.Driver");
        con=DriverManager.getConnection("jdbc:postgresql://ec2-54-160-120-28.compute-1.amazonaws.com/deo9lklvpqmcj0","sctialzdhovxkq","9261bbeee7ad3bc2ea836532f43ad2ec8d9eb986fa6e272a9ed55d514a83eab8");
        st=con.createStatement();
        try
        {
            switch(op)
            {
                case 'c':
                    rs=st.executeQuery("update task set task=(select task from task where id="+tid+")||' COMPLETED' where id="+tid);
                break;
                case 'e':
                    
                break;
                case 'd':
                    rs=st.executeQuery("delete from task where id="+tid);
                break;
            }
    	}
    	catch(Exception ee)
    	{
            out.print(ee);
    	}
    	con.close();
    	out.print("closed");
    }
    catch(Exception e)
    {
    	out.print(e);
    }
//out.print(name+" "+id+" "+pass);
%>