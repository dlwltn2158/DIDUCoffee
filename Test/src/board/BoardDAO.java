package board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;


public class BoardDAO {
		
	Connection con = null;
	PreparedStatement pstmt  = null;
	ResultSet rs = null;		
	String sql = "";	
	
	
	private Connection getConnection() throws Exception {
		
		Connection con = null;
		Context init = new InitialContext();
		DataSource ds = 
				(DataSource)init.lookup("java:comp/env/jdbc/jspbeginner");
		con = ds.getConnection();
		
		return con;
	} // getConnection
	
	
	
	public void reInsertBoard(BoardBean bBean){
		
		int num = 0;
		 
		try {
			
			con = getConnection();
			
			sql = "select max(num) from board";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				
				num = rs.getInt(1) + 1;
				
			}else{
				num = 1;
			}
			
			sql = "update board set re_seq=re_seq+1 where re_ref=? and re_seq>?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, bBean.getRe_ref()); // �겫占쏙쭗�몿占쏙옙�벥 域밸챶竊숃린�뜇�깈
			pstmt.setInt(2, bBean.getRe_seq()); // �겫占쏙쭗�몿占쏙옙�벥 疫뀐옙 占쎌뿯占쎌젾 占쎈떄占쎄퐣
			pstmt.executeUpdate();
			
			sql = "insert into board values(?,?,?,?,?,?,?,?,?,?,now(),?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.setString(2, bBean.getName());
			pstmt.setString(3, bBean.getPasswd());
			pstmt.setString(4, bBean.getSubject());
			pstmt.setString(5, bBean.getContent());
			pstmt.setString(6, bBean.getFile());
			pstmt.setInt(7, bBean.getRe_ref()); 
			pstmt.setInt(8, bBean.getRe_lev() + 1); 
			pstmt.setInt(9, bBean.getRe_seq() + 1);
			pstmt.setInt(10, 0); 
			pstmt.setString(11, bBean.getIp()); 
			
			
			pstmt.executeUpdate();
			
			
		} catch (Exception e) {
		System.out.println("reInsertBoard 筌롫뗄�꺖占쎈굡 占쎌궎�몴占�: " + e);
			
		
		}finally{
			
			if(rs!=null)try{rs.close();}catch(Exception err){err.printStackTrace();}
			if(pstmt!=null)try{pstmt.close();}catch(Exception err){err.printStackTrace();}
			if(con!=null)try{con.close();}catch(Exception err){err.printStackTrace();}
			
		}
	
	}
	
	
		public void revreInsertBoard(BoardBean bBean){
			
			int num = 0;
			 
			try {
				
				con = getConnection();
				sql = "select max(num) from revboard";
				pstmt = con.prepareStatement(sql);
				rs = pstmt.executeQuery();
				if(rs.next()){
					num = rs.getInt(1) + 1;
					
				}else{
					num = 1;
				}
				sql = "update revboard set re_seq=re_seq+1 where re_ref=? and re_seq>?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, bBean.getRe_ref()); 
				pstmt.setInt(2, bBean.getRe_seq()); 
				pstmt.executeUpdate();
				
				
				sql = "insert into revboard values(?,?,?,?,?,?,?,?,?,?,now(),?)";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, num);
				pstmt.setString(2, bBean.getName());
				pstmt.setString(3, bBean.getPasswd());
				pstmt.setString(4, bBean.getSubject());
				pstmt.setString(5, bBean.getContent());
				pstmt.setString(6, bBean.getFile());
				pstmt.setInt(7, bBean.getRe_ref()); 
				pstmt.setInt(8, bBean.getRe_lev() + 1);
				pstmt.setInt(9, bBean.getRe_seq() + 1);
				pstmt.setInt(10, 0);
				pstmt.setString(11, bBean.getIp());
				
				
				pstmt.executeUpdate();
				
				
			} catch (Exception e) {
			System.out.println("revreInsertBoard 筌롫뗄�꺖占쎈굡 占쎌궎�몴占�: " + e);
				
			
			}finally{
				if(rs!=null)try{rs.close();}catch(Exception err){err.printStackTrace();}
				if(pstmt!=null)try{pstmt.close();}catch(Exception err){err.printStackTrace();}
				if(con!=null)try{con.close();}catch(Exception err){err.printStackTrace();}
				
			}
		
		}
	
		
	public int updateBoard(BoardBean bBean){
		int check = 0;
		
		try {
			con = getConnection();
			
			sql = "select passwd from board where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, bBean.getNum());
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				if(bBean.getPasswd().equals(rs.getString("passwd"))){
					check = 1;
					sql = "update board set name=?, subject=?, content=? where num=?";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, bBean.getName());
					pstmt.setString(2, bBean.getSubject());
					pstmt.setString(3, bBean.getContent());
					pstmt.setInt(4, bBean.getNum());
					
					
					pstmt.executeUpdate();
					
					
					
					
				}else{
					check = 0;
				}
				
			}
			
		} catch (Exception e) {
		System.out.println("updateBoard筌롫뗄�꺖占쎈굡 占쎌궎�몴占�: "+ e);
			
		}finally{
		
			if(rs!=null)try{rs.close();}catch(Exception err){err.printStackTrace();}
			if(pstmt!=null)try{pstmt.close();}catch(Exception err){err.printStackTrace();}
			if(con!=null)try{con.close();}catch(Exception err){err.printStackTrace();}
			
			
		}
		return check;
		
	}
	
		public int revupdateBoard(BoardBean bBean){
			int check = 0;
			
			try {
				con = getConnection();
				
				sql = "select passwd from revboard where num=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, bBean.getNum());
				rs = pstmt.executeQuery();
				
				if(rs.next()){
					if(bBean.getPasswd().equals(rs.getString("passwd"))){
						check = 1; 
						sql = "update revboard set name=?, subject=?, content=? where num=?";
						pstmt = con.prepareStatement(sql);
						pstmt.setString(1, bBean.getName());
						pstmt.setString(2, bBean.getSubject());
						pstmt.setString(3, bBean.getContent());
						pstmt.setInt(4, bBean.getNum());
						
						
						pstmt.executeUpdate();
						
						
						
						
					}else{
						check = 0;
					}
					
				}
				
			} catch (Exception e) {
			System.out.println("revupdateBoard筌롫뗄�꺖占쎈굡 占쎌궎�몴占�: "+ e);
				
			}finally{
			
				if(rs!=null)try{rs.close();}catch(Exception err){err.printStackTrace();}
				if(pstmt!=null)try{pstmt.close();}catch(Exception err){err.printStackTrace();}
				if(con!=null)try{con.close();}catch(Exception err){err.printStackTrace();}
				
				
			}
			return check;
			
		}
		/////////////////////////////////////////
	
