
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>


<% 
	request.setCharacterEncoding("utf-8");
	
	String no=request.getParameter("no");
	
	Connection con=null;
	
	PreparedStatement stmt=null;
	
	String sql="delete from tblSawon where no= ?";
			
	String url="jdbc:mysql://localhost:3306/jspbeginner?serverTimezone=Asia/Seoul";
	String id="jspid", pw="jsppass";
	
	try{
			
			Class.forName("com.mysql.jdbc.Driver");
			con=DriverManager.getConnection(url, id, pw);
			
			stmt=con.prepareStatement(sql);
			stmt.setInt(1, Integer.parseInt(no));
			stmt.executeUpdate();
			//삭제성공 메세지 출력
		%>
			<script type="text/javascript"> 
				window.alert("삭제완")
				location.href="index.jsp";
			
			</script>
		<%
		
	}catch(Exception exception){
		System.out.print("delsawon 예외 발생" +exception);
	}finally{
		if(con!=null){
			con.close();
		}
		if(stmt!=null){
			stmt.close();
		}
	}
	
			

%>



