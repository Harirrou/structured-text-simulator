# Structured Text Simulator

A web-based CODESYS-like simulator for Structured Text (ST) programming with advanced visualization and real-time PLC behavior.

## Features

- **ST Code Editor**: Monaco-based editor with syntax highlighting and code completion
- **Real-time Simulation**: Execute ST code and view variable changes in real-time
- **CODESYS-like Visualization**: PLC-style monitoring of variables with visual indicators
- **Live Code Animation**: Visualize execution flow directly in the ST code
- **Variable Tracing**: Track and chart numeric variables over time
- **Comprehensive Visualizers**:
  - Boolean Visualizer: Displays true/false states with visual indicators
  - Timer Visualizer: Shows timer progress and states
  - Counter Visualizer: Displays counter values with increment/decrement animations
  - ST Code Animator: Highlights active lines during code execution

## Getting Started

### Prerequisites

- Node.js (v14 or higher)
- npm (v7 or higher)

### Installation

1. Clone the repository:
   ```
   git clone https://github.com/Harirrou/structured-text-simulator.git
   cd structured-text-simulator
   ```

2. Install frontend dependencies:
   ```
   cd frontend
   npm install
   ```

3. Start the development server:
   ```
   npm run dev
   ```

4. Open your browser and navigate to:
   ```
   http://localhost:3000
   ```

## Project Structure

```
structured-text-simulator/
├── frontend/
│   ├── components/
│   │   ├── layout/         # Layout components
│   │   ├── simulator/      # Simulator-specific components
│   │   │   ├── BoolVisualizer.tsx
│   │   │   ├── TimerVisualizer.tsx
│   │   │   ├── CounterVisualizer.tsx
│   │   │   ├── CODESYSLikeMonitor.tsx
│   │   │   ├── STCodeAnimator.tsx
│   │   │   └── index.ts
│   │   ├── ui/            # Reusable UI components
│   │   └── ...
│   ├── pages/
│   │   ├── _app.tsx       # Next.js App component
│   │   ├── index.tsx      # Home page
│   │   ├── st-simulator.tsx # ST Simulator page
│   │   └── ...
│   ├── styles/
│   │   ├── globals.css
│   │   └── monaco-editor.css
│   ├── utils/
│   │   ├── STLanguageService.ts # Core ST language service
│   │   └── ...
│   ├── public/
│   ├── package.json
│   └── next.config.js
└── README.md
```

## Usage Examples

The simulator comes with several example ST programs to demonstrate different aspects of PLC programming:

1. **Boolean Logic**: Demonstrates boolean operations and conditional statements
2. **Timers**: Shows how to use TON, TOF, and TP timer functions
3. **Counters**: Illustrates CTU, CTD counter operations
4. **PLC Sequence**: Demonstrates a multi-step sequence typical in PLC applications

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the LICENSE file for details.