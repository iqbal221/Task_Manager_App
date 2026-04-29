📱 Task Manager App

<p>A simple, fast, and modern Task Management Mobile App built with Flutter and powered by an Express.js + MongoDB backend.
Manage your daily tasks efficiently with clean UI and real-time updates.</p>
................
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

................
📊 Task Status System
Each task has one of the following statuses:

🟢 New
🔵 Progress
✅ Completed
❌ Cancelled

Dashboard shows task count like:

[
  { "status": "New", "count": 2 },
  { "status": "Progress", "count": 1 },
  { "status": "Completed", "count": 0 },
  { "status": "Cancelled", "count": 1 }
]

.......................
🛠️ Tech Stack
📱 Frontend
Flutter
Provider (State Management)
REST API Integration

🌐 Backend
Node.js
Express.js
MongoDB
Mongoose
............
⚙️ Installation Guide
1️⃣ Clone Repository
git clone https://github.com/your-username/task-manager-app.git
2️⃣ Install Dependencies
flutter pub get
3️⃣ Run App
flutter run

........................
🔗 API Configuration

Update your API base URL:

Urls.baseUrl = "http://YOUR_IP:5000/api/v1";
📌 Important Notes
📱 Android Emulator → 10.0.2.2

📱 Physical Device → Use your PC IP
Example:

http://192.168.1.100:5000/api/v1
📦 Build Release APK
flutter build apk --release
