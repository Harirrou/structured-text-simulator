(* PLC Sequence Example
   Demonstrates a structured PLC program with step sequencing
   similar to real PLC applications
*)

PROGRAM SequenceControl
VAR
  (* State variables *)
  CurrentStep : INT := 0;
  StepTimer : TIME := T#0ms;
  LastStepTime : TIME := T#0ms;
  
  (* Process variables *)
  StartButton : BOOL := FALSE;
  StopButton : BOOL := FALSE;
  EmergencyStop : BOOL := FALSE;
  
  (* Input sensors *)
  SensorA : BOOL := FALSE;
  SensorB : BOOL := FALSE;
  SensorC : BOOL := FALSE;
  
  (* Output actuators *)
  MotorForward : BOOL := FALSE;
  MotorReverse : BOOL := FALSE;
  Valve1 : BOOL := FALSE;
  Valve2 : BOOL := FALSE;
  Heater : BOOL := FALSE;
  
  (* Process parameters *)
  HeatingTime : TIME := T#5s;
  CoolingTime : TIME := T#3s;
  
  (* Status indicators *)
  SystemRunning : BOOL := FALSE;
  SystemFault : BOOL := FALSE;
  CycleComplete : BOOL := FALSE;
END_VAR

(* Reset all outputs - safety first *)
PROCEDURE ResetOutputs
  MotorForward := FALSE;
  MotorReverse := FALSE;
  Valve1 := FALSE;
  Valve2 := FALSE;
  Heater := FALSE;
END_PROCEDURE

(* Main sequence control *)
IF EmergencyStop THEN
  (* Emergency stop logic *)
  CurrentStep := 0;
  SystemRunning := FALSE;
  SystemFault := TRUE;
  ResetOutputs();
ELSE
  CASE CurrentStep OF
    0: (* Idle state - waiting for start *)
      ResetOutputs();
      CycleComplete := FALSE;
      SystemFault := FALSE;
      
      IF StartButton AND NOT StopButton THEN
        CurrentStep := 10; (* Go to first step *)
        SystemRunning := TRUE;
        StepTimer := T#0ms;
      END_IF;
      
    10: (* Step 1 - Start motor forward until sensor A activates *)
      MotorForward := TRUE;
      
      IF SensorA THEN
        CurrentStep := 20; (* Move to next step *)
        LastStepTime := StepTimer;
        StepTimer := T#0ms;
      END_IF;
      
    20: (* Step 2 - Activate Valve1 and wait for heating time *)
      MotorForward := FALSE;
      Valve1 := TRUE;
      Heater := TRUE;
      
      IF StepTimer >= HeatingTime THEN
        CurrentStep := 30; (* Move to next step *)
        LastStepTime := StepTimer;
        StepTimer := T#0ms;
      END_IF;
      
    30: (* Step 3 - Cooling cycle with Valve2 *)
      Heater := FALSE;
      Valve1 := FALSE;
      Valve2 := TRUE;
      
      IF StepTimer >= CoolingTime OR SensorC THEN
        CurrentStep := 40; (* Move to next step *)
        LastStepTime := StepTimer;
        StepTimer := T#0ms;
      END_IF;
      
    40: (* Step 4 - Return to home position *)
      Valve2 := FALSE;
      MotorReverse := TRUE;
      
      IF SensorB THEN
        CurrentStep := 50; (* Move to completion *)
        LastStepTime := StepTimer;
        StepTimer := T#0ms;
      END_IF;
      
    50: (* Completion step *)
      ResetOutputs();
      CycleComplete := TRUE;
      SystemRunning := FALSE;
      CurrentStep := 0; (* Return to idle *)
      
  ELSE (* Default case - should never happen *)
    ResetOutputs();
    SystemFault := TRUE;
    CurrentStep := 0;
  END_CASE;
  
  (* Update step timer *)
  StepTimer := StepTimer + T#100ms; (* Assuming 100ms cycle time *)
  
  (* Handle stop button during operation *)
  IF StopButton AND CurrentStep > 0 THEN
    CurrentStep := 0;
    SystemRunning := FALSE;
    ResetOutputs();
  END_IF;
END_IF;