import React from 'react';
import type { AppProps } from 'next/app';
import Head from 'next/head';
import { ThemeProvider } from '../utils/ThemeContext';

// Global CSS imports
import '../styles/globals.css';
import '../styles/monaco-editor.css'; // Monaco editor styles

function MyApp({ Component, pageProps }: AppProps) {
  return (
    <ThemeProvider>
      <Head>
        <title>Structured Text Simulator</title>
        <meta name="description" content="A web-based CODESYS-like simulator for Structured Text (ST) programming" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <link rel="icon" href="/favicon.ico" />
      </Head>
      <Component {...pageProps} />
    </ThemeProvider>
  );
}

export default MyApp;