<%@ page import="java.sql.Connection, java.sql.PreparedStatement, java.sql.ResultSet" %>
<%@ page import="com.forum.database.Database" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Forum Threads</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 20px;
            background-color: #f4f4f9;
        }
        h1 {
            text-align: center;
            color: #333;
        }
        .thread {
            margin-bottom: 20px;
            padding: 15px;
            border: 1px solid #ddd;
            border-radius: 5px;
            background-color: #fff;
        }
        .thread h3 {
            margin: 0;
            color: #007BFF;
        }
        .thread p {
            margin: 5px 0 0;
            color: #555;
        }
    </style>
</head>
<body>
    <h1>Forum Threads</h1>
    <div>
        <%
            Connection conn = null;
            PreparedStatement stmt = null;
            ResultSet rs = null;

            try {
                // Establish connection to the database
                conn = Database.getConnection();

                // SQL query to fetch threads
                String sql = "SELECT title, content FROM threads";
                stmt = conn.prepareStatement(sql);

                // Execute the query
                rs = stmt.executeQuery();

                // Iterate through the result set and display threads
                while (rs.next()) {
        %>
                    <div class="thread">
                        <h3><%= rs.getString("title") %></h3>
                        <p><%= rs.getString("content") %></p>
                    </div>
        <%
                }
            } catch (Exception e) {
                // Display error if something goes wrong
                out.println("<p style='color:red;'>An error occurred: " + e.getMessage() + "</p>");
            } finally {
                // Close resources to prevent memory leaks
                if (rs != null) try { rs.close(); } catch (Exception e) {}
                if (stmt != null) try { stmt.close(); } catch (Exception e) {}
                if (conn != null) try { conn.close(); } catch (Exception e) {}
            }
        %>
    </div>
</body>
</html>
