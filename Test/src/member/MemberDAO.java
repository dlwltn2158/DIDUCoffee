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
// DB에 관련한 모든 작업 하는 클래스
public class MemberDAO {

	// jspbeginner데이터베이스와 연결을 맺는 메소드
	private Connection getconnection() throws Exception {
		
		Connection con = null;
		Context init = new InitialContext();
		// 커넥션풀 얻기
		DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/jspbeginner");
		// 커넥션풀로 부터 커넥션객체 (DB와 미리 연결 되어 있는 접속을 알리는 객체) 빌려오기
		con = ds.getConnection();
		
		return con;
		
		
	}
	
	// 로그인 처리시 사용하는 메소드
	// 입력받은 id, pass값과 DB에 저장되어 있는 id,pass값을 확인하여 로그인 처리
	public int userCheck(String id,String passwd){
		int check = -1; // 1 -> 아이디 맞음, 비밀번호 맞음
					    // 0 -> 아이디 맞음, 비밀번호 틀림
						// -1 -> 아이디 틀림
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String sql = "";
		
		
		try {
			
			// 1. DB접속 객체 얻기 (커넥션풀로부터 커넥션 객체 얻기)
			con = getconnection();
			
			// 2. SQL(SELECT)만들기 -> 매개변수로 전달 받는 id에 해당하는 레코드 검색
			sql = "select * from member where id=?";
			
			// 3. SQL실행할 객체 PreparedStatement 얻기
			pstmt = con.prepareStatement(sql);
					
			// 4. ?에 대응되는 값 설정
			pstmt.setString(1, id);
			
			// 5. SELECT구문 실행 후 그 결과를 ResultSet에 저장후 얻기
			rs = pstmt.executeQuery();
			
			if(rs.next()){ // 로그인 하기 위해 입력한 id가 존재하고
				
				// 로그인시 입력한 비밀번호와 DB에 저장되어 있는 검색한 비밀번호가 같으면
				if(passwd.equals(rs.getString("passwd"))){
					
					check = 1; // 아이디 맞음, 비밀번호 맞음 판별값 1저장
				} else{ // 아이디는 동일하나 비밀번호가 다르다면
					
					check = 0;
					
				}
				
			}else { // id가 DB에 존재하지않는다
				
			}
			
		} catch (Exception e) {
			System.out.println("userCheck메소드 내부에서 오류 : "+e);
		}finally {
			
			try {
				// 자원해제
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(con != null) con.close();
				
			} catch (SQLException e) {
				e.printStackTrace();
			}
			
		}
		
		return check; // 1또는 0또는 -1을 리턴 -> loginPro.jsp로 리턴
		
	} // userCheck 메소드 닫는 기호
	
	
	
	
	
	// 회원가입을 위해 사용자가 입력한 id값을 매개변수로 전달 받아
	// DB에 사용자가 입력한 id값이 존재하는지 SELECT검색하여
	// 만약 사용자가 입력한 id에 해당하는 회원 레코드가 검색되면
	// check변수값을 1로 저장하여 <- 아이디 중복됨을 나타내고
	// 만약 사용자가 입력한 id에 해당하는 회원 레코드가 검색이 되지 않으면
	// check변수값을 0으로 저장하여 <- 아이디 중복 아님을 나타내고
	// 결과적으로 아이디 중복이냐, 중복이 아니냐는 check변수에 저장되어 있으므로
	// check변수값을 리턴한다.
	public int idCheck(String id){
		
		int check = 0;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		
		try {
			// 1. DB연결 (커넥션풀로부터 커넥션 얻기)
			con = getconnection();
			
			// 2. SQL문 만들기(SELECT) -> 매개변수로 전달받은 입력한 아이디에 해당하는 레코드 검색
			sql = "select * from member where id=?";
			
			// 3. SQL구문을 실행할 PreparedStatement객체 얻기
			// ?기호에 대응되는 SELECT할 값을 제외한 나머지 전체 insert문장을 PreparedStatement객체에 담아
			// 반환받기
			pstmt = con.prepareStatement(sql);
			
			// 4. ?기호에 대응되는 값 설정
			pstmt.setString(1, id);
			
			// 5. PreparedStatement객체의 executeQuery()메소드를 호출하여
			// 검색! 검색후 그 결과를 ResultSet에 담아 반환
			rs = pstmt.executeQuery();
			
			//6. 우리가 입력한 아이디에 해당하는 레코드가 검색되면(id가 존재하면, id가 중복되었다면)
			if(rs.next()){
				check = 1;
			}else { // 입력한 아이디에 해당하는 회원레코드가 검색되지않으면 (id가 중복되지않았다면)
				check = 0;
			}
			
		}catch(Exception e){
			System.out.println("idCheck()메소드에서 오류 : "+ e);
		} finally {
			try {
				// 자원해제
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(con != null) con.close();
				
			} catch (SQLException e) {
				e.printStackTrace();
			}
		} // finally
		// 7. check변수값 리턴
		return check; // 1또는 0을 리턴
		
	} // idCheck()메소드 닫는 부분
	
	
	
