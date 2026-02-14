
// Added React import to provide access to React.ReactNode type
import React from 'react';

export interface Feature {
  id: string;
  title: string;
  description: string;
  icon: React.ReactNode;
  color?: string;
}

export interface ThemeOption {
  id: string;
  name: string;
  colors: string[];
  isPremium?: boolean;
}