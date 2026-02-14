import React, { useState, useEffect } from 'react';
import Navbar from './components/Navbar';
import Hero from './components/Hero';
import Features from './components/Features';
import AudioStudio from './components/AudioStudio';
import DownloadSection from './components/DownloadSection';
import FeedbackSection from './components/FeedbackSection';
import Footer from './components/Footer';
import PrivacyPolicy from './components/PrivacyPolicy';
import TermsOfService from './components/TermsOfService';

type Page = 'home' | 'privacy' | 'terms';

function App() {
  const [currentPage, setCurrentPage] = useState<Page>('home');
  const [loading, setLoading] = useState(true);
  const [isSplashExiting, setIsSplashExiting] = useState(false);

  useEffect(() => {
    window.scrollTo(0, 0);
  }, [currentPage]);

  useEffect(() => {
    const timer = setTimeout(() => {
      setIsSplashExiting(true);
      setTimeout(() => setLoading(false), 800);
    }, 3200);
    return () => clearTimeout(timer);
  }, []);

  const renderContent = () => {
    switch (currentPage) {
      case 'privacy':
        return <PrivacyPolicy onBack={() => setCurrentPage('home')} />;
      case 'terms':
        return <TermsOfService onBack={() => setCurrentPage('home')} />;
      default:
        return (
          <div className="fade-in-content">
            <Hero />
            
            <section className="py-12 border-y border-white/5 glass bg-white/[0.01]">
              <div className="max-w-7xl mx-auto px-6 grid grid-cols-2 md:grid-cols-4 gap-8">
                <div className="text-center group">
                  <span className="block text-4xl font-black tracking-tighter group-hover:text-blue-500 transition-colors">999k+</span>
                  <span className="text-[10px] font-black uppercase tracking-[0.2em] text-gray-600">Tracks Indexed</span>
                </div>
                <div className="text-center border-l border-white/5 group">
                  <span className="block text-4xl font-black tracking-tighter group-hover:text-blue-500 transition-colors">12k+</span>
                  <span className="text-[10px] font-black uppercase tracking-[0.2em] text-gray-600">Active Listeners</span>
                </div>
                <div className="text-center border-l border-white/5 group">
                  <span className="block text-4xl font-black tracking-tighter group-hover:text-blue-500 transition-colors">4.9/5</span>
                  <span className="text-[10px] font-black uppercase tracking-[0.2em] text-gray-600">User Rating</span>
                </div>
                <div className="text-center border-l border-white/5 group">
                  <span className="block text-4xl font-black tracking-tighter group-hover:text-blue-500 transition-colors">24bit</span>
                  <span className="text-[10px] font-black uppercase tracking-[0.2em] text-gray-600">Audio Quality</span>
                </div>
              </div>
            </section>

            <Features />
            <AudioStudio />
            <DownloadSection />
            <FeedbackSection />
          </div>
        );
    }
  };

  if (loading) {
    return (
      <div className={`fixed inset-0 bg-black z-[100] flex items-center justify-center transition-opacity duration-1000 ${isSplashExiting ? 'opacity-0' : 'opacity-100'}`}>
        <h1 className="splash-text text-3xl md:text-5xl font-black text-white uppercase translate-x-[0.6em]">
          EXCALIBUR
        </h1>
      </div>
    );
  }

  return (
    <div className="min-h-screen bg-[#05070a] text-white selection:bg-blue-500/30 selection:text-blue-200 antialiased">
      <Navbar onHome={() => setCurrentPage('home')} />
      <main>
        {renderContent()}
      </main>
      <Footer 
        onPrivacy={() => setCurrentPage('privacy')} 
        onTerms={() => setCurrentPage('terms')}
        onHome={() => setCurrentPage('home')}
      />
    </div>
  );
}

export default App;