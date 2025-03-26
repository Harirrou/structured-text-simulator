# Installation Guide for Structured Text Simulator

This guide provides detailed instructions for setting up and running the Structured Text Simulator project.

## Prerequisites

Before you begin, ensure you have the following installed:

- **Node.js** (v14.0.0 or higher)
- **npm** (v7.0.0 or higher)
- **Git** (for cloning the repository)

## Installation Steps

### 1. Clone the Repository

```bash
git clone https://github.com/Harirrou/structured-text-simulator.git
cd structured-text-simulator
```

### 2. Install Frontend Dependencies

```bash
cd frontend
npm install
```

This will install all the necessary dependencies for the frontend application, including:
- Next.js
- React
- Monaco Editor
- Chart.js
- Tailwind CSS
- React Icons

### 3. Start the Development Server

```bash
npm run dev
```

This command starts the Next.js development server. By default, it runs on port 3000. If this port is already in use, it will automatically try the next available port (3001, 3002, etc.).

### 4. Access the Application

Open your web browser and navigate to:
```
http://localhost:3000
```

Or the port shown in your terminal output if a different port was used.

## Troubleshooting Common Issues

### Global CSS Import Error

If you encounter an error like:

```
Global CSS cannot be imported from files other than your Custom <App>. 
```

Make sure that:
1. All global CSS files are imported only in `_app.tsx`
2. No other component is directly importing global CSS

### Port Already in Use

If you see an error that the port is already in use, you can:

1. Let Next.js automatically pick a different port, or
2. Stop the process using that port, or
3. Manually specify a different port:

```bash
npm run dev -- -p 3001
```

### Build Errors

If you encounter build errors:

1. Ensure all dependencies are correctly installed
2. Check for compatibility issues between packages
3. Clear the Next.js cache:

```bash
rm -rf .next
npm run dev
```

## Production Deployment

To build for production:

```bash
npm run build
```

To start the production server:

```bash
npm run start
```

## Environment Variables

Create a `.env` file in the frontend directory for any environment-specific configuration:

```
NEXT_PUBLIC_API_URL=your_api_url_here
```

## Additional Notes

- The application uses Monaco Editor which might require specific Webpack configurations
- Tailwind CSS is used for styling and responsiveness
- Chart.js is used for visualizing variable traces over time

For any additional issues or questions, please refer to the project repository or create an issue on GitHub.