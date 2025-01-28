<%@page import="javax.servlet.http.Part"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.AddPosts"%>
<%@page import="java.util.List"%>
<%!
    public String isBlankNull(String str) {
        return (str == null || str.trim().isEmpty()) ? "" : str;
    }
%>
<%
    String strUserId = String.valueOf(session.getAttribute("UserId"));
    if ("".equals(isBlankNull(strUserId)) || "null".equalsIgnoreCase(strUserId)) {
        response.sendRedirect("Login");
        session.removeAttribute("UserId");
    } else {
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Add Post - Apex Hotels Blog</title>
        <link href="style/css/bootstrap.css" rel="stylesheet">
        
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
        <link href="style/css/bootstrap.css" rel="stylesheet" type="text/css"/>
        <link href="style/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <script src="js/JQuery.js" type="text/javascript"></script>
        <jsp:include page="../include/menu.jsp"/>
    </head>
    <body class="bg-light">
        <div class="container mt-5">
            <h2>Add New Post</h2>
            <form action="AddPostTo" method="post">
                <div class="form-group">
                    <label for="title">Post Title</label>
                    <input type="text" id="title" name="title" class="form-control" required>
                </div>
                <div class="form-group">
                    <label for="content">Post Content</label>
                    <textarea id="content" name="content" class="form-control" rows="5" required></textarea>
                </div>

                
                <button type="submit" class="btn btn-success mt-3">Add Post</button>
                <input type="hidden" id="hdnUserId" name="hdnUserId" value="<%=strUserId%>">
            </form>

        </div>
    </body>
</html>
<%}%>
