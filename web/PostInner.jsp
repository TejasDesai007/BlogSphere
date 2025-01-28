<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="com.MysqlConnect"%>

<%
    String query = request.getParameter("query");
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    MysqlConnect dbc = new MysqlConnect();

    response.setContentType("application/json");
//    System.out.println(query);

    try {
        conn = dbc.getConnection();

        // Query to search for posts matching the query
        String sql = "SELECT Posts.PostID, Posts.Title, Posts.Content, Posts.PublishedAt, Users.UserName "
                   + "FROM Posts "
                   + "JOIN Users ON Posts.UserID = Users.UserID "
                   + "WHERE Posts.IsPublished = TRUE AND (Posts.Title LIKE ? OR Posts.Content LIKE ?) "
                   + "ORDER BY Posts.PublishedAt DESC";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, "%" + query + "%");
        pstmt.setString(2, "%" + query + "%");
        rs = pstmt.executeQuery();

        // Generate JSON response
        StringBuilder json = new StringBuilder("[");
        boolean first = true;
        while (rs.next()) {
            if (!first) json.append(",");
            first = false;

            json.append("{")
                .append("\"postID\":").append(rs.getInt("PostID")).append(",")
                .append("\"title\":\"").append(rs.getString("Title").replace("\"", "\\\"")).append("\",")
                .append("\"content\":\"").append(rs.getString("Content").replace("\"", "\\\"")).append("\",")
                .append("\"publishedAt\":\"").append(rs.getString("PublishedAt")).append("\",")
                .append("\"userName\":\"").append(rs.getString("UserName")).append("\"")
                .append("}");
        }
        json.append("]");
        out.print(json.toString());

    } catch (Exception e) {
        e.printStackTrace();
        out.print("[]");
    } finally {
        if (rs != null) try { rs.close(); } catch (Exception e) { e.printStackTrace(); }
        if (pstmt != null) try { pstmt.close(); } catch (Exception e) { e.printStackTrace(); }
        if (conn != null) try { conn.close(); } catch (Exception e) { e.printStackTrace(); }
    }
%>
