<jsp:useBean id="obj" class="com.AddPosts"/>
<jsp:setProperty property="*" name="obj"/>
<%
    if (obj.createPost()== null) {
        out.println("Success");
    } else {
        out.println(obj.createPost());
    }
    response.sendRedirect("Home");
%>
