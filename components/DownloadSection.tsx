import React, { useState, useEffect } from 'react';
import { Smartphone, Monitor, Apple, ArrowRight, DownloadCloud, XCircle } from 'lucide-react';

interface DownloadVersion {
  id: number;
  version_name: string;
  download_url: string;
  candownload: boolean;
  byte: string | number;
  release_date: string;
}

const DownloadSection: React.FC = () => {
  const [downloading, setDownloading] = useState<string | null>(null);
  const [progress, setProgress] = useState(0);
  const [dbVersions, setDbVersions] = useState<DownloadVersion[]>([]);
  const [isLoading, setIsLoading] = useState(true);

  useEffect(() => {
    const fetchVersions = async () => {
      try {
        const response = await fetch('/netlify/functions/get-downloads');
        if (!response.ok) throw new Error('Failed to load versions');
        const data = await response.json();
        setDbVersions(data);
      } catch (err) {
        console.error("Fetch Error:", err);
      } finally {
        setIsLoading(false);
      }
    };
    fetchVersions();
  }, []);

  const formatBytes = (bytes: string | number) => {
    const b = typeof bytes === 'string' ? parseFloat(bytes) : bytes;
    if (!b || b === 0) return '0 MB';
    return (b / (1024 * 1024)).toFixed(1) + ' MB';
  };

  const startDownload = (platform: string, url: string, canDownload: boolean) => {
    if (downloading || !canDownload || url === '#') return;
    
    setDownloading(platform);
    setProgress(0);
    
    const interval = setInterval(() => {
      setProgress(prev => {
        if (prev >= 100) {
          clearInterval(interval);
          window.location.href = url;
          setTimeout(() => setDownloading(null), 2000);
          return 100;
        }
        return prev + 5;
      });
    }, 100);
  };

  const activeVersion = dbVersions.find(v => v.candownload);
  const isEnabled = !!activeVersion;

  return (
    <section id="download" className="py-24 px-6 bg-gradient-to-t from-blue-600/5 to-transparent relative">
      <div className="max-w-6xl mx-auto">
        <div className="text-center mb-16">
          <div className="inline-flex items-center space-x-2 px-3 py-1 glass rounded-full mb-6 border border-white/5">
            <DownloadCloud size={12} className="text-blue-500" />
            <span className="text-[10px] font-black uppercase tracking-[0.2em] text-gray-500">
              Official Releases
            </span>
          </div>
          <h2 className="text-5xl md:text-6xl font-black tracking-tighter mb-4 uppercase">Downloads.</h2>
          <p className="text-gray-400 max-w-2xl mx-auto text-lg">
            {isLoading ? 'Checking for updates...' : isEnabled ? `Stable version detected: ${activeVersion.version_name}` : 'No releases available currently.'}
          </p>
        </div>
        
        <div className="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 gap-8">
          {/* Windows */}
          <div 
            onClick={() => isEnabled && startDownload('windows', activeVersion.download_url, activeVersion.candownload)}
            className={`glass p-10 rounded-[40px] card-hover group cursor-pointer transition-all relative overflow-hidden ${!isEnabled ? 'opacity-40' : ''}`}
          >
            <Monitor size={56} className="mx-auto mb-8 group-hover:text-blue-500 transition-colors" />
            <h3 className="text-2xl font-black mb-2 uppercase tracking-tighter">Windows</h3>
            {downloading === 'windows' ? (
              <div className="mt-4">
                <div className="h-1.5 w-full bg-white/5 rounded-full overflow-hidden mb-3">
                  <div className="h-full bg-blue-500" style={{ width: `${progress}%` }} />
                </div>
                <span className="text-[10px] font-black text-blue-500 uppercase">Requesting binary...</span>
              </div>
            ) : (
              <>
                <span className="text-[10px] font-black text-gray-500 uppercase tracking-[0.2em]">
                  {isEnabled ? `${activeVersion.version_name} • ${formatBytes(activeVersion.byte)}` : 'Unavailable'}
                </span>
                <div className="mt-8 pt-8 border-t border-white/5 flex items-center justify-center font-bold text-blue-500">
                  <span>{isEnabled ? 'Download EXE' : 'Locked'}</span>
                  {isEnabled ? <ArrowRight size={18} className="ml-2" /> : <XCircle size={18} className="ml-2" />}
                </div>
              </>
            )}
          </div>

          {/* Android */}
          <div 
            onClick={() => isEnabled && startDownload('android', activeVersion.download_url, activeVersion.candownload)}
            className={`glass p-10 rounded-[40px] card-hover group cursor-pointer transition-all relative overflow-hidden ${!isEnabled ? 'opacity-40' : ''}`}
          >
            <Smartphone size={56} className="mx-auto mb-8 group-hover:text-green-500 transition-colors" />
            <h3 className="text-2xl font-black mb-2 uppercase tracking-tighter">Android</h3>
            {downloading === 'android' ? (
              <div className="mt-4">
                <div className="h-1.5 w-full bg-white/5 rounded-full overflow-hidden mb-3">
                  <div className="h-full bg-green-500" style={{ width: `${progress}%` }} />
                </div>
                <span className="text-[10px] font-black text-green-500 uppercase">Requesting APK...</span>
              </div>
            ) : (
              <>
                <span className="text-[10px] font-black text-gray-500 uppercase tracking-[0.2em]">
                   {isEnabled ? `${activeVersion.version_name} • ${formatBytes(activeVersion.byte)}` : 'Unavailable'}
                </span>
                <div className="mt-8 pt-8 border-t border-white/5 flex items-center justify-center font-bold text-green-500">
                  <span>{isEnabled ? 'Download APK' : 'Locked'}</span>
                  {isEnabled ? <ArrowRight size={18} className="ml-2" /> : <XCircle size={18} className="ml-2" />}
                </div>
              </>
            )}
          </div>

          {/* macOS */}
          <div className="glass p-10 rounded-[40px] opacity-30 cursor-not-allowed">
            <Apple size={56} className="mx-auto mb-8 text-gray-600" />
            <h3 className="text-2xl font-black mb-2 uppercase tracking-tighter">macOS</h3>
            <span className="text-[10px] font-black text-gray-600 uppercase tracking-[0.2em]">Coming Soon</span>
          </div>
        </div>
      </div>
    </section>
  );
};

export default DownloadSection;