
import React from 'react';
import { Youtube, Music, CloudDownload, Disc, Search, Clock } from 'lucide-react';
import { Feature } from '../types';

const features: Feature[] = [
  {
    id: 'yt',
    title: 'YOUTUBE SOURCING',
    description: 'Direct extraction via neural network for binary audio.',
    icon: <Youtube className="text-red-500" />,
  },
  {
    id: 'spotify',
    title: 'SPOTIFY MATCHING',
    description: 'Metadata matching for synced cloud tracks.',
    icon: <Music className="text-green-500" />,
  },
  {
    id: 'offline',
    title: 'OFFLINE ACCESS',
    description: 'Download tracks directly to your device library.',
    icon: <CloudDownload className="text-blue-500" />,
  },
  {
    id: 'library',
    title: 'LIBRARY MANAGEMENT',
    description: 'Organize your local and imported music folders.',
    icon: <Disc className="text-cyan-500" />,
  },
  {
    id: 'cloud',
    title: 'CLOUD SEARCH',
    description: 'Find millions of global tracks with our AI indexer.',
    icon: <Search className="text-purple-500" />,
  },
  {
    id: 'history',
    title: 'SMART HISTORY',
    description: 'Every beat tracked, synced across all devices.',
    icon: <Clock className="text-yellow-500" />,
  },
];

const Features: React.FC = () => {
  return (
    <section id="features" className="py-24 px-6 bg-black/50">
      <div className="max-w-7xl mx-auto">
        <div className="mb-16">
          <h2 className="text-4xl font-bold mb-4 tracking-tight">Powerful Capabilities.</h2>
          <p className="text-gray-400 max-w-xl">Everything you need to orchestrate your musical journey, from sourcing to mastering.</p>
        </div>

        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
          {features.map((feature) => (
            <div key={feature.id} className="glass p-8 rounded-3xl card-hover flex flex-col items-center text-center">
              <div className="p-4 bg-white/5 rounded-2xl mb-6">
                {/* Fixed TS error: adding <any> generic allows specifying custom props like 'size' in cloneElement */}
                {React.cloneElement(feature.icon as React.ReactElement<any>, { size: 32 })}
              </div>
              <h3 className="text-lg font-extrabold mb-3 tracking-wider uppercase">{feature.title}</h3>
              <p className="text-gray-500 text-sm leading-relaxed">{feature.description}</p>
            </div>
          ))}
        </div>
      </div>
    </section>
  );
};

export default Features;
