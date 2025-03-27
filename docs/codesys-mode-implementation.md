# Implementing CODESYS-like Operation Modes

This guide explains how to implement proper CODESYS-like operation modes in the structured text simulator project.

## Understanding CODESYS Operation Modes

In CODESYS, PLC programs have specific operation modes that control their execution:

### Application States
- **Run**: Program is actively executing
- **Stop**: Program execution is paused
- **Debug**: Program is in debugging mode
- **Single Cycle**: Program executes a single cycle then stops

### Operating States
- **None**: No specific state
- **Program Loaded**: Program is loaded but not running
- **Download**: Program is being downloaded to the PLC
- **Online Change**: Changes are being applied while running
- **Force Active**: Values are being forced
- **Exception**: Error condition
- **Reset**: System is resetting

## Implementation Steps

To implement these modes in our simulator, we'll need to:

1. Create an enum for application states
2. Modify the `SimulationState` interface to include the mode
3. Update the UI to display and control the current mode
4. Modify the execution logic to respect the current mode

### 1. Create ApplicationMode Enum

```typescript
// frontend/types/simulation.ts
export enum ApplicationMode {
  STOP = 'STOP',
  RUN = 'RUN',
  DEBUG = 'DEBUG',
  SINGLE_CYCLE = 'SINGLE_CYCLE',
  ONLINE_CHANGE = 'ONLINE_CHANGE'
}
```

### 2. Update SimulationState Interface

```typescript
// In your st-simulator.tsx or relevant file
interface SimulationState {
  variables: STVariable[];
  messages: ConsoleMessage[];
  running: boolean;
  cycleCount: number;
  error: string | null;
  validationErrors?: ValidationError[];
  executionPath?: string[];
  applicationMode: ApplicationMode; // Add this line
}
```

### 3. Add Mode Controls to UI

Add a mode selector in the simulation controls:

```tsx
<div className="flex flex-col">
  <div className="flex items-center mb-2">
    <span className="mr-2 font-medium">Mode:</span>
    <select 
      value={simulationState.applicationMode} 
      onChange={e => setApplicationMode(e.target.value as ApplicationMode)}
      className="border rounded p-1 bg-gray-50 dark:bg-gray-700"
    >
      <option value={ApplicationMode.STOP}>STOP</option>
      <option value={ApplicationMode.RUN}>RUN</option>
      <option value={ApplicationMode.DEBUG}>DEBUG</option>
      <option value={ApplicationMode.SINGLE_CYCLE}>SINGLE CYCLE</option>
      <option value={ApplicationMode.ONLINE_CHANGE}>ONLINE CHANGE</option>
    </select>
  </div>
  
  <div className="flex items-center">
    <div className={`w-3 h-3 rounded-full mr-2 ${getModeIndicatorColor()}`}></div>
    <span className="text-sm">
      {simulationState.applicationMode}
    </span>
  </div>
</div>
```

### 4. Add Mode Indicator Function

```typescript
const getModeIndicatorColor = () => {
  switch (simulationState.applicationMode) {
    case ApplicationMode.STOP:
      return 'bg-red-500';
    case ApplicationMode.RUN:
      return 'bg-green-500';
    case ApplicationMode.DEBUG:
      return 'bg-blue-500';
    case ApplicationMode.SINGLE_CYCLE:
      return 'bg-yellow-500';
    case ApplicationMode.ONLINE_CHANGE:
      return 'bg-purple-500';
    default:
      return 'bg-gray-500';
  }
};
```

### 5. Update Mode Management Logic

```typescript
const setApplicationMode = (mode: ApplicationMode) => {
  setSimulationState(prevState => ({
    ...prevState,
    applicationMode: mode,
    running: mode === ApplicationMode.RUN
  }));
  
  // Handle mode-specific behavior
  switch (mode) {
    case ApplicationMode.RUN:
      startContinuousSimulation();
      break;
    case ApplicationMode.STOP:
      stopContinuousSimulation();
      break;
    case ApplicationMode.SINGLE_CYCLE:
      stopContinuousSimulation();
      runSimulationStep();
      break;
    case ApplicationMode.DEBUG:
      stopContinuousSimulation();
      // Enable debug controls
      break;
    case ApplicationMode.ONLINE_CHANGE:
      // Handle online changes
      break;
  }
};
```

### 6. Add Status Bar Component

Add a status bar to show the current mode and PLC status:

```tsx
const StatusBar = () => (
  <div className="flex items-center justify-between border-t p-2 bg-gray-100 dark:bg-gray-800">
    <div className="flex items-center">
      <span className="font-medium mr-2">Status:</span>
      <div className={`w-3 h-3 rounded-full mr-2 ${getModeIndicatorColor()}`}></div>
      <span>{simulationState.applicationMode}</span>
    </div>
    <div className="flex items-center">
      <span className="font-medium mr-2">Cycle:</span>
      <span>{simulationState.cycleCount}</span>
    </div>
    <div className="flex items-center">
      {simulationState.error && (
        <span className="text-red-500">{simulationState.error}</span>
      )}
    </div>
  </div>
);
```

## CODESYS-like Online/Offline Indicators

In CODESYS, there are visual indicators showing whether you're online or offline with the PLC.

### Add Online/Offline Indicator

```tsx
const OnlineIndicator = () => (
  <div className="flex items-center p-2 bg-gray-100 dark:bg-gray-800 rounded">
    <div className={`w-3 h-3 rounded-full mr-2 ${simulationState.running ? 'bg-green-500' : 'bg-red-500'}`}></div>
    <span className="text-sm font-medium">
      {simulationState.running ? 'ONLINE' : 'OFFLINE'}
    </span>
  </div>
);
```

## Initialization

Ensure the application starts in the correct mode:

```typescript
// Initialize with STOP mode
const [simulationState, setSimulationState] = useState<SimulationState>({
  variables: [],
  messages: [],
  running: false,
  cycleCount: 0,
  error: null,
  applicationMode: ApplicationMode.STOP
});
```

## References

- [CODESYS Scripting Documentation](https://content.helpme-codesys.com/en/ScriptingEngine/idx-codesys_scripting.html)
- [ApplicationState in CODESYS](https://content.helpme-codesys.com/en/ScriptingEngine/idx-codesys_scripting.html#applicationstate)
- [OperatingState in CODESYS](https://content.helpme-codesys.com/en/ScriptingEngine/idx-codesys_scripting.html#operatingstate)