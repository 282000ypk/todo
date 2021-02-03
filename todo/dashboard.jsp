<%@page language="java" import="java.io.*"%>
<%@page language="java" import="java.sql.*"%>
<%@page language="java" import="java.util.*"%>
<%
	HttpSession hs=request.getSession();
	if(hs.getAttribute("name")==null || hs==null)
	{	
		response.sendRedirect("login.html");
	}
%>

<!DOCTYPE html>
<html>
<head>
	<title>Todo</title>
	<script type="text/javascript">
		var flag=true;
		var taskid=-1;
		var sortby="datetime,time"
		function add()
		{

			var name=document.getElementById("taskname").value;
			if(name=="")
			{
				alert("Please enter Task name")
				flag=false;
			}
			else
			{
				flag=true;
				var sdate=document.getElementById("sdate").value;
				var edate=document.getElementById("edate").value;
				var sdatehh=document.getElementById("sdatehh").value;
				var sdatemm=document.getElementById("sdatemm").value;
				var sdatess=document.getElementById("sdatess").value;
				var edatehh=document.getElementById("edatehh").value;
				var edatemm=document.getElementById("edatemm").value;
				var edatess=document.getElementById("edatess").value;
				if(sdatehh>=0 && sdatehh<=23 && sdatemm>=0 && sdatemm<=55 && sdatess>=0 && sdatess<=55 && edatehh>=0 && edatehh<=23 && edatemm>=0 && edatemm<=55 && edatess>=0 && edatess<=55)
				{
					var query="name="+name+"&sdate="+sdate+"&edate="+edate+"&sdatehh="+sdatehh+"&sdatemm="+sdatemm+"&sdatess="+edatess+"&edatehh="+edatehh+"&edatemm="+edatemm+"&edatess="+edatess;
					var xml=new XMLHttpRequest();
					xml.onreadystatechange = function(){
					}
					xml.open("GET","add.jsp?"+query);
					xml.send();
				}
				else
				{
					alert("invalid time or date")
				}
			}
		}
		function addtask()
		{
			add();
			refresh();
		}
		function refresh(value)
		{
			if(value!=null)
				sortby=value;
			task();
			//setTimeout(refresh, 5000);
		}
		function task()
		{
			var xml=new XMLHttpRequest();
			xml.onreadystatechange = function(){
				if(this.readyState==4 && this.status==200)
					document.getElementById("retrived").innerHTML=xml.responseText;
			}
			xml.open("GET","retrive.jsp?sortby="+sortby);
			xml.send();
		}
		function activate(id)
		{
			if(taskid!=-1)
			{
				var x=document.getElementById(taskid+"tr")
				x.style.background='white';
			}
			taskid=id.id;
			var x=document.getElementById(id.id+"tr")
			x.style.background='green';
		}
		function action(option)
		{
			var xml=new XMLHttpRequest();
			xml.onreadystatechange = function(){
				if(this.readyState==4 && this.status==200)
					refresh();
			}
			xml.open("GET","action.jsp?tid="+taskid+"&op="+option);
			xml.send();
			refresh();
		}
		function drop()
		{
			var edit=document.getElementById("edit");
			edit.classList.remove("editactive");
			edit.classList.add("editinactive");
		}
		function edit(flag)
		{
			if(taskid!=-1)
			{
				if(flag)
				{
					var edit=document.getElementById("edit");
					edit.classList.remove("editinactive");
					edit.classList.add("editactive");	
					var data=document.getElementById("val"+taskid).value;
					var dataarr=data.split("|");
					var name=document.getElementById("editname").value=dataarr[0];
					var sdate=document.getElementById("sdate1").value=dataarr[1];
					var edate=document.getElementById("edate1").value=dataarr[2];
					var sdatehh=document.getElementById("sdatehh1").value=dataarr[3].split(":")[0];
					var sdatemm=document.getElementById("sdatemm1").value=dataarr[3].split(":")[1];
					var sdatess=document.getElementById("sdatess1").value=dataarr[3].split(":")[2];
					var edatehh=document.getElementById("edatehh1").value=dataarr[4].split(":")[0];
					var edatemm=document.getElementById("edatemm1").value=dataarr[4].split(":")[1];
					var edatess=document.getElementById("edatess1").value=dataarr[4].split(":")[2];
				}
				else
				{
					var edit=document.getElementById("edit");
					edit.classList.remove("editactive");
					edit.classList.add("editinactive");		
					var name=document.getElementById("editname").value;
					if(name=="")
					{
						alert("Please enter Task name")
						flag=false;
					}
					else
					{
						flag=true;
						var sdate=document.getElementById("sdate1").value;
						var edate=document.getElementById("edate1").value;
						var sdatehh=document.getElementById("sdatehh1").value;
						var sdatemm=document.getElementById("sdatemm1").value;
						var sdatess=document.getElementById("sdatess1").value;
						var edatehh=document.getElementById("edatehh1").value;
						var edatemm=document.getElementById("edatemm1").value;
						var edatess=document.getElementById("edatess1").value;
						if(sdatehh>=0 && sdatehh<=23 && sdatemm>=0 && sdatemm<=55 && sdatess>=0 && sdatess<=55 && edatehh>=0 && edatehh<=23 && edatemm>=0 && edatemm<=55 && edatess>=0 && edatess<=55)
						{
							var query="name="+name+"&sdate="+sdate+"&edate="+edate+"&sdatehh="+sdatehh+"&sdatemm="+sdatemm+"&sdatess="+edatess+"&edatehh="+edatehh+"&edatemm="+edatemm+"&edatess="+edatess+"&tid="+taskid;
							var xml=new XMLHttpRequest();
							xml.onreadystatechange = function(){
							}
							xml.open("GET","edit.jsp?"+query);
							xml.send();
						}
						else
						{
							alert("invalid time or date")
						}
					}
					refresh();	
				}
			}
			else
			{
				alert("select task first")
			}
		}
	</script>
	<meta name="viewport" content="width=device-width,initial-scale=1.0">
	<link rel="stylesheet" type="text/css" href="dashboard.css">
