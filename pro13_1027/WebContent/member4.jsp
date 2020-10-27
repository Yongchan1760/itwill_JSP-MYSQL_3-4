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
		
		<%-- <jsp:useBean id="생성할객체의 주소를 담을 참조 변수이름" class="생성할 객체의 클래스 경로 "> 
			객체생성: usebean scope="현재 생성한 객체의 접근 법위 "
							request
							page
							session,application 지정하지않으면 기본은 page
							new memberbean() 기본 메서드 생성 
		</jsp:useBean> --%>
		
		
		
	<%--
		회원가입창 에서 전달된 input태그의 name속성값과 jsp:setproperty액션 태그의 param속성의 값이 같으면??
		meberbean객체의 각변수에 입력한 정보들을 request영역에서 꺼내와 자동으로 각각 저장하게 됨
		단! 조건 memeberbean클래스의 각변수 이름과 param 속성의 값 이름이 동일 해야한다는 조건이 있다.
		
		member4.jsp
		memberform.html
		멤버빈클래스의 
		
		memberform.html의 id값을 ->member4.jsp ->멤버빈클래스의 
		id가 동일해야한다.
		
		입력한 정보를 멤버4.ㅓjsp로 보내어서 멤버빈클래스로 저장하자. 파람 동적으로 입력
	--%>
	
		<!--set 메소드 호출시 매개변수로 value속성값을 전달하여 인스턴스 변수에 저장  -->
		<jsp:setProperty name="m" property="id" param="id"/>
		<!--setname (String name)메소드 호출시.. 매개변수로 value속성값을 전달하여 name객체변수에 저장  -->
		<jsp:setProperty name="m" property="name" param="name"/>
		<!--매개변수로 전달할 값은 value  set id 메소드 호출시 value값을 id매개변수로 전달하여 저장하자.
		아래것을 호출-->
		<jsp:setProperty name="m" property="pwd" param="pwd"/>
		<jsp:setProperty property="email" name="m" param="email"/>
		
		<!--멤버빈객체를 생성해서 set메소드를 호출해서 각각의 값을 저장하자.  -->
		
		<!--자바코드를 줄이고 액션태그를 사용하면 소스 길이를 줄일수있어서 좋다.  -->
		<%-- set name을 호출하여 value값을 매개변수에 전달하여 저장하자.
		  		 id를 
		  		 pwd를
		  		 email를
		  		 
		 public void setId(String id) {
		this.id = id;
		} 
		
		
		 <jsp:setProperty name="생성한 객체의 id값 넣어주기 "/> 
		 memberform.html 회원가입창에서 전송된 요청값들을 request영역에서 언더
		memberbean객체의 setter메소들을 호출시 매개변수로 전달하여 각변수에 젖아 --%>
		
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
			<td width="5%">가입일</td>
		</tr>
	<%
	//DB에 조회한 회원정보가 없으면?
	if(membersList.size() == 0){
	%>
		<tr>
			<td colspan="5">
				<b>등록된 회원이 없습니다.</b>
			</td>
		</tr>
	<%
	}else{//DB에서 조회한 회원이 있으면?
		//for반복문을 이용해 ArrayList배열에 저장된 MemberBean객체를 하나씩 가져온후..
		//MemberBean객체의 각변수에 저장된  조회한 회원정보들을 getter메소드를 호출해서 얻은후 출력!
		for(int i=0;  i<membersList.size(); i++){
			
			MemberBean bean = (MemberBean)membersList.get(i);
	%>	
		<tr align="center">
			<td><%=bean.getId() %></td>
			<td><%=bean.getPwd() %></td>
			<td><%=bean.getName() %></td>
			<td><%=bean.getEmail() %></td>
			<td><%=bean.getJoinDate() %></td>
		</tr>	
		
	<%		
		}//for끝
	}//else끝
	%>
		<tr height="1" bgcolor="#99ccff">
			<td colspan="5"></td>
		</tr>
	</table>



</body>
</html>







