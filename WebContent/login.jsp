<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Course Management</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css"/>

    <style>
        body {
            font-family: 'Poppins', sans-serif;
            height: 100vh;
            margin: 0;
            overflow: hidden;
            /* Same animated background as index for consistency */
            background: linear-gradient(-45deg, #ee7752, #e73c7e, #23a6d5, #23d5ab);
            background-size: 400% 400%;
            animation: gradientBG 15s ease infinite;
            display: flex;
            justify-content: center;
            align-items: center;
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
            max-width: 420px;
            color: white;
            position: relative;
        }

        h2.form-title {
            font-weight: 700;
            margin-bottom: 30px;
            text-align: center;
            letter-spacing: 1px;
            text-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        /* Custom Input Fields for Dark Background */
        .form-control {
            background: rgba(255, 255, 255, 0.2);
            border: none;
            border-radius: 50px;
            padding: 12px 20px;
            color: #fff;
            margin-bottom: 15px;
            backdrop-filter: blur(5px);
        }

        .form-control::placeholder {
            color: rgba(255, 255, 255, 0.7);
        }

        .form-control:focus {
            background: rgba(255, 255, 255, 0.3);
            box-shadow: 0 0 10px rgba(255, 255, 255, 0.2);
            color: #fff;
        }
        
        /* Input Labels */
        .form-label {
            font-weight: 600;
            font-size: 0.9rem;
            margin-left: 10px;
        }

        /* Radio Buttons Styling */
        .role-group {
            background: rgba(0, 0, 0, 0.1);
            padding: 10px;
            border-radius: 15px;
            display: flex;
            justify-content: space-between;
            margin-bottom: 20px;
        }

        .form-check-input {
            cursor: pointer;
        }
        
        .form-check-label {
            cursor: pointer;
            font-size: 0.9rem;
        }

        /* Login Button */
        .btn-login {
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

        .btn-login:hover {
            background: #f0f0f0;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
            color: #d62f6d;
        }

        /* Links */
        .signup-link {
            text-align: center;
            margin-top: 20px;
            font-size: 0.9rem;
        }

        .signup-link a {
            color: #fff;
            text-decoration: none;
            font-weight: 600;
            border-bottom: 1px dashed rgba(255,255,255,0.5);
        }

        .signup-link a:hover {
            color: #fff;
            border-bottom: 1px solid #fff;
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

    <div class="glass-card animate__animated animate__fadeInUp">
        <a href="index.html" class="btn-back"><i class="fas fa-arrow-left"></i></a>

        <h2 class="form-title">Login</h2>

        <%
            String error = request.getParameter("error");
            if ("invalid".equals(error)) {
        %>
            <div class="alert alert-custom animate__animated animate__shakeX">
                <i class="fas fa-exclamation-circle me-2"></i> Invalid username, password, or role.
            </div>
        <% } %>

        <form action="login" method="post">
            <div class="mb-3">
                <label for="username" class="form-label">Username</label>
                <div class="input-group">
                    <input type="text" name="username" class="form-control" id="username" placeholder="Enter your username" required>
                </div>
            </div>

            <div class="mb-3">
                <label for="pass" class="form-label">Password</label>
                <div class="input-group">
                    <input type="password" name="pass" class="form-control" id="pass" placeholder="Enter your password" required>
                </div>
            </div>

            <div class="mb-3">
                <label class="form-label">Select Role</label>
                <div class="role-group">
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" name="role" id="admin" value="admin" required>
                        <label class="form-check-label" for="admin">Admin</label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" name="role" id="teacher" value="teacher">
                        <label class="form-check-label" for="teacher">Teacher</label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" name="role" id="student" value="student">
                        <label class="form-check-label" for="student">Student</label>
                    </div>
                </div>
            </div>

            <button type="submit" class="btn btn-login">
                Log In <i class="fas fa-sign-in-alt ms-2"></i>
            </button>
        </form>

        <div class="signup-link">
            Don’t have an account? <a href="signup.jsp">Sign up here</a>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>