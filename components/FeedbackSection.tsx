import React, { useState } from 'react';
import { MessageSquare, Star, Send, CheckCircle2 } from 'lucide-react';

const FeedbackSection: React.FC = () => {
  const [formData, setFormData] = useState({
    name: '',
    email: '',
    rating: 5,
    type: 'Suggestion',
    message: ''
  });
  const [status, setStatus] = useState<'idle' | 'sending' | 'success' | 'error'>('idle');

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setStatus('sending');
    
    try {
      const response = await fetch('/netlify/functions/submit-feedback', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(formData)
      });

      if (!response.ok) throw new Error('Failed to save feedback');
      
      setStatus('success');
      setFormData({ name: '', email: '', rating: 5, type: 'Suggestion', message: '' });
      setTimeout(() => setStatus('idle'), 5000);
    } catch (err) {
      console.error(err);
      setStatus('error');
      setTimeout(() => setStatus('idle'), 3000);
    }
  };

  return (
    <section id="feedback" className="py-24 px-6 bg-black">
      <div className="max-w-4xl mx-auto">
        <div className="text-center mb-16">
          <MessageSquare size={48} className="mx-auto mb-6 text-blue-500" />
          <h2 className="text-4xl font-black tracking-tighter uppercase mb-4">Community Feedback</h2>
          <p className="text-gray-500">Your input helps us forge the ultimate audio experience.</p>
        </div>

        <div className="glass p-8 md:p-12 rounded-[40px] border-white/5">
          {status === 'success' ? (
            <div className="text-center py-12">
              <CheckCircle2 size={64} className="mx-auto text-green-500 mb-6" />
              <h3 className="text-2xl font-black uppercase">Feedback Received</h3>
              <p className="text-gray-500 mt-2">Thank you for helping us improve.</p>
            </div>
          ) : (
            <form onSubmit={handleSubmit} className="space-y-6">
              <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
                <input 
                  required
                  value={formData.name}
                  onChange={e => setFormData({...formData, name: e.target.value})}
                  className="w-full bg-white/[0.03] border border-white/10 rounded-2xl px-5 py-4 outline-none focus:border-blue-500/50"
                  placeholder="Your Name"
                />
                <input 
                  required
                  type="email"
                  value={formData.email}
                  onChange={e => setFormData({...formData, email: e.target.value})}
                  className="w-full bg-white/[0.03] border border-white/10 rounded-2xl px-5 py-4 outline-none focus:border-blue-500/50"
                  placeholder="Your E-mail"
                />
              </div>

              <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
                <div className="flex gap-2 p-2 glass rounded-2xl justify-between px-4">
                  {[1, 2, 3, 4, 5].map(num => (
                    <button 
                      key={num}
                      type="button"
                      onClick={() => setFormData({...formData, rating: num})}
                      className={`w-10 h-10 rounded-xl flex items-center justify-center transition-all ${formData.rating === num ? 'bg-blue-500 text-white' : 'text-gray-500'}`}
                    >
                      <Star size={16} fill={formData.rating >= num ? "currentColor" : "none"} />
                    </button>
                  ))}
                </div>
                <select 
                  value={formData.type}
                  onChange={e => setFormData({...formData, type: e.target.value})}
                  className="w-full bg-white/[0.03] border border-white/10 rounded-2xl px-5 py-4 outline-none focus:border-blue-500/50 appearance-none text-gray-400"
                >
                  <option>Suggestion</option>
                  <option>Bug / Error</option>
                  <option>Praise</option>
                </select>
              </div>

              <textarea 
                required
                rows={4}
                value={formData.message}
                onChange={e => setFormData({...formData, message: e.target.value})}
                className="w-full bg-white/[0.03] border border-white/10 rounded-2xl px-5 py-4 outline-none focus:border-blue-500/50"
                placeholder="How can we improve Excalibur?"
              ></textarea>

              <button 
                disabled={status === 'sending'}
                className="w-full py-5 bg-white text-black rounded-[20px] font-black uppercase tracking-widest text-xs flex items-center justify-center gap-3 hover:bg-blue-500 hover:text-white transition-all disabled:opacity-50"
              >
                {status === 'sending' ? 'Sending...' : status === 'error' ? 'Connection Error' : 'Submit Feedback'}
              </button>
            </form>
          )}
        </div>
      </div>
    </section>
  );
};

export default FeedbackSection;