package member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

// DAO
// DB�� ������ ��� �۾� �ϴ� Ŭ����
public class MemberDAO {

	// jspbeginner�����ͺ��̽��� ������ �δ� �޼ҵ�
	private Connection getconnection() throws Exception {
		
		Connection con = null;
		Context init = new InitialContext();
		// Ŀ�ؼ�Ǯ ���
		DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/jspbeginner");
		// Ŀ�ؼ�Ǯ�� ���� Ŀ�ؼǰ�ü (DB�� �̸� ���� �Ǿ� �ִ� ������ �˸��� ��ü) ��������
		con = ds.getConnection();
		
		return con;
		
		
	}
	
	// �α��� ó���� ����ϴ� �޼ҵ�
	// �Է¹��� id, pass���� DB�� ����Ǿ� �ִ� id,pass���� Ȯ���Ͽ� �α��� ó��
	public int userCheck(String id,String passwd){
		int check = -1; // 1 -> ���̵� ����, ��й�ȣ ����
					    // 0 -> ���̵� ����, ��й�ȣ Ʋ��
						// -1 -> ���̵� Ʋ��
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String sql = "";
		
		
		try {
			
			// 1. DB���� ��ü ��� (Ŀ�ؼ�Ǯ�κ��� Ŀ�ؼ� ��ü ���)
			con = getconnection();
			
			// 2. SQL(SELECT)����� -> �Ű������� ���� �޴� id�� �ش��ϴ� ���ڵ� �˻�
			sql = "select * from member where id=?";
			
			// 3. SQL������ ��ü PreparedStatement ���
			pstmt = con.prepareStatement(sql);
					
			// 4. ?�� �����Ǵ� �� ����
			pstmt.setString(1, id);
			
			// 5. SELECT���� ���� �� �� ����� ResultSet�� ������ ���
			rs = pstmt.executeQuery();
			
			if(rs.next()){ // �α��� �ϱ� ���� �Է��� id�� �����ϰ�
				
				// �α��ν� �Է��� ��й�ȣ�� DB�� ����Ǿ� �ִ� �˻��� ��й�ȣ�� ������
				if(passwd.equals(rs.getString("passwd"))){
					
					check = 1; // ���̵� ����, ��й�ȣ ���� �Ǻ��� 1����
				} else{ // ���̵�� �����ϳ� ��й�ȣ�� �ٸ��ٸ�
					
					check = 0;
					
				}
				
			}else { // id�� DB�� ���������ʴ´�
				
			}
			
		} catch (Exception e) {
			System.out.println("userCheck�޼ҵ� ���ο��� ���� : "+e);
		}finally {
			
			try {
				// �ڿ�����
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(con != null) con.close();
				
			} catch (SQLException e) {
				e.printStackTrace();
			}
			
		}
		
		return check; // 1�Ǵ� 0�Ǵ� -1�� ���� -> loginPro.jsp�� ����
		
	} // userCheck �޼ҵ� �ݴ� ��ȣ
	
	
	
	
	
	// ȸ�������� ���� ����ڰ� �Է��� id���� �Ű������� ���� �޾�
	// DB�� ����ڰ� �Է��� id���� �����ϴ��� SELECT�˻��Ͽ�
	// ���� ����ڰ� �Է��� id�� �ش��ϴ� ȸ�� ���ڵ尡 �˻��Ǹ�
	// check�������� 1�� �����Ͽ� <- ���̵� �ߺ����� ��Ÿ����
	// ���� ����ڰ� �Է��� id�� �ش��ϴ� ȸ�� ���ڵ尡 �˻��� ���� ������
	// check�������� 0���� �����Ͽ� <- ���̵� �ߺ� �ƴ��� ��Ÿ����
	// ��������� ���̵� �ߺ��̳�, �ߺ��� �ƴϳĴ� check������ ����Ǿ� �����Ƿ�
	// check�������� �����Ѵ�.
	public int idCheck(String id){
		
		int check = 0;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		
		try {
			// 1. DB���� (Ŀ�ؼ�Ǯ�κ��� Ŀ�ؼ� ���)
			con = getconnection();
			
			// 2. SQL�� �����(SELECT) -> �Ű������� ���޹��� �Է��� ���̵� �ش��ϴ� ���ڵ� �˻�
			sql = "select * from member where id=?";
			
			// 3. SQL������ ������ PreparedStatement��ü ���
			// ?��ȣ�� �����Ǵ� SELECT�� ���� ������ ������ ��ü insert������ PreparedStatement��ü�� ���
			// ��ȯ�ޱ�
			pstmt = con.prepareStatement(sql);
			
			// 4. ?��ȣ�� �����Ǵ� �� ����
			pstmt.setString(1, id);
			
			// 5. PreparedStatement��ü�� executeQuery()�޼ҵ带 ȣ���Ͽ�
			// �˻�! �˻��� �� ����� ResultSet�� ��� ��ȯ
			rs = pstmt.executeQuery();
			
			//6. �츮�� �Է��� ���̵� �ش��ϴ� ���ڵ尡 �˻��Ǹ�(id�� �����ϸ�, id�� �ߺ��Ǿ��ٸ�)
			if(rs.next()){
				check = 1;
			}else { // �Է��� ���̵� �ش��ϴ� ȸ�����ڵ尡 �˻����������� (id�� �ߺ������ʾҴٸ�)
				check = 0;
			}
			
		}catch(Exception e){
			System.out.println("idCheck()�޼ҵ忡�� ���� : "+ e);
		} finally {
			try {
				// �ڿ�����
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(con != null) con.close();
				
			} catch (SQLException e) {
				e.printStackTrace();
			}
		} // finally
		// 7. check������ ����
		return check; // 1�Ǵ� 0�� ����
		
	} // idCheck()�޼ҵ� �ݴ� �κ�
	
	
	
