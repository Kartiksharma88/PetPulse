# 🐾 PetPulse – Portable Pet Processing Unit
*A Flutter + Laravel Full Stack CRUD Application*

---

## 🧭 Project Summary

**PetPulse** is a cross-platform application developed using **Flutter** (frontend) and **Laravel** (backend) for managing pet records.
It enables users to perform **CRUD operations** (Create, Read, Update, Delete) on pet data stored in a **MySQL database**.

This project demonstrates full-stack development skills by integrating a responsive Flutter UI with a Laravel REST API.

---

## 🏗️ System Architecture

```
+---------------------+         +--------------------+         +-----------------+
|    Flutter App      | <-----> |   Laravel Backend  | <-----> |  MySQL Database |
+---------------------+         +--------------------+         +-----------------+

Frontend → Sends requests to Laravel API  
Backend → Processes data and communicates with MySQL  
Database → Stores all pet-related information
```

---

## ⚙️ Backend Setup – Laravel

### Requirements
- PHP 8.1 or above  
- Composer  
- MySQL  

### Installation Steps

1. Navigate to your Laravel project folder:  
   `cd petpulse-backend`  

2. Install all dependencies:  
   `composer install`  

3. Copy the example environment file and generate an app key:  
   ```
   cp .env.example .env  
   php artisan key:generate
   ```

4. Configure your `.env` file with your database details:  
   ```
   DB_CONNECTION=mysql  
   DB_HOST=127.0.0.1  
   DB_PORT=3306  
   DB_DATABASE=petpulse_db  
   DB_USERNAME=root  
   DB_PASSWORD=
   ```

5. Run migrations and seed initial data:  
   `php artisan migrate --seed`  

6. Start the development server:  
   `php artisan serve`  

➡ **Laravel backend will now run on:** http://127.0.0.1:8000  

---

## 💻 Frontend Setup – Flutter

### Requirements
- Flutter SDK (latest stable version)  
- VS Code or Android Studio  
- Emulator or Chrome browser  

### Installation Steps

1. Navigate to your Flutter app folder:  
   `cd petpulse_app`  

2. Fetch all dependencies:  
   `flutter pub get`  

3. Run the app:  
   `flutter run -d chrome`  
   *(or use `flutter run -d windows` for desktop)*  

> ⚠️ Ensure that your Laravel server is running before launching Flutter.  

---

## 🗄️ Database Design

**Database Name:** `petpulse_db`  
**Main Table:** `pets`  

| Column | Type | Description |
|:-------|:------|:------------|
| id | INT (Primary Key) | Auto-increment unique ID |
| name | VARCHAR | Pet’s name |
| species | VARCHAR | Type of animal (Dog, Cat, etc.) |
| age | INT | Pet’s age |
| owner_name | VARCHAR | Pet owner’s name |
| created_at | TIMESTAMP | Record creation time |
| updated_at | TIMESTAMP | Record update time |

📄 **Database export file:** `pets.sql`

---

## 🌐 API Endpoints

| Method | Endpoint | Description |
|:-------|:----------|:------------|
| GET | `/api/pets` | Fetch all pets |
| GET | `/api/pets/{id}` | Fetch a single pet |
| POST | `/api/pets` | Add a new pet |
| PUT | `/api/pets/{id}` | Update existing pet |
| DELETE | `/api/pets/{id}` | Delete a pet record |

➡ All endpoints are defined in `routes/api.php` and handled by the `PetController`.  

---

## 🖥️ Core Features

- ➕ Add new pets with name, species, age, and owner details  
- 👀 View all registered pets in a responsive list  
- ✏️ Edit existing pet information  
- ❌ Delete pet records instantly  
- 🔄 Real-time API communication with Laravel backend  
- 🎨 Clean, minimal, and playful UI  

---

## 📸 Screenshots

Screenshots are available inside the **`screenshots/`** folder.  
Include the following:  
- Add Pet Screen  
- Pet List View  
- Edit Pet Form  
- Delete Confirmation  

---

## 🧠 Technology Stack

| Layer | Technology |
|:------|:------------|
| Frontend | Flutter (Dart) |
| Backend | Laravel (PHP) |
| Database | MySQL |
| API | RESTful JSON |
| Tools | VS Code, Android Studio, Postman |

---

## 📁 Folder Structure

```
PetPulse/
│
├── petpulse_app/          → Flutter frontend
├── petpulse-backend/      → Laravel backend
├── pets.sql               → Database export
├── screenshots/           → Screenshots folder
└── README.md              → Project documentation
```

---

## 🚀 Future Enhancements

- 🖼️ Add pet image upload functionality  
- 🔐 Implement authentication (Login/Signup)  
- 🔍 Add search and filter options  
- ☁️ Deploy on cloud platforms like Firebase or Render  

---

## ✅ Submission Checklist

☑️ `petpulse_app` – Flutter frontend  
☑️ `petpulse-backend` – Laravel backend  
☑️ `pets.sql` – Database export  
☑️ `README.md` – Documentation  
☑️ `screenshots/` – Screenshot folder  

---

## 🏁 Summary

PetPulse is a complete full-stack CRUD application that highlights modern web and mobile development practices using Flutter and Laravel.  
It demonstrates effective API handling, responsive UI design, and structured documentation for academic and professional evaluation.

---
