📱 Task Manager App

<p>A simple, fast, and modern Task Management Mobile App built with Flutter and powered by an Express.js + MongoDB backend.
Manage your daily tasks efficiently with clean UI and real-time updates.</p>

🚀 Features</br>
✅ User Authentication (Login / Signup)</br>
✅ Create New Tasks</br>
✅ Update Task Status (New, Progress, Completed, Cancelled)</br>
✅ Delete Tasks</br>
✅ Task Status Count Dashboard</br>
✅ Clean & Responsive UI</br>
✅ Dark Mode Support 🌙</br>
✅ REST API Integration</br>
🛠️ Tech Stack</br>

📊 Task Status System</br>

Each task has one of the following statuses:
🟢 New</br>
🔵 Progress</br>
✅ Completed</br>
❌ Cancelled</br>

Dashboard shows task count like:</br>

[
  { "status": "New", "count": 2 },
  { "status": "Progress", "count": 1 },
  { "status": "Completed", "count": 0 },
  { "status": "Cancelled", "count": 1 }
]
</br>
🛠️ Tech Stack</br>
📱 Frontend
Flutter</br>
Provider (State Management)</br>
REST API Integration

🌐 Backend</br>
Node.js</br>
Express.js</br>
MongoDB</br>
Mongoose</br>

⚙️ Installation Guide</br>
1️⃣ Clone Repository</br>
git clone https://github.com/your-username/task-manager-app.git
2️⃣ Install Dependencies</br>
flutter pub get</br>
3️⃣ Run App</br>
flutter run
</br>
🔗 API Configuration
Update your API base URL:</br>
Urls.baseUrl = "http://YOUR_IP:5000/api/v1";</br>

📌 Important Notes</br>
📱 Android Emulator → 10.0.2.2</br>
📱 Physical Device → Use your PC IP</br>
Example:
http://192.168.1.100:5000/api/v1</br>
📦 Build Release APK</br>
flutter build apk --release
