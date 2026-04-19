📱 Task Manager App

A simple, fast, and modern Task Management Mobile App built with Flutter and powered by an Express.js + MongoDB backend.
Manage your daily tasks efficiently with clean UI and real-time updates.

🚀 Features
✅ User Authentication (Login / Signup)
✅ Create New Tasks
✅ Update Task Status (New, Progress, Completed, Cancelled)
✅ Delete Tasks
✅ Task Status Count Dashboard
✅ Clean & Responsive UI
✅ Dark Mode Support 🌙
✅ REST API Integration
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
📸 Screenshots

Add your app screenshots here before uploading to Play Store

Login Screen
Dashboard
Task List
Add Task Screen
⚙️ Installation
1. Clone the repository
git clone https://github.com/your-username/task-manager-app.git
2. Install dependencies
flutter pub get
3. Run the app
flutter run
🔗 API Configuration

Update your API base URL in:

Urls.baseUrl = "http://YOUR_IP:5000/api/v1";
Important for Emulator:
Android Emulator → 10.0.2.2
Physical Device → Use your PC IP (e.g. 192.168.x.x)
📦 Build APK
flutter build apk --release
🎯 Play Store Description (Short)

Task Manager App helps you organize your daily tasks efficiently with a clean UI, status tracking, and real-time updates.

🔒 Authentication
Secure login system
Token-based authentication
User session handling
🌙 Theme Support
Default: Dark Mode
Light Mode supported
Dynamic UI color changes
🧠 Future Improvements
🔔 Push Notifications
📅 Task Reminder
☁️ Cloud Sync
📊 Analytics Dashboard
🤝 Contribution

Feel free to fork this project and contribute:

git checkout -b feature/new-feature
📄 License

This project is licensed under the MIT License.

👨‍💻 Developer

Md Zahed Iqbal
Flutter Developer 🚀

⭐ Support

If you like this project, give it a ⭐ on GitHub!
