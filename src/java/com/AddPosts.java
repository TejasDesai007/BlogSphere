package com;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import javax.servlet.http.Part;

public class AddPosts {

    private int userID, hdnUserId;
    private String title, content;
    // List to store image parts from the request

    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public int getHdnUserId() {
        return hdnUserId;
    }

    public void setHdnUserId(int hdnUserId) {
        this.hdnUserId = hdnUserId;
    }

  
    // Utility method to handle null or blank strings
    public String isBlankNull(String str) {
        return (str == null || str.trim().isEmpty()) ? "" : str;
    }

    // Method to create a new post along with associated images
    public Exception createPost() throws SQLException, IOException {
        Exception ex = null;
        Connection con = null;
        PreparedStatement pstmt = null;
        MysqlConnect dbc;
        int postID = -1;  // To store the generated PostID

        try {
            dbc = new MysqlConnect();
            con = dbc.getConnection();

            // Insert new post into the Posts table
            pstmt = con.prepareStatement("INSERT INTO Posts (UserID, Title, Content, PublishedAt, IsPublished) VALUES (?, ?, ?, NOW(), TRUE)", PreparedStatement.RETURN_GENERATED_KEYS);
            pstmt.setInt(1, hdnUserId);
            pstmt.setString(2, title);
            pstmt.setString(3, content);
            pstmt.executeUpdate();

      

            pstmt.close();
        } catch (Exception e) {
            e.printStackTrace();
            ex = e;  // Catching the exception to return
        } finally {
            if (con != null) {
                con.close();  // Closing the connection
            }
        }

        return ex;  // Returning any exceptions that may have occurred
    }

    // Helper method to extract the file name from the Part object
    
}
