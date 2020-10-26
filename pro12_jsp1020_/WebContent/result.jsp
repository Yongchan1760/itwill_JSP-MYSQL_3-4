<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    
    
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
</head>
<body>
	<h1>login.html의 요청을 받아 클라이언트의 웹브라우저에 응답해주는 result.jsp페이지 </h1>
	
	<%
		//1, login.html에서 입력한 아이디와 비밀번호가 한글이 존재하면 한글이 꺠지므로 ruquest 
		//내장객체 영역에 인코딩방식을 utf-8로 지정하자
		//한글처리
		request.setCharacterEncoding("utf-8");
	
	
		//2. login.html 에서 입력하여 요청한 요청값 얻기
		//request 내장객체 영역에서 꺼내오기
		//방법) request객체.getparmeter("<input 태그의 namd속성값>") 반환값 ->입력한 값을 문자열로 얻는다.
	 	String user_id=request.getParameter("user_id");
		
	 	String user_pw=request.getParameter("user_pw");

	%>
	
	<h1> 입력한 아이디:  <%=user_id %> </h1>
	<h1> 입력한 비밀번호:  <%=user_pw %> </h1>
	
</body>
</html>