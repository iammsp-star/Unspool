# Product Requirement Document (PRD)
**Project Name:** Unspool (Open Source)

**Objective:** A mobile application designed to curb short-form video addiction by tracking usage, setting hard limits, and offering gamified accountability.

## Core Features
1. **Reel Scroll Tracker:** Automatically tracks scroll count, daily time spent, and usage statistics across YouTube Shorts, Snapchat, Instagram Reels, Facebook Reels, and TikTok.
2. **Gamified Accountability ("Reel Battle"):** Allows users to compete with friends to see who scrolls the least.
3. **Digital Wellbeing Controls (Plus Feature):** Hard cooling-down timers and app blocking once limits are breached.
4. **Authentication & Cloud Sync:** Google Login to securely persist user stats, leaderboard rankings, and premium tier settings.

## Monetization / Freemium Tier
* **Free:** Scroll count, daily stats, and friend battles.
* **Plus (₹25/month billed annually or ₹99/monthly):** Hard limits, cooldown execution, and selective platform blocking.

## Appflow (User Journey Map)
```
[App Launch]
    │
    ▼
[First-Time Onboarding] ──► Prompt for Google Login ──► Request Android Accessibility Permissions
    │
    ▼
[Main Dashboard View]
    │
    ├───► [View Stats] ──► Deep dive into historical metrics
    │
    ├───► [Reel Battle] ──► Invite / view friends live leaderboard rankings
    │
    └───► [Hit Limit Triggered] 
                │
                ▼
      [Is User Plus Tier?]
         ├──► YES: Trigger "Cool Down Screen" overlay, blocking access.
         └──► NO:  Prompt Paywall ("Upgrade to Plus to Lock App").
```
