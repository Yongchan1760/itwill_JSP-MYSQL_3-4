<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
</head>
<body>
	<!-- 2. scoreTest.html로부터 입력받은 점수를 다중 if~else문을 이용해 학점으로 변환합니다. -->
	
	<%
		//1.한글처리
		request.setCharacterEncoding("utf-8");
		//2. 입력받은 시험점수를 request객체 영역에서 꺼내와서 int score 변수에 저장시키기
		String user_score =request.getParameter("score");
		int score=Integer.parseInt(user_score);
	%>
		
	<%
		//3.시험점수 100점 출력
	%>	
	
	<%
		//4. 입력 받은 점수가 90점 이상이면 if??
				if(score>=90){
	%>			
					<h1>a학점입니다.</h1>
	<% 				
				}else if(score>=80){
	%>			
					<h1>b학점입니다.</h1>
	<% 				
				}else if(score>=70){
	%>
					<h1>c학점입니다.</h1>		
	<% 			
				}else if(score>=60){
	%>	
					<h1>d학점입니다.</h1>
	<% 			
				}else{
	%>				
					<h1>f학점입니다.</h1>
	<% 			
				}
				//h1 a학점입니다.
				
				//입력받은 점수가 80~90점 사이이면 
				//h1 b학점입니다.
				
				//입력받은 점수가 70~80점 사이이면 
				//h1 c학점입니다.
				
				//입력받은 점수가 60~70점 사이이면 
				//h1 d학점입니다.
				
				//그외 
				//h1 f학점입니다.
	%>
	
	<br>
	<a href="scoreTest.html">시험점수 다시 입력하러 가기</a>
</body>
</html>