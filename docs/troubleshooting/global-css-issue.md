# Resolving the Global CSS Import Error in Next.js

## The Issue

In Next.js applications, you may encounter the following error:

```
Global CSS cannot be imported from files other than your Custom <App>. Due to the Global nature of stylesheets, and to avoid conflicts, Please move all first-party global CSS imports to pages/_app.js. Or convert the import to Component-Level CSS (CSS Modules).
```

This occurs because Next.js requires all global CSS to be imported only in the `_app.js` or `_app.tsx` file to maintain proper CSS encapsulation and avoid unexpected cascading effects.

## Why This Happens

In our structured text simulator project, we saw this error when multiple components tried to import the same global CSS file (`monaco-editor.css`). 

The error specifically appeared when:
- The CSS was imported in `programming-editor-enhanced.tsx`
- The same CSS was already imported in `_app.tsx`

## Solution

### Step 1: Check for Global CSS Imports

Inspect your components and look for imports like:

```typescript
import '../styles/monaco-editor.css';
import '../styles/globals.css';
// or any other global CSS imports
```

### Step 2: Consolidate CSS in _app.tsx

Move all global CSS imports to your `_app.tsx` file:

```typescript
// pages/_app.tsx
import '../styles/globals.css';
import '../styles/monaco-editor.css'; // Monaco editor styles
// other global styles...

function MyApp({ Component, pageProps }) {
  return <Component {...pageProps} />;
}

export default MyApp;
```

### Step 3: Remove Duplicated Imports

Remove any global CSS imports from other components. These files should NOT have global CSS imports:
- `pages/programming-editor-enhanced.tsx`
- `pages/st-simulator.tsx`
- Any other page or component files

### Step 4: For Component-Specific Styles

For styles that should only apply to specific components, use CSS Modules instead:

1. Create a file named `[Component].module.css` (e.g., `ProgrammingEditor.module.css`)
2. Import it in your component:

```typescript
import styles from './ProgrammingEditor.module.css';

function ProgrammingEditor() {
  return <div className={styles.container}>...</div>;
}
```

### Step 5: Restart Development Server

After making these changes, restart your development server:

```bash
npm run dev
```

## Additional Tips

### Using Monaco Editor with Next.js

Monaco Editor requires special handling in Next.js:

1. Ensure the Monaco Editor CSS is imported only in `_app.tsx`
2. Consider using dynamic imports for the editor component to avoid SSR issues:

```typescript
import dynamic from 'next/dynamic';

const MonacoEditorWrapper = dynamic(
  () => import('../components/MonacoEditorWrapper'),
  { ssr: false }
);
```

### When to Use Global CSS vs. CSS Modules

- **Global CSS**: Use for site-wide styles (typography, colors, layout grids)
- **CSS Modules**: Use for component-specific styles to avoid conflicts

## Verification

To verify the fix, check that:
1. Your application compiles without the Global CSS error
2. The Monaco Editor still displays correctly with proper styling
3. No styling conflicts occur between components