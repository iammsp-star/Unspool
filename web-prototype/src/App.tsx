import { useState } from 'react';
import { 
  Activity, Trophy, Settings, Lock, Smartphone, Database, 
  Play, MousePointer2, LogOut, CheckCircle2, ShieldAlert 
} from 'lucide-react';
import { mockDB, useDatabase } from './mockDatabase';
import { 
  AreaChart, Area, XAxis, CartesianGrid, Tooltip, ResponsiveContainer 
} from 'recharts';
import confetti from 'canvas-confetti';

const ACTIVE_UID = "uid_12345";
const TODAY = "2026-05-20";

function triggerConfetti() {
  confetti({
    particleCount: 100,
    spread: 70,
    origin: { y: 0.6 },
    colors: ['#6366f1', '#ec4899', '#10b981']
  });
}

// --- MOBILE EMULATOR SCREENS ---

function OnboardingScreen() {
  return (
    <div className="screen-enter flex flex-col items-center justify-center h-full p-6 text-center" style={{ backgroundColor: 'hsl(var(--bg-dark))' }}>
      <div className="w-24 h-24 rounded-3xl mb-8 flex items-center justify-center" style={{ background: 'linear-gradient(135deg, hsl(var(--primary)), hsl(var(--secondary)))' }}>
        <Activity size={48} color="white" />
      </div>
      <h1 className="text-3xl font-bold mb-4">Unspool</h1>
      <p className="text-lg mb-8" style={{ color: 'hsl(var(--text-secondary))' }}>
        Take back control of your time. Track your scrolls, battle friends, and cure your brainrot.
      </p>
      <button 
        className="btn btn-primary w-full py-4 text-lg rounded-2xl"
        onClick={() => mockDB.login(ACTIVE_UID)}
      >
        Sign in with Google
      </button>
    </div>
  );
}

function CircularProgress({ scrolls, limit }: { scrolls: number, limit: number }) {
  const percentage = Math.min((scrolls / limit) * 100, 100);
  const isOverLimit = scrolls >= limit;
  
  return (
    <div className="relative w-48 h-48 mx-auto my-6 flex items-center justify-center">
      <svg className="progress-ring w-full h-full" width="100%" height="100%" viewBox="0 0 100 100">
        <circle className="progress-ring__circle-bg" strokeWidth="8" fill="transparent" r="42" cx="50" cy="50" />
        <circle 
          className="progress-ring__circle" 
          stroke={isOverLimit ? 'hsl(var(--danger))' : 'hsl(var(--primary))'}
          strokeWidth="8" 
          strokeLinecap="round"
          fill="transparent" 
          r="42" cx="50" cy="50" 
          strokeDasharray="264" 
          strokeDashoffset={264 - (percentage / 100) * 264}
        />
      </svg>
      <div className="absolute text-center" style={{ transform: 'rotate(90deg)' }}>
        <div className="text-4xl font-bold">{scrolls}</div>
        <div className="text-sm" style={{ color: 'hsl(var(--text-muted))' }}>/ {limit} scrolls</div>
      </div>
    </div>
  );
}

function DashboardScreen({ user }: { user: any }) {
  const stats = user.daily_stats[TODAY] || { total_scrolls: 0, minutes_spent: 0, instagram_count: 0, youtube_count: 0, tiktok_count: 0 };
  const limit = user.settings.daily_scroll_limit;
  
  const chartData = [
    { name: 'IG', value: stats.instagram_count },
    { name: 'YT', value: stats.youtube_count },
    { name: 'TT', value: stats.tiktok_count },
    { name: 'SC', value: stats.snapchat_count },
    { name: 'FB', value: stats.facebook_count },
  ];

  return (
    <div className="screen-enter p-6 h-full overflow-y-auto pb-24" style={{ backgroundColor: 'hsl(var(--bg-dark))' }}>
      <div className="flex justify-between items-center mb-6">
        <h2 className="text-2xl font-bold">Today</h2>
        {user.profile.isPlusUser && (
          <div className="px-3 py-1 rounded-full text-xs font-bold bg-opacity-20" style={{ background: 'hsl(var(--secondary) / 0.2)', color: 'hsl(var(--secondary))' }}>
            PLUS
          </div>
        )}
      </div>
      
      <div className="glass-card p-6 text-center mb-6">
        <CircularProgress scrolls={stats.total_scrolls} limit={limit} />
        <div className="text-xl font-semibold mb-1">{stats.minutes_spent} mins wasted</div>
        <p className="text-sm" style={{ color: 'hsl(var(--text-secondary))' }}>Keep it under control today!</p>
      </div>

      <h3 className="text-lg font-bold mb-4">Platform Breakdown</h3>
      <div className="h-48 mb-6 glass-card p-4">
        <ResponsiveContainer width="100%" height="100%">
          <AreaChart data={chartData}>
            <defs>
              <linearGradient id="colorValue" x1="0" y1="0" x2="0" y2="1">
                <stop offset="5%" stopColor="hsl(var(--primary))" stopOpacity={0.8}/>
                <stop offset="95%" stopColor="hsl(var(--primary))" stopOpacity={0}/>
              </linearGradient>
            </defs>
            <CartesianGrid strokeDasharray="3 3" stroke="hsl(var(--border-glass))" vertical={false} />
            <XAxis dataKey="name" stroke="hsl(var(--text-muted))" fontSize={12} tickLine={false} axisLine={false} />
            <Tooltip 
              contentStyle={{ background: 'hsl(var(--bg-surface))', border: '1px solid hsl(var(--border-glass))', borderRadius: '8px' }}
              itemStyle={{ color: 'hsl(var(--text-primary))' }}
            />
            <Area type="monotone" dataKey="value" stroke="hsl(var(--primary))" fillOpacity={1} fill="url(#colorValue)" />
          </AreaChart>
        </ResponsiveContainer>
      </div>
    </div>
  );
}

