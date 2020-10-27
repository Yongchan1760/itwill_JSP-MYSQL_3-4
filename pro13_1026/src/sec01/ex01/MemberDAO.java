package sec01.ex01;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import jdk.nashorn.internal.ir.WhileNode;

//�ڹٺ� Ŭ���� ������ DAOŬ����
//- DB���� �۾� �ϴ� Ŭ���� 

//����Ŭ DBMS�� �����ͺ��̽��� �����Ͽ� �۾��� Ŭ���� 
public class MemberDAO {
	
	//�����ͺ��̽� ���� �۾��� �ʿ��� ��ü���� ������ ���� ����
	private Connection con;
	private PreparedStatement pstmt; 
	private DataSource dataFactory;//Ŀ�ؼ�Ǯ 
	
	//�⺻������ : Ŀ�ؼ�Ǯ(DataSource)��ü�� ��� ������
	public MemberDAO() {
		try{
			//��Ĺ�� ����Ǹ� context.xml�� <Resource>������ �о�ͼ� ��Ĺ �޸𸮿� ������Ʈ����
			//Context��ü���� ������ �����ϴ�.
			//�̶� InitialContext��ü�� �ϴ� ������ ��Ĺ ����� context.xml�� ���ؼ� ������
			//Context��ü�鿡 ������ �ϴ� ������ �մϴ�.
			Context ctx = new InitialContext();
			
			//JNDI������� �����ϱ� ���� �⺻���(java:/comp/env)�� �����մϴ�.
			//lookup("java:/comp/env")�� ���� ȯ�漳���� ���õ� ���ؽ�Ʈ ��ü�� �����ϱ� ���� �⺻�ּ��Դϴ�.
			Context envContext = (Context)ctx.lookup("java:/comp/env");
			
			//�׷��� ��Ĺ context.xml�� ������ <Resource name="jdbc/oracle"..>�±���
			//name�� "jdbc/oracle"�� �̿��� ��Ĺ�� �̸� DB�� ���� �� ����
			//DataSource��ü(Ŀ�ؼ� Ǯ������ �ϴ� ��ü)�� �޾ƿɴϴ�.
			dataFactory = (DataSource)envContext.lookup("jdbc/oracle");
			
			
		}catch(Exception e){
			System.out.println("Ŀ�ؼ�Ǯ ��� ����! : " + e.toString());
		}
	}
	
	//DB�� ȸ�������� �߰��� �޼ҵ�
	//member.jsp���������� ȣ���ϴ� �޼ҵ��  �Ű������� ���� �Ǿ� ���� MemberBean��ü�� ����������?
	//�Է��� ȸ���������� ����Ǿ� �ִ�.
	public void addMember(MemberBean memberBean){
		
		try{
			//DataSource(Ŀ�ؼ�Ǯ)���ο� �ִ� DB�� �̸������� ���� Connectinon��ü ������ ��������
			con = dataFactory.getConnection();
			
			//�Է��� ȸ���������� �Ű������� ���� ���� MemberBean��ü�� �������� ����� ���� ��� ����
			String id = memberBean.getId();
			String pwd = memberBean.getPwd();
			String name = memberBean.getName();
			String email = memberBean.getEmail();		
			//insert���� ����� (PreparedStatement���)
			String query = "insert into t_member(id,pwd,name,email)values(?,?,?,?)";		
			
			//?�� ������ insert������ �ӽ÷�  OraclePreparedStatementWrapper���ఴü�� ���..
			//OraclePreparedStatmentWrapper <---insert������ DB�� �����Ͽ� ������ ������ �ϴ� ��ü ���
			pstmt = con.prepareStatement(query);
			
			//OraclePreparedStatementWrapper���ఴü��  ? �� 4�� ����
			pstmt.setString(1, id);
			pstmt.setString(2, pwd);
			pstmt.setString(3, name);
			pstmt.setString(4, email);
			
			//OraclePreparedStatementWrapper���ఴü�� �̿��Ͽ� DB�� insert������ ������ ����!
			pstmt.executeUpdate();
			
		}catch(Exception e){
			
			System.out.println("addMember�޼ҵ� ���ο��� ���� : " + e.toString());
			
		}finally{
			try {
				//�ڿ�����
				if(pstmt != null) pstmt.close();
				if(con != null) con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			
		}//finally��
		
	}//addMember�޼ҵ� ��
	
	
	//DB�� ��� ȸ�������� ��ȸ(�˻�) �ϴ� �޼ҵ�
	public List listMembers(){
		
		//DB�� ��� ȸ���������� ��ȸ(�˻�) �Ͽ� �����ų �������� �迭 ArrayList���� ����
		List list = new ArrayList();
				
		try{
			//Ŀ�ؼ�Ǯ(DataSource)�� ���� Connection��ü ���
			con = dataFactory.getConnection();
			
			//SELECT���� ����� : ȸ�������� �ֱ� �����ϼ����� �������������Ͽ� ��� ȸ�� ��ȸ 
			String query = "select * from t_member order by joinDate desc";
					
			//OraclePreparedStatementWrapper���ఴü ���
			pstmt = con.prepareStatement(query);
			
			//? ��ȣ�� �����Ǵ� �� ����
					
			//��ȸ�� ��� ȸ���������� OracleResultSetImpl��ü�� ��� �̰�ü ��ü�� ��ȯ�ޱ�
			ResultSet rs = pstmt.executeQuery();
			
			//���̺� ������ ������ ������ �ִ� OracleResultSetImpl��ü�� ��ȸ�� ȸ�����ڵ尡 �����ϴ� ���� �ݺ�
			while(rs.next()){
				//����Ŭ DB�� t_member���̺��� �˻��� ���ڵ��� ���÷�����(���ٴ����� �˻��� ����)�� 
				//OracleResultSet��ü���� ������ �������� ����
				String id = rs.getString("id"); 
				String pwd = rs.getString("pwd");
				String name = rs.getString("name");
				String email = rs.getString("email");
				Date joinDate = rs.getDate("joinDate");
				
				//�˻��� ȸ�� �Ѹ��� ����(��������)�� MemberBean��ü�� �����Ͽ� ������ ������ ����
				MemberBean vo  = new MemberBean();
				vo.setId(id);
				vo.setPwd(pwd);
				vo.setName(name);
				vo.setEmail(email);
				vo.setJoinDate(joinDate);
				
				//���� MemberBean��ü�� ArrayList�迭�� �߰� 
				list.add(vo);
			}//�ݺ����� ��
	
		}catch(Exception e){
			System.out.println("listMembers�޼ҵ� ���ο��� ���� : " + e);
		}finally{
			
			try {
				if(pstmt != null) pstmt.close();
				if(con != null) con.close(); //Ŀ�ؼ�Ǯ�� �ݳ�
			} catch (SQLException e) {
				e.printStackTrace();
			}
			
		}
		//ArrayList�迭��  member.jsp�� ��ȯ
		return list;
		
	}//listMembers�޼ҵ� ��
		
}//MemberDAOŬ���� ��





