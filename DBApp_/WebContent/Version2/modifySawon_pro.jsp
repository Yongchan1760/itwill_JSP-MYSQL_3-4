<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>

<%
	//1. 수정하기 위해 입력한 정보들은 request 객체 메모리에 저장되었기 떄문에..
	//request객체 메모리 영역에서 꺼내오기전에.. 한글이 꺠지는 것을 방지하기 위해
	//인코딩 방식은 utf-8로 설정
	//(한글처리)
	request.setCharacterEncoding("utf-8");

	String no=request.getParameter("no");
	
	//수정을 위해 입력한 정보들 얻기
	//얻는 이유 update문장을 완성하기 위해!
	
	String s_id= request.getParameter("s_id");
	String s_name= request.getParameter("s_name");
	String s_pw= request.getParameter("s_pw");
	String s_age= request.getParameter("s_age");
	String s_addr= request.getParameter("s_addr");
	String s_extension= request.getParameter("s_extension");
	String s_dept= request.getParameter("s_dept");
	
	
    //수정한 값들을 얻어와서 수정을 눌렀을떄 그값을 가져와서 그갑들을 디비에 저장시켜 업데이트 해야한다
    
    //히든 태그로 전달 받은 수정할 직원 번호에 해당되는 레코드의? 회원정보를 위 수정을 위해 입력한 정보들로 수정하는 sql문 만들기
    String sql= "update tblSawon set id=?,name=?,pass=?,age=?,addr=?,extension=?,dept=? where no=?";
    
  	//디비작업을 하기위해 update java.sql 패키지에 존재하는 객체를 담을 변수선언
  	Connection con=null;

  	PreparedStatement stmt=null;
  	//5. db와 연결할 정보들 db주소,접속 id,접속 pw
  	String url="jdbc:mysql://localhost:3306/jspbeginner?serverTimezone=Asia/Seoul";
	String id="jspid", pw="jsppass";
	
	//6.db와 연결하여 update쿼리 문을 시작합니다
	
	try{
		//드라이버 로딩
		Class.forName("com.mysql.jdbc.Driver");
		//디비 연결시도
		con=DriverManager.getConnection(url, id, pw);
		// db전송하여 stmt객체 얻기
		
		//
		
		
			stmt=con.prepareStatement(sql);
		
			stmt.setString(1, s_id);
			stmt.setString(2, s_name);
			stmt.setString(3, s_pw);
			stmt.setInt(4, Integer.parseInt(s_age));
			stmt.setString(5, s_addr);
			stmt.setString(6, s_extension);
			stmt.setString(7, s_dept);
			stmt.setInt(8, Integer.parseInt(no));
		//업데이트 실행
		stmt.executeUpdate();
%>
		<script type="text/javascript"> 
			window.alert("수정성공");
			//자바스크립트의 재요청 포워딩 기술
			//index.jsp로 이동
			location.href="index.jsp";
			
			
		</script>
		
<%
	}catch(Exception exception){
		System.out.println("modifysawon.pro.jsp에서 예외발생"+ exception);
	}finally{
		//자원해제
		if(stmt!=null){
			stmt.close();
		}
		if(con!=null){
			con.close();
		}

		
	}

    
    
%>