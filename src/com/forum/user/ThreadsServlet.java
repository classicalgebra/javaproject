package com.forum.user;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/threads")
public class ThreadsServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            Connection conn = com.forum.database.Database.getConnection();
            String sql = "SELECT title, content FROM threads";
            PreparedStatement stmt = conn.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();

            StringBuilder threadsHtml = new StringBuilder("<html><body>");
            while (rs.next()) {
                threadsHtml.append("<h3>").append(rs.getString("title")).append("</h3>");
                threadsHtml.append("<p>").append(rs.getString("content")).append("</p>");
            }
            threadsHtml.append("</body></html>");

            response.getWriter().write(threadsHtml.toString());
        } catch (Exception e) {
            response.getWriter().write("Error: " + e.getMessage());
        }
    }
}
