<%@page language="java" import="java.io.*"%>
<%@page language="java" import="java.sql.*"%>
<%
HttpSession hs=request.getSession();
String cid=hs.getAttribute("name")+"";
String tid=request.getParameter("tid");
String name=request.getParameter("name");
//out.print(name+"<br>");
String sdate=(request.getParameter("sdate")=="")?"NULL":"'"+request.getParameter("sdate")+"'";
//out.print(sdate+"<br>");
String edate=(request.getParameter("edate")=="")?"NULL":"'"+request.getParameter("edate")+"'";
//out.print(edate+"<br>");
String sdatehh=(request.getParameter("sdatehh")=="")?"0":""+request.getParameter("sdatehh")+"";
//out.print(sdatehh+"<br>");
String sdatemm=(request.getParameter("sdatemm")=="")?"0":""+request.getParameter("sdatemm")+"";
//out.print(sdatemm+"<br>");
String sdatess=(request.getParameter("sdatess")=="")?"0":""+request.getParameter("sdatess")+"";
//out.print(sdatess+"<br>");
String edatehh=(request.getParameter("edatehh")=="")?"0":""+request.getParameter("edatehh")+"";
//out.print(edatehh+"<br>");
String edatemm=(request.getParameter("edatemm")=="")?"0":""+request.getParameter("edatemm")+"";
//out.print(edatemm+"<br>");
String edatess=(request.getParameter("edatess")=="")?"0":""+request.getParameter("edatess")+"";
//out.print(edatess+"<br>");

String stime=(sdatehh=="NULL" && sdatemm=="NULL" && sdatess=="NULL")?"NULL":"'"+sdatehh+":"+sdatemm+":"+sdatess+"'";
String etime=(edatehh=="NULL" && edatemm=="NULL" && edatess=="NULL")?"NULL":"'"+edatehh+":"+edatemm+":"+edatess+"'";

Connection con;
Statement st;
ResultSet rs;
try
{
    out.print("update task set task='"+name+"' ,cid='"+cid+"',NOW(),NOW(),startdate="+sdate+",starttime="+stime+",enddate="+edate+",endtime="+etime+" where id="+tid);
    Class.forName("org.postgresql.Driver");
    con=DriverManager.getConnection("jdbc:postgresql://ec2-54-160-120-28.compute-1.amazonaws.com/deo9lklvpqmcj0","sctialzdhovxkq","9261bbeee7ad3bc2ea836532f43ad2ec8d9eb986fa6e272a9ed55d514a83eab8");
    st=con.createStatement();
    /* insert into task values(DEFAULT,'name','ADMIN',NOW(),NOW(),'2021-01-27','1:1:1','2021-01-27','2:2:2');*/
    try{
    rs=st.executeQuery("update task set task='"+name+"' ,cid='"+cid+"',datetime=NOW(),time=NOW(),startdate="+sdate+",starttime="+stime+",enddate="+edate+",endtime="+etime+" where id="+tid);
    }
    catch(Exception ee)
    {
        out.print(ee);
    }
    con.close();
    out.print("success");
}
catch(Exception e)
{
    out.print(e);
}
%>