</head>
<body onload="refresh()">
	<div class="mainbody">
		<a href="Logout.jsp"><button class="logout">Logout</button></a>
		<div class="addtask">
			<div class="addtasksub">
				<div class="addtasksub1">
				<span class="taskheading"><b>Add Task:</b><span style="color: red;">*</span> :</span>
				<input type="text" id="taskname" class="taskheadingio" style="" required="">
				</div> 
				<div class="addtasksub2">
					<span style="width: 100%;"><b>Start Date:</b></span>
					<div style="width: 100%">
					<input type="date" id="sdate" style="max-width: 35%;background-color: transparent;border: none;outline: none;border-bottom: solid black;color: black;font-size: 20px;">
					<input type="number" id="sdatehh" placeholder="hh" style="width: 19%;background-color: transparent;border: none;outline: none;border-bottom: solid black;color: black;font-size: 20px;">
					<input type="number" id="sdatemm" placeholder="mm" style="width: 19%;background-color: transparent;border: none;outline: none;border-bottom: solid black;color: black;font-size: 20px;">
					<input type="number" id="sdatess" placeholder="ss" style="width: 19%;background-color: transparent;border: none;outline: none;border-bottom: solid black;color: black;font-size: 20px;">
					</div>
					<span style="width: 100%;"><b>End Date:</b></span>
					<div style="width: 100%">
					<input type="date" id="edate" style="max-width: 35%;background-color: transparent;border: none;outline: none;border-bottom: solid black;color: black;font-size: 20px;">
					<input type="number" id="edatehh" placeholder="hh" style="width: 19%;background-color: transparent;border: none;outline: none;border-bottom: solid black;color: black;font-size: 20px;">
					<input type="number" id="edatemm" placeholder="mm" style="width: 19%;background-color: transparent;border: none;outline: none;border-bottom: solid black;color: black;font-size: 20px;">
					<input type="number" id="edatess" placeholder="ss" style="width: 19%;background-color: transparent;border: none;outline: none;border-bottom: solid black;color: black;font-size: 20px;">
					</div>
				</div>
				<div class="addtasksub3">
				<button class="btn" onclick="addtask()">Add Task</button>
				</div>
			</div>
		</div>
		<div class="blank">

		</div>
		<div class="alltask">
			<div class="action">
				<b>Sort By:</b><select onchange="refresh(this.value)" onload="refresh(this.value)" style="width: 200px;">
					<option value="datetime,time"> Task Add Date Time</option>
					<option value="startdate,starttime"> Task Start Date Time</option>
					<option value="enddate,endtime"> Task End Date Time</option>
				</select>

			</div>
			<div style="min-height: 5%;width: 100%;padding: 10px;">
				<!--<button class="btnaction" onclick="action('d')">delete</button>-->
				<button class="btnaction" onclick="action('c')">complete</button>
				<button class="btnaction" onclick="edit(true)">edit</button>
				<button class="btnaction" onclick="refresh()">Refresh</button>
			</div>
			<div class="retrived" id="retrived">
				
			</div>	
		</div>
	</div>
	<div class="edit editinactive" id="edit">
		<button onclick="edit(false)" class="btn">Save</button><button onclick="drop()" class="btn">Cancel</button>
		<br><span class="taskheading"><b>Edit Task:</b><span style="color: red;">*</span> :</span>
		<input type="text" id="editname" class="taskheadingio" style="">
		<span style="width: 100%;"><b>Start Date:</b></span>
		<div style="width: 100%">
		<input type="date" id="sdate1" style="max-width: 35%;background-color: transparent;border: none;outline: none;border-bottom: solid black;color: black;font-size: 20px;">
		<input type="number" id="sdatehh1" placeholder="hh" style="width: 19%;background-color: transparent;border: none;outline: none;border-bottom: solid black;color: black;font-size: 20px;">
		<input type="number" id="sdatemm1" placeholder="mm" style="width: 19%;background-color: transparent;border: none;outline: none;border-bottom: solid black;color: black;font-size: 20px;">
		<input type="number" id="sdatess1" placeholder="ss" style="width: 19%;background-color: transparent;border: none;outline: none;border-bottom: solid black;color: black;font-size: 20px;">
		<br><span style="width: 100%;"><b>End Date:</b></span>
		<div style="width: 100%">
		<input type="date" id="edate1" style="max-width: 35%;background-color: transparent;border: none;outline: none;border-bottom: solid black;color: black;font-size: 20px;">
		<input type="number" id="edatehh1" placeholder="hh" style="width: 19%;background-color: transparent;border: none;outline: none;border-bottom: solid black;color: black;font-size: 20px;">
		<input type="number" id="edatemm1" placeholder="mm" style="width: 19%;background-color: transparent;border: none;outline: none;border-bottom: solid black;color: black;font-size: 20px;">
		<input type="number" id="edatess1" placeholder="ss" style="width: 19%;background-color: transparent;border: none;outline: none;border-bottom: solid black;color: black;font-size: 20px;">
	</div>
</body>
</html>

