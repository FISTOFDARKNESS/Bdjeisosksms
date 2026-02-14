
import React from 'react';
import { ArrowLeft, Scale, Terminal, Zap, AlertTriangle } from 'lucide-react';

interface TermsOfServiceProps {
  onBack: () => void;
}

const TermsOfService: React.FC<TermsOfServiceProps> = ({ onBack }) => {
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
        <h1 className="text-6xl font-black tracking-tighter mb-4 uppercase">Terms of Service</h1>
        <p className="text-gray-500 font-bold uppercase tracking-widest text-xs">Effective date: June 2024</p>
      </div>
      
      <div className="space-y-16">
        <section className="glass p-10 rounded-[32px] border-white/5">
          <div className="flex items-center gap-4 mb-6">
            <div className="p-3 bg-yellow-500/10 rounded-xl text-yellow-500"><Scale size={24} /></div>
            <h2 className="text-2xl font-black text-white uppercase tracking-tight">1. Fair Usage Policy</h2>
          </div>
          <p className="text-gray-400 leading-relaxed text-lg">
            Excalibur Music is intended for the management and high-fidelity playback of personal audio collections. Users are prohibited from using the cloud search indexing features to facilitate bulk scraping or automated downloading.
          </p>
        </section>

        <section>
          <div className="flex items-center gap-4 mb-6">
            <div className="p-3 bg-blue-500/10 rounded-xl text-blue-500"><Terminal size={24} /></div>
            <h2 className="text-2xl font-black text-white uppercase tracking-tight">2. Software License</h2>
          </div>
          <p className="text-gray-400 leading-relaxed text-lg">
            We grant you a revocable, non-exclusive license to use the Excalibur Audio Engine. Modification of binary files or unauthorized access to our secure endpoints is strictly forbidden.
          </p>
        </section>

        <section className="glass p-10 rounded-[32px] border-white/5 border-red-500/10">
          <div className="flex items-center gap-4 mb-6">
            <div className="p-3 bg-red-500/10 rounded-xl text-red-500"><AlertTriangle size={24} /></div>
            <h2 className="text-2xl font-black text-white uppercase tracking-tight">3. Disclaimer of Warranty</h2>
          </div>
          <p className="text-gray-400 leading-relaxed text-lg">
            Excalibur provides the software "as-is". While we maintain high availability for our cloud services, we are not responsible for metadata mismatch or any loss of local data resulting from third-party API changes.
          </p>
        </section>

        <section>
          <div className="flex items-center gap-4 mb-6">
            <div className="p-3 bg-cyan-500/10 rounded-xl text-cyan-500"><Zap size={24} /></div>
            <h2 className="text-2xl font-black text-white uppercase tracking-tight">4. Account Termination</h2>
          </div>
          <p className="text-gray-400 leading-relaxed text-lg">
            Abuse of our API calls or injecting malicious code into forms will result in immediate termination of your access to our services.
          </p>
        </section>
      </div>
    </div>
  );
};

export default TermsOfService;