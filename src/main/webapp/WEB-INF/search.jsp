<%@ page import="java.sql.*, java.util.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Search Results</title>
</head>
<body>
    <h2>Search Results for: ${param.query}</h2>
    <%
        String searchTerm = request.getParameter("query");
        String jdbcUrl = "jdbc:postgresql://localhost:5432/amazon_search";
        String jdbcUser = "postgres";
        String jdbcPass = "1234";
        try {
            Class.forName("org.postgresql.Driver");
            Connection conn = DriverManager.getConnection(jdbcUrl, jdbcUser, jdbcPass);
            String sql = "SELECT * FROM products WHERE name ILIKE ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, "%" + searchTerm + "%");
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                String productName = rs.getString("name");
                String productDesc = rs.getString("description");
                out.println("<p><b>" + productName + "</b><br>" + productDesc + "</p>");
            }
            rs.close();
            stmt.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace(out);
        }
    %>
</body>
</html>