	// joinPro.jsp���� �Ű������� ���� ���� MemberBean�� DB�� �߰�
	public void insertmember(MemberBean memberBean){
		
		Connection con = null;
		PreparedStatement pstmt = null;
		// insert������ ����� ������ ����
		String sql="";
		
		try{
			// 1. DB���� (Ŀ�ؼ�Ǯ�κ��� Ŀ�ؼ� ���)
			con = getconnection();
			
			// 2. SQL���� ����� (INSERT)
			sql = "insert into member(id,passwd,name,reg_date,email,address1,address2,address3,tel,mtel)"
					+ "values(?,?,?,?,?,?,?,?,?,?)";
			
			// 3. SQL������ ������ PreparedStatement��ü ���
			// ?��ȣ�� �����Ǵ� insert�� ���� ������ ������ ��ü insert������ PreparedStatement��ü�� ���
			// ��ȯ�ޱ�
			pstmt = con.prepareStatement(sql);
			
			// 4. ?��ȣ�� �����Ǵ� insert�� ���� ����
			pstmt.setString(1, memberBean.getId());
			pstmt.setString(2, memberBean.getPasswd());
			pstmt.setString(3, memberBean.getName());
			pstmt.setTimestamp(4, memberBean.getReg_date());
			pstmt.setString(5, memberBean.getEmail());
			pstmt.setString(6, memberBean.getAddress1());
			pstmt.setString(7, memberBean.getAddress2());
			pstmt.setString(8, memberBean.getAddress3());
			pstmt.setString(9, memberBean.getTel());
			pstmt.setString(10, memberBean.getMtel());
			
			// 5. PreparedStatement�� ������ insert��ü ������ DB�� �����Ͽ� ����
			pstmt.executeUpdate();
			
		}catch (Exception e){
			System.out.println("insertMember�޼ҵ� ���ο��� ���� : "+ e);
		}finally{
			// 6. �ڿ�����
			try {
				if(pstmt != null){ // ����ϰ� ������
					pstmt.close();
				}
				if(con != null) { // ����ϰ� ������
					con.close();
				}
			} catch (SQLException e) { // alt+shift+z
				e.printStackTrace();
			}
		} // finally �ݴ� �κ�
		
	} // insertMember�޼ҵ� �ݴ� �κ�
	
	
	