function BattleScreen({ db }: { db: any }) {
  const battle = db.battles["battle_id_987"];
  const participants = battle.participants.map((uid: string) => ({
    uid,
    profile: db.users[uid].profile,
    stats: db.users[uid].daily_stats[TODAY] || { total_scrolls: 0 }
  })).sort((a: any, b: any) => a.stats.total_scrolls - b.stats.total_scrolls);

  return (
    <div className="screen-enter p-6 h-full overflow-y-auto pb-24" style={{ backgroundColor: 'hsl(var(--bg-dark))' }}>
      <h2 className="text-2xl font-bold mb-2">Reel Battles</h2>
      <p className="mb-6" style={{ color: 'hsl(var(--text-secondary))' }}>Compete to scroll the least.</p>
      
      <div className="glass-card p-5 mb-4 border border-indigo-500/30">
        <div className="flex justify-between items-center mb-4">
          <h3 className="font-bold text-lg">{battle.roomName}</h3>
          <span className="text-xs px-2 py-1 rounded bg-green-500/20 text-green-400 font-medium">LIVE</span>
        </div>
        
        <div className="space-y-4">
          {participants.map((p: any, index: number) => (
            <div key={p.uid} className="flex items-center justify-between bg-black/20 p-3 rounded-xl">
              <div className="flex items-center gap-3">
                <div className="font-bold text-lg w-6">{index + 1}</div>
                <img src={p.profile.photoURL} alt="avatar" className="w-10 h-10 rounded-full border border-gray-600" />
                <span className="font-semibold">{p.uid === ACTIVE_UID ? 'You' : p.profile.displayName}</span>
              </div>
              <div className="text-right">
                <div className="font-bold text-xl">{p.stats.total_scrolls}</div>
                <div className="text-xs text-gray-400">scrolls</div>
              </div>
            </div>
          ))}
        </div>
        
        {participants[0].uid === ACTIVE_UID && (
          <div className="mt-4 text-center text-sm font-medium text-emerald-400 bg-emerald-400/10 p-2 rounded-lg">
            You're winning! Keep off the reels!
          </div>
        )}
      </div>
    </div>
  );
}

function PaywallScreen() {
  return (
    <div className="screen-enter p-6 h-full overflow-y-auto pb-24 relative" style={{ backgroundColor: 'hsl(var(--bg-dark))' }}>
      <div className="text-center mt-4 mb-8">
        <h2 className="text-3xl font-bold mb-2 text-gradient">Unspool Plus</h2>
        <p style={{ color: 'hsl(var(--text-secondary))' }}>Unlock digital wellbeing controls.</p>
      </div>

      <div className="glass-card p-1 mb-6 border-2" style={{ borderColor: 'hsl(var(--secondary))' }}>
        <div className="bg-black/40 rounded-xl p-5 relative overflow-hidden">
          <div className="absolute top-0 right-0 bg-pink-500 text-white text-xs font-bold px-3 py-1 rounded-bl-lg z-10">
            BEST VALUE
          </div>
          <h3 className="text-xl font-bold mb-1">Yearly Plan</h3>
          <div className="text-3xl font-bold mb-1">₹25 <span className="text-base font-normal text-gray-400">/mo</span></div>
          <p className="text-sm text-gray-400 mb-4">Billed ₹299 annually (70% OFF)</p>
          <button 
            className="btn btn-primary w-full py-3"
            onClick={() => {
              mockDB.upgradeToPlus(ACTIVE_UID);
              triggerConfetti();
            }}
          >
            Upgrade Now
          </button>
        </div>
      </div>

      <div className="glass-card p-5 mb-8">
        <h3 className="text-lg font-bold mb-1">Monthly Plan</h3>
        <div className="text-xl font-bold mb-4">₹99 <span className="text-sm font-normal text-gray-400">/mo</span></div>
        <button 
          className="btn btn-glass w-full py-3"
          onClick={() => {
            mockDB.upgradeToPlus(ACTIVE_UID);
            triggerConfetti();
          }}
        >
          Select Monthly
        </button>
      </div>

      <h3 className="font-bold mb-4">Features</h3>
      <ul className="space-y-3 text-sm">
        <li className="flex gap-3 items-center"><CheckCircle2 size={18} color="hsl(var(--success))" /> Hard limits & blocking</li>
        <li className="flex gap-3 items-center"><CheckCircle2 size={18} color="hsl(var(--success))" /> Cooldown timers execution</li>
        <li className="flex gap-3 items-center"><CheckCircle2 size={18} color="hsl(var(--success))" /> Selective platform blocking</li>
      </ul>
    </div>
  );
}