//////////////////////grupdate
public int grupdateBoard(BoardBean bBean){
int check = 0;

try {
	con = getConnection();
	
	sql = "select passwd from gallery where num=?";
	pstmt = con.prepareStatement(sql);
	pstmt.setInt(1, bBean.getNum());
	rs = pstmt.executeQuery();
	
	if(rs.next()){
		if(bBean.getPasswd().equals(rs.getString("passwd"))){
			check = 1; 
			sql = "update gallery set name=?, subject=?, content=? where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bBean.getName());
			pstmt.setString(2, bBean.getSubject());
			pstmt.setString(3, bBean.getContent());
			pstmt.setInt(4, bBean.getNum());
			
			
			pstmt.executeUpdate();
			
			
			
			
		}else{
			check = 0; 
		}
		
	}
	
} catch (Exception e) {
System.out.println("revupdateBoard筌롫뗄�꺖占쎈굡 占쎌궎�몴占�: "+ e);
	
}finally{

	if(rs!=null)try{rs.close();}catch(Exception err){err.printStackTrace();}
	if(pstmt!=null)try{pstmt.close();}catch(Exception err){err.printStackTrace();}
	if(con!=null)try{con.close();}catch(Exception err){err.printStackTrace();}
	
	
}
return check;

}
/////////////////////////////////////////
	
	
	
	public int deleteBoard(int num, String passwd){
	
		int check = 0; 
		
		try{
			con = getConnection();
			
			sql = "select passwd from board where num=?";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			
			if(rs.next()){ 
				
				if(passwd.equals(rs.getString("passwd"))){
					check = 1;
					
					sql ="delete from board where num=?";
					pstmt = con.prepareStatement(sql);
					pstmt.setInt(1, num);
					pstmt.executeUpdate();
					
				}else{ 
					check = 0;
				}
				
			}
			
		}catch(Exception err){
			err.printStackTrace();

			System.out.println("deleteBoard : "+err);
			
		}finally{
			if(rs!=null)try{rs.close();}catch(Exception err){err.printStackTrace();}
			if(pstmt!=null)try{pstmt.close();}catch(Exception err){err.printStackTrace();}
			if(con!=null)try{con.close();}catch(Exception err){err.printStackTrace();}
			
		}
		return check; 
		
	}
	
	//////revdelete
	public int revdeleteBoard(int num, String passwd){
		
		int check = 0; 
		
		try{
			con = getConnection();
			
			sql = "select passwd from revboard where num=?";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()){ 
				
				if(passwd.equals(rs.getString("passwd"))){
					check = 1;
					
					sql ="delete from revboard where num=?";
					pstmt = con.prepareStatement(sql);
					pstmt.setInt(1, num);
					
					// DELETE 
					pstmt.executeUpdate();
					
				}else{ 
					check = 0;
				}
				
			}
			
		}catch(Exception err){
			err.printStackTrace();
			
		}finally{
			
			if(rs!=null)try{rs.close();}catch(Exception err){err.printStackTrace();}
			if(pstmt!=null)try{pstmt.close();}catch(Exception err){err.printStackTrace();}
			if(con!=null)try{con.close();}catch(Exception err){err.printStackTrace();}
			
		}
		return check; 
		
	}
	//////////////////////////////////////////////
	
	
	
	
	
	public BoardBean getBoard(int num){ 
		
		BoardBean boardBean = null;
		
		try {
			// �뚣끇苑뽳옙�∽옙占썸에占� �겫占쏙옙苑� �뚣끇苑뽳옙�� 揶쏆빘猿� 占쎈섯疫뀐옙 (DB占쏙옙 沃섎챶�봺 占쎈염野껉퀣�뱽 筌띾툙占� Connection揶쏆빘猿� 占쎈섯疫뀐옙)
			con = getConnection();
			
			// 筌띲끆而삭퉪占쏙옙�땾嚥∽옙 占쎌읈占쎈뼎 獄쏆룇占� 疫뀐옙甕곕뜇�깈占쎈퓠 占쎈퉸占쎈뼣占쎈┷占쎈뮉 疫뀐옙 野껓옙占쎄퉳 SQL�눧占�
			sql = "select * from board where num=?";
			
			// select�뤃�됎�占쎌뱽 占쎈뼄占쎈뻬占쎈막 揶쏆빘猿� 占쎈섯疫뀐옙
			pstmt = con.prepareStatement(sql);
			
			// ?占쎈퓠 占쏙옙占쎌벓占쎈┷占쎈뮉 疫뀐옙 甕곕뜇�깈 占쎄퐬占쎌젟
			pstmt.setInt(1, num);
			
			// select 占쎈뼄占쎈뻬占쎌뜎 野껓옙占쎄퉳占쎈쭆 占쎈릭占쎄돌占쎌벥 疫뀐옙占쎌젟癰귣�占쏙옙 ResultSet 占쎌뿫占쎈뻻占쏙옙占쎌삢占쎈꺖占쎈퓠 占쏙옙占쎌삢 占쎈릭占쎈연 獄쏆꼹�넎
			rs = pstmt.executeQuery();
			
			
			if(rs.next()){ // 野껓옙占쎄퉳占쎈쭆 疫뀐옙占쎌뵠 鈺곕똻�삺 占쎈릭筌롳옙
				
				boardBean = new BoardBean(); // 野껓옙占쎄퉳占쎈립 占쎌젟癰귣�占쏙옙 rs占쎈퓠占쎄퐣 �댆�눖沅∽옙占쏙옙苑� 占쏙옙占쎌삢占쎈막 占쎌뒠占쎈즲
				
				// setter筌롫뗄�꺖占쎈굡�몴占� 占쎌넞占쎌뒠 占쎈퉸占쎄퐣 癰귨옙占쎈땾占쎈퓠 野껓옙占쎄퉳占쎈립 揶쏅�⑸굶占쎌뱽 占쏙옙占쎌삢
				boardBean.setContent(rs.getString("content"));
				boardBean.setDate(rs.getTimestamp("date"));
				boardBean.setFile(rs.getString("file"));
				boardBean.setIp(rs.getString("ip"));
				boardBean.setName(rs.getString("name"));
				boardBean.setNum(rs.getInt("num"));
				boardBean.setPasswd(rs.getString("passwd"));
				boardBean.setRe_lev(rs.getInt("re_lev"));
				boardBean.setRe_ref(rs.getInt("re_ref"));
				boardBean.setRe_seq(rs.getInt("re_seq"));
				boardBean.setReadcount(rs.getInt("readcount"));
				boardBean.setSubject(rs.getString("subject"));
				
				} // if占쎄국
		
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			//占쎌쁽占쎌뜚占쎈퉸占쎌젫
			if(rs!=null)try{rs.close();}catch(Exception err){err.printStackTrace();}
			if(pstmt!=null)try{pstmt.close();}catch(Exception err){err.printStackTrace();}
			if(con!=null)try{con.close();}catch(Exception err){err.printStackTrace();}
			
		}
		
		
		return boardBean; // BoardBean 揶쏆빘猿� �뵳�뗪쉘
		
		
	} // 筌롫뗄�꺖占쎈굡 占쎄국
	
	///////revgetBoard
		public BoardBean revgetBoard(int num){ 
			
			BoardBean boardBean = null;
			
			try {
				con = getConnection();
				
				sql = "select * from revboard where num=?";
				
				
				pstmt = con.prepareStatement(sql);
				
				
				pstmt.setInt(1, num);
				
				rs = pstmt.executeQuery();
				
				
				if(rs.next()){ 
					
					boardBean = new BoardBean(); //
					
					boardBean.setContent(rs.getString("content"));
					boardBean.setDate(rs.getTimestamp("date"));
					boardBean.setFile(rs.getString("file"));
					boardBean.setIp(rs.getString("ip"));
					boardBean.setName(rs.getString("name"));
					boardBean.setNum(rs.getInt("num"));
					boardBean.setPasswd(rs.getString("passwd"));
					boardBean.setRe_lev(rs.getInt("re_lev"));
					boardBean.setRe_ref(rs.getInt("re_ref"));
					boardBean.setRe_seq(rs.getInt("re_seq"));
					boardBean.setReadcount(rs.getInt("readcount"));
					boardBean.setSubject(rs.getString("subject"));
					
					}
			
			} catch (Exception e) {
				e.printStackTrace();
			}finally{
				
				if(rs!=null)try{rs.close();}catch(Exception err){err.printStackTrace();}
				if(pstmt!=null)try{pstmt.close();}catch(Exception err){err.printStackTrace();}
				if(con!=null)try{con.close();}catch(Exception err){err.printStackTrace();}
				
			}
			
			
			return boardBean; 
			
			
		} // 筌롫뗄�꺖占쎈굡 占쎄국
		
	///////grgetBoard
			public BoardBean grgetBoard(int num){ // content.jsp占쎈퓠占쎄퐣 占쎌깈�빊占� 占쎈립 筌롫뗄�꺖占쎈굡
				
				BoardBean boardBean = null;
				
				try {
					// �뚣끇苑뽳옙�∽옙占썸에占� �겫占쏙옙苑� �뚣끇苑뽳옙�� 揶쏆빘猿� 占쎈섯疫뀐옙 (DB占쏙옙 沃섎챶�봺 占쎈염野껉퀣�뱽 筌띾툙占� Connection揶쏆빘猿� 占쎈섯疫뀐옙)
					con = getConnection();
					
					// 筌띲끆而삭퉪占쏙옙�땾嚥∽옙 占쎌읈占쎈뼎 獄쏆룇占� 疫뀐옙甕곕뜇�깈占쎈퓠 占쎈퉸占쎈뼣占쎈┷占쎈뮉 疫뀐옙 野껓옙占쎄퉳 SQL�눧占�
					sql = "select * from gallery where num=?";
					
					// select�뤃�됎�占쎌뱽 占쎈뼄占쎈뻬占쎈막 揶쏆빘猿� 占쎈섯疫뀐옙
					pstmt = con.prepareStatement(sql);
					
					// ?占쎈퓠 占쏙옙占쎌벓占쎈┷占쎈뮉 疫뀐옙 甕곕뜇�깈 占쎄퐬占쎌젟
					pstmt.setInt(1, num);
					
					// select 占쎈뼄占쎈뻬占쎌뜎 野껓옙占쎄퉳占쎈쭆 占쎈릭占쎄돌占쎌벥 疫뀐옙占쎌젟癰귣�占쏙옙 ResultSet 占쎌뿫占쎈뻻占쏙옙占쎌삢占쎈꺖占쎈퓠 占쏙옙占쎌삢 占쎈릭占쎈연 獄쏆꼹�넎
					rs = pstmt.executeQuery();
					
					
					if(rs.next()){ // 野껓옙占쎄퉳占쎈쭆 疫뀐옙占쎌뵠 鈺곕똻�삺 占쎈릭筌롳옙
						
						boardBean = new BoardBean(); // 野껓옙占쎄퉳占쎈립 占쎌젟癰귣�占쏙옙 rs占쎈퓠占쎄퐣 �댆�눖沅∽옙占쏙옙苑� 占쏙옙占쎌삢占쎈막 占쎌뒠占쎈즲
						
						// setter筌롫뗄�꺖占쎈굡�몴占� 占쎌넞占쎌뒠 占쎈퉸占쎄퐣 癰귨옙占쎈땾占쎈퓠 野껓옙占쎄퉳占쎈립 揶쏅�⑸굶占쎌뱽 占쏙옙占쎌삢
						boardBean.setContent(rs.getString("content"));
						boardBean.setDate(rs.getTimestamp("date"));
						boardBean.setFile(rs.getString("file"));
						boardBean.setIp(rs.getString("ip"));
						boardBean.setName(rs.getString("name"));
						boardBean.setNum(rs.getInt("num"));
						boardBean.setPasswd(rs.getString("passwd"));
						boardBean.setRe_lev(rs.getInt("re_lev"));
						boardBean.setRe_ref(rs.getInt("re_ref"));
						boardBean.setRe_seq(rs.getInt("re_seq"));
						boardBean.setReadcount(rs.getInt("readcount"));
						boardBean.setSubject(rs.getString("subject"));
						
						} // if占쎄국
				
				} catch (Exception e) {
					e.printStackTrace();
				}finally{
					//占쎌쁽占쎌뜚占쎈퉸占쎌젫
					if(rs!=null)try{rs.close();}catch(Exception err){err.printStackTrace();}
					if(pstmt!=null)try{pstmt.close();}catch(Exception err){err.printStackTrace();}
					if(con!=null)try{con.close();}catch(Exception err){err.printStackTrace();}
					
				}
				
				
				return boardBean; // BoardBean 揶쏆빘猿� �뵳�뗪쉘
				
				
			} // 筌롫뗄�꺖占쎈굡 占쎄국
			////////////////////////////
	
	// 疫뀐옙甕곕뜇�깈�몴占� 筌띲끆而삭퉪占쏙옙�땾嚥∽옙 占쎌읈占쎈뼎 獄쏆룇釉�.. 疫뀐옙甕곕뜇�깈占쎈퓠 占쎈퉸占쎈뼣占쎈┷占쎈뮉 疫뀐옙占쎌벥 鈺곌퀬�돳占쎈땾 1筌앹빓占� 占쎈뻻占쎄텕占쎈뮉 筌롫뗄�꺖占쎈굡
	public void updateReadCount(int num){ 
		
		try {
			// �뚣끇苑뽳옙�∽옙占썸에占� �겫占쏙옙苑� �뚣끇苑뽳옙�� 揶쏆빘猿� 占쎈섯疫뀐옙 (DB占쏙옙 沃섎챶�봺 占쎈염野껉퀣�뱽 筌띾툙占� Connection揶쏆빘猿� 占쎈섯疫뀐옙)
			con = getConnection();
			
			sql = "update board set readcount=readcount+1 where num=?";
			
			pstmt = con.prepareStatement(sql);
					
			pstmt.setInt(1, num);
			
			pstmt.executeUpdate();
		
		} catch (Exception e) {

			
			e.printStackTrace();
		}finally {
			//占쎌쁽占쎌뜚占쎈퉸占쎌젫
			if(rs!=null)try{rs.close();}catch(Exception err){err.printStackTrace();}
			if(pstmt!=null)try{pstmt.close();}catch(Exception err){err.printStackTrace();}
			if(con!=null)try{con.close();}catch(Exception err){err.printStackTrace();}
			
		}
	}
	
	////revupdate
	// 疫뀐옙甕곕뜇�깈�몴占� 筌띲끆而삭퉪占쏙옙�땾嚥∽옙 占쎌읈占쎈뼎 獄쏆룇釉�.. 疫뀐옙甕곕뜇�깈占쎈퓠 占쎈퉸占쎈뼣占쎈┷占쎈뮉 疫뀐옙占쎌벥 鈺곌퀬�돳占쎈땾 1筌앹빓占� 占쎈뻻占쎄텕占쎈뮉 筌롫뗄�꺖占쎈굡
		public void revupdateReadCount(int num){ // content.jsp占쎈퓠占쎄퐣 占쎌깈�빊占� 占쎈릭占쎈뮉 筌롫뗄�꺖占쎈굡
			
			try {
				// �뚣끇苑뽳옙�∽옙占썸에占� �겫占쏙옙苑� �뚣끇苑뽳옙�� 揶쏆빘猿� 占쎈섯疫뀐옙 (DB占쏙옙 沃섎챶�봺 占쎈염野껉퀣�뱽 筌띾툙占� Connection揶쏆빘猿� 占쎈섯疫뀐옙)
				con = getConnection();
				
				sql = "update revboard set readcount=readcount+1 where num=?";
				
				pstmt = con.prepareStatement(sql);
						
				pstmt.setInt(1, num);
				
				pstmt.executeUpdate();
			
			} catch (Exception e) {

				
				e.printStackTrace();
			}finally {
				//占쎌쁽占쎌뜚占쎈퉸占쎌젫
				if(rs!=null)try{rs.close();}catch(Exception err){err.printStackTrace();}
				if(pstmt!=null)try{pstmt.close();}catch(Exception err){err.printStackTrace();}
				if(con!=null)try{con.close();}catch(Exception err){err.printStackTrace();}
				
			}
		}
		////////////////////////////////////
	
	////grupdate
		// 疫뀐옙甕곕뜇�깈�몴占� 筌띲끆而삭퉪占쏙옙�땾嚥∽옙 占쎌읈占쎈뼎 獄쏆룇釉�.. 疫뀐옙甕곕뜇�깈占쎈퓠 占쎈퉸占쎈뼣占쎈┷占쎈뮉 疫뀐옙占쎌벥 鈺곌퀬�돳占쎈땾 1筌앹빓占� 占쎈뻻占쎄텕占쎈뮉 筌롫뗄�꺖占쎈굡
			public void grupdateReadCount(int num){ // content.jsp占쎈퓠占쎄퐣 占쎌깈�빊占� 占쎈릭占쎈뮉 筌롫뗄�꺖占쎈굡
				
				try {
					// �뚣끇苑뽳옙�∽옙占썸에占� �겫占쏙옙苑� �뚣끇苑뽳옙�� 揶쏆빘猿� 占쎈섯疫뀐옙 (DB占쏙옙 沃섎챶�봺 占쎈염野껉퀣�뱽 筌띾툙占� Connection揶쏆빘猿� 占쎈섯疫뀐옙)
					con = getConnection();
					
					sql = "update gallery set readcount=readcount+1 where num=?";
					
					pstmt = con.prepareStatement(sql);
							
					pstmt.setInt(1, num);
					
					pstmt.executeUpdate();
				
				} catch (Exception e) {

					
					e.printStackTrace();
				}finally {
					//占쎌쁽占쎌뜚占쎈퉸占쎌젫
					if(rs!=null)try{rs.close();}catch(Exception err){err.printStackTrace();}
					if(pstmt!=null)try{pstmt.close();}catch(Exception err){err.printStackTrace();}
					if(con!=null)try{con.close();}catch(Exception err){err.printStackTrace();}
					
				}
			}
			////////////////////////////////////
	
	
	//揶쏄낱�읂占쎌뵠筌욑옙 筌띾뜄�뼄 筌띯뫁�맄占쎈퓠 筌ｃ꺂苡뀐쭪紐껋쨮 癰귣똻肉э쭪占� 占쎈뻻占쎌삂疫뀐옙甕곕뜇�깈, 占쎈립占쎈읂占쎌뵠筌욑옙占쎈뼣 癰귣똻肉т빳占� 疫뀐옙揶쏆뮇�땾�몴占� 筌띲끆而삭퉪占쏙옙�땾嚥∽옙 占쎌읈占쎈뼎 獄쏆룇釉�.
	//SELECT野껓옙占쎄퉳占쎈립 野껉퀗�궢�몴占� ArrayList占쎈퓠 占쏙옙占쎌삢占쎌뜎 �뵳�뗪쉘 占쎈릭占쎈뮉 筌롫뗄�꺖占쎈굡 
	public List<BoardBean> getBoardList(int startRow,int pageSize){
		
		List<BoardBean> boardList = new ArrayList<BoardBean>();
		
		try{
			//Connection揶쏆빘猿� 占쎈섯疫뀐옙 
			con = getConnection();
			//SELECT�뤃�됎� 筌띾슢諭얏묾占� 
			sql = "select * from board order by re_ref desc, re_seq asc limit ?,?";
			//SELECT�뤃�됎� 占쎈뼄占쎈뻬占쎈막 PreparedStatement占쎈뼄占쎈뻬 揶쏆빘猿� 占쎈섯疫뀐옙
			pstmt = con.prepareStatement(sql);
			//?揶쏉옙 占쎄퐬占쎌젟
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, pageSize);
			//SELECT�뤃�됎� 占쎈뼄占쎈뻬占쎌뜎 野껓옙占쎄퉳 占쎈립 野껉퀗�궢 獄쏆룄由�
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				BoardBean bBean = new BoardBean();
				//rs => BoardBean揶쏆빘猿쒙옙�벥 揶쏄낮占쏙옙�땾占쎈퓠 占쏙옙占쎌삢
				bBean.setContent(rs.getString("content"));
				bBean.setDate(rs.getTimestamp("date"));
				bBean.setFile(rs.getString("file"));
				bBean.setIp(rs.getString("ip"));
				bBean.setName(rs.getString("name"));
				bBean.setNum(rs.getInt("num"));
				bBean.setPasswd(rs.getString("passwd"));
				bBean.setRe_lev(rs.getInt("re_lev"));
				bBean.setRe_ref(rs.getInt("re_ref"));
				bBean.setRe_seq(rs.getInt("re_seq"));
				bBean.setReadcount(rs.getInt("readcount"));
				bBean.setSubject(rs.getString("subject"));
					
				//BoardBean揶쏆빘猿� => ArrayList獄쏄퀣肉댐옙肉� �빊遺쏙옙
				boardList.add(bBean);

			}//while�눧占�			
			
		}catch(Exception err){
			System.out.println("getBoardList筌롫뗄�꺖占쎈굡 占쎄땀�겫占쏙옙肉됵옙苑� 占쎌궎�몴占� : " + err);
		}finally {
			//占쎌쁽占쎌뜚占쎈퉸占쎌젫
			if(rs!=null)try{rs.close();}catch(Exception err){err.printStackTrace();}
			if(pstmt!=null)try{pstmt.close();}catch(Exception err){err.printStackTrace();}
			if(con!=null)try{con.close();}catch(Exception err){err.printStackTrace();}
		}
		
		return boardList;//ArrayList獄쏆꼹�넎
	}
	/////////////////revgetBOardList
	
	public List<BoardBean> revgetBoardList(int startRow,int pageSize){
		
		List<BoardBean> boardList = new ArrayList<BoardBean>();
		
		try{
			con = getConnection();
			sql = "select * from revboard order by re_ref desc, re_seq desc limit ?,?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, pageSize);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				BoardBean bBean = new BoardBean();
				bBean.setContent(rs.getString("content"));
				bBean.setDate(rs.getTimestamp("date"));
				bBean.setFile(rs.getString("file"));
				bBean.setIp(rs.getString("ip"));
				bBean.setName(rs.getString("name"));
				bBean.setNum(rs.getInt("num"));
				bBean.setPasswd(rs.getString("passwd"));
				bBean.setRe_lev(rs.getInt("re_lev"));
				bBean.setRe_ref(rs.getInt("re_ref"));
				bBean.setRe_seq(rs.getInt("re_seq"));
				bBean.setReadcount(rs.getInt("readcount"));
				bBean.setSubject(rs.getString("subject"));
					
				boardList.add(bBean);

			}	
			
		}catch(Exception err){
			System.out.println("revgetBoardList : " + err);
		}finally {
			if(rs!=null)try{rs.close();}catch(Exception err){err.printStackTrace();}
			if(pstmt!=null)try{pstmt.close();}catch(Exception err){err.printStackTrace();}
			if(con!=null)try{con.close();}catch(Exception err){err.printStackTrace();}
		}
		
		return boardList;
	}
	
	//////////////////////////////////////////////
	
	
	public int getBoardCount(){
		
		int count = 0;
		
		try {
			
			con = getConnection();
			sql = "select count(*) from board";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				count = rs.getInt(1);
			}
		
		} catch (Exception e) {
			System.out.println("getBoardCount() : " + e);
		} finally {
			if(rs!=null)try{rs.close();}catch(Exception err){err.printStackTrace();}
			if(pstmt!=null)try{pstmt.close();}catch(Exception err){err.printStackTrace();}
			if(con!=null)try{con.close();}catch(Exception err){err.printStackTrace();}
		}
		
		return count;
	}
	
	////////revgetBoardCount
		public int revgetBoardCount(){
			
			int count = 0; 
			
			try {
				
				con = getConnection();
				
				sql = "select count(*) from revboard";
				
				pstmt = con.prepareStatement(sql);
				
				rs = pstmt.executeQuery();
				
				if(rs.next()){
					count = rs.getInt(1);
				}
			
			} catch (Exception e) {
				System.out.println("revgetBoardCount(): " + e);
			} finally {
				
				if(rs!=null)try{rs.close();}catch(Exception err){err.printStackTrace();}
				if(pstmt!=null)try{pstmt.close();}catch(Exception err){err.printStackTrace();}
				if(con!=null)try{con.close();}catch(Exception err){err.printStackTrace();}
			}
			
			return count;
		}
	
		////////grgetBoardCOunt
		public int grgetBoardCount(){
			
			int count = 0;//野껓옙占쎄퉳占쎈립 占쎌읈筌ｏ옙 疫뀐옙 揶쏉옙占쎈땾�몴占� 占쏙옙占쎌삢占쎈막 癰귨옙占쎈땾 
			
			try {
				//�뚣끇苑뽳옙�∽옙占썸에占� �겫占쏙옙苑� �뚣끇苑뽳옙�� 揶쏆빘猿� 占쎈섯疫뀐옙 (DB占쎌젔占쎈꺗占쎌젟癰귣�占쏙옙 筌욑옙占쎈빍�⑨옙 占쎌뿳占쎈뮉 Connection占쎈섯疫뀐옙)
				con = getConnection();
				//sql SELECT-> 占쎌읈筌�占� 疫뀐옙揶쏆뮇�땾 野껓옙占쎄퉳
				sql = "select count(*) from gallery";
				//SELECT�눧占� 占쎈뼄占쎈뻬 揶쏆빘猿� 占쎈섯疫뀐옙
				pstmt = con.prepareStatement(sql);
				//SELECT�눧占� 占쎈뼄占쎈뻬 占쎌뜎 野껓옙占쎄퉳占쎈립 野껉퀗�궢 占쎈섯疫뀐옙
				rs = pstmt.executeQuery();
				
				if(rs.next()){
					count = rs.getInt(1);//野껓옙占쎄퉳占쎈립 疫뀐옙占쎌벥 揶쏆뮇�땾 
				}
			
			} catch (Exception e) {
				System.out.println("grgetBoardCount()筌롫뗄�꺖占쎈굡 占쎌궎�몴占� : " + e);
			} finally {
				//占쎌쁽占쎌뜚占쎈퉸占쎌젫
				if(rs!=null)try{rs.close();}catch(Exception err){err.printStackTrace();}
				if(pstmt!=null)try{pstmt.close();}catch(Exception err){err.printStackTrace();}
				if(con!=null)try{con.close();}catch(Exception err){err.printStackTrace();}
			}
			
			return count;
		}
		//////////////////////////////////////////////
		
	//野껊슣�뻻占쎈솇 占쎄퉱疫뀐옙 �빊遺쏙옙(雅뚯눊占�)
	//-> writePro.jsp占쎈퓠占쎄퐣 insertBoard()筌롫뗄�꺖占쎈굡 占쎌깈�빊�뮇�뻻.. 
	//   占쎌읈占쎈뼎占쎈립 BoardBean揶쏆빘猿쒐몴占� 占쎌뵠占쎌뒠占쎈릭占쎈연 insert SQL�눧紐꾩뱽 筌띾슢諭억옙�쁽.
	public  void insertBoard(BoardBean bBean){		
		
		int num = 0; //�빊遺쏙옙占쎈막 疫뀐옙甕곕뜇�깈 占쏙옙占쎌삢 占쎌뒠占쎈즲	
		try{
			//�뚣끇苑뽳옙�∽옙占썸에占� �겫占쏙옙苑� �뚣끇苑뽳옙�� 揶쏆빘猿� 占쎈섯疫뀐옙 (DB占쎌젔占쎈꺗占쎌젟癰귣�占쏙옙 筌욑옙占쎈빍�⑨옙 占쎌뿳占쎈뮉 Connection占쎈섯疫뀐옙)
			con = getConnection();
			//占쎄퉱疫뀐옙 �빊遺쏙옙占쎈뻻..疫뀐옙甕곕뜇�깈 �뤃�뗫릭疫뀐옙
			//-> board占쎈�믭옙�뵠�뇡遺용퓠 占쏙옙占쎌삢占쎈┷占쎈선 占쎌뿳占쎈뮉 揶쏉옙占쎌삢 占쎄쿃疫뀐옙甕곕뜇�깈 占쎈섯疫뀐옙
			//->疫뀐옙占쎌뵠 占쎈씨占쎌뱽 野껋럩�뒭 : 疫뀐옙甕곕뜇�깈 1 嚥∽옙 筌욑옙占쎌젟
			//->疫뀐옙占쎌뵠 占쎌뿳占쎌뱽 野껋럩�뒭 : 筌ㅼ뮄�젏 疫뀐옙甕곕뜇�깈(甕곕뜇�깈揶쏉옙 揶쏉옙占쎌삢占쎄쿃揶쏉옙) + 1 嚥∽옙 筌욑옙占쎌젟
			sql = "select max(num) from board";//揶쏉옙占쎌삢 占쎄쿃疫뀐옙甕곕뜇�깈 野껓옙占쎄퉳
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()){//野껓옙占쎄퉳占쎈립 占쎈쑓占쎌뵠占쎄숲揶쏉옙 鈺곕똻�삺 占쎈릭筌롳옙?
				num = rs.getInt(1) + 1; //疫뀐옙占쎌뵠 占쎌뿳占쎌뱽 野껋럩�뒭 筌ㅼ뮆占썸묾占썼린�뜇�깈 + 1
			}else{//野껓옙占쎄퉳占쎌뵠 占쎈┷筌욑옙 占쎈륫占쎌몵筌롳옙?
				num = 1; //疫뀐옙占쎌뵠 占쎈씨占쎌뱽 野껋럩�뒭 
			}
			//insert�뤃�됎� 筌띾슢諭얏묾占�
			sql = "insert into board "
				+ "(num,name,passwd,subject,"
				+ "content,file,re_ref,re_lev,"
				+ "re_seq,readcount,date,ip)"
				+ "values(?,?,?,?,?,?,?,?,?,?,?,?)";
			//insert�뤃�됎�占쎌뱽 占쎈뼄占쎈뻬占쎈막 PreparedStatement占쎈섯疫뀐옙 
			pstmt = con.prepareStatement(sql);
			//?占쏙옙占쎌벓 占쎈┷占쎈뮉 �빊遺쏙옙占쎈막 揶쏅�れ뱽 占쎄퐬占쎌젟
			pstmt.setInt(1, num);//�빊遺쏙옙占쎈막 占쎄퉱疫뀐옙甕곕뜇�깈
			pstmt.setString(2, bBean.getName());//占쎄퉱疫뀐옙占쎌뱽 �빊遺쏙옙占쎈립 占쎌삂占쎄쉐占쎌쁽 占쎌뵠�뵳占�
			pstmt.setString(3, bBean.getPasswd());//�빊遺쏙옙占쎈막 占쎄퉱疫뀐옙占쎌벥 �뜮袁⑨옙甕곕뜇�깈
			pstmt.setString(4, bBean.getSubject());//�빊遺쏙옙占쎈막 占쎄퉱疫뀐옙占쎌벥 疫뀐옙占쎌젫筌륅옙
			pstmt.setString(5, bBean.getContent());//�빊遺쏙옙占쎈막 占쎄퉱疫뀐옙占쎌벥 疫뀐옙占쎄땀占쎌뒠
			pstmt.setString(6, bBean.getFile());//�빊遺쏙옙占쎈막 占쎄퉱疫뀐옙 占쎈쑓占쎌뵠占쎄숲餓ο옙 占쎈씜嚥≪뮆諭띰옙釉� 占쎈솁占쎌뵬筌륅옙
			pstmt.setInt(7, num);// num 雅뚯눊占썼린�뜇�깈 疫꿸퀣占� == re_ref 域밸챶竊숃린�뜇�깈
			pstmt.setInt(8, 0);//�빊遺쏙옙占쎈막 占쎄퉱疫뀐옙占쎌벥 占쎈굶占쎈연占쎈쾺疫뀐옙 占쎌젟占쎈즲揶쏉옙 re_lev
			pstmt.setInt(9, 0);//疫뀐옙 占쎈떄占쎄퐣 re_seq
			pstmt.setInt(10, 0);//�빊遺쏙옙占쎈막 疫뀐옙占쎌벥 鈺곌퀬�돳占쎈땾 readcount 0
			pstmt.setTimestamp(11, bBean.getDate());//疫뀐옙 占쎌삂占쎄쉐 占쎄텊筌욑옙
			pstmt.setString(12, bBean.getIp());//疫뀐옙占쎈쿀占쎄텢占쎌뿺占쎌벥 IP雅뚯눘�꺖 
			
			//insert占쎈뼄占쎈뻬
			pstmt.executeUpdate();
			
		}catch(Exception e){
			System.out.println("inserBoard筌롫뗄�꺖占쎈굡 占쎄땀�겫占쏙옙肉됵옙苑� 占쎌궎�몴占�:" + e);
		}finally {
			//占쎌쁽占쎌뜚占쎈퉸占쎌젫
			if(rs!=null)try{rs.close();}catch(Exception err){err.printStackTrace();}
			if(pstmt!=null)try{pstmt.close();}catch(Exception err){err.printStackTrace();}
			if(con!=null)try{con.close();}catch(Exception err){err.printStackTrace();}
		}		
	}//insertBoard筌롫뗄�꺖占쎈굡 占쎈뼍占쎈뮉 �겫占썽겫占�
	
	///////revinsert
	//野껊슣�뻻占쎈솇 占쎄퉱疫뀐옙 �빊遺쏙옙(雅뚯눊占�)
		//-> writePro.jsp占쎈퓠占쎄퐣 insertBoard()筌롫뗄�꺖占쎈굡 占쎌깈�빊�뮇�뻻.. 
		//   占쎌읈占쎈뼎占쎈립 BoardBean揶쏆빘猿쒐몴占� 占쎌뵠占쎌뒠占쎈릭占쎈연 insert SQL�눧紐꾩뱽 筌띾슢諭억옙�쁽.
		public  void revinsertBoard(BoardBean bBean){		
			
			int num = 0; //�빊遺쏙옙占쎈막 疫뀐옙甕곕뜇�깈 占쏙옙占쎌삢 占쎌뒠占쎈즲	
			try{
				//�뚣끇苑뽳옙�∽옙占썸에占� �겫占쏙옙苑� �뚣끇苑뽳옙�� 揶쏆빘猿� 占쎈섯疫뀐옙 (DB占쎌젔占쎈꺗占쎌젟癰귣�占쏙옙 筌욑옙占쎈빍�⑨옙 占쎌뿳占쎈뮉 Connection占쎈섯疫뀐옙)
				con = getConnection();
				//占쎄퉱疫뀐옙 �빊遺쏙옙占쎈뻻..疫뀐옙甕곕뜇�깈 �뤃�뗫릭疫뀐옙
				//-> board占쎈�믭옙�뵠�뇡遺용퓠 占쏙옙占쎌삢占쎈┷占쎈선 占쎌뿳占쎈뮉 揶쏉옙占쎌삢 占쎄쿃疫뀐옙甕곕뜇�깈 占쎈섯疫뀐옙
				//->疫뀐옙占쎌뵠 占쎈씨占쎌뱽 野껋럩�뒭 : 疫뀐옙甕곕뜇�깈 1 嚥∽옙 筌욑옙占쎌젟
				//->疫뀐옙占쎌뵠 占쎌뿳占쎌뱽 野껋럩�뒭 : 筌ㅼ뮄�젏 疫뀐옙甕곕뜇�깈(甕곕뜇�깈揶쏉옙 揶쏉옙占쎌삢占쎄쿃揶쏉옙) + 1 嚥∽옙 筌욑옙占쎌젟
				sql = "select max(num) from revboard";//揶쏉옙占쎌삢 占쎄쿃疫뀐옙甕곕뜇�깈 野껓옙占쎄퉳
				pstmt = con.prepareStatement(sql);
				rs = pstmt.executeQuery();
				
				if(rs.next()){//野껓옙占쎄퉳占쎈립 占쎈쑓占쎌뵠占쎄숲揶쏉옙 鈺곕똻�삺 占쎈릭筌롳옙?
					num = rs.getInt(1) + 1; //疫뀐옙占쎌뵠 占쎌뿳占쎌뱽 野껋럩�뒭 筌ㅼ뮆占썸묾占썼린�뜇�깈 + 1
				}else{//野껓옙占쎄퉳占쎌뵠 占쎈┷筌욑옙 占쎈륫占쎌몵筌롳옙?
					num = 1; //疫뀐옙占쎌뵠 占쎈씨占쎌뱽 野껋럩�뒭 
				}
				//insert�뤃�됎� 筌띾슢諭얏묾占�
				sql = "insert into revboard "
					+ "(num,name,passwd,subject,"
					+ "content,file,re_ref,re_lev,"
					+ "re_seq,readcount,date,ip)"
					+ "values(?,?,?,?,?,?,?,?,?,?,?,?)";
				//insert�뤃�됎�占쎌뱽 占쎈뼄占쎈뻬占쎈막 PreparedStatement占쎈섯疫뀐옙 
				pstmt = con.prepareStatement(sql);
				//?占쏙옙占쎌벓 占쎈┷占쎈뮉 �빊遺쏙옙占쎈막 揶쏅�れ뱽 占쎄퐬占쎌젟
				pstmt.setInt(1, num);//�빊遺쏙옙占쎈막 占쎄퉱疫뀐옙甕곕뜇�깈
				pstmt.setString(2, bBean.getName());//占쎄퉱疫뀐옙占쎌뱽 �빊遺쏙옙占쎈립 占쎌삂占쎄쉐占쎌쁽 占쎌뵠�뵳占�
				pstmt.setString(3, bBean.getPasswd());//�빊遺쏙옙占쎈막 占쎄퉱疫뀐옙占쎌벥 �뜮袁⑨옙甕곕뜇�깈
				pstmt.setString(4, bBean.getSubject());//�빊遺쏙옙占쎈막 占쎄퉱疫뀐옙占쎌벥 疫뀐옙占쎌젫筌륅옙
				pstmt.setString(5, bBean.getContent());//�빊遺쏙옙占쎈막 占쎄퉱疫뀐옙占쎌벥 疫뀐옙占쎄땀占쎌뒠
				pstmt.setString(6, bBean.getFile());//�빊遺쏙옙占쎈막 占쎄퉱疫뀐옙 占쎈쑓占쎌뵠占쎄숲餓ο옙 占쎈씜嚥≪뮆諭띰옙釉� 占쎈솁占쎌뵬筌륅옙
				pstmt.setInt(7, num);// num 雅뚯눊占썼린�뜇�깈 疫꿸퀣占� == re_ref 域밸챶竊숃린�뜇�깈
				pstmt.setInt(8, 0);//�빊遺쏙옙占쎈막 占쎄퉱疫뀐옙占쎌벥 占쎈굶占쎈연占쎈쾺疫뀐옙 占쎌젟占쎈즲揶쏉옙 re_lev
				pstmt.setInt(9, 0);//疫뀐옙 占쎈떄占쎄퐣 re_seq
				pstmt.setInt(10, 0);//�빊遺쏙옙占쎈막 疫뀐옙占쎌벥 鈺곌퀬�돳占쎈땾 readcount 0
				pstmt.setTimestamp(11, bBean.getDate());//疫뀐옙 占쎌삂占쎄쉐 占쎄텊筌욑옙
				pstmt.setString(12, bBean.getIp());//疫뀐옙占쎈쿀占쎄텢占쎌뿺占쎌벥 IP雅뚯눘�꺖 
				
				//insert占쎈뼄占쎈뻬
				pstmt.executeUpdate();
				
			}catch(Exception e){
				System.out.println("revinserBoard筌롫뗄�꺖占쎈굡 占쎄땀�겫占쏙옙肉됵옙苑� 占쎌궎�몴占�:" + e);
			}finally {
				//占쎌쁽占쎌뜚占쎈퉸占쎌젫
				if(rs!=null)try{rs.close();}catch(Exception err){err.printStackTrace();}
				if(pstmt!=null)try{pstmt.close();}catch(Exception err){err.printStackTrace();}
				if(con!=null)try{con.close();}catch(Exception err){err.printStackTrace();}
			}		
		}//insertBoard筌롫뗄�꺖占쎈굡 占쎈뼍占쎈뮉 �겫占썽겫占�
		
		/////////////////////////////////////////////////////////
	
	///////grinsert
			public  void grinsertBoard(BoardBean bBean){		
				
				int num = 0; //�빊遺쏙옙占쎈막 疫뀐옙甕곕뜇�깈 占쏙옙占쎌삢 占쎌뒠占쎈즲	
				try{
					//�뚣끇苑뽳옙�∽옙占썸에占� �겫占쏙옙苑� �뚣끇苑뽳옙�� 揶쏆빘猿� 占쎈섯疫뀐옙 (DB占쎌젔占쎈꺗占쎌젟癰귣�占쏙옙 筌욑옙占쎈빍�⑨옙 占쎌뿳占쎈뮉 Connection占쎈섯疫뀐옙)
					con = getConnection();
					//占쎄퉱疫뀐옙 �빊遺쏙옙占쎈뻻..疫뀐옙甕곕뜇�깈 �뤃�뗫릭疫뀐옙
					//-> board占쎈�믭옙�뵠�뇡遺용퓠 占쏙옙占쎌삢占쎈┷占쎈선 占쎌뿳占쎈뮉 揶쏉옙占쎌삢 占쎄쿃疫뀐옙甕곕뜇�깈 占쎈섯疫뀐옙
					//->疫뀐옙占쎌뵠 占쎈씨占쎌뱽 野껋럩�뒭 : 疫뀐옙甕곕뜇�깈 1 嚥∽옙 筌욑옙占쎌젟
					//->疫뀐옙占쎌뵠 占쎌뿳占쎌뱽 野껋럩�뒭 : 筌ㅼ뮄�젏 疫뀐옙甕곕뜇�깈(甕곕뜇�깈揶쏉옙 揶쏉옙占쎌삢占쎄쿃揶쏉옙) + 1 嚥∽옙 筌욑옙占쎌젟
					sql = "select max(num) from gallery";//揶쏉옙占쎌삢 占쎄쿃疫뀐옙甕곕뜇�깈 野껓옙占쎄퉳
					pstmt = con.prepareStatement(sql);
					rs = pstmt.executeQuery();
					
					if(rs.next()){//野껓옙占쎄퉳占쎈립 占쎈쑓占쎌뵠占쎄숲揶쏉옙 鈺곕똻�삺 占쎈릭筌롳옙?
						num = rs.getInt(1) + 1; //疫뀐옙占쎌뵠 占쎌뿳占쎌뱽 野껋럩�뒭 筌ㅼ뮆占썸묾占썼린�뜇�깈 + 1
					}else{//野껓옙占쎄퉳占쎌뵠 占쎈┷筌욑옙 占쎈륫占쎌몵筌롳옙?
						num = 1; //疫뀐옙占쎌뵠 占쎈씨占쎌뱽 野껋럩�뒭 
					}
					//insert�뤃�됎� 筌띾슢諭얏묾占�
					sql = "insert into gallery "
						+ "(num,name,passwd,subject,"
						+ "content,file,re_ref,re_lev,"
						+ "re_seq,readcount,date,ip)"
						+ "values(?,?,?,?,?,?,?,?,?,?,?,?)";
					//insert�뤃�됎�占쎌뱽 占쎈뼄占쎈뻬占쎈막 PreparedStatement占쎈섯疫뀐옙 
					pstmt = con.prepareStatement(sql);
					//?占쏙옙占쎌벓 占쎈┷占쎈뮉 �빊遺쏙옙占쎈막 揶쏅�れ뱽 占쎄퐬占쎌젟
					pstmt.setInt(1, num);//�빊遺쏙옙占쎈막 占쎄퉱疫뀐옙甕곕뜇�깈
					pstmt.setString(2, bBean.getName());//占쎄퉱疫뀐옙占쎌뱽 �빊遺쏙옙占쎈립 占쎌삂占쎄쉐占쎌쁽 占쎌뵠�뵳占�
					pstmt.setString(3, bBean.getPasswd());//�빊遺쏙옙占쎈막 占쎄퉱疫뀐옙占쎌벥 �뜮袁⑨옙甕곕뜇�깈
					pstmt.setString(4, bBean.getSubject());//�빊遺쏙옙占쎈막 占쎄퉱疫뀐옙占쎌벥 疫뀐옙占쎌젫筌륅옙
					pstmt.setString(5, bBean.getContent());//�빊遺쏙옙占쎈막 占쎄퉱疫뀐옙占쎌벥 疫뀐옙占쎄땀占쎌뒠
					pstmt.setString(6, bBean.getFile());//�빊遺쏙옙占쎈막 占쎄퉱疫뀐옙 占쎈쑓占쎌뵠占쎄숲餓ο옙 占쎈씜嚥≪뮆諭띰옙釉� 占쎈솁占쎌뵬筌륅옙
					pstmt.setInt(7, num);// num 雅뚯눊占썼린�뜇�깈 疫꿸퀣占� == re_ref 域밸챶竊숃린�뜇�깈
					pstmt.setInt(8, 0);//�빊遺쏙옙占쎈막 占쎄퉱疫뀐옙占쎌벥 占쎈굶占쎈연占쎈쾺疫뀐옙 占쎌젟占쎈즲揶쏉옙 re_lev
					pstmt.setInt(9, 0);//疫뀐옙 占쎈떄占쎄퐣 re_seq
					pstmt.setInt(10, 0);//�빊遺쏙옙占쎈막 疫뀐옙占쎌벥 鈺곌퀬�돳占쎈땾 readcount 0
					pstmt.setTimestamp(11, bBean.getDate());//疫뀐옙 占쎌삂占쎄쉐 占쎄텊筌욑옙
					pstmt.setString(12, bBean.getIp());//疫뀐옙占쎈쿀占쎄텢占쎌뿺占쎌벥 IP雅뚯눘�꺖 
					
					//insert占쎈뼄占쎈뻬
					pstmt.executeUpdate();
					
				}catch(Exception e){
					System.out.println("grinserBoard筌롫뗄�꺖占쎈굡 占쎄땀�겫占쏙옙肉됵옙苑� 占쎌궎�몴占�:" + e);
				}finally {
					//占쎌쁽占쎌뜚占쎈퉸占쎌젫
					if(rs!=null)try{rs.close();}catch(Exception err){err.printStackTrace();}
					if(pstmt!=null)try{pstmt.close();}catch(Exception err){err.printStackTrace();}
					if(con!=null)try{con.close();}catch(Exception err){err.printStackTrace();}
				}		
			}//insertBoard筌롫뗄�꺖占쎈굡 占쎈뼍占쎈뮉 �겫占썽겫占�
			
			/////////////////////////////////////////////////////////
		
	
	
	
	public List<BoardBean>  getBoardList(int startRow,int pageSize,String search){
		List<BoardBean> boardList=new ArrayList<BoardBean>();
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql="";
		try {
			
			con=getConnection();
			
			sql="select * from board where subject like ? order by re_ref desc, re_seq asc limit ?,?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, "%"+search+"%");
			pstmt.setInt(2, startRow);
			pstmt.setInt(3, pageSize);
			
			rs=pstmt.executeQuery();
			
			while(rs.next()){
				BoardBean bBean=new BoardBean();
				bBean.setContent(rs.getString("content"));
				bBean.setDate(rs.getTimestamp("date"));
				bBean.setFile(rs.getString("file"));
				bBean.setIp(rs.getString("ip"));
				bBean.setName(rs.getString("name"));
				bBean.setNum(rs.getInt("num"));
				bBean.setPasswd(rs.getString("passwd"));
				bBean.setRe_lev(rs.getInt("re_lev"));
				bBean.setRe_ref(rs.getInt("re_ref"));
				bBean.setRe_seq(rs.getInt("re_seq"));
				bBean.setReadcount(rs.getInt("readcount"));
				bBean.setSubject(rs.getString("subject"));
				
				boardList.add(bBean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			if(rs!=null)try{rs.close();}catch(SQLException ex){}
			if(pstmt!=null)try{pstmt.close();}catch(SQLException ex){}
			if(con!=null)try{con.close();}catch(SQLException ex){}
		}
		return boardList;
	}
	
	//////revgetBoardList	

	public List<BoardBean>  revgetBoardList(int startRow,int pageSize,String search){
		List<BoardBean> boardList=new ArrayList<BoardBean>();
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql="";
		try {
			
			con=getConnection();
			
			sql="select * from revboard where subject like ? order by re_ref desc, re_seq asc limit ?,?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, "%"+search+"%"); 
			pstmt.setInt(2, startRow);
			pstmt.setInt(3, pageSize);
			
			rs=pstmt.executeQuery();
			
			while(rs.next()){
				BoardBean bBean=new BoardBean();
				bBean.setContent(rs.getString("content"));
				bBean.setDate(rs.getTimestamp("date"));
				bBean.setFile(rs.getString("file"));
				bBean.setIp(rs.getString("ip"));
				bBean.setName(rs.getString("name"));
				bBean.setNum(rs.getInt("num"));
				bBean.setPasswd(rs.getString("passwd"));
				bBean.setRe_lev(rs.getInt("re_lev"));
				bBean.setRe_ref(rs.getInt("re_ref"));
				bBean.setRe_seq(rs.getInt("re_seq"));
				bBean.setReadcount(rs.getInt("readcount"));
				bBean.setSubject(rs.getString("subject"));
				
				boardList.add(bBean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			if(rs!=null)try{rs.close();}catch(SQLException ex){}
			if(pstmt!=null)try{pstmt.close();}catch(SQLException ex){}
			if(con!=null)try{con.close();}catch(SQLException ex){}
		}
		return boardList;
	}
	
	/////////////////////////////////////////////////////////
	
//////grgetBoardList	

	//揶쏄낱�읂占쎌뵠筌욑옙 筌띾뜄�뼄 筌띯뫁�맄占쎈퓠 筌ｃ꺂苡뀐쭪紐껋쨮 癰귣똻肉э쭪占� 占쎈뻻占쎌삂疫뀐옙甕곕뜇�깈, 占쎈립占쎈읂占쎌뵠筌욑옙占쎈뼣 癰귣똻肉т빳占� 疫뀐옙揶쏆뮇�땾�몴占� 筌띲끆而삭퉪占쏙옙�땾嚥∽옙 占쎌읈占쎈뼎 獄쏆룇釉�.
	//SELECT野껓옙占쎄퉳占쎈립 野껉퀗�궢�몴占� ArrayList占쎈퓠 占쏙옙占쎌삢占쎌뜎 �뵳�뗪쉘 占쎈릭占쎈뮉 筌롫뗄�꺖占쎈굡 
	public List<BoardBean> grgetBoardList(int startRow,int pageSize){
		
		List<BoardBean> boardList = new ArrayList<BoardBean>();
		
		try{
			//Connection揶쏆빘猿� 占쎈섯疫뀐옙 
			con = getConnection();
			//SELECT�뤃�됎� 筌띾슢諭얏묾占� 
			sql = "select * from gallery order by re_ref desc, re_seq asc limit ?,?";
			//SELECT�뤃�됎� 占쎈뼄占쎈뻬占쎈막 PreparedStatement占쎈뼄占쎈뻬 揶쏆빘猿� 占쎈섯疫뀐옙
			pstmt = con.prepareStatement(sql);
			//?揶쏉옙 占쎄퐬占쎌젟
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, pageSize);
			//SELECT�뤃�됎� 占쎈뼄占쎈뻬占쎌뜎 野껓옙占쎄퉳 占쎈립 野껉퀗�궢 獄쏆룄由�
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				BoardBean bBean = new BoardBean();
				//rs => BoardBean揶쏆빘猿쒙옙�벥 揶쏄낮占쏙옙�땾占쎈퓠 占쏙옙占쎌삢
				bBean.setContent(rs.getString("content"));
				bBean.setDate(rs.getTimestamp("date"));
				bBean.setFile(rs.getString("file"));
				bBean.setIp(rs.getString("ip"));
				bBean.setName(rs.getString("name"));
				bBean.setNum(rs.getInt("num"));
				bBean.setPasswd(rs.getString("passwd"));
				bBean.setRe_lev(rs.getInt("re_lev"));
				bBean.setRe_ref(rs.getInt("re_ref"));
				bBean.setRe_seq(rs.getInt("re_seq"));
				bBean.setReadcount(rs.getInt("readcount"));
				bBean.setSubject(rs.getString("subject"));
					
				//BoardBean揶쏆빘猿� => ArrayList獄쏄퀣肉댐옙肉� �빊遺쏙옙
				boardList.add(bBean);

			}//while�눧占�			
			
		}catch(Exception err){
			System.out.println("grgetBoardList筌롫뗄�꺖占쎈굡 占쎄땀�겫占쏙옙肉됵옙苑� 占쎌궎�몴占� : " + err);
		}finally {
			//占쎌쁽占쎌뜚占쎈퉸占쎌젫
			if(rs!=null)try{rs.close();}catch(Exception err){err.printStackTrace();}
			if(pstmt!=null)try{pstmt.close();}catch(Exception err){err.printStackTrace();}
			if(con!=null)try{con.close();}catch(Exception err){err.printStackTrace();}
		}
		
		return boardList;//ArrayList獄쏆꼹�넎
	}
	
	/////////////////////////////////////////////////////////
    
    public int getCount(String search){
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql="";
		int count=0;
		try {
			con=getConnection();
			sql="select count(*) from board where subject like ?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, "%"+search+"%");
			rs=pstmt.executeQuery();
			if(rs.next()){
				count=rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			if(rs!=null)try{rs.close();}catch(SQLException ex){}
			if(pstmt!=null)try{pstmt.close();}catch(SQLException ex){}
			if(con!=null)try{con.close();}catch(SQLException ex){}
		}
		return count;
	}
    
    
    //////////////////////////////////////////
    
    
/////////////revgetCount
    
		public int revgetCount(String search){
			Connection con=null;
			PreparedStatement pstmt=null;
			ResultSet rs=null;
			String sql="";
			int count=0;
		try {
			con=getConnection();
			sql="select count(*) from revboard where subject like ?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, "%"+search+"%");
			rs=pstmt.executeQuery();
		if(rs.next()){
			count=rs.getInt(1);
		}
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			if(rs!=null)try{rs.close();}catch(SQLException ex){}
			if(pstmt!=null)try{pstmt.close();}catch(SQLException ex){}
			if(con!=null)try{con.close();}catch(SQLException ex){}
		}
		return count;
		}

    
    
	
	
}//BoardDAO






