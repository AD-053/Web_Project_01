<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Email Verification</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css"/>

    <style>
        body {
            font-family: 'Poppins', sans-serif;
            min-height: 100vh;
            margin: 0;
            /* Animated Gradient Background */
            background: linear-gradient(-45deg, #e73c7e, #23a6d5, #ee7752, #23d5ab);
            background-size: 400% 400%;
            animation: gradientBG 15s ease infinite;
            display: flex;
            justify-content: center;
            align-items: center;
            color: #fff;
        }

        @keyframes gradientBG {
            0% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
            100% { background-position: 0% 50%; }
        }

        /* Glassmorphism Card */
        .verify-card {
            background: rgba(255, 255, 255, 0.15);
            box-shadow: 0 8px 32px 0 rgba(31, 38, 135, 0.37);
            backdrop-filter: blur(12px);
            -webkit-backdrop-filter: blur(12px);
            border-radius: 20px;
            border: 1px solid rgba(255, 255, 255, 0.18);
            padding: 40px;
            max-width: 450px;
            width: 100%;
            text-align: center;
            transition: transform 0.3s ease;
        }

        .verify-card:hover {
            transform: translateY(-5px);
        }

        h4 {
            font-weight: 700;
            margin-bottom: 10px;
            color: white;
            text-shadow: 1px 1px 3px rgba(0,0,0,0.3);
        }

        p.text-muted {
            opacity: 0.9;
            margin-bottom: 30px;
        }

        /* Custom Inputs for OTP/Code */
        .verify-inputs input {
            width: 50px;
            height: 60px;
            text-align: center;
            font-size: 24px;
            font-weight: 600;
            margin: 0 4px;
            border: 2px solid rgba(255, 255, 255, 0.4);
            border-radius: 12px;
            background: rgba(255, 255, 255, 0.1);
            color: white;
            transition: border-color 0.3s, box-shadow 0.3s, background 0.3s;
        }
        .verify-inputs input:focus {
            border-color: #ffcc00; /* Yellow accent */
            box-shadow: 0 0 10px rgba(255, 204, 0, 0.5);
            background: rgba(255, 255, 255, 0.3);
            outline: none;
        }
        
        /* Verification Button (Primary Action) */
        .btn-verify {
            margin-top: 30px;
            width: 100%;
            font-size: 18px;
            padding: 12px;
            border-radius: 50px;
            background-color: #ffcc00; /* Yellow accent */
            color: #333;
            font-weight: 700;
            border: none;
            transition: all 0.3s;
            text-transform: uppercase;
        }
        .btn-verify:hover {
            background-color: #e6b800;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
        }
        
        /* Error Message Box */
        .error-msg-box {
            background: rgba(220, 53, 69, 0.8);
            color: white;
            border-radius: 10px;
            font-size: 0.9rem;
            padding: 10px;
            margin-top: 15px;
            backdrop-filter: blur(5px);
        }
    </style>
</head>
<body>
    <div class="verify-card animate__animated animate__zoomIn">
        <h4 class="mb-3"><i class="fas fa-envelope-open-text me-2"></i> Email Verification</h4>
        <p class="text-muted">Enter the 6-digit code sent to your email address to proceed.</p>
        
        <form action="verify" method="post" id="verifyForm">
            <div class="d-flex justify-content-center verify-inputs">
                <input type="text" name="digit1" maxlength="1" required inputmode="numeric">
                <input type="text" name="digit2" maxlength="1" required inputmode="numeric">
                <input type="text" name="digit3" maxlength="1" required inputmode="numeric">
                <input type="text" name="digit4" maxlength="1" required inputmode="numeric">
                <input type="text" name="digit5" maxlength="1" required inputmode="numeric">
                <input type="text" name="digit6" maxlength="1" required inputmode="numeric">
            </div>
            <input type="hidden" name="code" id="hiddenCode">
            <button type="submit" class="btn btn-verify">
                <i class="fas fa-check-circle me-1"></i> Verify Code
            </button>
        </form>

        <% if (request.getParameter("error") != null) { %>
            <div class="error-msg-box animate__animated animate__shakeX">
                <i class="fas fa-times-circle me-2"></i> Verification failed. The code is incorrect or expired.
            </div>
        <% } %>
    </div>

    <script>
        const inputs = document.querySelectorAll(".verify-inputs input");
        const hiddenCode = document.getElementById("hiddenCode");
        const form = document.getElementById("verifyForm");

        inputs.forEach((input, index) => {
            // Function to handle input and move focus
            input.addEventListener("input", (e) => {
                // Ensure only one digit is processed
                input.value = input.value.replace(/[^0-9]/g, '').substring(0, 1);
                
                if (input.value.length === 1 && index < inputs.length - 1) {
                    inputs[index + 1].focus();
                }
                if (index === inputs.length - 1 && input.value.length === 1) {
                    input.blur();
                }
            });

            // Function to handle backspace
            input.addEventListener("keydown", (e) => {
                if (e.key === "Backspace" && !input.value && index > 0) {
                    inputs[index - 1].focus();
                }
            });
        });

        // Function to combine digits before submission
        form.addEventListener("submit", () => {
            let code = "";
            inputs.forEach(input => code += input.value);
            hiddenCode.value = code;
        });
    </script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>