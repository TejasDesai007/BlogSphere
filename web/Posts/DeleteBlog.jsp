<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.MysqlConnect"%>
<%!
    public String isBlankNull(String str) {
        return (str == null || str.trim().isEmpty()) ? "" : str;
    }
%>
<%
    MysqlConnect dbc = new MysqlConnect();
    Connection con = null;
    PreparedStatement pstmt = null;
    String postid = isBlankNull(request.getParameter("postID"));

    try {
        con = dbc.getConnection();
        pstmt = con.prepareStatement("DELETE FROM posts WHERE PostID = ?");
        pstmt.setString(1, postid);

        int rowsAffected = pstmt.executeUpdate();
        if (rowsAffected > 0) {
            out.println("Deleted Successfully!");
            
        } else {
            out.println("No record found with the given room ID.");
        }

    } catch (SQLException ex) {
        
        if (ex.getMessage().toLowerCase().contains("foreign key constraint fails")) {
            out.println("Cannot delete: The guest is used in for bookings");
        } else {
            out.println("Error occurred: " + ex.getMessage());
        }
    } finally {
        
        try {
            if (pstmt != null) pstmt.close();
            if (con != null) con.close();
        } catch (Exception e) {
            out.println("Error closing resources: " + e.getMessage());
        }
    }
    response.sendRedirect("Home");
%>
