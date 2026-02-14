
import React from 'react';
import { Music2, Github, Twitter, Instagram } from 'lucide-react';

interface FooterProps {
  onPrivacy: () => void;
  onTerms: () => void;
  onHome: () => void;
}

const Footer: React.FC<FooterProps> = ({ onPrivacy, onTerms, onHome }) => {
  return (
    <footer className="py-20 px-6 border-t border-white/5 glass">
      <div className="max-w-7xl mx-auto">
        <div className="grid grid-cols-1 md:grid-cols-3 gap-12 mb-16">
          <div className="col-span-1">
            <div className="flex items-center space-x-3 mb-6 cursor-pointer" onClick={onHome}>
              <div className="p-2 bg-white text-black rounded-lg">
                <Music2 size={24} />
              </div>
              <span className="text-xl font-extrabold tracking-tighter uppercase">Excalibur</span>
            </div>
            <p className="text-gray-500 text-sm leading-relaxed mb-6">
              Revolutionizing audio fidelity. Professional tools for the modern collector.
            </p>
            <div className="flex space-x-4">
              <a href="#" className="p-2 glass rounded-full hover:text-white transition-colors"><Twitter size={18} /></a>
              <a href="#" className="p-2 glass rounded-full hover:text-white transition-colors"><Instagram size={18} /></a>
              <a href="#" className="p-2 glass rounded-full hover:text-white transition-colors"><Github size={18} /></a>
            </div>
          </div>

          <div>
            <h4 className="font-bold text-white mb-6 uppercase text-xs tracking-widest">Platform</h4>
            <ul className="space-y-4 text-sm text-gray-500">
              <li><button onClick={onHome} className="hover:text-white transition-colors">Downloads</button></li>
              <li><a href="#" className="hover:text-white transition-colors">Changelog</a></li>
              <li><a href="#" className="hover:text-white transition-colors">App Specs</a></li>
              <li><a href="#" className="hover:text-white transition-colors">Mobile (Stable)</a></li>
            </ul>
          </div>

          <div>
            <h4 className="font-bold text-white mb-6 uppercase text-xs tracking-widest">Legal</h4>
            <ul className="space-y-4 text-sm text-gray-500">
              <li><button onClick={onPrivacy} className="hover:text-white transition-colors">Privacy Policy</button></li>
              <li><button onClick={onTerms} className="hover:text-white transition-colors">Terms of Service</button></li>
              <li><a href="#" className="hover:text-white transition-colors">DMCA</a></li>
            </ul>
          </div>
        </div>
        
        <div className="pt-8 border-t border-white/5 flex flex-col md:flex-row justify-between items-center gap-4 text-xs text-gray-600 font-bold uppercase tracking-widest">
          <p>© 2024 Excalibur Music. All rights reserved.</p>
          <div className="flex space-x-8">
            <button onClick={onPrivacy} className="hover:text-white transition-colors">Privacy</button>
            <button onClick={onTerms} className="hover:text-white transition-colors">Terms</button>
          </div>
        </div>
      </div>
    </footer>
  );
};

export default Footer;