	//joinPro.jsp���� �Ű������� ���� ���� MemberBean�� DB�� �߰�
		public void updatemember(MemberBean memberBean,String id){
			
			Connection con = null;
			PreparedStatement pstmt = null;
			// insert������ ����� ������ ����
			String sql="";
			ResultSet rs = null;
			
			try{
				// 1. DB���� (Ŀ�ؼ�Ǯ�κ��� Ŀ�ؼ� ���)
				con = getconnection();
			
				sql = "select * from member where id=?";
				
				// 3. SQL������ ������ PreparedStatement��ü ���
				// ?��ȣ�� �����Ǵ� SELECT�� ���� ������ ������ ��ü insert������ PreparedStatement��ü�� ���
				// ��ȯ�ޱ�
				pstmt = con.prepareStatement(sql);
				
				// 4. ?��ȣ�� �����Ǵ� �� ����
				pstmt.setString(1, id);
				
				// 5. PreparedStatement��ü�� executeQuery()�޼ҵ带 ȣ���Ͽ�
				// �˻�! �˻��� �� ����� ResultSet�� ��� ��ȯ
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
					
					// 2. SQL���� ����� (INSERT)
					sql = "update member set passwd=?,name=?,reg_date=?,address1=?,address2=?,address3=?,tel=?,mtel=?"+ 
							" where id=?";
					
				
					// 3. SQL������ ������ PreparedStatement��ü ���
					// ?��ȣ�� �����Ǵ� update�� ���� ������ ������ ��ü update������ PreparedStatement��ü�� ���
					// ��ȯ�ޱ�
					pstmt = con.prepareStatement(sql);
					
					// 4. ?��ȣ�� �����Ǵ� insert�� ���� ����
					pstmt.setString(1, memberBean.getPasswd());
					pstmt.setString(2, memberBean.getName());
					pstmt.setTimestamp(3, memberBean.getReg_date());
				/*	pstmt.setString(4, memberBean.getEmail());*/
					pstmt.setString(4, memberBean.getAddress1());
					pstmt.setString(5, memberBean.getAddress2());
					pstmt.setString(6, memberBean.getAddress3());
					pstmt.setString(7, memberBean.getTel());
					pstmt.setString(8, memberBean.getMtel());
					pstmt.setString(9, id);
					
					// 5. PreparedStatement�� ������ insert��ü ������ DB�� �����Ͽ� ����
					pstmt.executeUpdate();
					
				}
			
				
			}catch (Exception e){
				System.out.println("updateMember�޼ҵ� ���ο��� ���� : "+ e);
			}finally{
				// 6. �ڿ�����
				try {
					if(rs != null){rs.close();}
					if(pstmt != null){ // ����ϰ� ������
						pstmt.close();
					}
					if(con != null) { // ����ϰ� ������
						con.close();
					}
				} catch (SQLException e) { // alt+shift+z
					e.printStackTrace();
				}
			} // finally �ݴ� �κ�
			
		} // updateMember�޼ҵ� �ݴ� �κ�
		
		
		//joinPro.jsp���� �Ű������� ���� ���� MemberBean�� DB�� �߰�
				public void deletemember(MemberBean memberBean,String id){
					
					Connection con = null;
					PreparedStatement pstmt = null;
					// insert������ ����� ������ ����
					String sql="";
					ResultSet rs = null;
					
					try{
						con = getconnection();
					
						sql = "select * from member where id=?";
						
						pstmt = con.prepareStatement(sql);
						
						pstmt.setString(1, id);
						
						rs = pstmt.executeQuery();
						
						if(rs.next()) {
							
							sql = "delete from member where id=?";
							
							pstmt = con.prepareStatement(sql);
							
							pstmt.setString(1, memberBean.getPasswd());
							
							pstmt.executeUpdate();
							
						}
					
						
					}catch (Exception e){
						System.out.println("deleteMember�޼ҵ� ���ο��� ���� : "+ e);
					}finally{
						// 6. �ڿ�����
						try {
							if(rs != null){rs.close();}
							if(pstmt != null){ // ����ϰ� ������
								pstmt.close();
							}
							if(con != null) { // ����ϰ� ������
								con.close();
							}
						} catch (SQLException e) { // alt+shift+z
							e.printStackTrace();
						}
					} // finally �ݴ� �κ�
					
				} // deleteMember�޼ҵ� �ݴ� �κ�

		
		/////////select
				
						public MemberBean selectDB(String id){
							
							MemberBean bean = null;
							Connection con = null;
							PreparedStatement pstmt = null;
							ResultSet rs = null;
							String sql = "";
							
							try{
								con = getconnection();
								sql = "select * from member where id=?";
								pstmt = con.prepareStatement(sql);
								pstmt.setString(1, id);
								rs = pstmt.executeQuery();
								
								if(rs.next()){
									bean = new MemberBean();
									bean.setId(rs.getString("id"));
									bean.setPasswd(rs.getString("passwd"));
									bean.setName(rs.getString("name"));
									bean.setEmail(rs.getString("email"));
									bean.setAddress1(rs.getString("address1"));
									bean.setAddress2(rs.getString("address2"));
									bean.setAddress3(rs.getString("address3"));
									bean.setTel(rs.getString("tel"));
									bean.setMtel(rs.getString("mtel"));
								}
							}catch(Exception e){
								System.out.println("select ���� : "+e);
							}finally{
								try {
									if(rs != null){rs.close();}
									if(pstmt != null){ // ����ϰ� ������
										pstmt.close();
									}
									if(con != null) { // ����ϰ� ������
										con.close();
									}
								} catch (SQLException e) { // alt+shift+z
									e.printStackTrace();
								}
							}
							return bean;
						}
						
						
				/////////select
		
	
} // MemberDAOŬ���� �ݴ� �κ�




