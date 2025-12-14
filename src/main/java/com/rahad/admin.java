package com.rahad;

import java.io.IOException;
import java.sql.*;
import java.net.URLEncoder; // Required for safely encoding URL parameters
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/admin")
public class admin extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    // Database connection details
    private static final String DB_URL = "jdbc:mysql://localhost:3306/project";
    private static final String DB_USER = "root";
    private static final String DB_PASS = "sust53";

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        String status = "error";
        String message = "An unknown error occurred.";
        
        Connection con = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);

            if ("addCourse".equals(action)) {
                // --- 1. Add Course Logic ---
                String courseName = request.getParameter("course_name");
                String courseCode = request.getParameter("course_code");
                
                // Check if course code already exists (Prevent Duplicate)
                if (isCourseCodeExists(con, courseCode)) {
                    message = "Course Code '" + courseCode + "' already exists. Please use a unique code.";
                } else {
                    String insertQuery = "INSERT INTO course_data (course_name, course_code, student_list, teacher_list) VALUES (?, ?, JSON_ARRAY(), JSON_ARRAY())";
                    PreparedStatement pst = con.prepareStatement(insertQuery);
                    pst.setString(1, courseName);
                    pst.setString(2, courseCode);
                    
                    int rowsAffected = pst.executeUpdate();

                    if (rowsAffected > 0) {
                        status = "success";
                        message = "Course '" + courseName + " (" + courseCode + ")' added successfully!";
                    } else {
                        message = "Failed to insert course data into the database.";
                    }
                }

            } else if ("assignTeacher".equals(action)) {
                // --- 2. Assign Teacher Logic ---
                String courseName = request.getParameter("course_name");
                String teacherUsername = request.getParameter("teacher_name");
                String courseCode = null;
                boolean teacherAssigned = false;

                // Step 1: Get Course Code
                String getCodeQuery = "SELECT course_code, JSON_CONTAINS(teacher_list, '\"" + teacherUsername + "\"') AS assigned FROM course_data WHERE course_name = ?";
                PreparedStatement getCodeStmt = con.prepareStatement(getCodeQuery);
                getCodeStmt.setString(1, courseName);
                ResultSet rs = getCodeStmt.executeQuery();

                if (rs.next()) {
                    courseCode = rs.getString("course_code");
                    int alreadyAssigned = rs.getInt("assigned");

                    if (alreadyAssigned == 1) {
                        // Teacher is already assigned
                        message = "Teacher '" + teacherUsername + "' is already assigned to course '" + courseName + "'.";
                    } else {
                        // Step 2: Assign Teacher (Append to JSON array)
                        String updateQuery = "UPDATE course_data SET teacher_list = JSON_ARRAY_APPEND(teacher_list, '$', ?) WHERE course_code = ?";
                        PreparedStatement updateStmt = con.prepareStatement(updateQuery);
                        updateStmt.setString(1, teacherUsername);
                        updateStmt.setString(2, courseCode);
                        
                        int rowsAffected = updateStmt.executeUpdate();

                        if (rowsAffected > 0) {
                            status = "success";
                            message = "Teacher '" + teacherUsername + "' successfully assigned to course '" + courseName + "'.";
                            teacherAssigned = true;
                        } else {
                            message = "Failed to update course data for teacher assignment.";
                        }
                    }
                } else {
                    message = "Error: Course '" + courseName + "' not found.";
                }
                
                // Check if the teacher exists (Optional but highly recommended)
                if (!teacherAssigned && !isUserExists(con, teacherUsername, "teacher")) {
                    message = "Error: Teacher username '" + teacherUsername + "' not found in signup data.";
                }

            } else if ("removeCourse".equals(action)) {
                // --- 3. Remove Course Logic ---
                String courseName = request.getParameter("course_name");
                
                String deleteQuery = "DELETE FROM course_data WHERE course_name = ?";
                PreparedStatement deleteStmt = con.prepareStatement(deleteQuery);
                deleteStmt.setString(1, courseName);
                int rowsAffected = deleteStmt.executeUpdate();

                if (rowsAffected > 0) {
                    status = "success";
                    message = "Course '" + courseName + "' and all its enrollment data removed successfully!";
                } else {
                    message = "Course '" + courseName + "' not found or could not be removed.";
                }
            } else {
                 status = "error";
                 message = "Invalid action specified.";
            }

        } catch (ClassNotFoundException e) {
            status = "error";
            message = "Database Driver not found. Contact Admin.";
            e.printStackTrace();
        } catch (SQLException e) {
            status = "error";
            message = "Database Error: " + e.getMessage();
            e.printStackTrace();
        } catch (Exception e) {
            status = "error";
            message = "Server Error: " + e.getMessage();
            e.printStackTrace();
        } finally {
            if (con != null) {
                try {
                    con.close();
                } catch (SQLException ignore) {}
            }
        }
        
        // --- Redirection to trigger alert on admin.jsp ---
        // URL-encode the message to safely pass it via the URL
        String encodedMessage = URLEncoder.encode(message, "UTF-8");
        response.sendRedirect("admin.jsp?status=" + status + "&message=" + encodedMessage);
    }
    
    // Helper method to check if a course code already exists
    private boolean isCourseCodeExists(Connection con, String courseCode) throws SQLException {
        String query = "SELECT COUNT(*) FROM course_data WHERE course_code = ?";
        try (PreparedStatement pst = con.prepareStatement(query)) {
            pst.setString(1, courseCode);
            try (ResultSet rs = pst.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        }
        return false;
    }
    
    // Helper method to check if a user (teacher) exists
    private boolean isUserExists(Connection con, String username, String role) throws SQLException {
        String query = "SELECT COUNT(*) FROM signup_data WHERE username = ? AND role = ?";
        try (PreparedStatement pst = con.prepareStatement(query)) {
            pst.setString(1, username);
            pst.setString(2, role);
            try (ResultSet rs = pst.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        }
        return false;
    }
}
