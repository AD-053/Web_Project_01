<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.rahad.dao.logindao"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Teacher Dashboard</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700&display=swap" rel="stylesheet">

    <style>
        body {
            font-family: 'Poppins', sans-serif;
            min-height: 100vh;
            padding: 40px 0;
            color: #fff;
            /* Pink/Purple Animated Gradient Background */
            background: linear-gradient(-45deg, #e73c7e, #ff7eb3, #6a11cb, #a854d9);
            background-size: 400% 400%;
            animation: gradientBG 15s ease infinite;
            padding-top: 80px;
        }

        @keyframes gradientBG {
            0% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
            100% { background-position: 0% 50%; }
        }

        /* Fixed Navbar using Glassmorphism style */
        .navbar-custom {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            -webkit-backdrop-filter: blur(10px);
            box-shadow: 0px 4px 15px rgba(0, 0, 0, 0.3);
            border-bottom: 1px solid rgba(255, 255, 255, 0.2);
            padding: 12px 0;
        }
        .navbar-custom .navbar-brand {
            color: white;
            font-weight: 700;
            font-size: 1.5rem;
            letter-spacing: 1px;
            text-shadow: 0 1px 3px rgba(0,0,0,0.3);
        }
        
        /* Glass-Effect Dashboard Card */
        .dashboard-card {
            background: rgba(255, 255, 255, 0.15);
            backdrop-filter: blur(10px);
            -webkit-backdrop-filter: blur(10px);
            border-radius: 15px;
            border: 1px solid rgba(255, 255, 255, 0.2);
            padding: 35px;
            box-shadow: 0 8px 30px rgba(0, 0, 0, 0.3);
            max-width: 900px;
            margin: 0 auto 30px;
        }

        h2 {
            font-weight: 700;
            color: white; 
            text-shadow: 1px 1px 3px rgba(0,0,0,0.3);
            margin-bottom: 30px;
            font-size: 2rem;
        }

        h3 {
            font-weight: 600;
            color: #ffcc00; /* Yellow/Gold highlight */
            margin-bottom: 15px;
            border-bottom: 2px solid rgba(255, 255, 255, 0.3);
            padding-bottom: 8px;
            font-size: 1.5rem;
        }

        /* Table Styling */
        .table {
            background-color: rgba(255, 255, 255, 0.95); /* Near opaque white for clear reading */
            border-radius: 10px;
            overflow: hidden;
            margin-bottom: 30px;
        }
        
        .table th {
            background-color: #e73c7e; /* Pink accent color */
            color: white;
            font-weight: 600;
            text-align: left;
        }
        
        .table td {
            color: #333;
            vertical-align: middle;
        }
        
        .table-hover tbody tr:hover {
            background-color: #f0f0f0;
        }
        
        /* View Students Button */
        .btn-view {
            background-color: #6a11cb; /* Deep purple */
            color: #fff;
            border: none;
            padding: 8px 18px;
            border-radius: 50px;
            transition: all 0.3s;
            font-weight: 600;
            text-transform: uppercase;
            font-size: 0.85rem;
        }
        .btn-view:hover {
            background-color: #5a0fb8;
            transform: scale(1.05);
        }

        /* Logout Button */
        .btn-logout {
            background: white;
            color: #e73c7e; /* Pink/Magenta */
            border: none;
            font-weight: 700;
            padding: 8px 18px;
            border-radius: 50px;
            transition: 0.3s;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
        }
        .btn-logout:hover {
            background: #f0f0f0;
            color: #d62f6d;
        }
        
        /* Student List Display */
        .student-list-box {
            background: rgba(255, 255, 255, 0.2);
            padding: 20px;
            border-radius: 10px;
            border: 1px solid rgba(255, 255, 255, 0.3);
            margin-top: 20px;
        }
        
        .student-list-box ul {
            list-style-type: none;
            padding-left: 0;
            columns: 2; /* Display names in two columns */
        }
        
        .student-list-box ul li {
            background: rgba(255, 255, 255, 0.9);
            color: #333;
            margin: 8px 0;
            padding: 10px 15px;
            border-radius: 8px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            font-weight: 500;
            break-inside: avoid;
        }

        .btn-close-list {
            background: #ffcc00;
            color: #333;
            border: none;
            padding: 5px 12px;
            border-radius: 50px;
            float: right;
            font-size: 0.8rem;
            font-weight: 600;
            transition: 0.3s;
        }
        .btn-close-list:hover {
            background: #e6b800;
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
      if(!dao.check(username,pass,"teacher")){
    	  response.sendRedirect("login.jsp");
      }
      // --------------------------------------------------------
  %>
    <nav class="navbar navbar-custom fixed-top">
        <div class="container">
            <span class="navbar-brand"><i class="fas fa-chalkboard-teacher me-2"></i> Teacher Control Panel</span>
            <form action="logout" method="post" class="d-inline">
                <button type="submit" class="btn-logout">
                    <i class="fas fa-sign-out-alt me-1"></i> Logout
                </button>
            </form>
        </div>
    </nav>

    <div class="container">
        <div class="dashboard-card animate__animated animate__fadeInUp">
            
            <h2 class="text-center">Welcome, ${sessionScope.username}</h2>

            <h3><i class="fas fa-book-open me-2"></i> Your Assigned Courses</h3>
            <div class="table-responsive">
                <table class="table table-striped table-hover shadow-sm">
                    <thead>
                        <tr>
                            <th scope="col">Course Name</th>
                            <th scope="col">Course Code</th>
                            <th scope="col" class="text-center">Student Roster</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            ArrayList<String[]> courses = (ArrayList<String[]>) request.getAttribute("teacherCourses");
                            if (courses != null && !courses.isEmpty()) {
                                for (String[] row : courses) {
                        %>
                        <tr>
                            <td><%= row[0] %></td>
                            <td><span class="badge bg-primary"><%= row[1] %></span></td>
                            <td class="text-center">
                                <form action="teacher" method="get">
                                    <input type="hidden" name="course_code" value="<%= row[1] %>">
                                    <button type="submit" class="btn-view">
                                        <i class="fas fa-users me-1"></i> View Students
                                    </button>
                                </form>
                            </td>
                        </tr>
                        <% 
                                }
                            } else {
                        %>
                        <tr>
                            <td colspan="3" class="text-center text-muted">No courses currently assigned to you.</td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>

            <%
                String selectedCode = (String) request.getAttribute("selectedCourseCode");
                ArrayList<String> students = (ArrayList<String>) request.getAttribute("enrolledStudents");
                
                if (selectedCode != null) {
            %>
            <div class="mt-4">
                <h3>
                    <i class="fas fa-user-check me-2"></i> Students Enrolled in: <%= selectedCode %>
                    <a href="teacher" class="btn-close-list"><i class="fas fa-times me-1"></i> Close View</a>
                </h3>
                
                <div class="student-list-box">
                    <% if (students != null && !students.isEmpty()) { %>
                        <ul>
                            <% for (String student : students) { %>
                                <li><%= student.trim() %></li>
                            <% } %>
                        </ul>
                    <% } else { %>
                        <p class="text-muted text-center py-3">No students enrolled in this course yet.</p>
                    <% } %>
                </div>
            </div>
            <% } %>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>