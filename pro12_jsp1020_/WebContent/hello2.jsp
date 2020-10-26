<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
    <%--선언문을 이용해
    name변수를 선언후 이순신 저장 
    getname()메소드 선언 -> name 변수에 저장된값 반환 
     --%>
     
     <%!String name="이순신";
     public String getName(){
    	 return name;
     }
     %>
     
      <%--
   	순서1.   
      클라이언트가 웹브라우저 주소창에 주소를 입력해서 hello2.jsp페이지를 요청합니다.
      요청할 주소> httpL localhost:8080/pro12_jsp/hello2.jsp?age=22
     
     순서2. 
     요청을 받은 hello2.jsp 서버페이지에서 request객체 메모리에 저장되어있는 요청한 age값을 얻는다.
     
   	순서3.
     
     
     --%>
     
     <%--스크립틀릿 기호 내부에 자바코드 이용 --%>
     <% String age=request.getParameter("age"); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<%--표현식을 이용해 전송된 나이를 클라이언트의 웹브라우저로 출력 (응답)함. --%>
	<h1>안녕하세요 <%=getName() %>님!!</h1> 
	<h1>나이는 <%=age%>살입니다.!!</h1>
</body>
</html>