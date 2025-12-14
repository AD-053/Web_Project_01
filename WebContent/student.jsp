<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.rahad.dao.logindao"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Dashboard</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css"/>

    <style>
        body {
            font-family: 'Poppins', sans-serif;
            min-height: 100vh;
            padding: 40px 0;
            color: #fff;
            /* Animated Gradient Background */
            background: linear-gradient(-45deg, #ee7752, #e73c7e, #23a6d5, #23d5ab);
            background-size: 400% 400%;
            animation: gradientBG 15s ease infinite;
        }

        @keyframes gradientBG {
            0% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
            100% { background-position: 0% 50%; }
        }

        /* Glass-Effect Dashboard Card */
        .dashboard-card {
            background: rgba(255, 255, 255, 0.15); /* Light translucent white */
            backdrop-filter: blur(10px);
            -webkit-backdrop-filter: blur(10px);
            border-radius: 15px;
            border: 1px solid rgba(255, 255, 255, 0.2);
            padding: 35px;
            box-shadow: 0 8px 30px rgba(0, 0, 0, 0.3);
            transition: transform 0.3s ease;
            max-width: 900px;
            margin: 0 auto;
        }
        
        .dashboard-card:hover {
             transform: translateY(-3px);
        }

        h2 {
            font-weight: 700;
            color: white; 
            text-shadow: 1px 1px 3px rgba(0,0,0,0.3);
            margin-bottom: 30px;
            font-size: 2.2rem;
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
            background-color: rgba(255, 255, 255, 0.9); /* Opaque background for readability */
            border-radius: 10px;
            overflow: hidden;
            margin-bottom: 30px;
        }
        
        .table th {
            background-color: #23a6d5; /* Blue accent from gradient */
            color: white;
            font-weight: 600;
            vertical-align: middle;
        }
        
        .table td {
            color: #333;
            vertical-align: middle;
        }

        .table-hover tbody tr:hover {
            background-color: #f0f0f0;
        }

        /* Enroll Button */
        .btn-enroll {
            background-color: #e73c7e; /* Pink accent from gradient */
            color: #fff;
            font-weight: 600;
            border: none;
            padding: 8px 18px;
            border-radius: 50px; /* Fully rounded */
            transition: all 0.3s;
            box-shadow: 0 4px 10px rgba(231, 60, 126, 0.4);
            text-transform: uppercase;
            font-size: 0.85rem;
        }
        .btn-enroll:hover {
            background-color: #cc0066;
            transform: scale(1.05);
        }

        /* Logout Button */
        .btn-logout {
            background: rgba(255, 77, 77, 0.8);
            border: 1px solid rgba(255, 255, 255, 0.3);
            color: white;
            padding: 8px 25px;
            border-radius: 50px;
            transition: all 0.3s;
            font-weight: 600;
        }
        .btn-logout:hover {
            background: #cc0000;
            transform: scale(1.05);
            box-shadow: 0 0 10px rgba(255, 0, 0, 0.5);
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
      if(!dao.check(username,pass,"student")){
    	  response.sendRedirect("login.jsp");
      }
  %>

    <div class="container animate__animated animate__fadeIn">
        <div class="dashboard-card">
            
            <h2 class="text-center">
                <i class="fas fa-user-graduate me-2"></i> Welcome, ${sessionScope.username}
            </h2>

            <h3 class="mt-4"><i class="fas fa-certificate me-2"></i> My Registered Courses</h3>
            <div class="table-responsive">
                <table class="table table-striped table-hover shadow-sm">
                    <thead>
                        <tr>
                            <th scope="col">Course Name</th>
                            <th scope="col">Course Code</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            ArrayList<String[]> registered = (ArrayList<String[]>) request.getAttribute("registeredCourses");
                            if (registered != null && !registered.isEmpty()) {
                                for (String[] row : registered) {
                        %>
                        <tr>
                            <td><%= row[0] %></td>
                            <td><span class="badge bg-primary"><%= row[1] %></span></td>
                        </tr>
                        <% 
                                }
                            } else { 
                        %>
                        <tr><td colspan="2" class="text-center text-muted">No courses registered yet. Start enrolling below!</td></tr>
                        <% } %>
                    </tbody>
                </table>
            </div>

            <h3 class="mt-4"><i class="fas fa-list-alt me-2"></i> Available Courses for Enrollment</h3>
            <div class="table-responsive">
                <table class="table table-bordered table-hover shadow-sm">
                    <thead>
                        <tr>
                            <th scope="col">Course Name</th>
                            <th scope="col">Course Code</th>
                            <th scope="col" class="text-center">Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            ArrayList<String[]> available = (ArrayList<String[]>) request.getAttribute("availableCourses");
                            if (available != null && !available.isEmpty()) {
                                for (String[] row : available) {
                        %>
                        <tr>
                            <td><%= row[0] %></td>
                            <td><span class="badge bg-secondary"><%= row[1] %></span></td>
                            <td class="text-center">
                                <form action="enroll" method="post">
                                    <input type="hidden" name="course_code" value="<%= row[1] %>">
                                    <button type="submit" class="btn-enroll">
                                        <i class="fas fa-user-plus me-1"></i> Enroll Now
                                    </button>
                                </form>
                            </td>
                        </tr>
                        <% 
                                }
                            } else { 
                        %>
                        <tr><td colspan="3" class="text-center text-muted">Congratulations! You are registered for all available courses.</td></tr>
                        <% } %>
                    </tbody>
                </table>
            </div>

            <form action="logout" method="post" class="text-center mt-5">
                <button type="submit" class="btn-logout">
                    <i class="fas fa-sign-out-alt me-2"></i> Secure Logout
                </button>
            </form>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>