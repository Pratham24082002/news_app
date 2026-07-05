# 📰 NewsPulse

A Flutter news application built using **Clean Architecture** and **BLoC** that fetches the latest news from the NewsAPI. The app allows users to browse news by category, search articles, read article details, and open the full article in the browser.

---

## 📱 Features

- 🚀 Animated Splash Screen
- 🏠 Clean Home Screen with News Categories
- 📰 Browse Top Headlines by Category
- 🔍 Search News Articles
- 📄 Article Detail Screen
- 🌐 Read Full Article in Browser
- 📄 Infinite Scroll Pagination
- 🔄 Pull to Refresh
- ✨ Shimmer Loading Effect
- 📡 Internet Connectivity Check
- ⚠️ Error Handling
- 📝 API Logging using Dio Interceptors

---

## 📂 Project Structure

```
lib/
│
├── core/
│   ├── constants/
│   ├── error/
│   ├── network/
│   └── routes/
│
├── data/
│   ├── datasource/
│   ├── models/
│   └── repositories/
│
├── domain/
│   ├── entities/
│   └── repositories/
│
├── presentation/
│   ├── bloc/
│   ├── screens/
│   └── widgets/
│
└── main.dart
```

---

## 🏗️ Architecture

The project follows **Clean Architecture** with **BLoC** for state management.

```
Presentation
      │
      ▼
     BLoC
      │
      ▼
 Repository
      │
      ▼
Remote Data Source
      │
      ▼
     Dio
      │
      ▼
   NewsAPI
```

---

## 🛠 Tech Stack

- Flutter
- Dart
- flutter_bloc
- Dio
- Equatable
- connectivity_plus
- shimmer
- url_launcher

---

## 📡 API

This project uses the **NewsAPI**.

https://newsapi.org/

---

## 🚀 Getting Started

### Clone the repository

```bash
git clone https://github.com/yourusername/newspulse.git
```

### Install dependencies

```bash
flutter pub get
```

### Add your API Key

Create the following file:

```
lib/core/constants/secrets.dart
```

Add your NewsAPI key:

```dart
class Secrets {
  static const String newsApiKey = 'YOUR_API_KEY';
}
```

### Run the application

```bash
flutter run
```

---

## 📦 Build Release APK

```bash
flutter build apk --release
```

APK location:

```
build/app/outputs/flutter-apk/app-release.apk
```

---

## ✨ Implemented Features

- Clean Architecture
- Repository Pattern
- BLoC State Management
- Dependency Separation
- Pagination
- Search Functionality
- Shimmer Loading
- Connectivity Check
- Dio Logging Interceptor
- External Browser Support

---

## 👨‍💻 Author

**Pratham Kandalgaonkar**

GitHub: https://github.com/Pratham24082002

---

## 📄 License

This project is developed for learning and interview demonstration purposes.