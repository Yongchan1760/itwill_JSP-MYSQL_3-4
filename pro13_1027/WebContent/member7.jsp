<%@page import="java.util.List"%>
<%@page import="sec01.ex01.MemberDAO"%>
<%@page import="sec01.ex01.MemberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		//request객체 영역에 인코딩 방식 UTF-8로 설정
		request.setCharacterEncoding("UTF-8");
	%>
	  		<!-- 멤버빈클래스로부터 객체를 만든다 -->
		<jsp:useBean id="m" class="sec01.ex01.MemberBean" scope="page"> 
			
		</jsp:useBean>
		
		
	<!--회원가입창 memform.html에서 입력받은 정보들을  
	모두 request영역에서 꺼내와서memberbean객체의 각 변수에 저장 할때
	<input> 태그의 name속성값과 memberbean클래스의 각변수명이 모두 동일하면..
	모든 setter메소드가 호출되어 자동으로 memberbean객체의 각변수에 저장된다.  
	
	* 모든이라는 뜻-->
		<!--set 메소드 호출시 매개변수로 value속성값을 전달하여 인스턴스 변수에 저장  -->
		<jsp:setProperty name="m" property="*"/>
		<!-- 모든 set메소드를 호출하여 값을 넣자 -->
		
	
		
	<% 
		//입력한 회원데이터들을 memberbean객체의 각 객체 변수에 저장하기 위해
		//set으로 시작되는 메소드들을 호출하자
		//생성한 참조변수 m으로 class="sec01.ex01.MemberBean"가 생성한 객체에 접근할수있다.
		
		
		//입력한 회원데이터들을 DB에 전송하여 INSERT작업하기 위해 MembmerDAO객체 생성시 
		//기본생성자를 호출해 커넥션풀 얻기
		MemberDAO memberDAO = new MemberDAO();
		
		//입력한 회원데이터들을 DB의 t_member테이블에 INSERT하기 위해 addMember메소드 호출시
		//MemberBean객체를 매개변수로 전달 하여 작업 합니다.
		memberDAO.addMember(m); 
		
		//DB의 테이블에 저장되어 있는 전체 회원정보를 조회하기 위해 MemberDAO의  listMembers()메소드 호출!
		//반환값으로 조회한 회원정보들을 받자
		List membersList = memberDAO.listMembers(); 
		
		out.print(membersList.size());
	
	%>

	<table align="center" width="100%">
		<tr align="center" bgcolor="#99ccff">
			<td width="7%">아이디</td>
			<td width="7%">비밀번호</td>
			<td width="5%">이름</td>
			<td width="11%">이메일</td>
		</tr>
	
	<!--jsp:usebean 액션태그로 생성한 memberbean객체의 getter메소드를 호출하여 반환된 변수의 값을 출력  -->
		<tr align="center">
			<!--memberbean객체의 getid()메소드를 호출하여 id변수값을 반환받아 출력 
			반복문 사용불가 :액션태그 -->
			<td> <jsp:getProperty name="m" property="id" /> </td> 
			<td> <jsp:getProperty name="m" property="pwd"/> </td>
			<td> <jsp:getProperty name="m" property="name"/> </td>
			<td> <jsp:getProperty name="m" property="email"/></td>
			<td> </td>
		</tr>
		<tr height="1" bgcolor="#99ccff">
			<td colspan="5"></td>
		</tr>
	</table>



</body>
</html>







