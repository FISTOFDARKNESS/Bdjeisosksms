
import React from 'react';
import { Music2 } from 'lucide-react';

interface NavbarProps {
  onHome: () => void;
}

const Navbar: React.FC<NavbarProps> = ({ onHome }) => {
  return (
    <nav className="fixed top-0 left-0 right-0 z-50 glass border-b border-white/5 px-6 py-4">
      <div className="max-w-7xl mx-auto flex items-center justify-between">
        <div className="flex items-center space-x-3 group cursor-pointer" onClick={onHome}>
          <div className="p-2 bg-white text-black rounded-lg group-hover:scale-110 transition-transform">
            <Music2 size={24} strokeWidth={2.5} />
          </div>
          <span className="text-xl font-extrabold tracking-tighter uppercase">Excalibur</span>
        </div>
        
        <div className="hidden md:flex items-center space-x-8 text-sm font-medium text-gray-400">
          <a href="#features" onClick={(e) => { e.preventDefault(); onHome(); setTimeout(() => document.getElementById('features')?.scrollIntoView({behavior: 'smooth'}), 100); }} className="hover:text-white transition-colors">Features</a>
          <a href="#audio-studio" onClick={(e) => { e.preventDefault(); onHome(); setTimeout(() => document.getElementById('audio-studio')?.scrollIntoView({behavior: 'smooth'}), 100); }} className="hover:text-white transition-colors">Audio Studio</a>
          <a href="#download" onClick={(e) => { e.preventDefault(); onHome(); setTimeout(() => document.getElementById('download')?.scrollIntoView({behavior: 'smooth'}), 100); }} className="hover:text-white transition-colors">Download</a>
        </div>

        <div className="flex items-center space-x-4">
          <span className="text-[10px] font-black text-gray-600 uppercase tracking-widest border border-white/5 px-2 py-1 rounded">v2.4.0-STABLE</span>
        </div>
      </div>
    </nav>
  );
};

export default Navbar;
