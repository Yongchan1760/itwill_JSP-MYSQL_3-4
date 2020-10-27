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
		
		//memberForm.html에서 입력한 가입할 회원 데이터들을 request내장객체 영역에서 꺼내오기 
		/* String id = request.getParameter("id");
		String pwd = request.getParameter("pwd");
		String name = request.getParameter("name");
		String email = request.getParameter("email"); */
	%>
	
	<%-- 
			usebean 액션태그를 이용해 id속성값이 m인 memberbean클래스를 이용해 객체를 생성 
			생성된 memberbean객체를 참조할 범위 ! scope속성 값을 page로 지정하면..
			현재 meber2.jsp페이지 내에서만 memberbean객체를 공유해서 사용할수있다.
			참고 : scope 생략하면 기본값은 page이다.
	--%>
	
	
		<jsp:useBean id="m" class="sec01.ex01.MemberBean" scope="page"> 
			
		</jsp:useBean>
		
		<%-- <jsp:useBean id="생성할객체의 주소를 담을 참조 변수이름" class="생성할 객체의 클래스 경로 "> 
			객체생성: usebean scope="현재 생성한 객체의 접근 법위 "
							request
							page
							session,application 지정하지않으면 기본은 page
							new memberbean() 기본 메서드 생성 
		</jsp:useBean> --%>
		<!--set 메소드 호출시 매개변수로 value속성값을 전달하여 인스턴스 변수에 저장  -->
		<jsp:setProperty name="m" property="id" value='<%=request.getParameter("id") %>'/>
		<!--setname (String name)메소드 호출시.. 매개변수로 value속성값을 전달하여 name객체변수에 저장  -->
		<jsp:setProperty name="m" property="name" value='<%=request.getParameter("name") %>'/>
		<!--매개변수로 전달할 값은 value  set id 메소드 호출시 value값을 id매개변수로 전달하여 저장하자.
		아래것을 호출-->
		<jsp:setProperty name="m" property="pwd" value='<%=request.getParameter("pwd") %>'/>
		<%-- <jsp:setProperty name="m" property="setpwd(String pwd)" "/> --%>
		<jsp:setProperty property="email" name="m" value='<%=request.getParameter("email") %>'/>
		
		
		
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
		
		
		
		/* 
		 위에 setproperty 액션태그 사용을 위한 주석처리
		 
		m.setId(id);
		m.setPwd(pwd);
		m.setName(name);
		m.setEmail(email); */
		
		
		//입력한 회원데이터들을 MemberBean객체 생성시 생성자를 호출해 각 인스턴스변수에 저장
		//MemberBean m = new MemberBean(id,pwd,name,email);
		
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







