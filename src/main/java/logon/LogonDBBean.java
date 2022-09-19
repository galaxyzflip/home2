package logon;
import java.sql.*;
import java.util.*;
import java.sql.DriverManager;

public class LogonDBBean {

	
	private static LogonDBBean instance = new LogonDBBean();
	
	public static LogonDBBean getInstance() {
		return instance;
	}
	
	private LogonDBBean() {
		
	}
	
	//커넥션풀 생성, 커넥션 객체 반환
	private Connection getConnection() throws Exception{
		String jdbcDriver = "jdbc:apache:commons:dbcp:/pool";
		return DriverManager.getConnection(jdbcDriver);
	}

	
	
	//inputPro.jsp 에서 회원가입할때 사용
//	public int insertMember(LogonDataBean member) throws Exception{
//		Connection conn = null;
//		PreparedStatement pstmt = null;
//		int x = -1;
//		try {
//			conn = getConnection();
//			pstmt = conn.prepareStatement("insert into members values(?,?,?,?,?,?,?,?)");
//			pstmt.setString(1, member.getId());
//			pstmt.setString(2, member.getPasswd());
//			pstmt.setString(3, member.getName());
//			pstmt.setString(4, member.getBirthday());
//			pstmt.setString(5, member.getMale());
//			pstmt.setString(6, member.getEmail());
//			pstmt.setString(7, member.getBlog());
//			pstmt.setTimestamp(8, member.getReg_date());
//			
//			pstmt.executeQuery();
//			x = 1;
//			return x; 
//		}catch(Exception ex) {
//			ex.printStackTrace();
//			return x;
//		}finally {
//			if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
//			if(conn != null) try {conn.close();} catch(SQLException ex) {}
//		}
//		
//	}
	
	//inputPro.jsp 에서 회원가입할때 사용
	public void insertMember(LogonDataBean member) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			conn = getConnection();
			
			//휴대폰번호 - 기호 삭제
			String phone = member.getPhone().replace("-", "");
			
			pstmt = conn.prepareStatement("insert into members(id, passwd, name, birthday,"
					+ " male, email,blog, reg_date, zipcode, address, address2, phone) "
					+ "values(?,?,?,?,?,?,?,?,?,?,?,?)");
			pstmt.setString(1, member.getId());
			pstmt.setString(2, member.getPasswd());
			pstmt.setString(3, member.getName());
			pstmt.setString(4, member.getBirthday());
			pstmt.setString(5, member.getMale());
			pstmt.setString(6, member.getEmail());
			pstmt.setString(7, member.getBlog());
			pstmt.setTimestamp(8, member.getReg_date());
			pstmt.setString(9, member.getZipcode());
			pstmt.setString(10, member.getAddress());
			pstmt.setString(11, member.getDetailAddress());
			pstmt.setString(12,phone);
			
