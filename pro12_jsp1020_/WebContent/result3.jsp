<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    
    
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
</head>
<body>
	<h1>login3.html의 요청을 받아 클라이언트의 웹브라우저에 응답해주는 result3.jsp페이지 </h1>
	
	<%
		//1, login3.html에서 입력한 아이디와 비밀번호가 한글이 존재하면 한글이 꺠지므로 ruquest 
		//내장객체 영역에 인코딩방식을 utf-8로 지정하자
		//한글처리
		request.setCharacterEncoding("utf-8");
	
	
		//2. login3.html 에서 입력하여 요청한 요청값 얻기
		//request 내장객체 영역에서 꺼내오기
		//방법) request객체.getparmeter("<input 태그의 namd속성값>") 반환값 ->입력한 값을 문자열로 얻는다.
	 	String user_id=request.getParameter("user_id");
		
	 	String user_pw=request.getParameter("user_pw");

	%>
	
<%--한걸음 더나아가 스크립틀릿 기호 안에 자바코드를 사용해 id가 정상적으로 입력되었는지 체크한후 
	정상 입력 여부에 따라 동적으로 다른 결과를 출력하도록 구현하자. --%>
	
	<% 
		//아이디를 입력하지 않았다면 ?
		if(user_id==null || user_id.length()==0){
	%>		
			아이디를 입력하세요 .<br>
			<a href="/pro12_jsp/login3.html">로그인하기</a>
	<% 	
		}else{//아이디를 입력했다면?
			if(user_id.equals("admin")){//아이디를 입력한 경우 입력할 아이디가 admin이면? 다시 체크 
	%>	
				<h1> 관리자로 로그인 했습니다.</h1>
				<form action="">
					<input type="button" value="회원정보 수정하기 ">
					<input type="button" value="회원정보 삭제하기">			
				</form>
	<% 
		}else{//일반 사용자 아이디를 입력했을경우 admin이 아니고 일반 사용자 
	%>		
			<h1> 환영합니다. <%=user_id%> 님!!!</h1>
	<%
		}		
		}
	%>
	
</body>
</html>