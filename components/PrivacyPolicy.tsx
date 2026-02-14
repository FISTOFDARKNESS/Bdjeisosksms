
import React from 'react';
import { ArrowLeft, Shield, Eye, Lock, Globe } from 'lucide-react';

interface PrivacyPolicyProps {
  onBack: () => void;
}

const PrivacyPolicy: React.FC<PrivacyPolicyProps> = ({ onBack }) => {
  return (
    <div className="pt-40 pb-32 px-6 max-w-4xl mx-auto antialiased">
      <button 
        onClick={onBack}
        className="flex items-center space-x-2 text-gray-500 hover:text-white transition-colors mb-16 uppercase text-xs font-black tracking-[0.3em] group"
      >
        <ArrowLeft size={16} className="group-hover:-translate-x-1 transition-transform" />
        <span>Back to Portal</span>
      </button>

      <div className="mb-20">
        <h1 className="text-6xl font-black tracking-tighter mb-4 uppercase">Privacy Policy</h1>
        <p className="text-gray-500 font-bold uppercase tracking-widest text-xs">Last Updated: May 2024 • Build 2.4.0</p>
      </div>
      
      <div className="space-y-16">
        <section className="glass p-10 rounded-[32px] border-white/5">
          <div className="flex items-center gap-4 mb-6">
            <div className="p-3 bg-blue-500/10 rounded-xl text-blue-500"><Eye size={24} /></div>
            <h2 className="text-2xl font-black text-white uppercase tracking-tight">Data Intelligence</h2>
          </div>
          <p className="text-gray-400 leading-relaxed text-lg mb-4">
            Excalibur Music utilizes secure cloud storage to store minimal telemetry and user-provided email addresses. We track application performance metrics to optimize the high-fidelity audio engine.
          </p>
          <ul className="text-gray-500 space-y-3 text-sm font-medium">
            <li className="flex items-center gap-2"><div className="w-1.5 h-1.5 bg-blue-500 rounded-full" /> Email addresses for Beta access.</li>
            <li className="flex items-center gap-2"><div className="w-1.5 h-1.5 bg-blue-500 rounded-full" /> OS version for build compatibility.</li>
            <li className="flex items-center gap-2"><div className="w-1.5 h-1.5 bg-blue-500 rounded-full" /> Audio playback frequency for DSP tuning.</li>
          </ul>
        </section>

        <section>
          <div className="flex items-center gap-4 mb-6">
            <div className="p-3 bg-green-500/10 rounded-xl text-green-500"><Lock size={24} /></div>
            <h2 className="text-2xl font-black text-white uppercase tracking-tight">Infrastructure Security</h2>
          </div>
          <p className="text-gray-400 leading-relaxed text-lg">
            All data transactions are conducted over SSL-secured channels. Your sensitive library metadata never leaves your local machine; only high-level indexing stats are synced to provide global search capabilities.
          </p>
        </section>

        <section className="glass p-10 rounded-[32px] border-white/5">
          <div className="flex items-center gap-4 mb-6">
            <div className="p-3 bg-purple-500/10 rounded-xl text-purple-500"><Globe size={24} /></div>
            <h2 className="text-2xl font-black text-white uppercase tracking-tight">Third-Party Handshakes</h2>
          </div>
          <p className="text-gray-400 leading-relaxed text-lg mb-6">
            Excalibur acts as a secure bridge to platforms like YouTube and Spotify. We do not store your credentials for these services; all authentication is handled via industry-standard OAuth2 locally.
          </p>
        </section>
      </div>
    </div>
  );
};

export default PrivacyPolicy;