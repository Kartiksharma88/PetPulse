# 🐾 PetPulse - Portable Pet Processing Unit

## 📘 Overview
PetPulse is a full-stack **Flutter + Laravel** based application designed to manage pet records efficiently.  
It provides full CRUD functionality — allowing users to **add**, **view**, **edit**, and **delete** pet details with a simple and modern interface.

---

## ⚙️ Backend Setup (Laravel)

### Requirements
- PHP >= 8.1  
- Composer  
- MySQL  

### Steps to Setup

1. **Open a terminal and navigate to the backend folder:**
   ```bash
   cd petpulse-backend
Install dependencies:

bash
Copy code
composer install
Copy the environment file and generate an app key:

bash
Copy code
cp .env.example .env
php artisan key:generate
Configure your .env file with your database details:

env
Copy code
DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=petpulse_db
DB_USERNAME=root
DB_PASSWORD=
Run migrations and seed sample data:

bash
Copy code
php artisan migrate --seed
Start the Laravel development server:

bash
Copy code
php artisan serve
➜ Server will run at: http://127.0.0.1:8000

💻 Frontend Setup (Flutter)
Requirements
Flutter SDK (latest stable)

Android Studio or VS Code

Chrome browser (for web) or Visual Studio Build Tools (for Windows)

Steps to Setup
Navigate to the Flutter app folder:

bash
Copy code
cd petpulse_app
Install dependencies:

bash
Copy code
flutter pub get
Run the app:

For Web:

bash
Copy code
flutter run -d chrome
For Windows:

bash
Copy code
flutter run -d windows
Ensure the Laravel backend server is running before launching the Flutter app.

🗄️ Database Information
Database Name: petpulse_db

Export File: pets.sql

Main Table: pets

Column Name	Data Type	Description
id	INT (Primary Key)	Auto Increment
name	VARCHAR	Pet’s name
species	VARCHAR	Type of animal (Dog, Cat, etc.)
age	INT	Pet’s age
owner_name	VARCHAR	Pet owner’s name
created_at	TIMESTAMP	Record creation time
updated_at	TIMESTAMP	Last update time

🚀 API Endpoints
Method	Endpoint	Description
GET	/api/pets	Fetch all pets
GET	/api/pets/{id}	Fetch a single pet by ID
POST	/api/pets	Add new pet record
PUT	/api/pets/{id}	Update existing pet record
DELETE	/api/pets/{id}	Delete pet record

📸 Screenshots
Screenshots demonstrating CRUD operations are included in the screenshots/ folder:

🐕 Add New Pet Form

📋 Pet List View

✏️ Edit Pet Details

❌ Delete Pet Confirmation

🧠 Technologies Used
Frontend: Flutter (Dart)

Backend: Laravel (PHP)

Database: MySQL

API Communication: RESTful HTTP (JSON)

🧩 Folder Structure
arduino
Copy code
PetPulse/
│
├── petpulse_app/           ← Flutter frontend
│   ├── lib/
│   ├── pubspec.yaml
│   └── ...
│
├── petpulse-backend/       ← Laravel backend
│   ├── app/
│   ├── routes/
│   ├── database/
│   └── ...
│
├── pets.sql                ← Database export file
├── screenshots/            ← UI screenshots
└── README.md               ← Project documentation
📦 Submission Package Includes
✅ Flutter App Source Code
✅ Laravel Backend Source Code
✅ MySQL Database Export (pets.sql)
✅ README File (this one)
✅ Screenshots Folder

👨‍💻 Author
Kartik Sharma
Department of Computer Science
Model Institute of Engineering and Technology, Jammu

yaml
Copy code

---

✅ **How to update it:**
1. Open VS Code → open your existing `README.md`  
2. Press **Ctrl + A** to select all  
3. Press **Ctrl + V** to paste the above new version  
4. Press **Ctrl + S** to save  
