package sec01.ex01;

import java.sql.Date;

//�ڹٺ��� ������ VOŬ���� 

//����1. �Է��� ȸ�������� Ŭ���������� �����ؼ� ��ü ������ DB�� �Ѳ����� ������ �ϱ� ���� �����ִ� Ŭ���� 
//����2. DB�κ��� ��ȸ�� �ѻ���� ȸ��������  Ŭ���������� �����ϰ� �����ִ� Ŭ���� 

// t_member���̺��� ������  MemberBeanŬ������ �ۼ� �մϴ�.
// MemberBeanŬ������ �Ӽ��� t_memberȸ�����̺��� �� �÷��̸��� �״�� ����ϸ�
// �ڷ����� �÷� �̸��� �ڷ����� �����ϰ� �����մϴ�.
public class MemberBean {
	/* t_memberȸ�����̺��� �÷� �̸��� �����ϰ� �����̸��� �ڷ����� �����մϴ�. */
	private String id;
	private String pwd;
	private String name;
	private String email;
	private Date joinDate;
	
	/*�ƹ��ϵ� ���� �ʴ� �⺻������*/
	public MemberBean(){}
	
	/*���ڰ� 4�� ������*/
	public MemberBean(String id, String pwd, String name, String email){
		this.id = id;
		this.pwd = pwd;
		this.name  = name;
		this.email = email;
	}
	
	/*getter / setter�޼ҵ�� */
	//alt + shift + s   r
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPwd() {
		return pwd;
	}

	public void setPwd(String pwd) {
		this.pwd = pwd;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public Date getJoinDate() {
		return joinDate;
	}

	public void setJoinDate(Date joinDate) {
		this.joinDate = joinDate;
	}

	
	
}