			pstmt.executeQuery();
			
		}catch(Exception ex) {
			ex.printStackTrace();
			
		}finally {
			jdbcUtil.close(pstmt);
			jdbcUtil.close(conn);
			
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
	

	
	//confirmId.jsp 에서 id 중복체크 
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
				x = -1; //해당 아이디 없음 > 사용 가능
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
	
	//modifyForm.jsp 에서 수정폼에 로그인한 회원의 정보를 보여줄대
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
				member.setZipcode(rs.getString("zipcode"));
				member.setAddress(rs.getString("address"));
				member.setDetailAddress(rs.getString("address2"));
				member.setPhone(rs.getString("phone"));
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
	
	
	//modifyPro.jsp 에서 작업
	public void updateMember(LogonDataBean member) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("update members set passwd=?, name=?, "
					+ "email=?, blog=?, zipcode=?, address = ?, address2 = ?, phone=? where id=?");
			pstmt.setString(1, member.getPasswd());
			pstmt.setString(2, member.getName());
			pstmt.setString(3, member.getEmail());
			pstmt.setString(4, member.getBlog());
			pstmt.setString(5, member.getZipcode());
			pstmt.setString(6, member.getAddress());
			pstmt.setString(7, member.getDetailAddress());
			pstmt.setString(8, member.getPhone());
			pstmt.setString(9, member.getId());
			pstmt.executeUpdate();
			
		}catch(Exception ex) {
			ex.printStackTrace();
			
		}finally {
			if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
			if(conn != null) try {conn.close();} catch(SQLException ex) {}
		}
	}
	
	//deletePro.jsp 에서 호출
	//회원정보 삭제할때
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
	
	//다음 주소 api 쓰면서 안쓰기로함...
	public Vector<ZipcodeBean> zipcodeRead(String area3) {
		
		Vector<ZipcodeBean> vecList = new Vector<>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = getConnection();
			String query = "select * from zipcode where area3 like '%" + area3 + "%'"; 
			pstmt = conn.prepareStatement(query);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				ZipcodeBean bean = new ZipcodeBean();
				bean.setZipcode(rs.getString("zipcode"));
				bean.setArea1(rs.getString("area1"));
				bean.setArea2(rs.getString("area2"));
				bean.setArea3(rs.getString("area3"));
				bean.setArea4(rs.getString("area4"));
				vecList.addElement(bean);
				
			}
			
		}catch(Exception ex) {
			ex.printStackTrace();
			
		}finally {
			if(rs != null) try {rs.close();} catch(SQLException ex) {}
			if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
			if(conn != null) try {conn.close();} catch(SQLException ex) {}
		}
		
		return vecList;
	}
	
	
	// 이름, 폰번호 입력해서 아이디 찾기
	public String findId(String name, String sendPhone) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String id="";
		String phone = sendPhone.replace("-", "");
		
		
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select id from members where name = ? and phone = ?");
			pstmt.setString(1, name);
			pstmt.setString(2, phone);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				id = rs.getString("id"); 
			}
			
			
		}catch(Exception ex) {
			ex.printStackTrace();
			
		}finally {
			if(rs != null) try {rs.close();} catch(SQLException ex) {}
			if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
			if(conn != null) try {conn.close();} catch(SQLException ex) {}
			
		}
		
		return id;
		
	}
	
	public String findPasswd(String id, String sendPhone) {
		String passwd = "";
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String phone = sendPhone.replace("-", "");
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select passwd from members where id = ? and phone = ?");
			pstmt.setString(1, id);
			pstmt.setString(2, phone);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				passwd = rs.getString("passwd");
			}
			
		}catch(Exception ex) {
			ex.printStackTrace();
			
		}finally {
			if(rs != null) try {rs.close();} catch(SQLException ex) {}
			if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
			if(conn != null) try {conn.close();} catch(SQLException ex) {}
		}
		return passwd;
	}
	
	//휴대폰번호 중복 체크 
	//x = -1 중복
	//x = 1 사용가능
	public int checkPhone(String sendPhone) {
		int x = -1;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String phone = sendPhone.replace("-", "");
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select phone from members where phone=?");
			pstmt.setString(1, phone);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				x = -1;
			
			}else {
				x = 1;
				
			}
			
			
		}catch(Exception ex) {
			
		}finally {
			if( rs != null) try {rs.close();} catch(SQLException ex) {}
			if( pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
			if( conn != null) try {conn.close();} catch(SQLException ex) {}
		}
		
		return x;
	}
	
	// checkphone2............. 
	public int checkPhone2(String sendPhone, String id) {
		int x = -1;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String phone = sendPhone.replace("-", "");
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select phone from members where phone=? and id != ? ");
			pstmt.setString(1, phone);
			pstmt.setString(2, id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				x = -1;
			
			}else {
				x = 1;
				
			}
			
			
		}catch(Exception ex) {
			
		}finally {
			if( rs != null) try {rs.close();} catch(SQLException ex) {}
			if( pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
			if( conn != null) try {conn.close();} catch(SQLException ex) {}
		}
		
		return x;
	}
}
















