<%@page import="java.sql.DriverManager"%>
<%@page import="javax.sound.midi.SysexMessage"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"">
<title>Insert title here</title>
</head>
<body>
	<%--순서1. addsawon.jsp form태그 내부에서 입력하여 요청한 가입할 회원내용을 얻기 --%>
	<%
		request.setCharacterEncoding("utf-8");
		//꺼내올값 인코딩
		
		String s_id=request.getParameter("s_id");
		String s_name=request.getParameter("s_name");
		String s_pw=request.getParameter("s_pw");
		String s_age=request.getParameter("s_age");
		String s_addr=request.getParameter("s_addr");
		String s_extension=request.getParameter("s_extension");
		String s_dept=request.getParameter("s_dept");
		//요청한값얻기
	
		//위 요청한 값들을 이용해 insert문 만들기  참고: 변수명을 +해서 전체 insert문장 만듬
		String sql="insert into tblSawon(id,name,pass,age,addr,extension,dept)"+
		"values('"+s_id+"','"+s_name+"','"+s_pw+"','"+s_age+"','"+s_addr+"','"+s_extension+"','"+s_dept+"')";
		
		//순서3 db연결후 insert문장 실행 하는 작업 
		// db작업을 위한 java.sql 패키지에있는 객체를 저장할 변수 2개 선언
			
		// db연결을 맺은 접속정보를 가지고있객체를 담을 변수
			Connection con=null;
		 //db연결후 sql문 insert문을 db에 전송하여 실행할 역할을 하는 변수 선언
			Statement stmt=null;
		 
			String url="jdbc:mysql://localhost:3306/jspbeginner?serverTimezone=Asia/Seoul";
	 		String id="jspid", pw="jsppass";
	 		
		 try{
			//1단계 mysql전용 driber로딩
				Class.forName("com.mysql.jdbc.Driver");
			//2단계 db연결 시도
			con=DriverManager.getConnection(url, id, pw);
			//3단계 statement 객체 얻기
			stmt=con.createStatement();
			//4단계 statement객체를 이용해 insert문장 db에 전송하여 실행 !!
			stmt.executeUpdate(sql);
			
			%>
				<h2>직원정보가 잘 추가 되었습니다.</h2>
				<a href="addSawon.jsp">새로운 직원 추가 화면으로 ...</a>
				<a href="index.jsp">메인화면 index.jsp ...</a>
			<%
		 }catch(Exception exception){
			 System.out.print("addsawon.pro.jsp에서 db관련 작업 오류"+exception);
		 }finally{
			  //자원해제
				
		 			if(stmt!=null){
		 				//statement객체가 아직 사용하고있으면 자원해제
		 				stmt.close();
		 			}
		 			if(con!=null){
		 				//connection 객체가 아직 사용하고있으면 자원해제
		 				con.close();
		 					}
		 }
			 
		 
	%>
</body>
</html>