# Hospital Management System

## Complete Documentation

A comprehensive full-stack Hospital Management System built with React, Node.js, Express, and MongoDB. This application digitizes hospital operations including patient management, appointments, bed allocation, ambulance services, and medical reporting.

---

## Table of Contents

1. [Overview](#overview)
2. [Architecture](#architecture)
3. [Tech Stack](#tech-stack)
4. [Project Structure](#project-structure)
5. [Data Models](#data-models)
6. [API Endpoints](#api-endpoints)
7. [User Roles & Permissions](#user-roles--permissions)
8. [Frontend Routes](#frontend-routes)
9. [Getting Started](#getting-started)
10. [Scripts Reference](#scripts-reference)
11. [Docker Configuration](#docker-configuration)
12. [Environment Variables](#environment-variables)
13. [Features](#features)
14. [Troubleshooting](#troubleshooting)

---

## Overview

The Hospital Management System (HMS) is a web-based application designed to streamline hospital operations. It provides a centralized dashboard for managing:

- **Patients** - Registration, admission, and discharge
- **Doctors** - Profile management and patient assignments
- **Nurses** - Patient care and appointment booking
- **Appointments** - Scheduling and management
- **Beds** - Room and bed allocation tracking
- **Ambulances** - Fleet management and dispatch
- **Reports** - Medical reports and prescriptions
- **Payments** - Billing and payment tracking

### Key Highlights

- 🔐 Role-based access control (Admin, Doctor, Nurse)
- 📊 Real-time dashboard with statistics
- 🏥 Complete patient lifecycle management
- 📋 Medical report generation
- 🚑 Ambulance fleet management
- 🛏️ Bed occupancy tracking
- 📧 Email-based password recovery

---

## Architecture

### System Architecture Diagram

```
┌──────────────────────────────────────────────────────────────────────────────┐
│                              HOSPITAL MANAGEMENT SYSTEM                       │
├──────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│  ┌─────────────────────────────────────────────────────────────────────────┐ │
│  │                           CLIENT LAYER                                   │ │
│  │  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐    │ │
│  │  │   Admin     │  │   Doctor    │  │    Nurse    │  │   Patient   │    │ │
│  │  │  Browser    │  │   Browser   │  │   Browser   │  │   Browser   │    │ │
│  │  └──────┬──────┘  └──────┬──────┘  └──────┬──────┘  └──────┬──────┘    │ │
│  │         │                │                │                │            │ │
│  └─────────┼────────────────┼────────────────┼────────────────┼────────────┘ │
│            │                │                │                │              │
│            └────────────────┴────────────────┴────────────────┘              │
│                                     │                                        │
│                                     ▼                                        │
│  ┌─────────────────────────────────────────────────────────────────────────┐ │
│  │                        FRONTEND LAYER (React)                           │ │
│  │                         http://localhost:3000                            │ │
│  │  ┌───────────────────────────────────────────────────────────────────┐  │ │
│  │  │                                                                   │  │ │
│  │  │   ┌─────────────┐   ┌─────────────┐   ┌─────────────────────┐   │  │ │
│  │  │   │   React     │   │   Redux     │   │    React Router     │   │  │ │
│  │  │   │ Components  │◄─►│   Store     │◄─►│    (Navigation)     │   │  │ │
│  │  │   └─────────────┘   └──────┬──────┘   └─────────────────────┘   │  │ │
│  │  │                            │                                     │  │ │
│  │  │                            ▼                                     │  │ │
│  │  │                    ┌──────────────┐                             │  │ │
│  │  │                    │    Axios     │                             │  │ │
│  │  │                    │ HTTP Client  │                             │  │ │
│  │  │                    └──────┬───────┘                             │  │ │
│  │  │                           │                                      │  │ │
│  │  └───────────────────────────┼──────────────────────────────────────┘  │ │
│  └──────────────────────────────┼──────────────────────────────────────────┘ │
│                                 │                                            │
│                                 │ HTTP/REST API                              │
│                                 ▼                                            │
│  ┌─────────────────────────────────────────────────────────────────────────┐ │
│  │                        BACKEND LAYER (Node.js)                          │ │
│  │                         http://localhost:8080                            │ │
│  │  ┌───────────────────────────────────────────────────────────────────┐  │ │
│  │  │                                                                   │  │ │
│  │  │   ┌─────────────┐   ┌─────────────┐   ┌─────────────────────┐   │  │ │
│  │  │   │   Express   │   │ Middlewares │   │       Routes        │   │  │ │
│  │  │   │   Server    │──►│  (JWT Auth) │──►│   (REST Endpoints)  │   │  │ │
│  │  │   └─────────────┘   └─────────────┘   └──────────┬──────────┘   │  │ │
│  │  │                                                  │               │  │ │
│  │  │                                                  ▼               │  │ │
│  │  │                                        ┌─────────────────┐      │  │ │
│  │  │                                        │    Mongoose     │      │  │ │
│  │  │                                        │      ODM        │      │  │ │
│  │  │                                        └────────┬────────┘      │  │ │
│  │  │                                                 │                │  │ │
│  │  └─────────────────────────────────────────────────┼────────────────┘  │ │
│  └────────────────────────────────────────────────────┼────────────────────┘ │
│                                                       │                      │
│                                                       ▼                      │
│  ┌─────────────────────────────────────────────────────────────────────────┐ │
│  │                        DATABASE LAYER (MongoDB)                         │ │
│  │                         mongodb://localhost:27017                        │ │
│  │  ┌───────────────────────────────────────────────────────────────────┐  │ │
│  │  │                                                                   │  │ │
│  │  │  ┌──────────┐ ┌──────────┐ ┌──────────┐ ┌──────────┐            │  │ │
│  │  │  │  Admin   │ │  Doctor  │ │  Nurse   │ │ Patient  │            │  │ │
│  │  │  └──────────┘ └──────────┘ └──────────┘ └──────────┘            │  │ │
│  │  │                                                                   │  │ │
│  │  │  ┌──────────┐ ┌──────────┐ ┌──────────┐ ┌──────────┐            │  │ │
│  │  │  │   Bed    │ │Ambulance │ │  Report  │ │ Payment  │            │  │ │
│  │  │  └──────────┘ └──────────┘ └──────────┘ └──────────┘            │  │ │
│  │  │                                                                   │  │ │
│  │  │  ┌──────────────┐ ┌──────────────┐ ┌──────────────┐             │  │ │
│  │  │  │ Appointment  │ │ Prescription │ │   Hospital   │             │  │ │
│  │  │  └──────────────┘ └──────────────┘ └──────────────┘             │  │ │
│  │  │                                                                   │  │ │
│  │  └───────────────────────────────────────────────────────────────────┘  │ │
│  └─────────────────────────────────────────────────────────────────────────┘ │
│                                                                              │
└──────────────────────────────────────────────────────────────────────────────┘
```

### Docker Architecture

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                            DOCKER ENVIRONMENT                               │
│                                                                             │
│  ┌────────────────────────────────────────────────────────────────────────┐ │
│  │                         Docker Network (hms-network)                   │ │
│  │                                                                        │ │
│  │  ┌──────────────────┐  ┌──────────────────┐  ┌──────────────────┐    │ │
│  │  │                  │  │                  │  │                  │    │ │
│  │  │   hms-mongodb    │  │   hms-backend    │  │  hms-frontend    │    │ │
│  │  │                  │  │                  │  │                  │    │ │
│  │  │  ┌────────────┐  │  │  ┌────────────┐  │  │  ┌────────────┐  │    │ │
│  │  │  │  MongoDB   │  │  │  │  Node.js   │  │  │  │   Nginx    │  │    │ │
│  │  │  │   6.0      │◄─┼──┼──│  Express   │◄─┼──┼──│   React    │  │    │ │
│  │  │  │            │  │  │  │            │  │  │  │   Build    │  │    │ │
│  │  │  └────────────┘  │  │  └────────────┘  │  │  └────────────┘  │    │ │
│  │  │                  │  │                  │  │                  │    │ │
│  │  │  Port: 27017     │  │  Port: 8080      │  │  Port: 80→3000   │    │ │
│  │  │                  │  │                  │  │                  │    │ │
│  │  └────────┬─────────┘  └──────────────────┘  └──────────────────┘    │ │
│  │           │                                                          │ │
│  └───────────┼──────────────────────────────────────────────────────────┘ │
│              │                                                            │
│              ▼                                                            │
│  ┌───────────────────┐                                                    │
│  │  mongodb_data     │  ◄── Persistent Volume                            │
│  │     (volume)      │                                                    │
│  └───────────────────┘                                                    │
│                                                                           │
└─────────────────────────────────────────────────────────────────────────────┘

External Access:
  • Frontend: http://localhost:3000
  • Backend:  http://localhost:8080
  • MongoDB:  mongodb://localhost:27017
```

### Request Flow Diagram

```
┌──────────┐     ┌──────────┐     ┌──────────┐     ┌──────────┐     ┌──────────┐
│          │     │          │     │          │     │          │     │          │
│  Client  │────►│  Nginx   │────►│  React   │────►│  Axios   │────►│  Backend │
│ (Browser)│     │ (Port 80)│     │   App    │     │  HTTP    │     │(Port 8080)│
│          │     │          │     │          │     │          │     │          │
└──────────┘     └──────────┘     └──────────┘     └──────────┘     └────┬─────┘
                                                                         │
                                                                         ▼
                                                                   ┌──────────┐
                                                                   │  Express │
                                                                   │  Router  │
                                                                   └────┬─────┘
                                                                        │
                                                                        ▼
                                                                   ┌──────────┐
                                                                   │   JWT    │
                                                                   │   Auth   │
                                                                   └────┬─────┘
                                                                        │
                                                                        ▼
                                                                   ┌──────────┐
                                                                   │ Mongoose │
                                                                   │  Models  │
                                                                   └────┬─────┘
                                                                        │
                                                                        ▼
                                                                   ┌──────────┐
                                                                   │ MongoDB  │
                                                                   │ Database │
                                                                   └──────────┘
```

---

## Tech Stack

### Backend

| Technology | Version | Purpose |
|------------|---------|---------|
| **Node.js** | 18.x | JavaScript runtime |
| **Express.js** | 4.18.x | Web application framework |
| **MongoDB** | 6.0 | NoSQL database |
| **Mongoose** | 6.8.x | MongoDB object modeling (ODM) |
| **JWT** | 8.5.x | JSON Web Token authentication |
| **bcrypt** | 5.1.x | Password hashing |
| **Nodemailer** | 6.9.x | Email sending (password recovery) |
| **dotenv** | 16.x | Environment variable management |
| **cors** | 2.8.x | Cross-Origin Resource Sharing |
| **validator** | 13.x | Data validation |

### Frontend

| Technology | Version | Purpose |
|------------|---------|---------|
| **React** | 18.2.x | UI component library |
| **Redux** | 4.2.x | State management |
| **Redux Thunk** | 2.4.x | Async actions middleware |
| **React Router** | 6.4.x | Client-side routing |
| **Axios** | 1.2.x | HTTP client |
| **Ant Design** | 5.0.x | UI component framework |
| **React Icons** | 4.7.x | Icon library |
| **React Toastify** | 9.1.x | Toast notifications |
| **FullCalendar** | 6.0.x | Calendar component |

### DevOps & Infrastructure

| Technology | Purpose |
|------------|---------|
| **Docker** | Containerization |
| **Docker Compose** | Multi-container orchestration |
| **Nginx** | Reverse proxy & static file serving |

---

## Project Structure

```
Hospital_Management_System/
│
├── 📁 Backend/                          # Backend API Server
│   ├── 📁 configs/
│   │   └── db.js                        # MongoDB connection configuration
│   │
│   ├── 📁 middlewares/                  # Authentication middlewares
│   │   ├── adminAuth.js                 # Admin JWT verification
│   │   ├── doctorAuth.js                # Doctor JWT verification
│   │   ├── nurseAuth.js                 # Nurse JWT verification
│   │   └── patientAuth.js               # Patient JWT verification
│   │
│   ├── 📁 models/                       # Mongoose data models
│   │   ├── Admin.model.js               # Admin schema
│   │   ├── Ambulance.model.js           # Ambulance schema
│   │   ├── Appointment.model.js         # Appointment schema
│   │   ├── Bed.model.js                 # Bed/Room schema
│   │   ├── Doctor.model.js              # Doctor schema
│   │   ├── Hospital.model.js            # Hospital schema
│   │   ├── Nurse.model.js               # Nurse schema
│   │   ├── Patient.model.js             # Patient schema
│   │   ├── Payment.model.js             # Payment schema
│   │   ├── Prescription.model.js        # Prescription schema
│   │   └── Report.model.js              # Medical report schema
│   │
│   ├── 📁 routes/                       # API route handlers
│   │   ├── Admins.Route.js              # /admin endpoints
│   │   ├── Ambulances.Route.js          # /ambulances endpoints
│   │   ├── Appointments.Route.js        # /appointments endpoints
│   │   ├── Beds.Route.js                # /beds endpoints
│   │   ├── Doctors.Route.js             # /doctors endpoints
│   │   ├── Hospitals.Route.js           # /hospitals endpoints
│   │   ├── Nurses.Route.js              # /nurses endpoints
│   │   ├── Patients.Route.js            # /patients endpoints
│   │   ├── Payments.route.js            # /payments endpoints
│   │   ├── Prescriptions.Route.js       # /prescriptions endpoints
│   │   └── Reports.Route.js             # /reports endpoints
│   │
│   ├── index.js                         # Express app entry point
│   ├── seed.js                          # Database seeding script
│   ├── package.json                     # Backend dependencies
│   ├── Dockerfile                       # Production Docker image
│   ├── Dockerfile.dev                   # Development Docker image
│   └── .dockerignore                    # Docker ignore rules
│
├── 📁 FrontEnd/                         # React Frontend Application
│   ├── 📁 public/                       # Static assets
│   │   ├── index.html                   # HTML template
│   │   ├── favicon.ico                  # Site favicon
│   │   └── manifest.json                # PWA manifest
│   │
│   ├── 📁 src/
│   │   ├── 📁 Components/               # Reusable components
│   │   │   ├── 📁 Footer/
│   │   │   │   └── Footer.jsx
│   │   │   └── 📁 Navbar/
│   │   │       └── Navbar.jsx
│   │   │
│   │   ├── 📁 config/
│   │   │   └── api.js                   # API base URL configuration
│   │   │
│   │   ├── 📁 img/                      # Image assets
│   │   │   ├── admin.jpg
│   │   │   ├── banner.png
│   │   │   ├── doctoravatar.png
│   │   │   └── ...
│   │   │
│   │   ├── 📁 Pages/
│   │   │   └── 📁 Dashboard/
│   │   │       ├── 📁 Dashboard-Login/
│   │   │       │   ├── DLogin.jsx       # Login page
│   │   │       │   └── DLogin.css
│   │   │       │
│   │   │       └── 📁 Main-Dashboard/
│   │   │           ├── 📁 AllPages/
│   │   │           │   ├── 📁 Admin/    # Admin-specific pages
│   │   │           │   │   ├── Add_Admin.jsx
│   │   │           │   │   ├── Add_Ambulance.jsx
│   │   │           │   │   ├── Add_Doctor.jsx
│   │   │           │   │   ├── Add_Nurse.jsx
│   │   │           │   │   ├── AddBeds.jsx
│   │   │           │   │   ├── Beds_Rooms.jsx
│   │   │           │   │   └── Check_Payment.jsx
│   │   │           │   │
│   │   │           │   ├── 📁 Doctor/   # Doctor-specific pages
│   │   │           │   │   ├── AllReport.jsx
│   │   │           │   │   ├── Check_Appointment.jsx
│   │   │           │   │   ├── Discharge_and_Create_Slip.jsx
│   │   │           │   │   ├── Doctor_Profile.jsx
│   │   │           │   │   └── Patient_Details.jsx
│   │   │           │   │
│   │   │           │   └── 📁 Nurse/    # Nurse-specific pages
│   │   │           │       ├── Add_Patient.jsx
│   │   │           │       ├── Book_Appointment.jsx
│   │   │           │       └── Nurse_Profile.jsx
│   │   │           │
│   │   │           └── 📁 GlobalFiles/  # Shared dashboard components
│   │   │               ├── CommonCSS.css
│   │   │               ├── FrontPage.jsx # Main dashboard
│   │   │               ├── Sidebar.jsx   # Navigation sidebar
│   │   │               └── Topbar.jsx
│   │   │
│   │   ├── 📁 Redux/                    # State management
│   │   │   ├── 📁 auth/                 # Authentication state
│   │   │   │   ├── action.js            # Auth actions
│   │   │   │   ├── reducer.js           # Auth reducer
│   │   │   │   └── types.js             # Action types
│   │   │   │
│   │   │   ├── 📁 Datas/                # Data fetching state
│   │   │   │   ├── action.js            # Data actions
│   │   │   │   ├── reducer.js           # Data reducer
│   │   │   │   └── types.js             # Action types
│   │   │   │
│   │   │   ├── index.js                 # Root reducer
│   │   │   └── store.js                 # Redux store configuration
│   │   │
│   │   ├── 📁 Routes/
│   │   │   └── AllRoutes.jsx            # Route definitions
│   │   │
│   │   ├── App.js                       # Root component
│   │   ├── App.css                      # Global styles
│   │   └── index.js                     # React entry point
│   │
│   ├── package.json                     # Frontend dependencies
│   ├── Dockerfile                       # Production Docker image
│   ├── Dockerfile.dev                   # Development Docker image
│   ├── nginx.conf                       # Nginx configuration
│   └── .dockerignore                    # Docker ignore rules
│
├── 📜 docker-compose.yml                # Production orchestration
├── 📜 docker-compose.dev.yml            # Development orchestration
│
├── 📜 start.sh                          # Start production services
├── 📜 stop.sh                           # Stop all services
├── 📜 restart.sh                        # Restart services
├── 📜 logs.sh                           # View container logs
├── 📜 clean.sh                          # Full cleanup
├── 📜 start-dev.sh                      # Start development mode
├── 📜 start-local.sh                    # Start without Docker
│
├── 📜 env.example                       # Environment variables template
├── 📜 DOCUMENTATION.md                  # This file
└── 📜 README.md                         # Project overview
```

---

## Data Models

### 1. Admin Model

```javascript
{
  userType: "admin",          // Fixed value
  adminID: Number,            // Unique login ID (required)
  adminName: String,          // Full name
  email: String,              // Email address
  password: String,           // Hashed password (required)
  gender: String,             // Male/Female/Other
  age: Number,                // Age in years
  mobile: Number,             // 10-digit phone number
  DOB: String,                // Date of birth
  address: String,            // Full address
  education: String,          // Educational qualifications
  image: String               // Profile image URL
}
```

### 2. Doctor Model

```javascript
{
  userType: "doctor",         // Fixed value
  docID: Number,              // Unique login ID (required)
  docName: String,            // Full name
  email: String,              // Email address
  password: String,           // Password (required)
  mobile: Number,             // Phone number
  age: Number,                // Age in years
  gender: String,             // Male/Female/Other
  bloodGroup: String,         // Blood group (A+, B-, etc.)
  DOB: Date,                  // Date of birth
  address: String,            // Full address
  education: String,          // Medical degrees
  department: String,         // Specialization (Cardiology, etc.)
  image: String,              // Profile image URL
  details: String             // Additional details/bio
}
```

### 3. Nurse Model

```javascript
{
  userType: "nurse",          // Fixed value
  nurseID: Number,            // Unique login ID (required)
  nurseName: String,          // Full name
  email: String,              // Email address
  password: String,           // Password (required)
  mobile: Number,             // Phone number
  age: Number,                // Age in years
  gender: String,             // Male/Female/Other
  bloodGroup: String,         // Blood group
  DOB: String,                // Date of birth
  address: String,            // Full address
  education: String,          // Nursing qualifications
  image: String,              // Profile image URL
  details: String             // Additional details
}
```

### 4. Patient Model

```javascript
{
  userType: "patient",        // Fixed value
  patientID: Number,          // Unique patient ID (required)
  patientName: String,        // Full name
  email: String,              // Email address
  password: String,           // Default: "password"
  mobile: Number,             // Phone number
  age: Number,                // Age in years
  gender: String,             // Male/Female/Other
  bloodGroup: String,         // Blood group
  DOB: String,                // Date of birth
  address: String,            // Full address
  department: String,         // Assigned department
  disease: String,            // Diagnosis/condition
  details: String,            // Additional medical details
  image: String,              // Profile image URL
  admitted: Boolean,          // Admission status (default: true)
  date: Date,                 // Admission date
  docID: ObjectId,            // Reference to assigned Doctor
  nurseID: ObjectId           // Reference to assigned Nurse
}
```

### 5. Appointment Model

```javascript
{
  userType: "patient",        // Fixed value
  patientID: Number,          // Patient ID (required)
  patientName: String,        // Patient name
  email: String,              // Email address
  mobile: Number,             // Phone number
  address: String,            // Address
  disease: String,            // Condition/reason for appointment
  department: String,         // Medical department
  date: String,               // Appointment date
  time: String,               // Appointment time
  age: Number,                // Patient age (required)
  gender: String              // Patient gender (required)
}
```

### 6. Bed Model

```javascript
{
  bedNumber: Number,          // Bed number (required)
  roomNumber: Number,         // Room number (required)
  occupied: String,           // Occupancy status
  patientID: ObjectId         // Reference to Patient (if occupied)
}
```

### 7. Ambulance Model

```javascript
{
  ambulanceID: Number,        // Unique ambulance ID (required)
  type: String,               // Ambulance type (required)
  charges: Number,            // Service charges (required)
  ambulanceDriver: String,    // Driver name (required)
  number: Number              // Vehicle number (required)
}
```

### 8. Report Model (Medical Report)

```javascript
{
  // Doctor Information
  docName: String,            // Doctor name (required)
  docDepartment: String,      // Department (required)
  docMobile: Number,          // Doctor contact (required)
  
  // Patient Information
  patientName: String,        // Patient name (required)
  patientAge: Number,         // Age (required)
  patientGender: String,      // Gender (required)
  patientMobile: Number,      // Contact (required)
  patientBloodGroup: String,  // Blood group (required)
  email: String,              // Email (required)
  patientDisease: String,     // Diagnosis
  
  // Vitals
  patientTemperature: Number, // Body temperature
  patientWeight: Number,      // Weight in kg
  patientBP: Number,          // Blood pressure
  patientGlucose: Number,     // Glucose level
  
  // Prescription
  medicines: [{
    medName: String,          // Medicine name
    dosage: Number,           // Dosage amount
    duration: String          // Duration (e.g., "7 days")
  }],
  
  extrainfo: String,          // Additional notes
  date: String,               // Report date
  time: String                // Report time
}
```

### 9. Payment Model

```javascript
{
  reportID: ObjectId,         // Reference to Report (required)
  paid: Boolean               // Payment status (default: false)
}
```

### 10. Prescription Model

```javascript
{
  docName: String,            // Doctor name (required)
  nurseName: String,          // Nurse name (required)
  
  hospital: {
    name: String,             // Hospital name (required)
    address: {
      street: String,         // Street address (required)
      city: String,           // City (required)
      state: String,          // State (required)
      pincode: Number         // PIN code (required)
    },
    phone: Number             // Hospital phone (required)
  },
  
  medicines: {
    diagnosis: String,        // Diagnosis
    medicineName: String,     // Medicine name (required)
    type: String,             // Medicine type (required)
    dosage: {
      quantity: Number,       // Quantity (required)
      duration: Number        // Duration in days (required)
    }
  },
  
  advice: String,             // Medical advice
  total: Number               // Total cost (required)
}
```

### Entity Relationship Diagram

```
┌──────────────┐       ┌──────────────┐       ┌──────────────┐
│    Admin     │       │    Doctor    │       │    Nurse     │
├──────────────┤       ├──────────────┤       ├──────────────┤
│ adminID (PK) │       │ docID (PK)   │       │ nurseID (PK) │
│ adminName    │       │ docName      │       │ nurseName    │
│ email        │       │ department   │       │ email        │
│ password     │       │ email        │       │ password     │
│ ...          │       │ password     │       │ ...          │
└──────────────┘       │ ...          │       └───────┬──────┘
                       └───────┬──────┘               │
                               │                      │
                               │ 1:N                  │ 1:N
                               ▼                      ▼
                       ┌──────────────────────────────────┐
                       │            Patient               │
                       ├──────────────────────────────────┤
                       │ patientID (PK)                   │
                       │ patientName                      │
                       │ docID (FK) ──────────────────────┤
                       │ nurseID (FK) ────────────────────┤
                       │ disease                          │
                       │ admitted                         │
                       │ ...                              │
                       └───────────────┬──────────────────┘
                                       │
           ┌───────────────────────────┼───────────────────────────┐
           │                           │                           │
           ▼                           ▼                           ▼
   ┌──────────────┐           ┌──────────────┐           ┌──────────────┐
   │ Appointment  │           │     Bed      │           │    Report    │
   ├──────────────┤           ├──────────────┤           ├──────────────┤
   │ patientID(FK)│           │ bedNumber    │           │ patientName  │
   │ patientName  │           │ roomNumber   │           │ docName      │
   │ date         │           │ patientID(FK)│           │ medicines[]  │
   │ time         │           │ occupied     │           │ ...          │
   │ department   │           └──────────────┘           └───────┬──────┘
   │ ...          │                                              │
   └──────────────┘                                              │
                                                                 │ 1:1
                                                                 ▼
                                                         ┌──────────────┐
                                                         │   Payment    │
                                                         ├──────────────┤
                                                         │ reportID(FK) │
                                                         │ paid         │
                                                         └──────────────┘

   ┌──────────────┐
   │  Ambulance   │  (Independent entity)
   ├──────────────┤
   │ ambulanceID  │
   │ type         │
   │ driver       │
   │ charges      │
   └──────────────┘
```

---

## API Endpoints

### Authentication Endpoints

| Method | Endpoint | Description | Access |
|--------|----------|-------------|--------|
| POST | `/admin/login` | Admin login | Public |
| POST | `/admin/register` | Register new admin | Admin |
| POST | `/admin/forgot` | Password recovery email | Public |
| POST | `/admin/password` | Send password to email | Admin |
| POST | `/doctors/login` | Doctor login | Public |
| POST | `/doctors/register` | Register new doctor | Admin |
| POST | `/nurses/login` | Nurse login | Public |
| POST | `/nurses/register` | Register new nurse | Admin |
| POST | `/patients/login` | Patient login | Public |
| POST | `/patients/register` | Register new patient | Nurse |

### Admin Routes (`/admin`)

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/admin` | Get all admins |
| POST | `/admin/login` | Admin login |
| POST | `/admin/register` | Create new admin |
| PATCH | `/admin/:adminId` | Update admin |
| DELETE | `/admin/:adminId` | Delete admin |

### Doctor Routes (`/doctors`)

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/doctors` | Get all doctors |
| POST | `/doctors/login` | Doctor login |
| POST | `/doctors/register` | Create new doctor |
| PATCH | `/doctors/:doctorId` | Update doctor profile |
| DELETE | `/doctors/:doctorId` | Delete doctor |

### Nurse Routes (`/nurses`)

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/nurses` | Get all nurses |
| POST | `/nurses/login` | Nurse login |
| POST | `/nurses/register` | Create new nurse |
| PATCH | `/nurses/:nurseId` | Update nurse profile |
| DELETE | `/nurses/:nurseId` | Delete nurse |

### Patient Routes (`/patients`)

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/patients` | Get all patients |
| POST | `/patients/register` | Register new patient |
| POST | `/patients/login` | Patient login |
| PATCH | `/patients/:patientId` | Update patient |
| DELETE | `/patients/:patientId` | Delete patient |

### Appointment Routes (`/appointments`)

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/appointments` | Get all appointments |
| POST | `/appointments/create` | Create appointment |
| DELETE | `/appointments/:id` | Delete appointment |

### Bed Routes (`/beds`)

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/beds` | Get all beds |
| POST | `/beds/add` | Add new bed |
| POST | `/beds/single` | Get single bed details |
| PATCH | `/beds/:id` | Update bed status |
| PUT | `/beds/discharge` | Discharge patient from bed |

### Ambulance Routes (`/ambulances`)

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/ambulances` | Get all ambulances |
| POST | `/ambulances/add` | Add new ambulance |
| DELETE | `/ambulances/:id` | Delete ambulance |

### Report Routes (`/reports`)

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/reports` | Get all reports |
| POST | `/reports/create` | Create medical report |

### Payment Routes (`/payments`)

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/payments` | Get all payments |
| POST | `/payments/add` | Create payment record |
| PATCH | `/payments/:id` | Update payment status |

### Hospital Routes (`/hospitals`)

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/hospitals` | Get dashboard statistics |

---

## User Roles & Permissions

### Role Hierarchy

```
┌─────────────────────────────────────────────────────────────────┐
│                         ADMIN                                   │
│  • Full system access                                           │
│  • Manage all users (doctors, nurses, admins)                   │
│  • Manage beds and ambulances                                   │
│  • View all data and statistics                                 │
├─────────────────────────────────────────────────────────────────┤
│                         DOCTOR                                  │
│  • View and update own profile                                  │
│  • View appointments                                            │
│  • Create medical reports                                       │
│  • Discharge patients                                           │
│  • View bed availability                                        │
├─────────────────────────────────────────────────────────────────┤
│                         NURSE                                   │
│  • View and update own profile                                  │
│  • Add new patients                                             │
│  • Book appointments                                            │
│  • View bed availability                                        │
└─────────────────────────────────────────────────────────────────┘
```

### Permission Matrix

| Feature | Admin | Doctor | Nurse | Patient |
|---------|:-----:|:------:|:-----:|:-------:|
| View Dashboard | ✅ | ✅ | ✅ | ❌ |
| Add Doctor | ✅ | ❌ | ❌ | ❌ |
| Add Nurse | ✅ | ❌ | ❌ | ❌ |
| Add Admin | ✅ | ❌ | ❌ | ❌ |
| Add Beds | ✅ | ❌ | ❌ | ❌ |
| Add Ambulance | ✅ | ❌ | ❌ | ❌ |
| Add Patient | ❌ | ❌ | ✅ | ❌ |
| Book Appointment | ❌ | ❌ | ✅ | ❌ |
| View Appointments | ❌ | ✅ | ❌ | ❌ |
| Create Report | ❌ | ✅ | ❌ | ❌ |
| View Reports | ❌ | ✅ | ❌ | ✅ |
| Discharge Patient | ❌ | ✅ | ❌ | ❌ |
| View Bed Status | ✅ | ✅ | ✅ | ❌ |
| Edit Own Profile | ✅ | ✅ | ✅ | ✅ |

---

## Frontend Routes

### Route Definitions

| Path | Component | Access | Description |
|------|-----------|--------|-------------|
| `/` | `DLogin` | Public | Login page |
| `/dashboard` | `FrontPage` | All Users | Main dashboard with statistics |

### Admin Routes

| Path | Component | Description |
|------|-----------|-------------|
| `/addoctor` | `AddDoctor` | Add new doctor form |
| `/addnurse` | `Add_Nurse` | Add new nurse form |
| `/admin` | `Add_Admin` | Add new admin form |
| `/addbeds` | `AddBeds` | Add new beds form |
| `/addambulance` | `Add_Ambulance` | Add new ambulance form |
| `/rooms` | `Beds_Rooms` | View all beds/rooms |

### Doctor Routes

| Path | Component | Description |
|------|-----------|-------------|
| `/doctorprofile` | `Doctor_Profile` | Doctor's profile page |
| `/checkappointment` | `Check_Appointment` | View and manage appointments |
| `/reports` | `AllReport` | View all medical reports |
| `/createslip` | `Discharge_and_Create_Slip` | Create discharge report |
| `/patientdetails` | `Patient_Details` | View patient information |

### Nurse Routes

| Path | Component | Description |
|------|-----------|-------------|
| `/nurseprofile` | `Nurse_Profile` | Nurse's profile page |
| `/addpatient` | `Add_Patient` | Add new patient form |
| `/bookappointment` | `Book_Appointment` | Book patient appointment |

---

## Getting Started

### Prerequisites

- **Docker** (v20.10+) and **Docker Compose** (v2.0+)
  - OR **Node.js** (v18+) and **MongoDB** (v6.0+) for local development

### Quick Start with Docker (Recommended)

```bash
# Clone the repository
git clone <repository-url>
cd Hospital_Management_System

# Start all services
./start.sh
```

The application will be available at:
- **Frontend**: http://localhost:3000
- **Backend API**: http://localhost:8080

### Default Login Credentials

| Role | ID | Password |
|------|-----|----------|
| Admin | 100 | masai |
| Doctor | 101 | masai |
| Nurse | 102 | masai |

---

## Scripts Reference

### Production Scripts

#### `start.sh` - Start All Services

Builds and starts all Docker containers in production mode.

```bash
./start.sh
```

**What it does:**
1. Checks Docker and Docker Compose installation
2. Stops any existing containers
3. Builds all Docker images
4. Starts MongoDB, Backend, and Frontend containers
5. Waits for services to be healthy
6. Seeds the database with default users
7. Displays connection URLs and credentials

**Output URLs:**
- Frontend: http://localhost:3000
- Backend: http://localhost:8080
- MongoDB: mongodb://localhost:27017

---

#### `stop.sh` - Stop All Services

Gracefully stops all running containers.

```bash
./stop.sh
```

**What it does:**
1. Stops all running containers
2. Removes container networks
3. Preserves database volume data

---

#### `restart.sh` - Restart All Services

Stops and starts all services.

```bash
./restart.sh
```

---

#### `logs.sh` - View Container Logs

View real-time logs from containers.

```bash
# View all logs
./logs.sh

# View specific service logs
./logs.sh backend
./logs.sh frontend
./logs.sh mongodb
```

**Usage:**
- Press `Ctrl+C` to exit log view

---

#### `clean.sh` - Full Cleanup

Removes all containers, volumes, and images.

```bash
./clean.sh
```

**⚠️ Warning:** This will delete all data including the database!

**What it removes:**
- All HMS containers
- Database volume (all data)
- Built Docker images
- Dangling images

---

### Development Scripts

#### `start-dev.sh` - Development Mode

Starts services with hot reload enabled.

```bash
./start-dev.sh
```

**Features:**
- Source code mounted as volumes
- Changes reflect immediately without rebuild
- Uses `nodemon` for backend
- Uses React dev server for frontend

**Best for:**
- Active development
- Quick iteration
- Debugging

---

#### `start-local.sh` - Local Mode (No Docker)

Runs services directly on your machine.

```bash
./start-local.sh
```

**Requirements:**
- Node.js 18+
- MongoDB running on localhost:27017

**What it does:**
1. Checks Node.js installation
2. Verifies MongoDB connection
3. Installs dependencies
4. Seeds the database
5. Starts backend with `nodemon`
6. Starts frontend with React dev server

---

### Script Comparison

| Feature | `start.sh` | `start-dev.sh` | `start-local.sh` |
|---------|:----------:|:--------------:|:----------------:|
| Docker Required | ✅ | ✅ | ❌ |
| Hot Reload | ❌ | ✅ | ✅ |
| Production Ready | ✅ | ❌ | ❌ |
| Uses Nginx | ✅ | ❌ | ❌ |
| Database Seeding | ✅ | Manual | ✅ |
| Build Time | Longer | Medium | Fastest |
| Best For | Deployment | Development | Quick Testing |

---

### Common Script Commands

```bash
# ========== PRODUCTION ==========
# Start everything
./start.sh

# Stop everything
./stop.sh

# Restart
./restart.sh

# View logs
./logs.sh
./logs.sh backend
./logs.sh frontend

# Full cleanup (deletes data!)
./clean.sh

# ========== DEVELOPMENT ==========
# Start with hot reload (Docker)
./start-dev.sh

# Start without Docker
./start-local.sh

# ========== DOCKER COMPOSE DIRECT ==========
# Production
docker compose up -d
docker compose down
docker compose logs -f

# Development
docker compose -f docker-compose.dev.yml up
docker compose -f docker-compose.dev.yml down

# ========== MANUAL SEEDING ==========
cd Backend
node seed.js
```

---

## Docker Configuration

### Production Configuration (`docker-compose.yml`)

```yaml
services:
  mongodb:     # MongoDB 6.0 database
  backend:     # Node.js API server
  frontend:    # Nginx serving React build
  seed:        # One-time database seeder
```

**Volumes:**
- `mongodb_data` - Persistent database storage

**Networks:**
- `hms-network` - Internal container communication

### Development Configuration (`docker-compose.dev.yml`)

```yaml
services:
  mongodb:     # MongoDB 6.0 database
  backend:     # Node.js with nodemon (hot reload)
  frontend:    # React dev server (hot reload)
```

**Volume Mounts:**
- `./Backend:/app` - Backend source code
- `./FrontEnd:/app` - Frontend source code

---

## Environment Variables

### Backend Variables

| Variable | Description | Default |
|----------|-------------|---------|
| `port` | Server port | 8080 |
| `dbURL` | MongoDB connection URL | mongodb://mongodb:27017/hms |
| `key` | JWT secret key | hms_jwt_secret_key_2024 |

### Frontend Variables

| Variable | Description | Default |
|----------|-------------|---------|
| `REACT_APP_API_URL` | Backend API URL | http://localhost:8080 |

### Setting Environment Variables

**Docker (via docker-compose.yml):**
```yaml
environment:
  - port=8080
  - dbURL=mongodb://mongodb:27017/hms
  - key=your_secret_key
```

**Local Development:**
Create `Backend/.env`:
```env
port=8080
dbURL=mongodb://localhost:27017/hms
key=your_secret_key
```

---

## Features

### Dashboard Features

#### Overview Statistics
- Total doctors, nurses, patients, admins
- Available beds and ambulances
- Active appointments
- Generated reports

#### Patient Table
- Real-time patient list
- Search and filter capabilities
- Quick access to patient details

### Admin Features

- ➕ **Add Doctor** - Register new doctors with specialization
- ➕ **Add Nurse** - Register new nursing staff
- ➕ **Add Admin** - Create new admin accounts
- 🛏️ **Manage Beds** - Add rooms and beds
- 🚑 **Manage Ambulances** - Fleet management
- 📊 **View Statistics** - Hospital-wide metrics

### Doctor Features

- 👤 **Profile Management** - Update personal details
- 📅 **View Appointments** - See scheduled patients
- 📋 **Create Reports** - Generate medical reports
- 💊 **Prescriptions** - Add medications with dosage
- 🏥 **Discharge Patients** - Complete treatment workflow
- 🛏️ **Check Beds** - View bed availability

### Nurse Features

- 👤 **Profile Management** - Update personal details
- ➕ **Add Patients** - Register new patients
- 📅 **Book Appointments** - Schedule patient visits
- 🛏️ **Check Beds** - View bed availability

### Authentication Features

- 🔐 **Role-based Login** - Admin/Doctor/Nurse
- 🔑 **JWT Authentication** - Secure API access
- 📧 **Password Recovery** - Email-based reset
- 💾 **Persistent Sessions** - LocalStorage based

---

## Troubleshooting

### Common Issues

#### Docker Issues

**Problem:** `Cannot connect to Docker daemon`
```bash
# Make sure Docker is running
sudo systemctl start docker
# Or on macOS, start Docker Desktop
```

**Problem:** `Port already in use`
```bash
# Check what's using the port
lsof -i :3000
lsof -i :8080
lsof -i :27017

# Kill the process or use different ports
```

**Problem:** `Container keeps restarting`
```bash
# Check container logs
./logs.sh backend
./logs.sh frontend

# Or directly
docker logs hms-backend
docker logs hms-frontend
```

#### MongoDB Issues

**Problem:** `MongoDB connection failed`
```bash
# Check if MongoDB container is running
docker ps | grep mongodb

# Check MongoDB logs
docker logs hms-mongodb

# Verify connection from backend
docker exec -it hms-backend sh
wget -qO- http://mongodb:27017
```

**Problem:** `Database not seeded`
```bash
# Manually run seed script
docker compose run --rm seed

# Or locally
cd Backend
node seed.js
```

#### Frontend Issues

**Problem:** `API connection failed`
```bash
# Check if backend is accessible
curl http://localhost:8080

# Verify REACT_APP_API_URL is set correctly
docker exec hms-frontend env | grep REACT_APP
```

**Problem:** `Blank page / React not loading`
```bash
# Check frontend logs
./logs.sh frontend

# Rebuild frontend
docker compose build frontend
docker compose up -d frontend
```

#### Authentication Issues

**Problem:** `Login not working`
- Verify credentials: ID: 100, Password: masai
- Check if database is seeded
- Clear browser localStorage

**Problem:** `JWT token expired`
- Logout and login again
- Clear localStorage: `localStorage.clear()`

### Useful Debug Commands

```bash
# Check running containers
docker ps

# Check all containers (including stopped)
docker ps -a

# View container resource usage
docker stats

# Access container shell
docker exec -it hms-backend sh
docker exec -it hms-frontend sh
docker exec -it hms-mongodb mongosh

# Check network connectivity
docker network ls
docker network inspect hms-network

# View Docker logs
docker compose logs --tail=100 -f

# Rebuild specific service
docker compose build --no-cache backend
docker compose up -d backend

# Complete reset
./clean.sh
./start.sh
```

### Getting Help

1. Check container logs: `./logs.sh`
2. Verify all services are running: `docker ps`
3. Test API directly: `curl http://localhost:8080/`
4. Check browser console for frontend errors
5. Verify environment variables are set correctly

---

## License

This project is open source and available under the MIT License.

---

*Last Updated: January 2026*

