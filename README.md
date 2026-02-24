# Professional Hospital Management System

A comprehensive, full-stack Hospital Management System designed to digitize and streamline hospital operations. Built with the **MERN** stack (MongoDB, Express, React, Node.js), this application provides a centralized platform for managing patients, doctors, nurses, appointments, beds, and medical reports.

**Designed and Re-engineered by [Vartika Sharma](https://github.com/vartikasharmadev)**

## 🌟 Key Features

- **Role-Based Access Control**: Secure login systems for Admin, Doctor, and Nurse roles.
- **Dynamic Dashboard**: Real-time statistics and overview of hospital metrics.
- **Personalized Profiles**: Customized views for medical professionals (e.g., [Vartika Sharma's Profile](file:///Users/dineshgoyal/.gemini/antigravity/brain/b882c044-23ba-4b2a-b77f-8f4c2b08e0c6/vartika_profile_page_1771944900717.png)).
- **Patient Management**: Full lifecycle management from registration and admission to discharge.
- **Resource Tracking**: Real-time tracking of bed occupancy and ambulance fleet.
- **Medical Documentation**: Digital generation of medical reports and prescriptions.
- **Appointment Scheduling**: Efficient scheduling and management of patient-doctor consultations.

## 📸 Visible Pages

````carousel
![Main Dashboard](file:///Users/dineshgoyal/.gemini/antigravity/brain/b882c044-23ba-4b2a-b77f-8f4c2b08e0c6/main_dashboard_1771944485136.png)
<!-- slide -->
![Vartika Sharma's Profile](file:///Users/dineshgoyal/.gemini/antigravity/brain/b882c044-23ba-4b2a-b77f-8f4c2b08e0c6/vartika_profile_page_1771944900717.png)
<!-- slide -->
![Doctor Dashboard Overview](file:///Users/dineshgoyal/.gemini/antigravity/brain/b882c044-23ba-4b2a-b77f-8f4c2b08e0c6/doctor_dashboard_overview_1771944929485.png)
<!-- slide -->
![Add Doctor - Management View](file:///Users/dineshgoyal/.gemini/antigravity/brain/b882c044-23ba-4b2a-b77f-8f4c2b08e0c6/add_doctor_page_1771944502853.png)
<!-- slide -->
![Login Page](file:///Users/dineshgoyal/.gemini/antigravity/brain/b882c044-23ba-4b2a-b77f-8f4c2b08e0c6/final_login_page_1771944944449.png)
````

## 🛠️ Tech Stack

### Frontend
- **React**: Modern UI component architecture.
- **Redux / Redux Thunk**: Complex state management.
- **Ant Design**: Professional-grade UI components.
- **Axios**: Efficient API interaction.

### Backend
- **Node.js & Express**: High-performance server environment.
- **MongoDB**: Scalable NoSQL database.
- **Mongoose**: Robust object modeling.
- **JWT**: Secure token-based authentication.

## 🚀 Getting Started

### Prerequisites
- Node.js (v20+ recommended)
- MongoDB (Running locally on default port 27017)

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/vartikasharmadev/Hospital-Management-System.git
   cd Hospital-Management-System
   ```

2. **Backend Setup**
   ```bash
   cd Backend
   npm install
   # Create a .env file (see .env.example)
   node seed.js # Seed initial data (Vartika Sharma etc.)
   npm run dev
   ```

3. **Frontend Setup**
   ```bash
   cd ../FrontEnd
   npm install
   npm start
   ```

## 🔐 Credentials (Default)

| Role | ID | Password |
| :--- | :--- | :--- |
| **Admin** | 100 | masai |
| **Doctor** | 101 | masai |
| **Nurse** | 102 | masai |

---
*Created and maintained by [Vartika Sharma](https://github.com/vartikasharmadev).*
