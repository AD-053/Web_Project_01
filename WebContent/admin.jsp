<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.rahad.dao.logindao"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css"/>

    <style>
        body {
            font-family: 'Poppins', sans-serif;
            min-height: 100vh;
            padding: 30px;
            color: #fff;
            background: #0A3D62;
            animation: gradientBG 15s ease infinite;
        }

        @keyframes gradientBG {
            0% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
            100% { background-position: 0% 50%; }
        }

        /* Glass-Effect Dashboard Cards */
        .dashboard-card {
            background: rgba(255, 255, 255, 0.15);
            backdrop-filter: blur(10px);
            -webkit-backdrop-filter: blur(10px);
            border-radius: 15px;
            border: 1px solid rgba(255, 255, 255, 0.2);
            padding: 25px;
            margin-bottom: 30px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.3);
            transition: transform 0.3s ease;
        }
        
        .dashboard-card:hover {
            transform: translateY(-5px);
        }

        h2, h3 {
            font-weight: 700;
            color: white; 
            text-shadow: 1px 1px 3px rgba(0,0,0,0.3);
            margin-bottom: 20px;
        }
        
        h3 {
            font-size: 1.5rem;
            color: #ffcc00; /* Use a highlight color for section titles */
        }

        /* Form Labels & Controls */
        .form-label {
            font-weight: 600;
            font-size: 0.9rem;
            color: rgba(255, 255, 255, 0.9);
        }

        /* Input Fields, including select */
        .form-control, .form-select {
            background: rgba(255, 255, 255, 0.2);
            border: none;
            border-radius: 8px;
            padding: 10px 15px;
            color: #fff;
            transition: background 0.3s;
            /* Ensure text is white and dropdown arrow is visible */
            -webkit-appearance: none;
            -moz-appearance: none;
            appearance: none;
            background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 16 16'%3e%3cpath fill='none' stroke='%23ffffff' stroke-linecap='round' stroke-linejoin='round' stroke-width='2' d='M2 5l6 6 6-6'/%3e%3c/svg%3e");
            background-repeat: no-repeat;
            background-position: right 0.75rem center;
            background-size: 16px 12px;
        }

        .form-control:focus, .form-select:focus {
            background: rgba(255, 255, 255, 0.3);
            box-shadow: 0 0 8px rgba(255, 255, 255, 0.5);
            color: #fff;
        }
        
        /* Options in dropdowns need a visible background */
        .form-select option {
            background-color: #0A3D62; /* Dark background for options */
            color: white;
        }

        /* Submit Button (Primary Action) */
        .btn-custom {
            background-color: #ffcc00; /* Yellow/Gold accent color */
            color: #333;
            font-weight: 700;
            border: none;
            border-radius: 8px;
            padding: 10px 20px;
            transition: all 0.3s;
            text-transform: uppercase;
            letter-spacing: 1px;
        }
        .btn-custom:hover {
            background-color: #e6b800;
            transform: translateY(-2px);
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.3);
            color: #333; 
        }

        /* Logout Button */
        .logout-btn {
            position: absolute;
            top: 25px;
            right: 35px;
            background: rgba(255, 77, 77, 0.8);
            backdrop-filter: blur(5px);
            border: 1px solid rgba(255, 255, 255, 0.3);
            color: white;
            border-radius: 8px;
            padding: 8px 15px;
            font-size: 14px;
            transition: all 0.3s;
            font-weight: 600;
        }
        .logout-btn:hover {
            background: #cc0000;
            transform: scale(1.05);
            box-shadow: 0 0 10px rgba(255, 0, 0, 0.5);
        }

        /* --- NEW: Colorful Glass Alerts --- */
        .alert-glass {
            font-weight: 600;
            border-radius: 12px;
            padding: 15px 25px;
            margin-bottom: 30px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
            backdrop-filter: blur(5px);
            -webkit-backdrop-filter: blur(5px);
            border: 1px solid rgba(255, 255, 255, 0.2);
        }

        /* Success Alert (Teal/Blue) */
        .alert-success-glass {
            background-color: rgba(35, 213, 171, 0.7); 
            color: #0d3b23; /* Dark green for contrast */
        }

        /* Error Alert (Pink/Red) */
        .alert-danger-glass {
            background-color: rgba(231, 60, 126, 0.7); 
            color: #5c182a; /* Dark pink/red for contrast */
        }
    </style>
