import { useState, useEffect } from 'react';

// Types mimicking the Firestore Schema
export interface UserProfile {
  displayName: string;
  email: string;
  photoURL: string;
  isPlusUser: boolean;
  isLoggedIn: boolean;
}

export interface DailyStats {
  total_scrolls: number;
  instagram_count: number;
  youtube_count: number;
  snapchat_count: number;
  facebook_count: number;
  tiktok_count: number;
  minutes_spent: number;
}

export interface UserSettings {
  daily_scroll_limit: number;
  cooldown_minutes: number;
  blocked_apps: string[];
}

export interface UserDocument {
  profile: UserProfile;
  daily_stats: Record<string, DailyStats>;
  settings: UserSettings;
}

export interface BattleDocument {
  roomName: string;
  participants: string[];
  createdAt: string;
}

export interface DatabaseSchema {
  users: Record<string, UserDocument>;
  battles: Record<string, BattleDocument>;
}

// Initial Mock State
const initialState: DatabaseSchema = {
  users: {
    "uid_12345": {
      profile: {
        displayName: "Alex Doe",
        email: "alex@gmail.com",
        photoURL: "https://api.dicebear.com/7.x/avataaars/svg?seed=Alex",
        isPlusUser: false,
        isLoggedIn: true
      },
      daily_stats: {
        "2026-05-20": {
          total_scrolls: 142,
          instagram_count: 80,
          youtube_count: 62,
          snapchat_count: 0,
          facebook_count: 0,
          tiktok_count: 0,
          minutes_spent: 45
        }
      },
      settings: {
        daily_scroll_limit: 200,
        cooldown_minutes: 15,
        blocked_apps: ["com.instagram.android", "com.zhiliaoapp.musically"]
      }
    },
    "uid_67890": {
      profile: {
        displayName: "Sam Smith",
        email: "sam@gmail.com",
        photoURL: "https://api.dicebear.com/7.x/avataaars/svg?seed=Sam",
        isPlusUser: true,
        isLoggedIn: false
      },
      daily_stats: {
        "2026-05-20": {
          total_scrolls: 210,
          instagram_count: 100,
          youtube_count: 10,
          snapchat_count: 0,
          facebook_count: 0,
          tiktok_count: 100,
          minutes_spent: 120
        }
      },
      settings: {
        daily_scroll_limit: 300,
        cooldown_minutes: 30,
        blocked_apps: []
      }
    }
  },
  battles: {
    "battle_id_987": {
      roomName: "Weekend Detox Crew",
      participants: ["uid_12345", "uid_67890"],
      createdAt: "2026-05-20T00:00:00Z"
    }
  }
};

// PubSub mechanism for Reactivity
type Listener = (state: DatabaseSchema) => void;
let state: DatabaseSchema = JSON.parse(JSON.stringify(initialState));
const listeners = new Set<Listener>();

export const mockDB = {
  getState: () => state,
  
  subscribe: (listener: Listener) => {
    listeners.add(listener);
    return () => listeners.delete(listener);
  },
  
  updateUserStats: (uid: string, date: string, platform: keyof DailyStats, increment: number) => {
    state = JSON.parse(JSON.stringify(state)); // Deep clone for immutability
    const stats = state.users[uid].daily_stats[date];
    if (stats) {
      if (platform !== 'minutes_spent') {
        stats.total_scrolls += increment;
      }
      stats[platform] += increment;
    }
    listeners.forEach(l => l(state));
  },

  upgradeToPlus: (uid: string) => {
    state = JSON.parse(JSON.stringify(state));
    state.users[uid].profile.isPlusUser = true;
    listeners.forEach(l => l(state));
  },

  updateSettings: (uid: string, settings: Partial<UserSettings>) => {
    state = JSON.parse(JSON.stringify(state));
    state.users[uid].settings = { ...state.users[uid].settings, ...settings };
    listeners.forEach(l => l(state));
  },
  
  login: (uid: string) => {
    state = JSON.parse(JSON.stringify(state));
    state.users[uid].profile.isLoggedIn = true;
    listeners.forEach(l => l(state));
  },

  logout: (uid: string) => {
    state = JSON.parse(JSON.stringify(state));
    state.users[uid].profile.isLoggedIn = false;
    listeners.forEach(l => l(state));
  }
};

// React Hook to consume the mock database
export function useDatabase() {
  const [dbState, setDbState] = useState<DatabaseSchema>(mockDB.getState());

  useEffect(() => {
    const unsubscribe = mockDB.subscribe(setDbState);
    return unsubscribe;
  }, []);

  return dbState;
}
