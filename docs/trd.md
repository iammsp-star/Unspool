# Technical Requirement Document (TRD)

## Architecture Strategy
To ensure easy deployment to the Play Store and cross-platform capabilities, a Flutter or React Native frontend combined with a Firebase or Supabase backend is ideal.

## Technology Stack
* **Frontend:** Flutter (Dart) or React Native (TypeScript).
* **Backend & Database:** Firebase Suite (Auth, Firestore, Cloud Functions). Provides easy Google Login and real-time listeners for friend battles without maintaining a custom server.
* **OS Permissions:** Android AccessibilityService API (required to detect scroll events and overlay block screens on third-party apps like Instagram/TikTok).

## System Topology Diagram
```
[Android Client (App)] 
       │
       ├──► [Accessibility API] ──► (Tracks Scrolls / Injects Overlay)
       │
       ├──► [Firebase Auth] ──────► (Google Sign-In Authentication)
       │
       └──► [Cloud Firestore] ────► (Stores Sync'd User Stats & Leaderboards)
```

## Backend Schema (Firestore NoSQL Structure)
```json
{
  "users": {
    "uid_12345": {
      "profile": {
        "displayName": "Alex Doe",
        "email": "alex@gmail.com",
        "photoURL": "https://...",
        "isPlusUser": true
      },
      "daily_stats": {
        "2026-05-20": {
          "total_scrolls": 142,
          "instagram_count": 80,
          "youtube_count": 62,
          "minutes_spent": 45
        }
      },
      "settings": {
        "daily_scroll_limit": 200,
        "cooldown_minutes": 15,
        "blocked_apps": ["com.instagram.android", "com.zhiliaoapp.musically"]
      }
    }
  },
  "battles": {
    "battle_id_987": {
      "roomName": "Weekend Detox Crew",
      "participants": ["uid_12345", "uid_67890"],
      "createdAt": "2026-05-20T00:00:00Z"
    }
  }
}
```