</head>
<body>

  
  <%
      // --- JSP Authentication Check (Keep Original Logic) ---
      response.setHeader("Cache-Control","no-cache,no-store,must-revalidate");
      String username = (String) session.getAttribute("username");
      String pass = (String) session.getAttribute("pass");
      
      logindao dao= new logindao();
      if(!dao.check(username,pass,"admin")){
    	  response.sendRedirect("login.jsp");
      }
      // --------------------------------------------------------
  %>
    <form action="logout" method="post">
        <button type="submit" class="logout-btn">
            <i class="fas fa-sign-out-alt me-1"></i> Logout
        </button>
    </form>

    <div class="container">
        <h2 class="text-center mb-5 mt-3">
            <i class="fas fa-tools me-2"></i> Administrator Control Panel
        </h2>

        <%
            // --- ALERT RENDERING LOGIC ---
            // Checks for URL parameters: ?status=success&message=...
            String status = request.getParameter("status");
            String message = request.getParameter("message");
            
            if ("success".equals(status) && message != null) {
        %>
            <div class="alert-glass alert-success-glass animate__animated animate__fadeInDown">
                <i class="fas fa-check-circle me-2"></i> 
                Success! <%= message.trim() %>
            </div>
        <%
            } else if ("error".equals(status) && message != null) {
        %>
            <div class="alert-glass alert-danger-glass animate__animated animate__shakeX">
                <i class="fas fa-exclamation-triangle me-2"></i> 
                Error: <%= message.trim() %>
            </div>
        <% } %>
        <div class="row justify-content-center">
            
            <div class="col-lg-6 col-md-10">
                <div class="dashboard-card">
                    <h3><i class="fas fa-plus-square me-2"></i> Add New Course</h3>
                    <form action="admin" method="get">
                        <input type="hidden" name="action" value="addCourse">
                        <div class="mb-3">
                            <label class="form-label">Course Name</label>
                            <input type="text" name="course_name" class="form-control" placeholder="e.g., Data Structures" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Course Code</label>
                            <input type="text" name="course_code" class="form-control" placeholder="e.g., CS401" required>
                        </div>
                        <button type="submit" class="btn-custom w-100">
                            <i class="fas fa-book-medical me-1"></i> Add Course
                        </button>
                    </form>
                </div>
            </div>

            <div class="col-lg-6 col-md-10">
                <div class="dashboard-card">
                    <h3><i class="fas fa-link me-2"></i> Assign Teacher to Course</h3>
                    <form action="admin" method="get">
                        <input type="hidden" name="action" value="assignTeacher">

                        <div class="mb-3">
                            <label class="form-label">Course Name</label>
                            <select name="course_name" class="form-select" required>
                                <option value="" disabled selected>Select a Course</option>
                                <%
                                    // --- JSP/JDBC for Course List ---
                                    Connection con_course = null;
                                    Statement st_course = null;
                                    ResultSet rs_course = null;
                                    try {
                                        Class.forName("com.mysql.cj.jdbc.Driver");
                                        con_course = DriverManager.getConnection("jdbc:mysql://localhost:3306/project", "root", "sust53");
                                        st_course = con_course.createStatement();
                                        rs_course = st_course.executeQuery("SELECT course_name FROM course_data ORDER BY course_name");
                                        while (rs_course.next()) {
                                %>
                                    <option value="<%= rs_course.getString("course_name") %>"><%= rs_course.getString("course_name") %></option>
                                <%
                                        }
                                    } catch (Exception e) {
                                        // e.printStackTrace(); 
                                    } finally {
                                        if (rs_course != null) try { rs_course.close(); } catch (SQLException ignore) {}
                                        if (st_course != null) try { st_course.close(); } catch (SQLException ignore) {}
                                        if (con_course != null) try { con_course.close(); } catch (SQLException ignore) {}
                                    }
                                %>
                            </select>
                            <datalist id="courseList">
                                <%
                                    // --- JSP/JDBC for Course List (Keep Original Logic) ---
                                    Connection con = null;
                                    Statement st = null;
                                    ResultSet rs = null;
                                    try {
                                        Class.forName("com.mysql.cj.jdbc.Driver");
                                        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/project", "root", "sust53");
                                        st = con.createStatement();
                                        rs = st.executeQuery("SELECT course_name FROM course_data");
                                        while (rs.next()) {
                                %>
                                    <option value="<%= rs.getString("course_name") %>">
                                <%
                                        }
                                    } catch (Exception e) {
                                        // e.printStackTrace(); // Keep this for debugging if needed
                                    } finally {
                                        if (con != null) try { con.close(); } catch (SQLException ignore) {}
                                    }
                                    // --------------------------------------------------------
                                %>
                            </datalist>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Teacher Username</label>
                            <select name="teacher_name" class="form-select" required>
                                <option value="" disabled selected>Select a Teacher</option>
                                <%
                                    // --- JSP/JDBC for Teacher List ---
                                    Connection con_teacher = null;
                                    Statement st_teacher = null;
                                    ResultSet rs_teacher = null;
                                    try {
                                        Class.forName("com.mysql.cj.jdbc.Driver");
                                        con_teacher = DriverManager.getConnection("jdbc:mysql://localhost:3306/project", "root", "sust53");
                                        st_teacher = con_teacher.createStatement();
                                        rs_teacher = st_teacher.executeQuery("SELECT username FROM signup_data WHERE role = 'teacher' ORDER BY username");
                                        while (rs_teacher.next()) {
                                %>
                                    <option value="<%= rs_teacher.getString("username") %>"><%= rs_teacher.getString("username") %></option>
                                <%
                                        }
                                    } catch (Exception e) {
                                        // e.printStackTrace(); 
                                    } finally {
                                        if (rs_teacher != null) try { rs_teacher.close(); } catch (SQLException ignore) {}
                                        if (st_teacher != null) try { st_teacher.close(); } catch (SQLException ignore) {}
                                        if (con_teacher != null) try { con_teacher.close(); } catch (SQLException ignore) {}
                                    }
                                %>
                            </select>
                            <datalist id="teacherList">
                                <%
                                    // --- JSP/JDBC for Teacher List (Keep Original Logic) ---
                                    con = null;
                                    st = null;
                                    rs = null;
                                    try {
                                        Class.forName("com.mysql.cj.jdbc.Driver");
                                        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/project", "root", "sust53");
                                        st = con.createStatement();
                                        rs = st.executeQuery("SELECT username FROM signup_data WHERE role = 'teacher'");
                                        while (rs.next()) {
                                %>
                                    <option value="<%= rs.getString("username") %>">
                                <%
                                        }
                                    } catch (Exception e) {
                                        // e.printStackTrace(); // Keep this for debugging if needed
                                    } finally {
                                        // Re-closing connection and resources
                                        if (con != null) try { con.close(); } catch (SQLException ignore) {}
                                    }
                                    // --------------------------------------------------------
                                %>
                            </datalist>
                        </div>

                        <button type="submit" class="btn-custom w-100">
                            <i class="fas fa-user-tie me-1"></i> Assign Teacher
                        </button>
                    </form>
                </div>
            </div>

            <div class="col-lg-6 col-md-10">
                <div class="dashboard-card bg-danger bg-opacity-25" style="border-color: rgba(255, 99, 71, 0.5);">
                    <h3><i class="fas fa-trash-alt me-2"></i> Remove Course (Admin Action)</h3>
                    <form action="admin" method="get">
                        <input type="hidden" name="action" value="removeCourse">
                        <div class="mb-3">
                            <label class="form-label">Select Course to Remove</label>
                            
                            <%-- *** FIX: Changed to <select> for a true, stylish dropdown *** --%>
                            <select name="course_name" class="form-select" required>
                                <option value="" disabled selected>Select Course to Delete</option>
                                <%
                                    // --- JSP/JDBC for Course List for REMOVAL ---
                                    Connection con_remove = null;
                                    Statement st_remove = null;
                                    ResultSet rs_remove = null;
                                    try {
                                        Class.forName("com.mysql.cj.jdbc.Driver");
                                        // Note: Using a fresh connection object to avoid resource collision
                                        con_remove = DriverManager.getConnection("jdbc:mysql://localhost:3306/project", "root", "sust53"); 
                                        st_remove = con_remove.createStatement();
                                        rs_remove = st_remove.executeQuery("SELECT course_name FROM course_data ORDER BY course_name");
                                        while (rs_remove.next()) {
                                %>
                                    <option value="<%= rs_remove.getString("course_name") %>"><%= rs_remove.getString("course_name") %></option>
                                <%
                                        }
                                    } catch (Exception e) {
                                        // e.printStackTrace(); 
                                    } finally {
                                        if (rs_remove != null) try { rs_remove.close(); } catch (SQLException ignore) {}
                                        if (st_remove != null) try { st_remove.close(); } catch (SQLException ignore) {}
                                        if (con_remove != null) try { con_remove.close(); } catch (SQLException ignore) {}
                                    }
                                %>
                            </select>
                            <%-- *** END FIX *** --%>

                        </div>
                        <button type="submit" class="btn btn-danger w-100 fw-bold">
                            <i class="fas fa-minus-circle me-1"></i> Remove Course Permanently
                        </button>
                    </form>
                </div>
            </div>
            
        </div> </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
