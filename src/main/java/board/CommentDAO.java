package board;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.sql.DriverManager;
import java.util.ArrayList;
import logon.jdbcUtil;


public class CommentDAO {

	private static CommentDAO instance = new CommentDAO();
	
	private CommentDAO() {}
	
	public static CommentDAO getInstance() {
		return instance;
	}
	
	private Connection getConnection() throws SQLException {
		String jdbcDriver = "jdbc:apache:commons:dbcp:/pool";
		return DriverManager.getConnection(jdbcDriver);
	}
	
	
	
	public void insertComment(CommentDTO cmt) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("insert into b_comment(content_num, commenter, commentt, passwd, reg_date, ip, comment_num) "
					+ "values(?,?,?,?,?,?,?)");
			pstmt.setInt(1, cmt.getContent_num());
			pstmt.setString(2, cmt.getCommenter());
			pstmt.setString(3, cmt.getCommentt());
			pstmt.setString(4, cmt.getPasswd());
			pstmt.setTimestamp(5, cmt.getReg_date());
			pstmt.setString(6, cmt.getIp());
			pstmt.setInt(7, cmt.getComment_num());
			//count 다시 구해서 넣자
			pstmt.executeUpdate();
			
			
		}catch(Exception ex) {
			ex.printStackTrace();
			
		}finally {
			jdbcUtil.close(conn);
			jdbcUtil.close(pstmt);
		}
		
	}
	
	
	public ArrayList<CommentDTO> getComments(int con_num, int start, int end) {
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<CommentDTO> list = null;

		try {
			conn = getConnection();
			
			String sql="select content_num,commenter,commentt,reg_date,ip,comment_num,r "
					+ "from (select content_num,commenter,commentt,reg_date,ip,comment_num, rownum r "
					+ "from (select content_num,commenter,commentt,reg_date,ip,comment_num "
					+ "from b_comment where content_num="+con_num+" order by reg_date desc) order by reg_date desc) where r >= ? and r <= ?";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				list = new ArrayList<>();
				do {
					CommentDTO cmt = new CommentDTO();
					cmt.setContent_num(rs.getInt("content_num"));
					cmt.setCommenter(rs.getString("commenter"));
					cmt.setCommentt(rs.getString("commentt"));
					cmt.setReg_date(rs.getTimestamp("reg_date"));
					cmt.setIp(rs.getString("ip"));
					cmt.setComment_num(rs.getInt("comment_num"));
					
					list.add(cmt);	
				}while(rs.next());
				
			}
			
		}catch(Exception ex) {
			ex.printStackTrace();
			
		}finally {
			jdbcUtil.close(conn);
			jdbcUtil.close(pstmt);
			jdbcUtil.close(rs);
		}
		
		return list;
	}
	
	
	public int getCommentCount(int con_num) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int count = 0;
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select count(1) from b_comment where content_num = ?");
			pstmt.setInt(1, con_num);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				count = rs.getInt(1);
			} else
				count = -1;
			
			
		}catch(Exception ex) {
			ex.printStackTrace();
			
		}finally {
			jdbcUtil.close(rs);
			jdbcUtil.close(pstmt);
			jdbcUtil.close(conn);
		}
		
		return count;
	}
	
	public int deleteComment(int content_num, String passwd, int comment_num) {
		int x = -1;
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String dbPasswd = "";
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select passwd from b_comment where content_num = ? and comment_num = ?");
			pstmt.setInt(1, content_num);
			pstmt.setInt(2, comment_num);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				dbPasswd = rs.getString("passwd");
				if(dbPasswd.equals(passwd)) {
					pstmt = conn.prepareStatement("delete from b_comment where content_num=? and comment_num = ?");
					pstmt.setInt(1, content_num);
					pstmt.setInt(2, comment_num);
					pstmt.executeUpdate();
					x = 1;
					
				}
					
				else
					x = -1;
				
			}
			
		}catch(Exception ex) {
			ex.printStackTrace();
			
		}finally {
			jdbcUtil.close(conn);
			jdbcUtil.close(rs);
			jdbcUtil.close(pstmt);
		}
		
		return x;
	}
	
	
	
}