	// joinPro.jsp에서 매개변수로 전달 받은 MemberBean을 DB에 추가
	public void insertmember(MemberBean memberBean){
		
		Connection con = null;
		PreparedStatement pstmt = null;
		// insert구문을 만들어 저장할 변수
		String sql="";
		
		try{
			// 1. DB연결 (커넥션풀로부터 커넥션 얻기)
			con = getconnection();
			
			// 2. SQL구문 만들기 (INSERT)
			sql = "insert into member(id,passwd,name,reg_date,email,address1,address2,address3,tel,mtel)"
					+ "values(?,?,?,?,?,?,?,?,?,?)";
			
			// 3. SQL구문을 실행할 PreparedStatement객체 얻기
			// ?기호에 대응되는 insert할 값을 제외한 나머지 전체 insert문장을 PreparedStatement객체에 담아
			// 반환받기
			pstmt = con.prepareStatement(sql);
			
			// 4. ?기호에 대응되는 insert할 값을 설정
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
			
			// 5. PreparedStatement에 설정된 insert전체 문장을 DB에 전송하여 실행
			pstmt.executeUpdate();
			
		}catch (Exception e){
			System.out.println("insertMember메소드 내부에서 오류 : "+ e);
		}finally{
			// 6. 자원해제
			try {
				if(pstmt != null){ // 사용하고 있으면
					pstmt.close();
				}
				if(con != null) { // 사용하고 있으면
					con.close();
				}
			} catch (SQLException e) { // alt+shift+z
				e.printStackTrace();
			}
		} // finally 닫는 부분
		
	} // insertMember메소드 닫는 부분
	
	
	
	//joinPro.jsp에서 매개변수로 전달 받은 MemberBean을 DB에 추가
		public void updatemember(MemberBean memberBean,String id){
			
			Connection con = null;
			PreparedStatement pstmt = null;
			// insert구문을 만들어 저장할 변수
			String sql="";
			ResultSet rs = null;
			
			try{
				// 1. DB연결 (커넥션풀로부터 커넥션 얻기)
				con = getconnection();
			
				sql = "select * from member where id=?";
				
				// 3. SQL구문을 실행할 PreparedStatement객체 얻기
				// ?기호에 대응되는 SELECT할 값을 제외한 나머지 전체 insert문장을 PreparedStatement객체에 담아
				// 반환받기
				pstmt = con.prepareStatement(sql);
				
				// 4. ?기호에 대응되는 값 설정
				pstmt.setString(1, id);
				
				// 5. PreparedStatement객체의 executeQuery()메소드를 호출하여
				// 검색! 검색후 그 결과를 ResultSet에 담아 반환
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
					
					// 2. SQL구문 만들기 (INSERT)
					sql = "update member set passwd=?,name=?,reg_date=?,address1=?,address2=?,address3=?,tel=?,mtel=?"+ 
							" where id=?";
					
				
					// 3. SQL구문을 실행할 PreparedStatement객체 얻기
					// ?기호에 대응되는 update할 값을 제외한 나머지 전체 update문장을 PreparedStatement객체에 담아
					// 반환받기
					pstmt = con.prepareStatement(sql);
					
					// 4. ?기호에 대응되는 insert할 값을 설정
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
					
					// 5. PreparedStatement에 설정된 insert전체 문장을 DB에 전송하여 실행
					pstmt.executeUpdate();
					
				}
			
				
			}catch (Exception e){
				System.out.println("updateMember메소드 내부에서 오류 : "+ e);
			}finally{
				// 6. 자원해제
				try {
					if(rs != null){rs.close();}
					if(pstmt != null){ // 사용하고 있으면
						pstmt.close();
					}
					if(con != null) { // 사용하고 있으면
						con.close();
					}
				} catch (SQLException e) { // alt+shift+z
					e.printStackTrace();
				}
			} // finally 닫는 부분
			
		} // updateMember메소드 닫는 부분
		
		
		//joinPro.jsp에서 매개변수로 전달 받은 MemberBean을 DB에 추가
				public void deletemember(MemberBean memberBean,String id){
					
					Connection con = null;
					PreparedStatement pstmt = null;
					// insert구문을 만들어 저장할 변수
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
						System.out.println("deleteMember메소드 내부에서 오류 : "+ e);
					}finally{
						// 6. 자원해제
						try {
							if(rs != null){rs.close();}
							if(pstmt != null){ // 사용하고 있으면
								pstmt.close();
							}
							if(con != null) { // 사용하고 있으면
								con.close();
							}
						} catch (SQLException e) { // alt+shift+z
							e.printStackTrace();
						}
					} // finally 닫는 부분
					
				} // deleteMember메소드 닫는 부분

		
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
								System.out.println("select 오류 : "+e);
							}finally{
								try {
									if(rs != null){rs.close();}
									if(pstmt != null){ // 사용하고 있으면
										pstmt.close();
									}
									if(con != null) { // 사용하고 있으면
										con.close();
									}
								} catch (SQLException e) { // alt+shift+z
									e.printStackTrace();
								}
							}
							return bean;
						}
						
						
				/////////select
		
	
} // MemberDAO클래스 닫는 부분




