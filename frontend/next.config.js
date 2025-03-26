/** @type {import('next').NextConfig} */
const nextConfig = {
  reactStrictMode: true,
  swcMinify: true,
  
  // Specify domains for image optimization if needed
  images: {
    domains: [],
  },
  
  // Webpack config for handling Monaco Editor
  webpack: (config, { isServer }) => {
    // Add Monaco Editor webpack loader config
    config.module.rules.push({
      test: /\.ttf$/,
      use: ['file-loader'],
    });

    // Important: return the modified config
    return config;
  },
  
  // Configure redirects to handle 404 errors seen in logs
  async redirects() {
    return [
      {
        source: '/st-simulator',
        destination: '/st-simulator',
        permanent: true,
      },
      {
        source: '/programming-editor',
        destination: '/programming-editor-enhanced',
        permanent: true,
      },
    ];
  },
};

module.exports = nextConfig;