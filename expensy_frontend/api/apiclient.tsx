'use client';

import axios from 'axios';

// Determine API base URL
const BASE_URL =
  process.env.NEXT_PUBLIC_API_URL?.trim() || 'http://localhost:8706';

// Log for dev mode
if (process.env.NODE_ENV !== 'production') {
  console.log('[apiClient] BASE_URL =', BASE_URL);
}

// Create axios instance
const apiClient = axios.create({
  baseURL: BASE_URL,
  headers: {
    'Content-Type': 'application/json',
  },
});

// Attach API key if defined
apiClient.interceptors.request.use((config) => {
  const apiKey = process.env.NEXT_APP_API_KEY?.trim();
  if (apiKey) {
    config.headers.Authorization = `Bearer ${apiKey}`;
  }
  return config;
});

export default apiClient;
