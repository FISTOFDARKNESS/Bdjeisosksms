
import React, { useState, useRef } from 'react';
import { Sliders, RotateCcw, Play, Square, Volume2 } from 'lucide-react';

const frequencies = [
  { label: '60Hz', freq: 60, sub: 'BASS' },
  { label: '150Hz', freq: 150, sub: 'LOW-MID' },
  { label: '400Hz', freq: 400, sub: 'MID' },
  { label: '1kHz', freq: 1000, sub: 'HIGH-MID' },
  { label: '2.4kHz', freq: 2400, sub: 'TREBLE' },
  { label: '6kHz', freq: 6000, sub: 'HIGH' },
  { label: '15kHz', freq: 15000, sub: 'AIR' }
];

const presets = {
  'FLAT': [50, 50, 50, 50, 50, 50, 50],
  'BASS BOOST': [90, 80, 60, 45, 40, 35, 30],
  'ROCK': [70, 65, 40, 45, 60, 75, 80],
  'POP': [45, 55, 75, 80, 70, 55, 45],
  'JAZZ': [65, 55, 45, 55, 40, 50, 65]
};

const AudioStudio: React.FC = () => {
  const [levels, setLevels] = useState(frequencies.map(() => 50));
  const [isPlaying, setIsPlaying] = useState(false);
  const audioCtx = useRef<AudioContext | null>(null);
  const oscillator = useRef<OscillatorNode | null>(null);
  const gainNode = useRef<GainNode | null>(null);

  const startTestTone = () => {
    if (!audioCtx.current) {
      audioCtx.current = new (window.AudioContext || (window as any).webkitAudioContext)();
    }
    
    if (isPlaying) {
      oscillator.current?.stop();
      setIsPlaying(false);
      return;
    }

    oscillator.current = audioCtx.current.createOscillator();
    gainNode.current = audioCtx.current.createGain();
    
    // Sum of levels affects the volume slightly to simulate EQ response
    const avgLevel = levels.reduce((a, b) => a + b, 0) / (levels.length * 100);
    gainNode.current.gain.setValueAtTime(0.1 * avgLevel, audioCtx.current.currentTime);
    
    // Just a demo: Use the middle frequency slider to control oscillator pitch
    oscillator.current.frequency.setValueAtTime(frequencies[2].freq, audioCtx.current.currentTime);
    oscillator.current.type = 'sine';
    
    oscillator.current.connect(gainNode.current);
    gainNode.current.connect(audioCtx.current.destination);
    
    oscillator.current.start();
    setIsPlaying(true);
  };

  const handleLevelChange = (index: number, val: number) => {
    const newLevels = [...levels];
    newLevels[index] = val;
    setLevels(newLevels);
    
    // Update gain in real-time if playing
    if (isPlaying && gainNode.current && audioCtx.current) {
      const avgLevel = newLevels.reduce((a, b) => a + b, 0) / (newLevels.length * 100);
      gainNode.current.gain.setTargetAtTime(0.1 * avgLevel, audioCtx.current.currentTime, 0.1);
    }
  };

  const applyPreset = (presetName: keyof typeof presets) => {
    setLevels(presets[presetName]);
  };

  return (
    <section id="audio-studio" className="py-24 px-6 bg-[#05070a] relative overflow-hidden">
      <div className="absolute right-0 top-0 w-1/2 h-full bg-gradient-to-l from-blue-600/5 to-transparent pointer-events-none" />
      
      <div className="max-w-5xl mx-auto relative z-10">
        <div className="flex flex-col md:flex-row md:items-end justify-between mb-12 gap-6">
          <div>
            <div className="inline-flex items-center space-x-2 px-3 py-1 glass rounded-md mb-4">
              <Sliders size={12} className="text-gray-400" />
              <span className="text-[10px] font-bold uppercase tracking-widest text-gray-400">DSP Engine v4.2</span>
            </div>
            <h2 className="text-5xl font-extrabold tracking-tight mb-2 uppercase">Audio Studio</h2>
            <p className="text-gray-500">Real-time frequency sculpting for pristine output.</p>
          </div>
          
          <div className="flex items-center gap-3">
            <button 
              onClick={startTestTone}
              className={`flex items-center space-x-3 px-6 py-3 rounded-full text-sm font-bold transition-all border ${isPlaying ? 'bg-red-500/10 border-red-500 text-red-500' : 'glass border-white/10 text-white hover:bg-white/10'}`}
            >
              {isPlaying ? <Square size={16} fill="currentColor" /> : <Play size={16} fill="currentColor" />}
              <span>{isPlaying ? 'Stop Test' : 'Test Tone'}</span>
            </button>
            <button 
              onClick={() => setLevels(frequencies.map(() => 50))}
              className="p-3 glass rounded-full text-gray-400 hover:text-white transition-colors"
              title="Reset"
            >
              <RotateCcw size={20} />
            </button>
          </div>
        </div>

        <div className="glass p-12 rounded-[40px] bg-black/40 border border-white/5 shadow-2xl relative overflow-hidden">
           {/* Visualizer Background Simulation */}
           <div className="absolute inset-x-0 bottom-0 h-32 opacity-10 pointer-events-none flex items-end px-12 gap-1">
             {Array.from({ length: 40 }).map((_, i) => (
               <div 
                 key={i} 
                 className="flex-1 bg-blue-500 rounded-t-sm transition-all duration-300"
                 style={{ height: `${Math.random() * 100}%` }}
               />
             ))}
           </div>

          <div className="flex justify-between items-end h-64 gap-2 sm:gap-4 md:gap-8 relative z-10">
            {frequencies.map((freq, idx) => (
              <div key={freq.label} className="flex-1 flex flex-col items-center h-full group">
                <div className="relative w-1.5 sm:w-2 h-full bg-white/5 rounded-full overflow-hidden">
                  <div 
                    className="absolute bottom-0 left-0 right-0 bg-blue-500 rounded-full transition-all duration-300"
                    style={{ height: `${levels[idx]}%`, boxShadow: levels[idx] > 20 ? '0 0 15px rgba(59, 130, 246, 0.5)' : 'none' }}
                  />
                  <input 
                    type="range"
                    min="0"
                    max="100"
                    value={levels[idx]}
                    onChange={(e) => handleLevelChange(idx, parseInt(e.target.value))}
                    className="absolute inset-0 w-full h-full opacity-0 cursor-pointer z-10"
                  />
                </div>
                <div className="mt-6 text-center">
                  <span className="block text-[10px] sm:text-xs font-bold text-white mb-1">{freq.label}</span>
                  <span className="block text-[8px] sm:text-[9px] font-bold text-gray-600 tracking-tighter uppercase whitespace-nowrap">{freq.sub}</span>
                </div>
              </div>
            ))}
          </div>
        </div>

        <div className="mt-12">
          <h4 className="text-xs font-bold text-gray-500 uppercase tracking-widest mb-6 flex items-center gap-2">
            <Volume2 size={12} />
            Master Presets
          </h4>
          <div className="flex flex-wrap gap-3">
            {Object.keys(presets).map(p => (
              <button 
                key={p} 
                onClick={() => applyPreset(p as keyof typeof presets)}
                className="px-5 py-2 glass rounded-full text-[10px] font-black tracking-widest hover:bg-white/5 border-white/5 hover:border-white/20 transition-all uppercase"
              >
                {p}
              </button>
            ))}
          </div>
        </div>
      </div>
    </section>
  );
};

export default AudioStudio;
