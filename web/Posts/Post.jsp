<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.MysqlConnect"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>View Post</title>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
        <link href="style/css/bootstrap.css" rel="stylesheet" type="text/css"/>
        <style>
            .post-content {
                margin-top: 30px;
            }
            .carousel-inner img {
                max-height: 400px;
                object-fit: cover;
            }
        </style>
        <jsp:include page="../include/menu.jsp"/>
    </head>
    <body class="bg-light">
        <div class="container">
            <div class="post-content">
                <%
                    Connection conn = null;
                    PreparedStatement pstmt = null, imgStmt = null;
                    ResultSet rs = null, imgRs = null;
                    MysqlConnect dbc = new MysqlConnect();
                    int postID = Integer.parseInt(request.getParameter("postID"));

                    try {
                        // Get database connection
                        conn = dbc.getConnection();

                        // Fetch the post details
                        String postQuery = "SELECT Posts.Title, Posts.Content, Posts.PublishedAt, Users.UserName "
                                + "FROM Posts "
                                + "JOIN Users ON Posts.UserID = Users.UserID "
                                + "WHERE Posts.PostID = ?";
                        pstmt = conn.prepareStatement(postQuery);
                        pstmt.setInt(1, postID);
                        rs = pstmt.executeQuery();

                        if (rs.next()) {
                            String title = rs.getString("Title");
                            String content = rs.getString("Content");
                            String publishedAt = rs.getString("PublishedAt");
                            String userName = rs.getString("UserName");

                            // Display post details
                %>
                <h1 class="mb-4"><i class="fas fa-file-alt"></i> <%= title %></h1>
                <h6 class="text-muted">By <%= userName %> on <%= publishedAt %></h6>
                <hr>
                <div id="carouselPost<%= postID %>" class="carousel slide my-4" data-bs-ride="carousel">
                    <div class="carousel-inner">
                        <%
                            // Fetch images for the post
                            String imgQuery = "SELECT ImagePath FROM PostImages WHERE PostID = ?";
                            imgStmt = conn.prepareStatement(imgQuery);
                            imgStmt.setInt(1, postID);
                            imgRs = imgStmt.executeQuery();

                            boolean isFirst = true;
                            while (imgRs.next()) {
                                String imagePath = imgRs.getString("ImagePath");
                        %>
                        <div class="carousel-item <%= isFirst ? "active" : "" %>">
                            <img src="<%= imagePath %>" class="d-block w-100" alt="Post Image">
                        </div>
                        <%
                                isFirst = false;
                            }
                        %>
                    </div>
                    <button class="carousel-control-prev" type="button" data-bs-target="#carouselPost<%= postID %>" data-bs-slide="prev">
                        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                        <span class="visually-hidden">Previous</span>
                    </button>
                    <button class="carousel-control-next" type="button" data-bs-target="#carouselPost<%= postID %>" data-bs-slide="next">
                        <span class="carousel-control-next-icon" aria-hidden="true"></span>
                        <span class="visually-hidden">Next</span>
                    </button>
                </div>
                <p class="mt-4"><%= content %></p>
                <%
                        } else {
                %>
                <div class="alert alert-danger">Post not found!</div>
                <%
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    } finally {
                        if (imgRs != null) try { imgRs.close(); } catch (Exception e) { e.printStackTrace(); }
                        if (imgStmt != null) try { imgStmt.close(); } catch (Exception e) { e.printStackTrace(); }
                        if (rs != null) try { rs.close(); } catch (Exception e) { e.printStackTrace(); }
                        if (pstmt != null) try { pstmt.close(); } catch (Exception e) { e.printStackTrace(); }
                        if (conn != null) try { conn.close(); } catch (Exception e) { e.printStackTrace(); }
                    }
                %>
            </div>
        </div>

        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
