<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>

</head>
<body>
	<%
		request.setCharacterEncoding("utf-8");
		int number=Integer.parseInt(request.getParameter("dan"));		
	%>
		<h1>for문을 이용해 구구단을 리스트로 출력합니다.</h1>
		<table border=1  width="1000">
			<tr bgcolor="yellow"> 
				<th colspan="2"><%=number %>단출력</th>
			</tr>
	<% 	
		for(int i=1;i<10;i++){
			if(i%2!=0){
	%>
		<tr align='center' bgcolor="green"> 
			<td width="500"><%=number+"*"+i %></td>
			<td width="500"><%=number*i%></td>
		</tr>
	<% 
		}else{
	%>
		<tr align='center' bgcolor="aqua"> 
			<td width="500"><%=number+"*"+i %></td>
			<td width="500"><%=number*i%></td>
		</tr>
	<% 
		}				
	}
	%>
	</table>
</body>
</html>