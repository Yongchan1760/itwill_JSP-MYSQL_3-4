<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
    <%--������ �̿���
    name������ ������ �̼��� ���� 
    getname()�޼ҵ� ���� -> name ������ ����Ȱ� ��ȯ 
     --%>
     
     <%!String name="�̼���";
     public String getName(){
    	 return name;
     }
     %>
     
      <%--
   	����1.   
      Ŭ���̾�Ʈ�� �������� �ּ�â�� �ּҸ� �Է��ؼ� hello2.jsp�������� ��û�մϴ�.
      ��û�� �ּ�> httpL localhost:8080/pro12_jsp/hello2.jsp?age=22
     
     ����2. 
     ��û�� ���� hello2.jsp �������������� request��ü �޸𸮿� ����Ǿ��ִ� ��û�� age���� ��´�.
     
   	����3.
     
     
     --%>
     
     <%--��ũ��Ʋ�� ��ȣ ���ο� �ڹ��ڵ� �̿� --%>
     <% String age=request.getParameter("age"); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<%--ǥ������ �̿��� ���۵� ���̸� Ŭ���̾�Ʈ�� ���������� ��� (����)��. --%>
	<h1>�ȳ��ϼ��� <%=getName() %>��!!</h1> 
	<h1>���̴� <%=age%>���Դϴ�.!!</h1>
</body>
</html>