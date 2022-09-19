package logon;
import java.sql.*;

public class LogonDBBean_home {

	private static LogonDBBean_home instance = new LogonDBBean_home();
	
	public static LogonDBBean_home getInstance() {
		return instance;
	}
	
	private LogonDBBean_home() {
		
	}
	
	//커넥션풀 생성, 커넥션 객체 반환
	private Connection getConnection() throws Exception{
		String jdbcDriver = "jdbc:apache:commons:dbcp:/pool_home";
		return DriverManager.getConnection(jdbcDriver);
	}

	
	
	//inputPro.jsp 에서 회원가입할때 사용
	public void insertMember(LogonDataBean member) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("insert into members values(?,?,?,?,?,?,?,?)");
			pstmt.setString(1, member.getId());
			pstmt.setString(2, member.getPasswd());
			pstmt.setString(3, member.getName());
			pstmt.setString(4, member.getBirthday());
			pstmt.setString(5, member.getMale());
			pstmt.setString(6, member.getEmail());
			pstmt.setString(7, member.getBlog());
			pstmt.setTimestamp(8, member.getReg_date());
			
			pstmt.executeQuery();
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
			if(conn != null) try {conn.close();} catch(SQLException ex) {}
		}
		
	}
	
	//loginPro.jsp에서 로그온 시도할때 호출
	public int userCheck(String id, String passwd) throws Exception{
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String dbpasswd="";
		int x = -1;
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select passwd from members where id= ?");
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				dbpasswd = rs.getString("passwd");
				if(dbpasswd.equals(passwd))
					x = 1; // 인증성공
				else
					x = 0; //비번 틀림
			}else
				x = -1; // 해당 아이디 없음
			
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
			if(rs != null) try {rs.close();} catch(SQLException ex) {}
			if(conn != null) try {conn.close();} catch(SQLException ex) {}
		}
		
		return x;
	}
	
	//confirmId.jsp 에서 id 중복체크 // 최창선
	//중복 아니면 1리턴 중복이면 -1 리턴
	public int confirmId(String id) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt= null;
		ResultSet rs = null;
		int x= -1;
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select id from members where id=?");
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				x = 1; // 해당 아이디 있음
			}else {
				x = -1; //해당 아이디 없음
			}
			
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			if(rs != null) try {rs.close();} catch(SQLException ex) {}
			if(pstmt != null) try {rs.close();} catch(SQLException ex) {}
			if(conn != null) try {rs.close();} catch(SQLException ex) {}
		}
		return x;
		
		
	}
	
	//updateMember.jsp 에서 수정폼에 가입된 회원의 정보를 보여줄대
	public LogonDataBean getMember(String id) throws Exception{
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		LogonDataBean member = null;
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select * from members where id=?");
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				member = new LogonDataBean();
				member.setId(rs.getString("id"));
				member.setPasswd(rs.getString("passwd"));
				member.setName(rs.getString("name"));
				member.setBirthday(rs.getString("birthday"));
				member.setMale(rs.getString("male"));
				member.setEmail(rs.getString("email"));
				member.setBlog(rs.getString("blog"));
				member.setReg_date(rs.getTimestamp("reg_date"));
			}
			
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			if(rs != null) try {rs.close();} catch(SQLException ex) {}
			if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
			if(conn != null) try {conn.close();} catch(SQLException ex) {}
		}
		return member;
	}
	
	
	//update 쿼리 날릴때
	public void updateMember(LogonDataBean member) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("update members set passwd=?, name=?, email=?, blog=? where id=?");
			pstmt.setString(1, member.getPasswd());
			pstmt.setString(2, member.getName());
			pstmt.setString(3, member.getEmail());
			pstmt.setString(4, member.getBlog());
			pstmt.setString(5, member.getId());
			pstmt.executeUpdate();
			
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
			if(conn != null) try {conn.close();} catch(SQLException ex) {}
		}
	}
	
	//delete 할때 
	public int deleteMember(String id, String passwd) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String dbpasswd = "";
		int x = -1;
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select passwd from members where id=?");
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				dbpasswd = rs.getString("passwd");
				if(dbpasswd.equals(passwd)) {
					pstmt = conn.prepareStatement("delete from members where id=?");
					pstmt.setString(1, id);
					pstmt.executeUpdate();
					x = 1; // 회원탈퇴 성공
				
				}else
					x = 0; // 비밀번호 틀림
			}
		
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			if(rs != null) try {rs.close();} catch(SQLException ex) {} 
			if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {} 
			if(conn != null) try {conn.close();} catch(SQLException ex) {} 
		}
		return x;
	}
	
	
	
	
}
















