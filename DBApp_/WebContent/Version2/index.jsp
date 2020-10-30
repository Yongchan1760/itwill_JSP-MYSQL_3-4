<%@page import="java.sql.DriverManager"%>
<%@page import="org.eclipse.jdt.internal.compiler.flow.FinallyFlowContext"%>
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
	<script type="text/javascript"> 
		//아래의 코드중 삭제 <a> 태를 클릭했을떄..
		//직원삭제를 정말로 하시겠습니까?? 라고 한번더 물어볼수있는 기능을하는 메소드 (함수)
		function funDel(no){
			
			//메세지 박스창이 나타나면서 메세지와 함께 확인,취소버튼중 확인버튼을 누르면 true
			// 취소 버튼을 누르면 false를 반환한다
			var result=confirm("직원을 정말로 삭제하시겠습니까?");
			
			//확인 버튼을 눌렀을떄  delSawon.jsp서버페이지로 삭제요청을 하여 이동시
			
			//삭제할 직원 no를 전달 !
			
			if(result==true){
				//delSawon.jsp 재요청시 .. 삭제할 직원 no전달
				location.href="delSawon.jsp?no="+no;
			}
		}
	</script>
</head>
<body>
	<%
		//아래의 form태그 내부에서 입력한 요청값 한글처리 
		request.setCharacterEncoding("utf-8");
		
		//입력한 검색기준값, 검색어를 request 메모리에서 꺼내오기 요청한값 얻기
		String search=request.getParameter("search");//선택한 검색기준값 얻기
		String searchText=request.getParameter("searchText");//입력한 검색어 얻기
	%>
	
	 <h2> 직원 정보 리스트</h2>
	 <%-- 직원추가 회원가입 페이지로 이동하는 링크 만들기 --%>
	 <a href="addSawon.jsp">직원추가 (회원가입)</a>
	 
	 <%-- 직원 정보를 검색 하기 위해 검색 기능 : 검색 기준값+검색어--%>
	 <form action="index.jsp" method="POST">
	 	<select name="search">
	 		<option value="id">아이디</option>
	 		<option value="addr">근무지</option>
	 		<option value="dept">부서명</option>
	 	</select>
	 		<input type="text" name="searchText">
	 		<input type="submit" value="검색">
	 </form>
	 
	 <%-- 조회한 직원정보 리스트  --%>
	 <table border="1">
	 	<tr>
	 		<th>아이디</th>
	 		<th>이름</th>
	 		<th>나이</th>
	 		<th>근무지</th>
	 		<th>부서명</th>
	 		<th>내선번호</th>
	 		<th>수정</th>
	 		<th>삭제</th>
	 	</tr>
	 	<%
	 		//db작업을 위한 java.sql 패키지에 있는 삼총사 객첵를 저장시킬 변수 선언 
	 		//1. db연결 정보를 가지고있는 connection객체를 저장할 변수선언
	 		Connection con=null;
	 		//2. db연결후 db에 sql문을 전송하여 실행할 객체를 저장할 변수 선언
	 		Statement stmt=null;
	 		//3. db에 sql문 select문을 전송하여 조회한 회원정보들을 임시로 저장할 담을 객체를 담을 변수선언
	 		ResultSet rs=null;
	 		
	 		//연결할 db ip주소, db접속 id, db접속 pw
	 		String url="jdbc:mysql://localhost:3306/jspbeginner?serverTimezone=Asia/Seoul";
	 		String id="jspid", pw="jsppass";
	 		
	 		//sql문을 저장할 변수
	 		String sql="";
	 		//sql문 작성(select)
	 		//검색어를 입력하고 전송 버튼을 클릭했을시 상황
	 		try{
	 			//검색어를 입력하지 않았다면?
	 			//searchText변수에 값이 비어있으면 true, 저장되어있으면 false를 반환
	 			if(searchText.isEmpty()){
	 				//직원정보를 모두 검색하는 select sql문만들기 
	 				sql="SELECT * FROM TBLSAWON";
	 			}
	 			else{
	 				//검색기준값에 해당하는 검색어단어를 포함하는 모든 직원을 검색하는 구문만들기
	 				sql="select * from tblSawon where "+ search +" like '%"+ searchText + "%'";
	 			}
	 		}catch(Exception exception){//처음에 검색어가 입력되지 않고 index.jsp를 처음 요청했을때 
	 			//모든 회원정보를 조회하는 sql문 만들기 
	 			sql="select * from tblSawon";
	 		}
	 	
	 		//db연동, db의 직원 데이터 조회부분
	 		try{
	 			//1단계 jdbc 드라이버를 drivermannager 클래스에 등록 드라이버 로딩
	 			Class.forName("com.mysql.jdbc.Driver");
	 			//2단계 db연결 시도(index.jsp db연결)
	 			con=DriverManager.getConnection(url, id, pw);//db접속정보를 매개변수로 전달해서 접속을 맺은 컨넥션객체를 가져온다
	 			//3단계 db에 select sql문장을 전송해서 실행!!
	 			stmt=con.createStatement();//반환값으로 스테이트먼트 객체을 받을수있다.
	 			//4단계 위에서 만든 sql select문장을 전송해서 조회한 결과를 resultset객체에 저장하여 얻기
	 			rs=stmt.executeQuery(sql);
	 			//select문장 실행후 조회한 결과데이터들을 resultset객체에서 꺼내와 저장
	 			while(rs.next()){
	 				//조회한 한줄의 직원 정보 얻기
	 				String s_no=String.valueOf(rs.getInt("no"));
	 				String s_id=rs.getString(2);//조회한 회원 id
	 				String s_name=rs.getString("name");
	 				String s_pw=rs.getString("pass");
	 				int s_age=rs.getInt("age");
	 				String s_addr=rs.getString("addr");
	 				String s_dept=rs.getString("dept");//조회한 회원의 부서명
	 				String s_extension=rs.getString("extension");//조회 내선번호
	 		%>
	 			<%--
	 				조회한 한줄의 직원정보를 출력
	 			 --%>
	 			 <tr>
	 			 	<td><%=s_id%></td>
	 			 	<td><%=s_name%></td>
	 			 	<td><%=s_age%></td>
	 			 	<td><%=s_addr%></td>
	 			 	<td><%=s_dept%></td>
	 			 	<td><%=s_extension%></td>
	 			 	<td><a href="modifySwon.jsp?no=<%=s_no%>">수정</a></td>
	 			 	<td><a href="javascript:funDel(<%=s_no%>)">삭제</a></td>
	 			  </tr>
	 		
	 		<% 		
	 			}//while 반복문 끝
	 		}catch(Exception exception){
	 			System.out.print("index.jsp에서 db관련 작업 오류"+exception);
	 		}finally{
	 			//자원해제 
	 			if(rs!=null){
	 				//resultset 객체가 아직 사용하고있으면 자원해제
	 				rs.close();
	 			}
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
	 </table>
</body>
</html>