function CooldownOverlay({ limit }: { limit: number }) {
  return (
    <div className="absolute inset-0 z-50 flex flex-col items-center justify-center p-6 text-center animate-enter" style={{ background: 'rgba(0,0,0,0.85)', backdropFilter: 'blur(24px)' }}>
      <ShieldAlert size={64} color="hsl(var(--danger))" className="mb-6 animate-pulse" />
      <h2 className="text-3xl font-bold mb-2">Limit Breached</h2>
      <p className="text-lg mb-8 text-gray-300">
        You've hit your limit of {limit} scrolls today. Your apps are now locked for cooldown.
      </p>
      <div className="text-5xl font-mono font-bold mb-8 text-pink-500">14:59</div>
      <p className="text-sm text-gray-400 mb-8">Put the phone down and take a breath.</p>
    </div>
  );
}


// --- MAIN APP COMPONENT ---

export default function App() {
  const db = useDatabase();
  const [activeTab, setActiveTab] = useState<'dashboard' | 'battles' | 'paywall'>('dashboard');
  
  const currentUser = db.users[ACTIVE_UID];
  const isLoggedIn = currentUser?.profile.isLoggedIn;
  const isPlusUser = currentUser?.profile.isPlusUser;
  
  const stats = currentUser?.daily_stats[TODAY];
  const limit = currentUser?.settings.daily_scroll_limit;
  const isOverLimit = Boolean(stats && limit && stats.total_scrolls >= limit);
  const showCooldown = Boolean(isOverLimit && isPlusUser);
  const showPaywallPrompt = Boolean(isOverLimit && !isPlusUser);

  // Render navigation bar for Mobile Emulator
  const BottomNav = () => (
    <div className="absolute bottom-0 left-0 right-0 h-20 bg-black/80 backdrop-blur-md border-t border-gray-800 flex justify-around items-center px-4 rounded-b-[36px] z-40">
      <button onClick={() => setActiveTab('dashboard')} className={`flex flex-col items-center gap-1 ${activeTab === 'dashboard' ? 'text-indigo-400' : 'text-gray-500'}`}>
        <Activity size={24} />
        <span className="text-[10px] font-semibold">Home</span>
      </button>
      <button onClick={() => setActiveTab('battles')} className={`flex flex-col items-center gap-1 ${activeTab === 'battles' ? 'text-indigo-400' : 'text-gray-500'}`}>
        <Trophy size={24} />
        <span className="text-[10px] font-semibold">Battles</span>
      </button>
      <button onClick={() => setActiveTab('paywall')} className={`flex flex-col items-center gap-1 ${activeTab === 'paywall' ? 'text-indigo-400' : 'text-gray-500'}`}>
        {isPlusUser ? <Settings size={24} /> : <Lock size={24} />}
        <span className="text-[10px] font-semibold">{isPlusUser ? 'Settings' : 'Upgrade'}</span>
      </button>
    </div>
  );

  return (
    <div className="min-h-screen text-white p-4" style={{ fontFamily: 'var(--font-body)' }}>
      {/* HEADER */}
      <header className="flex justify-between items-center py-4 px-8 mb-6 glass-panel">
        <div className="flex items-center gap-3">
          <div className="w-10 h-10 rounded-xl bg-indigo-600 flex items-center justify-center">
            <Activity size={24} color="white" />
          </div>
          <h1 className="text-2xl font-bold font-heading">Unspool <span className="text-sm font-normal text-indigo-400">Developer Preview</span></h1>
        </div>
        <div className="flex items-center gap-4">
          {isLoggedIn && (
            <div className="flex items-center gap-3">
              <span className="text-sm text-gray-400">{currentUser.profile.displayName}</span>
              <img src={currentUser.profile.photoURL} alt="User" className="w-10 h-10 rounded-full border-2 border-indigo-500" />
              <button onClick={() => mockDB.logout(ACTIVE_UID)} className="p-2 hover:bg-white/10 rounded-lg">
                <LogOut size={18} />
              </button>
            </div>
          )}
        </div>
      </header>

      <div className="flex flex-wrap lg:flex-nowrap gap-6 h-[calc(100vh-140px)]">
        
        {/* LEFT PANEL: MOBILE EMULATOR */}
        <div className="flex-shrink-0 mx-auto lg:mx-0">
          <div className="mobile-emulator">
            <div className="mobile-notch"></div>
            <div className="mobile-content relative">
              {!isLoggedIn ? (
                <OnboardingScreen />
              ) : (
                <>
                  {showCooldown && <CooldownOverlay limit={limit} />}
                  
                  {!showCooldown && showPaywallPrompt && activeTab !== 'paywall' && (
                    <div className="absolute inset-x-4 top-16 z-40 bg-pink-500 p-4 rounded-2xl shadow-2xl animate-pulse">
                      <div className="flex justify-between items-start mb-2">
                        <h3 className="font-bold">Limit Reached!</h3>
                      </div>
                      <p className="text-sm mb-3">You've hit your daily scroll limit. Upgrade to Plus to lock your apps automatically.</p>
                      <button onClick={() => setActiveTab('paywall')} className="bg-white text-pink-600 font-bold px-4 py-2 rounded-lg text-sm w-full">
                        Upgrade to Plus
                      </button>
                    </div>
                  )}

                  {activeTab === 'dashboard' && <DashboardScreen user={currentUser} />}
                  {activeTab === 'battles' && <BattleScreen db={db} />}
                  {activeTab === 'paywall' && <PaywallScreen />}
                  
                  <BottomNav />
                </>
              )}
            </div>
          </div>
        </div>

        {/* RIGHT PANEL: SIMULATOR & DATABASE */}
        <div className="flex-1 flex flex-col gap-6 overflow-hidden">
          
          {/* TOP: SIMULATOR CONSOLE */}
          <div className="glass-panel p-6 flex-shrink-0">
            <div className="flex items-center gap-2 mb-6 border-b border-white/10 pb-4">
              <Smartphone size={24} className="text-indigo-400" />
              <h2 className="text-xl font-bold font-heading">Accessibility Service Simulator</h2>
            </div>
            
            <div className="grid grid-cols-2 xl:grid-cols-4 gap-4">
              <button 
                className="btn btn-glass"
                disabled={!isLoggedIn || showCooldown}
                onClick={() => mockDB.updateUserStats(ACTIVE_UID, TODAY, 'instagram_count', 10)}
              >
                <MousePointer2 size={16} /> Scroll Instagram (+10)
              </button>
              <button 
                className="btn btn-glass"
                disabled={!isLoggedIn || showCooldown}
                onClick={() => mockDB.updateUserStats(ACTIVE_UID, TODAY, 'youtube_count', 15)}
              >
                <MousePointer2 size={16} /> Scroll YouTube (+15)
              </button>
              <button 
                className="btn btn-glass"
                disabled={!isLoggedIn || showCooldown}
                onClick={() => mockDB.updateUserStats(ACTIVE_UID, TODAY, 'minutes_spent', 5)}
              >
                <Play size={16} /> Watch Reels (+5m)
              </button>
              <button 
                className="btn btn-glass border-pink-500/50 hover:bg-pink-500/20"
                disabled={!isLoggedIn || showCooldown}
                onClick={() => mockDB.updateUserStats(ACTIVE_UID, TODAY, 'instagram_count', 100)}
              >
                <ShieldAlert size={16} className="text-pink-400" /> Trigger Limit Breach
              </button>
            </div>
          </div>

          {/* BOTTOM: REAL-TIME FIRESTORE VIEWER */}
          <div className="glass-panel p-0 flex-1 flex flex-col overflow-hidden border-indigo-500/30">
            <div className="bg-indigo-950/50 p-4 border-b border-indigo-500/20 flex items-center gap-2">
              <Database size={20} className="text-indigo-400" />
              <h2 className="font-bold font-mono text-sm tracking-widest text-indigo-200">FIRESTORE DOCUMENT STATE [LIVE]</h2>
            </div>
            <div className="p-4 overflow-y-auto flex-1 bg-black/40 font-mono text-xs sm:text-sm leading-relaxed">
              <pre className="text-emerald-400">
                {JSON.stringify(db, null, 2)}
              </pre>
            </div>
          </div>
          
        </div>
      </div>
    </div>
  );
}
