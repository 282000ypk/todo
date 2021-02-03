<%@page language="java" import="java.io.*"%>
<%@page language="java" import="java.sql.*"%>
<%@page language="java" import="java.util.*"%>
<%
    HttpSession hs=request.getSession();
    String uname=hs.getAttribute("name")+"";
    String sortby=request.getParameter("sortby");
	Connection con;
    Statement st;
    ResultSet rs;
    try
    {
        Class.forName("org.postgresql.Driver");
        con=DriverManager.getConnection("jdbc:postgresql://ec2-54-160-120-28.compute-1.amazonaws.com/deo9lklvpqmcj0","sctialzdhovxkq","9261bbeee7ad3bc2ea836532f43ad2ec8d9eb986fa6e272a9ed55d514a83eab8");
        st=con.createStatement();
        rs=st.executeQuery("select task,startdate,date_trunc('minute',starttime),enddate,date_trunc('minute',endtime),id from task where cid='"+uname+"' order by "+sortby+" desc");
            out.print("<table border=1 class=\"tasktable\">");
                    out.print("<tr style=\"color: white;background: black;\">");
                        out.print("<td>Task Name</td><td>Start Date</td>");
                        out.print("<td>Start Time</td>");
                        out.print("<td>End Date</td>");
                        out.print("<td>End Time</td>");
                        out.print("<td>Status</td>");
                    out.print("</tr>");
            while(rs.next())
            {
                boolean flag=false;
                String name="";
                String task[]=rs.getString(1).split(" ");
                if(task.length==1)
                {
                    name=rs.getString(1)+"";
                }
                else
                {
                    if(task[task.length-1].equals("COMPLETED"))
                    for(int i=0;i<task.length-1;i++)
                    {
                        name+=task[i]+" ";
                        flag=true;
                    }
                    else
                    {
                        name=rs.getString(1)+"";
                    }
                }
                String startdate=(rs.getString(2)==null)?"":rs.getString(2);
                String starttime=(rs.getString(3)==null)?"":rs.getString(3);
                String enddate=(rs.getString(4)==null)?"":rs.getString(4);
                String endtime=(rs.getString(5)==null)?"":rs.getString(5);
                out.print("<tr id="+rs.getString(6)+"tr >");
                out.print("<input type=text id=val"+rs.getString(6)+" value='"+name+"|"+startdate+"|"+enddate+"|"+starttime+"|"+endtime+"' style=\"display: none\">");
                    if(flag==true)
                    out.print("<td><input type=radio name=op id="+rs.getString(6)+" value="+rs.getString(6)+" onchange=\"activate(this)\">&nbsp&nbsp<s>"+name+"</s></td><td>"+startdate+"</td>");
                    else
                    out.print("<td><input type=radio name=op id="+rs.getString(6)+" value="+rs.getString(6)+" onchange=\"activate(this)\">&nbsp&nbsp"+name+"</td><td>"+startdate+"</td>");
                    out.print("<td>"+starttime+"</td>");
                    out.print("<td>"+enddate+"</td>");
                    out.print("<td>"+endtime+"</td>");
                    if(flag==true)
                        out.print("<td>"+task[task.length-1].charAt(0)+"</td>");
                    else
                        out.print("<td></td>");
                out.print("</tr>");
               	
            }
            out.print("</table>");
            con.close();
    }
    catch(Exception e)
    {
        out.print(e);
    }
%>