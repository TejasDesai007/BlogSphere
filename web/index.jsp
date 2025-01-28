<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.MysqlConnect"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Home - Blog</title>
        <link href="style/css/bootstrap.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
        <style>
            .card {
                margin-bottom: 20px;
            }
            .carousel-inner img {
                max-height: 300px;
                object-fit: cover;
            }
        </style>
        <jsp:include page="include/menu.jsp"/>
    </head>
    <body class="bg-light">
        <div class="container">
            <h1 class="my-4 text-center"><i class="fas fa-blog"></i> Blog Home</h1>

            <!-- Search Box -->
            <div class="mb-4">
                <input type="text" id="searchInput" class="form-control" placeholder="Search posts...">
            </div>

            <div class="row" id="postContainer">
                <%
                    String strUserId = (session.getAttribute("UserId") != null) ? session.getAttribute("UserId").toString() : "";
                    String strUsername = (session.getAttribute("Username") != null) ? session.getAttribute("Username").toString() : "Guest";
                    Connection conn = null;
                    PreparedStatement pstmt = null, imgStmt = null;
                    ResultSet rs = null, imgRs = null;
                    MysqlConnect dbc = new MysqlConnect();
                    try {
                        conn = dbc.getConnection();

                        String sql = "SELECT Posts.PostID, Posts.Title, Posts.Content, Posts.PublishedAt, Posts.UserID, Users.UserName "
                                + "FROM Posts "
                                + "JOIN Users ON Posts.UserID = Users.UserID "
                                + "WHERE Posts.IsPublished = TRUE "
                                + "ORDER BY Posts.PublishedAt DESC";
                        pstmt = conn.prepareStatement(sql);
                        rs = pstmt.executeQuery();

                        while (rs.next()) {
                            int postID = rs.getInt("PostID");
                            String title = rs.getString("Title");
                            String content = rs.getString("Content");
                            String publishedAt = rs.getString("PublishedAt");
                            String userName = rs.getString("UserName");
                            String postUserId = rs.getString("UserID");

                            String imgQuery = "SELECT ImagePath FROM PostImages WHERE PostID = ?";
                            imgStmt = conn.prepareStatement(imgQuery);
                            imgStmt.setInt(1, postID);
                            imgRs = imgStmt.executeQuery();
                %>
                <div class="col-md-6 post-card" data-title="<%= title.toLowerCase()%>" data-content="<%= content.toLowerCase()%>">
                    <div class="card">
                        <div id="carousel<%= postID%>" class="carousel slide" data-bs-ride="carousel">
                            <div class="carousel-inner">
                                <%
                                    boolean isFirst = true;
                                    while (imgRs.next()) {
                                        String imagePath = imgRs.getString("ImagePath");
                                %>
                                <div class="carousel-item <%= isFirst ? "active" : ""%>">
                                    <img src="<%= imagePath%>" class="d-block w-100" alt="Post Image">
                                </div>
                                <%
                                        isFirst = false;
                                    }
                                %>
                            </div>
                            <a class="carousel-control-prev" href="#carousel<%= postID%>" role="button" data-bs-slide="prev">
                                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                                <span class="visually-hidden">Previous</span>
                            </a>
                            <a class="carousel-control-next" href="#carousel<%= postID%>" role="button" data-bs-slide="next">
                                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                                <span class="visually-hidden">Next</span>
                            </a>
                        </div>
                        <div class="card-body">
                            <h5 class="card-title"><%= title%></h5>
                            <h6 class="card-subtitle mb-2 text-muted">By <%= userName%> on <%= publishedAt%></h6>
                            <p class="card-text"><%= content.length() > 150 ? content.substring(0, 150) + "..." : content%></p>
                            <a href="viewPost?postID=<%= postID%>" class="card-link">Read More</a>
                            <% if (strUserId.equals(postUserId)) {%>
                            <a href="DeleteBlog?postID=<%= postID%>" class="card-link text-danger"><i class="fas fa-trash-alt"></i> Delete</a>
                            <% }%>
                            <!-- Like Button -->
                            <button class="btn btn-light like-btn" data-postid="<%= postID%>">
                                <i class="far fa-heart"></i> 
                            </button>
                        </div>

                    </div>
                </div>
                <%
                            if (imgRs != null) {
                                imgRs.close();
                            }
                            if (imgStmt != null) {
                                imgStmt.close();
                            }
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    } finally {
                        if (rs != null) try {
                            rs.close();
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                        if (pstmt != null) try {
                            pstmt.close();
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                        if (conn != null) try {
                            conn.close();
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                    }
                %>
            </div>
        </div>

        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            $(document).ready(function () {
                $('#searchInput').on('input', function () {
                    const query = $(this).val().toLowerCase();

                    // Filter posts based on title or content
                    $('.post-card').each(function () {
                        const title = $(this).data('title');
                        const content = $(this).data('content');

                        if (title.includes(query) || content.includes(query)) {
                            $(this).show();
                        } else {
                            $(this).hide();
                        }
                    });
                });
                $('.like-btn').on('click', function () {
                    const heartIcon = $(this).find('i');
                    heartIcon.toggleClass('far fa-heart fas fa-heart'); // Toggle between outlined and filled heart
                    if (heartIcon.hasClass('fas')) {
                        $(this).addClass('text-danger'); // Add color for liked state
                    } else {
                        $(this).removeClass('text-danger'); // Remove color for unliked state
                    }
                });
            });
        </script>
    </body>
</html>
