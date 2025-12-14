# Course Management System

A comprehensive web-based Course Management System built using **Java Servlets**, **JSP**, and **MySQL**. This project demonstrates a complete implementation of a multi-user educational platform with role-based access control and modern UI design.

![Java](https://img.shields.io/badge/Java-ED8B00?style=flat&logo=java&logoColor=white)
![Servlet](https://img.shields.io/badge/Servlet-3.1-blue)
![JSP](https://img.shields.io/badge/JSP-2.3-green)
![MySQL](https://img.shields.io/badge/MySQL-8.0-orange)
![Bootstrap](https://img.shields.io/badge/Bootstrap-5.3-purple)
![Apache Tomcat](https://img.shields.io/badge/Tomcat-9.0-yellow)

---

## 📋 Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Technologies Used](#technologies-used)
- [System Requirements](#system-requirements)
- [Project Structure](#project-structure)
- [Database Schema](#database-schema)
- [Installation & Setup](#installation--setup)
- [Usage](#usage)
- [User Roles](#user-roles)
- [Contributors](#contributors)

---

## 🎯 Overview

This Course Management System is a complete web application developed as part of the **Web Technology** course project. It simulates the functionalities of an online learning platform where:

- **Admins** can manage courses and assign teachers
- **Teachers** can view their assigned courses and enrolled students
- **Students** can register for courses and track their enrollments

The application features a modern, responsive UI with glassmorphism design and animated gradient backgrounds, providing an attractive and user-friendly experience.

---

## ✨ Features

### Core Functionalities (All Requirements Met)

✅ **R-1: Multi-User Support**
- Three distinct user types: Student, Teacher, and Admin
- Role-based access control and personalized dashboards

✅ **R-2: User Authentication**
- Secure username and password authentication
- User registration with email verification (OTP-based)
- Session management for secure user sessions

✅ **R-3: Admin Capabilities**
- Add new courses to the system
- Assign teachers to specific courses
- Manage course catalog

✅ **R-4: Student Capabilities**
- Browse and register for available courses
- View all enrolled courses
- User-friendly course enrollment interface

✅ **R-5: Teacher Capabilities**
- View all assigned courses
- Select specific courses to view enrolled students
- Track student enrollment per course

### Additional Features

- **Modern UI/UX Design**
  - Responsive layout using Bootstrap 5.3
  - Font Awesome icons for enhanced visual appeal
  - Smooth animations using Animate.css

- **Email Verification**
  - OTP-based email verification during signup
  - Integration with JavaMail API
  
- **Session Management**
  - Secure session handling
  - Automatic logout functionality
  - Session-based authorization

- **Data Persistence**
  - MySQL database for storing user and course data
  - JSON arrays for managing student/teacher lists per course

---

## 🛠️ Technologies Used

### Backend
- **Java Servlets 3.1** - Server-side request handling
- **JSP (JavaServer Pages)** - Dynamic web page generation
- **JDBC** - Database connectivity
- **JavaMail API** - Email verification

### Frontend
- **HTML5 & CSS3** - Structure and styling
- **Bootstrap 5.3.3** - Responsive UI framework
- **JavaScript** - Client-side interactions
- **Font Awesome 6.0** - Icon library
- **Animate.css 4.1.1** - CSS animations
- **Google Fonts (Poppins)** - Typography

### Database
- **MySQL 8.0** - Relational database management

### Server
- **Apache Tomcat 9.0.85** - Servlet container

### Libraries & Dependencies
- `mysql-connector-j-9.4.0.jar` - MySQL JDBC driver
- `javax.mail-1.6.2.jar` - JavaMail API
- `activation-1.1.1.jar` - JavaBeans Activation Framework

---

## 💻 System Requirements

- **JDK**: Java Development Kit 8 or higher
- **IDE**: Eclipse IDE for Java EE Developers (or any compatible IDE)
- **Server**: Apache Tomcat 9.0 or higher
- **Database**: MySQL 8.0 or higher
- **Browser**: Modern web browser (Chrome, Firefox, Edge, Safari)

---

## 📁 Project Structure

```
course_management_system-jsp-servlet--main/
│
├── src/main/java/com/rahad/
│   ├── dao/
│   │   ├── logindao.java          # Login authentication DAO
│   │   └── register.java          # User registration DAO
│   │
│   ├── admin.java                 # Admin servlet
│   ├── student.java               # Student servlet
│   ├── teacher.java               # Teacher servlet
│   ├── login.java                 # Login servlet
│   ├── signup.java                # Signup servlet
│   ├── verify.java                # OTP verification servlet
│   ├── enroll.java                # Course enrollment servlet
│   ├── logout.java                # Logout servlet
│   └── EmailSender.java           # Email utility class
│
├── WebContent/
│   ├── WEB-INF/
│   │   ├── lib/                   # JAR dependencies
│   │   │   ├── mysql-connector-j-9.4.0.jar
│   │   │   ├── javax.mail-1.6.2.jar
│   │   │   └── activation-1.1.1.jar
│   │   └── web.xml                # Deployment descriptor
│   │
│   ├── index.html                 # Landing page
│   ├── login.jsp                  # Login page
│   ├── signup.jsp                 # Registration page
│   ├── verify.jsp                 # Email verification page
│   ├── admin.jsp                  # Admin dashboard
│   ├── teacher.jsp                # Teacher dashboard
│   └── student.jsp                # Student dashboard
│
├── build/classes/                 # Compiled Java classes
│
└── project.sql                    # Database schema
```

---

## 🗄️ Database Schema

### Table: `signup_data`
Stores user information for authentication and role management.

```sql
CREATE TABLE signup_data (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    username VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(100) NOT NULL,
    gender ENUM('male', 'female') NOT NULL,
    role ENUM('student', 'teacher', 'admin') NOT NULL
);
```

**Sample Data:**
```sql
INSERT INTO signup_data VALUES
(1, "Md. Rahad Islam", "rahad", "123", "male", "admin");
```

### Table: `course_data`
Stores course information with enrolled students and assigned teachers.

```sql
CREATE TABLE course_data (
    course_name VARCHAR(100) UNIQUE NOT NULL,
    course_code VARCHAR(20) UNIQUE NOT NULL,
    student_list JSON,
    teacher_list JSON
);
```

**Sample Data:**
```sql
INSERT INTO course_data (course_name, course_code, student_list, teacher_list)
VALUES (
    'web-technologies3',
    '161222602',
    JSON_ARRAY('rahim'),
    JSON_ARRAY('tayef')
);
```

---

## 🚀 Installation & Setup

### Step 1: Clone the Repository
```bash
git clone <repository-url>
cd course_management_system-jsp-servlet--main
```

### Step 2: Database Setup
1. Install MySQL Server 8.0 or higher
2. Create the database and tables:
   ```bash
   mysql -u root -p < project.sql
   ```
3. Verify the database:
   ```sql
   USE project;
   SHOW TABLES;
   ```

### Step 3: Configure Database Connection
Update the database credentials in DAO classes (`logindao.java`, `register.java`) if needed:
```java
String url = "jdbc:mysql://localhost:3306/project";
String username = "root";
String password = "your_password";
```

### Step 4: Setup Apache Tomcat
1. Download and extract Apache Tomcat 9.0.85
2. Configure Tomcat in your IDE (Eclipse):
   - Window → Preferences → Server → Runtime Environments
   - Add Apache Tomcat 9.0
   - Set installation directory

### Step 5: Add External JARs
Ensure the following JARs are in `WebContent/WEB-INF/lib/`:
- `mysql-connector-j-9.4.0.jar`
- `javax.mail-1.6.2.jar`
- `activation-1.1.1.jar`

### Step 6: Configure Email Service (Optional)
For email verification functionality, update `EmailSender.java` with your SMTP credentials:
```java
props.put("mail.smtp.host", "smtp.gmail.com");
props.put("mail.smtp.user", "your-email@gmail.com");
props.put("mail.smtp.password", "your-app-password");
```

### Step 7: Deploy the Application
1. Right-click project → Run As → Run on Server
2. Select Tomcat 9.0 server
3. The application will open at: `http://localhost:8080/course_management_system-jsp-servlet--main/`

---

## 📖 Usage

### Accessing the Application

1. **Landing Page**: Navigate to `http://localhost:8080/course_management_system-jsp-servlet--main/index.html`
2. **Login/Signup**: Choose to login with existing credentials or create a new account

### Default Admin Credentials
```
Username: rahad
Password: 123
Role: Admin
```

### Workflow

#### For Admin:
1. Login with admin credentials
2. Add new courses with course name and code
3. Assign teachers to courses
4. View all courses and their assignments

#### For Teacher:
1. Login with teacher credentials
2. View assigned courses
3. Select a course to view enrolled students
4. Monitor student enrollment

#### For Student:
1. Register a new account or login
2. Browse available courses
3. Enroll in desired courses
4. View enrolled courses list

---

## 👥 User Roles

### 1. Admin
**Capabilities:**
- Add new courses to the system
- Assign teachers to courses
- View all courses and assignments
- Manage the course catalog

**Dashboard Features:**
- Course creation form
- Teacher assignment interface
- Complete course overview

### 2. Teacher
**Capabilities:**
- View assigned courses
- See enrolled students per course
- Track course enrollments

**Dashboard Features:**
- List of assigned courses
- Student roster for each course
- Course details display

### 3. Student
**Capabilities:**
- Register for new courses
- View enrolled courses
- Browse course catalog

**Dashboard Features:**
- Available courses list
- Enrolled courses view
- Course enrollment interface

---

## 🎓 Project Compliance

This project fully satisfies all requirements specified in the Web Technology lab project:

| Requirement | Status | Implementation |
|-------------|--------|----------------|
| **R-1**: Three user types | ✅ Complete | Student, Teacher, Admin roles implemented |
| **R-2**: User authentication | ✅ Complete | Username/password auth + optional registration |
| **R-3**: Admin functionality | ✅ Complete | Course addition & teacher assignment |
| **R-4**: Student functionality | ✅ Complete | Course registration & enrollment view |
| **R-5**: Teacher functionality | ✅ Complete | Course view & student roster |
| **Design & Aesthetics** | ✅ Complete | Bootstrap 5.3, glassmorphism, animations |
| **Backend Integration** | ✅ Complete | MySQL database with proper schema |
| **Code Documentation** | ✅ Complete | Well-commented servlets and JSP pages |

---

## 👨‍💻 Contributors

- **Developer**: Md Rahad Islam
- **Course**: Web Technology (2nd Year, 2nd Semester)
- **Institution**: [SUST]

- **Developer**: Autanu Datta
- **Course**: Web Technology (2nd Year, 2nd Semester)
- **Institution**: [SUST]

---

<div align="center">

Made with using Java Servlets, JSP, and MySQL

</div>
