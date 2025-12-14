<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign Up - Course Management</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css"/>

    <style>
        body {
            font-family: 'Poppins', sans-serif;
            min-height: 100vh; /* Changed to min-height for scrolling on smaller screens */
            margin: 0;
            /* Animated Gradient Background */
            background: linear-gradient(-45deg, #ee7752, #e73c7e, #23a6d5, #23d5ab);
            background-size: 400% 400%;
            animation: gradientBG 15s ease infinite;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 40px 0; /* Add padding for vertical spacing */
        }

        @keyframes gradientBG {
            0% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
            100% { background-position: 0% 50%; }
        }

        /* Glassmorphism Card */
        .glass-card {
            background: rgba(255, 255, 255, 0.15);
            box-shadow: 0 8px 32px 0 rgba(31, 38, 135, 0.37);
            backdrop-filter: blur(12px);
            -webkit-backdrop-filter: blur(12px);
            border-radius: 20px;
            border: 1px solid rgba(255, 255, 255, 0.18);
            padding: 40px;
            width: 100%;
            max-width: 500px; /* Slightly wider than login for more content */
            color: white;
            position: relative;
        }

        h3 {
            font-weight: 700;
            margin-bottom: 25px;
            text-align: center;
            letter-spacing: 1px;
            text-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        /* Form Controls */
        .form-label {
            font-weight: 600;
            font-size: 0.9rem;
            margin-left: 5px;
            margin-bottom: 5px;
        }

        .form-control {
            background: rgba(255, 255, 255, 0.2);
            border: none;
            border-radius: 50px;
            padding: 10px 20px;
            color: #fff;
            backdrop-filter: blur(5px);
        }

        .form-control::placeholder {
            color: rgba(255, 255, 255, 0.7);
            font-size: 0.9rem;
        }

        .form-control:focus {
            background: rgba(255, 255, 255, 0.3);
            box-shadow: 0 0 10px rgba(255, 255, 255, 0.2);
            color: #fff;
            outline: none;
        }

        /* Radio Group Styling */
        .radio-group-container {
            background: rgba(0, 0, 0, 0.1);
            padding: 10px 15px;
            border-radius: 15px;
            margin-bottom: 15px;
            display: flex;
            align-items: center;
            gap: 20px;
        }

        .form-check-input {
            cursor: pointer;
            background-color: rgba(255,255,255,0.5);
            border: none;
        }
        
        .form-check-input:checked {
            background-color: #e73c7e;
            border-color: #e73c7e;
        }

        .form-check-label {
            cursor: pointer;
            font-size: 0.9rem;
        }

        /* Button Styling */
        .btn-custom {
            width: 100%;
            padding: 12px;
            border-radius: 50px;
            background: #fff;
            color: #e73c7e;
            font-weight: bold;
            border: none;
            text-transform: uppercase;
            letter-spacing: 1px;
            transition: all 0.3s ease;
            margin-top: 10px;
        }

        .btn-custom:hover {
            background: #f0f0f0;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
            color: #d62f6d;
        }

        /* Error Message Box */
        .alert-custom {
            background: rgba(220, 53, 69, 0.8);
            color: white;
            border: none;
            border-radius: 10px;
            font-size: 0.9rem;
            text-align: center;
            backdrop-filter: blur(5px);
            margin-bottom: 20px;
            padding: 10px;
        }

        /* Links */
        .login-link {
            text-align: center;
            margin-top: 20px;
            font-size: 0.9rem;
        }
        .login-link a {
            color: #fff;
            text-decoration: none;
            font-weight: 600;
            border-bottom: 1px dashed rgba(255,255,255,0.5);
        }
        .login-link a:hover {
            color: #fff;
            border-bottom: 1px solid #fff;
        }

        /* Back Button */
        .btn-back {
            position: absolute;
            top: 20px;
            left: 20px;
            color: white;
            font-size: 1.2rem;
            opacity: 0.7;
            transition: 0.3s;
        }
        .btn-back:hover {
            opacity: 1;
            transform: scale(1.1);
        }
    </style>
</head>
<body>

<div class="glass-card animate__animated animate__fadeInDown">
    <a href="index.html" class="btn-back"><i class="fas fa-arrow-left"></i></a>

    <h3>Create Account</h3>

    <%
        String error = request.getParameter("error");
        if ("duplicate".equals(error)) {
    %>
        <div class="alert-custom animate__animated animate__shakeX">
            <i class="fas fa-exclamation-triangle me-2"></i> Username already exists.
        </div>
    <% } else if ("email".equals(error)) { %>
        <div class="alert-custom animate__animated animate__shakeX">
            <i class="fas fa-envelope-open-text me-2"></i> Failed to send verification email.
        </div>
    <% } else if ("validation".equals(error)) { %>
        <div class="alert-custom animate__animated animate__shakeX">
            <i class="fas fa-times-circle me-2"></i> Check all fields & matching passwords.
        </div>
    <% } %>

    <form action="signup" method="post">
        
        <div class="row">
            <div class="col-md-6 mb-3">
                <label class="form-label">Full Name</label>
                <input type="text" name="fullname" class="form-control" placeholder="John Doe" required>
            </div>
            <div class="col-md-6 mb-3">
                <label class="form-label">Username</label>
                <input type="text" name="username" class="form-control" placeholder="johndoe123" required>
            </div>
        </div>

        <div class="mb-3">
            <label class="form-label">Email Address</label>
            <input type="email" name="email" class="form-control" placeholder="john@example.com" required>
        </div>

        <div class="row">
            <div class="col-md-6 mb-3">
                <label class="form-label">Password</label>
                <input type="password" name="password" class="form-control" placeholder="********" required>
            </div>
            <div class="col-md-6 mb-3">
                <label class="form-label">Confirm</label>
                <input type="password" name="confirmpassword" class="form-control" placeholder="********" required>
            </div>
        </div>

        <div class="row">
            <div class="col-md-6">
                <label class="form-label">Gender</label>
                <div class="radio-group-container">
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" name="gender" value="Male" id="male" required>
                        <label class="form-check-label" for="male"><i class="fas fa-mars"></i> Male</label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" name="gender" value="Female" id="female" required>
                        <label class="form-check-label" for="female"><i class="fas fa-venus"></i> Female</label>
                    </div>
                </div>
            </div>

            <div class="col-md-6">
                <label class="form-label">Role</label>
                <div class="radio-group-container">
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" name="role" value="Teacher" id="teacher" required>
                        <label class="form-check-label" for="teacher"><i class="fas fa-chalkboard-teacher"></i> Teacher</label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" name="role" value="Student" id="student" required>
                        <label class="form-check-label" for="student"><i class="fas fa-user-graduate"></i> Student</label>
                    </div>
                </div>
            </div>
        </div>

        <button type="submit" class="btn btn-custom">
            Sign Up <i class="fas fa-user-plus ms-1"></i>
        </button>
    </form>

    <div class="login-link">
        Already have an account? <a href="login.jsp">Log in</a>
    </div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>