# Snusless 

A SwiftUI-based iOS app designed to help users quit using snus (Swedish tobacco) by tracking their progress, maintaining streaks, and visualizing financial savings.

## Overview

Snusless empowers users to break free from snus addiction by making the quitting process trackable. The app shows daily progress, calculates money saved, and motivates users through streak tracking and savings goals.

## Screenshots

<p align="center">
  <strong>Onboarding Start View</strong>
</p>
<p align="center">
  <img src="screenshots/onboarding-start.png" width="250" alt="Onboarding Start"/>
</p>

<p align="center">
  <strong>Onboarding Summary View</strong>
</p>
<p align="center">
  <img src="screenshots/onboarding-summary.png" width="250" alt="Onboarding Summary"/>
</p>

<p align="center">
  <strong>Home View</strong>
</p>
<p align="center">
  <img src="screenshots/home-view.png" width="250" alt="Home View"/>
</p>

<p align="center">
  <strong>Profile View</strong>
</p>
<p align="center">
  <img src="screenshots/profile-view.png" width="250" alt="Profile View"/>
</p>

<p align="center">
  <strong>Statistics View</strong>
</p>
<p align="center">
  <img src="screenshots/statistics-view.png" width="250" alt="Statistics View"/>
</p>

<p align="center">
  <strong>Edit Profile View</strong>
</p>
<p align="center">
  <img src="screenshots/edit-profile.png" width="250" alt="Edit Profile"/>
</p>

<p align="center">
  <strong>Settings View</strong>
</p>
<p align="center">
  <img src="screenshots/settings.png" width="250" alt="Settings"/>
</p>


## Features

### 🏠 Daily Check-in
- Mark each day as snus-free with a single tap
- Track when you've slipped up with honest accountability
- Automatic streak breaking detection if a day is missed

### 💰 Savings Tracker
- Real-time calculation of money saved since quitting
- Customizable savings goals to work towards
- Visual progress indicators showing financial benefits

### 🔥 Streak System
- Current streak tracking (consecutive snus-free days)
- Longest streak record keeping
- Daily check-in history with dates
- Automatic streak reset when relapsing

### 👤 User Profile
- Personalized experience with user name
- Edit profile to update:
  - Number of snus cans (dosor) used per day
  - Portions per can
  - Price per can
  - Start date
  - Savings goal

### 📈 Statistics
- View detailed usage patterns
- Track total snus portions not taken
- Monitor progress over time

### 🔔 Notifications 
- Push notifications for daily reminders helps the user stay consistent to check in the progress each day.


## Technical Details

### Architecture
- **Framework**: SwiftUI with Swift Concurrency
- **Data Persistence**: SwiftData
- **Design Pattern**: MVVM (Model-View-ViewModel)
- **Minimum iOS Version**: iOS 17.0+ (required for SwiftData)

### Data Models

#### User
Stores all user-specific information:
- Personal details (name, start date)
- Consumption patterns (dosor, portions, price)
- Progress tracking (streak, savings, longest streak)
- Relapse information (dayOfLostStreak, snusTakenCount)

#### Streak
Manages daily check-in history:
- Array of checked-in dates
- Relationship with User model (cascade delete)

### Key Components

```
Snusless/
├── Models/
│   ├── User.swift
│   └── Streak.swift
├── Views/
│   ├── HomeView.swift
│   ├── ProfileView.swift
│   ├── StatisticsView.swift
│   └── EditProfileView.swift
├── ViewModels/
│   ├── HomeViewModel.swift
│   └── EditProfileViewModel.swift
└── Navigation/
    ├── TabNavigation.swift
    └── CustomTabBarView.swift
```

## How It Works

1. **Onboarding**: Users set up their profile with consumption habits and goals
2. **Daily Tracking**: Each day, users check in to confirm they stayed snus-free
3. **Streak Building**: Consecutive snus-free days build up the streak counter
4. **Savings Calculation**: The app calculates money saved based on:
   ```
   Daily Cost = numberOfDosor × pricePerDosa
   Total Saved = Daily Cost × Days Since Start
   ```
5. **Accountability**: If users relapse, they mark it honestly to reset their streak


## Localization

The app supports Swedish and English language.

## Future Enhancements

Potential features for future development:

- Achievement badges for milestones
- Social features to share progress
- Health statistics integration
- Customizable themes


## Credits

Created by:
- Amanda Tanaskovic
- Aurelie Vaudan
- Pinar Buyukcelebi
- Jonathan Strid

Developed in 2026 as part of the Mobile Application Development Class of Folkuniversitetet Göteborg

---

**Note**: Snusless is designed to support individuals in their journey to quit snus. While the app provides tracking and motivation tools, users experiencing addiction should also consider consulting healthcare professionals for comprehensive support.

