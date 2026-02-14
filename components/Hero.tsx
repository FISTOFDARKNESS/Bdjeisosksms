import React, { useState } from 'react';
import { Sparkles, Send, Check } from 'lucide-react';

const Hero: React.FC = () => {
  const [email, setEmail] = useState('');
  const [status, setStatus] = useState<'idle' | 'submitting' | 'success' | 'error'>('idle');

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!email) return;
    setStatus('submitting');
    
    try {
      const response = await fetch('/netlify/functions/submit-feedback', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          name: 'Beta Prospect',
          email: email,
          rating: 5,
          type: 'Waitlist',
          message: 'User requested access via Hero Section'
        })
      });

      if (!response.ok) throw new Error();
      setStatus('success');
      setEmail('');
      setTimeout(() => setStatus('idle'), 4000);
    } catch (err) {
      setStatus('error');
      setTimeout(() => setStatus('idle'), 3000);
    }
  };

  return (
    <section className="relative pt-48 pb-24 px-6 overflow-hidden">
      <div className="absolute top-0 left-1/2 -translate-x-1/2 w-full h-[700px] bg-gradient-to-b from-blue-600/10 via-transparent to-transparent pointer-events-none" />
      <div className="max-w-5xl mx-auto text-center relative z-10">
        <div className="inline-flex items-center space-x-3 px-4 py-1.5 glass rounded-full mb-10 border border-white/5">
          <Sparkles size={14} className="text-blue-400" />
          <span className="text-[10px] font-black uppercase tracking-[0.25em] text-gray-400">
            Next-Gen Audio Experience
          </span>
        </div>

        <h1 className="text-7xl md:text-9xl font-black tracking-tighter leading-[0.85] mb-10 uppercase">
          <span className="block text-white">Your Music,</span>
          <span className="block text-gray-700">Limitless.</span>
        </h1>

        <form onSubmit={handleSubmit} className="max-w-xl mx-auto mb-8 relative">
          <div className="flex gap-2 p-2 glass rounded-[24px] border-white/10 focus-within:border-blue-500/40 transition-all shadow-2xl">
            <input 
              type="email" 
              required
              value={email}
              onChange={(e) => setEmail(e.target.value)}
              placeholder="Email for beta access..." 
              className="flex-1 bg-transparent px-6 py-4 outline-none font-medium text-white"
            />
            <button 
              disabled={status === 'submitting'}
              className={`px-8 py-4 rounded-[18px] font-black text-sm transition-all ${status === 'success' ? 'bg-green-500 text-white' : 'bg-white text-black'}`}
            >
              {status === 'submitting' ? '...' : status === 'success' ? <Check size={20} /> : <Send size={20} />}
            </button>
          </div>
          {status === 'success' && <p className="text-[10px] font-black text-green-500 uppercase mt-4">Successfully joined waitlist</p>}
          {status === 'error' && <p className="text-[10px] font-black text-red-500 uppercase mt-4">An error occurred. Try again.</p>}
        </form>
      </div>
    </section>
  );
};

export default Hero;