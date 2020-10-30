<%@page import="java.sql.PreparedStatement"%>
<%@page import="javax.sound.midi.SysexMessage"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"">
<title>modifySwon.jsp 직원정보 수정페이지</title>
</head>
<body>
		<%
			//흐름 인덱스,jsp에서 수정태그를 클릭했을때 수정할 직원의 no를 전달 받아 no에 해당되는 
			//직원 한사람의 정보를 검색해서 현재 페이지에 출력하고, 출력한 정보를 보고 사용자가 직원정보를 수정한후 
			//db에 업데이트함
	
			//꺼내올 데이터 값 한글 안꺠지게 캐릭터셋 설정
			request.setCharacterEncoding("utf-8");
			
			String no=request.getParameter("no");
			
			//전달 받은 수정할 직원 번호에 해당하는 레코드 검색하는 select문 준비
			String sql="select * from tblSawon where no=?";
			
			// 디비 작업을 위한 자바.sql패키지에 존재하는 삼총사 객체를 담을 변수 준비 
			Connection con=null;
			PreparedStatement stmt=null;
			ResultSet rs=null;
			
			//연결할 디비주소, 디비 접속id,비밀번호 변수에 저장
			String url="jdbc:mysql://localhost:3306/jspbeginner?serverTimezone=Asia/Seoul";
	 		String id="jspid", pw="jsppass";

	 		//select 작업후 수정할 직원 정보를 저장할 변수들 선언
	 		
	 		String s_id=null, s_name=null, s_pw=null, s_age=null, s_addr=null;
	 		String s_extension=null, s_dept=null;
	 		
	 		
	 		
	 		
	 		try{	
	 		//디비연동후 select작업
	 		//1단계 mysql dbms에서 제공해주는  드라이버 객체를 동적으로 생성해서 드라이버 매니저 크래스에 저장 등록 
	 		Class.forName("com.mysql.jdbc.Driver");
	 		
	 		//디비를 연동시킴     //드라이버 매니저 클래스를 이용해 db와 연결을 맺은 connection객체를 생성
	 		con=DriverManager.getConnection(url, id, pw);
	 		
	 		
	 		
	 		//디비랑 연동을 시킨후에 stmt객체를 반환받는다       //
	 		stmt=con.prepareStatement(sql);
	 		stmt.setInt(1,Integer.parseInt(no));
	 		//stmt객체에 디비를 담아 실행 시킨후 rs저장소에 임시로 저장시킨다.
	 		
	 		rs=stmt.executeQuery();
	 		
	 		//rs객체에 저장된 회원한명의 정보를 꺼내와서 각변수에 저장하고 
	 		
	 	
	 			if(rs.next()){
		 			s_id=rs.getString("id");
			 		s_name=rs.getString("name");
			 		s_pw=rs.getString("pass");
			 		s_age=String.valueOf(rs.getString("age"));
			 		s_extension=rs.getString("extension");
			 		s_dept=rs.getString("dept");
		 			s_addr=rs.getString("addr");
	 			}
	 		}catch(Exception exception){
	 			System.out.println("modifysawon.jsp에서 예외 발생"+exception);
	 		}finally{
	 			if(con!=null){
	 				con.close();
	 			}
	 			if(rs!=null){
	 				rs.close();
	 			}
	 			if(stmt!=null){
	 				stmt.close();
	 			}
	 		}
	 		
		
		%>
		
		<%-- 수정누르기전에 먼저 검색한 직원 한명의 정보를 나타내자
			나타낸 정보를 다시 수정하기 위해 입력후 modifysawon_pro.jsp로 수정요청합니다.
		 --%>
		
<form action="modifySawon_pro.jsp" method="post">

	<!--수정할 직원 번호는 input태그는 노출하지않고 수정할 직원 번호만 request에 담아 전송   -->
	<input type="hidden" name="no" value="<%=no%>"/>	
		<div align="center"> 
			<h1>회원정보 수정</h1>
				<table>
					<tr>
						<th>아이디</th>
						<td><input type="text" name="s_id" value="<%=s_id%>"></td>
					</tr>
					<tr>
						<th>이름</th>
						<td><input type="text" name="s_name" value="<%=s_name%>"></td>
					</tr>
					<tr>
						<th>비밀번호</th>
						<td><input type="text" name="s_pw" value="<%=s_pw%>"></td>
					</tr>
					<tr>
						<th>나이</th>
						<td><input type="text" name="s_age" value="<%=s_age%>"></td>
					</tr>
					<tr>
						<th>근무지</th>
						<td>
							<select name="s_addr">
								<option value="서울" <%if(s_addr.equals("서울")){%> selected="selected" <%} %>>서울</option>
								<option value="인천" <%if(s_addr.equals("인천")){%> selected="selected" <%} %>>인천</option>
								<option value="경기" <%if(s_addr.equals("경기")){%> selected="selected" <%} %>>경기</option>
								<option value="수원" <%if(s_addr.equals("수원")){%> selected="selected" <%} %>>수원</option>
							</select>
						</td>
					</tr>
					<tr> 
						<th>내선번호</th>
						<td><input type="text" name="s_extension" value="<%=s_extension%>"></td>
					</tr>
					<th>부서명</th>
						<td>
							<select name="s_dept">
								<option value="영업" <%if(s_dept.equals("영업")){%> selected="selected" <%} %>>영업</option>
								<option value="기술" <%if(s_dept.equals("기술")){%> selected="selected" <%} %>>기술</option>
								<option value="기획" <%if(s_dept.equals("기획")){%> selected="selected" <%} %>>기획</option>
							</select>
						</td>
					</tr>
					<tr>
						<td colspan="2">
							<input type="submit" value="수정">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<input type="reset" value="수정할 정보 다시 입력">
						</td>
					</tr>
				</table>
		</div>
</form>
		
			
		
		
</body>
</html>