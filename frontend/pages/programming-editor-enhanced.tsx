import React, { useState, useEffect, useRef } from 'react';
import { useRouter } from 'next/router';
import ThemeLayout from '../components/ThemeLayout';
import { useTheme } from '../utils/ThemeContext';
import STDocumentation from '../components/STDocumentation';
import STCodeSnippetsPanel from '../components/STCodeSnippetsPanel';
import MonacoEditorWrapper from '../components/MonacoEditorWrapper';
import { EditorLayout, EditorPanel } from '../components/layout/index';
import { Button } from '../components/ui';
import { FaBook, FaCode, FaSave, FaRunning, FaList, FaPlus, FaInfo, FaKeyboard, FaExclamationTriangle, FaCheckCircle } from 'react-icons/fa';
import { registerSTLanguage, registerSTCompletionProvider, registerSTDiagnosticsProvider, registerSTAutocompleteForVariables, extractVariablesFromSTCode } from '../utils/st-language';

// Default ST code example
const defaultCode = `PROGRAM Example
VAR
  Counter : INT := 0;
  Running : BOOL := TRUE;
END_VAR

WHILE Running DO
  Counter := Counter + 1;
  
  IF Counter >= 100 THEN
    Running := FALSE;
  END_IF;
END_WHILE;`;

// Interface for validation error reporting
interface ValidationError {
  message: string;
  line: number;
  severity: 'error' | 'warning' | 'info';
  column?: number;
  endColumn?: number;
}