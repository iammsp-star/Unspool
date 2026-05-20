# Unspool 🔒

Unspool is an open-source, cross-platform digital wellbeing application designed to help you break free from short-form video addiction. Track your daily scroll counts, battle friends to stay accountable, and hard-lock your feeds when you hit your limit.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Platform](https://img.shields.io/badge/platform-Android%20|%20Windows%20|%20macOS-blue)](https://flutter.dev)

---

## 📥 Download Unspool

*(Note: Official binaries will be available here soon via GitHub Releases.)*

- 📱 **[Download for Android (.apk)](https://github.com/iammsp-star/Unspool/releases)** *(Coming Soon)*
- 💻 **[Download for Windows (.exe)](https://github.com/iammsp-star/Unspool/releases)** *(Coming Soon)*
- 🍏 **[Download for macOS (.dmg)](https://github.com/iammsp-star/Unspool/releases)** *(Coming Soon)*

---

## 🚀 Features

- **Multi-Platform Sync:** Access your stats and manage your limits seamlessly across your Android device and laptop.
- **Reel Scroll Tracker:** Automatically monitors scroll overhead and platform usage across popular short-form media networks.
- **Reel Battle:** Invite friends to live leaderboards to see who can maintain the lowest scroll counts.
- **Hard Cooldowns (Plus Tier):** Enforces a strict system-level block once your limits are breached to force a digital detox.
- **Secure Cloud Storage:** Simple Google Login keeps your historical metrics and account level synchronized safely via a Firebase infrastructure.

---

## 🛠️ Architecture & Tech Stack

Unspool is built utilizing a modern, decoupled stack ensuring blazing-fast execution across both mobile and desktop environments:

- **Frontend Framework:** Flutter (Dart) — Multi-platform engine.
- **Database & Auth:** Firebase Core (Firestore, Firebase Auth with Google Sign-In).
- **Background Drivers (Android):** Custom `AccessibilityService` API listener to native hook system touch events and handle application overlays.
- **Desktop Window Manager:** Desktop-specific native plugins to monitor active application windows and manage focus/lockout routines.

---

## 💻 How to Build & Run Locally

### Prerequisites
Before compilation, ensure you have the following installed on your machine:
- [Flutter SDK](https://docs.flutter.dev/get-started/install) (Stable channel)
- [Android Studio](https://developer.android.com/studio) (For Android building)
- Xcode (If building for macOS) or Visual Studio (If building for Windows)
- A Firebase Project set up with **Google Sign-In** enabled.

### 1. Clone the Repository
```bash
git clone https://github.com/iammsp-star/Unspool.git
cd Unspool
```

### 2. Configure Firebase Environment

To connect the application to your own database cloud instances, add your config files:

* **For Mobile (Android):** Place your generated `google-services.json` file inside the `/android/app/` directory.
* **For Desktop:** Initialize your web/desktop web app keys within your Flutter entry configuration (`lib/main.dart`).

### 3. Install Dependencies

Get all required packages and plugins:

```bash
flutter pub get
```

### 4. Compiling the Builds

#### Target: Mobile (Android)

To run on a connected Android phone or emulator:

```bash
flutter run -d android
```

To generate a production-ready release package (`.apk` or `.aab`) for the Google Play Store:

```bash
flutter build apk --release
```

#### Target: Desktop (Laptop)

Ensure desktop support is enabled for your current OS (`flutter config --enable-windows-desktop` or `--enable-macos-desktop`).

Run locally on your laptop:

```bash
flutter run -d windows    # Or 'macos' / 'linux' depending on your OS
```

To compile a standalone executable installer for your desktop device:

```bash
flutter build windows    # Or 'macos' / 'linux'
```

---

## 🤝 Contributing & Open Source

Unspool is proudly **open-source** and distributed under the **MIT License**. We welcome developers, UI/UX designers, and anti-scroll advocates to help improve the tool!

1. Fork the Project.
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`).
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`).
4. Push to the Branch (`git push origin feature/AmazingFeature`).
5. Open a Pull Request.

---

## 📄 License

Distributed under the MIT License. See `LICENSE` for more information.
