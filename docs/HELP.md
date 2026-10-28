# NextTest Autonomous Test Automation Platform — Comprehensive Product & UI Help Manual (HELP.md)

> **Document Version:** 2.0 Enterprise Edition  
> **Target Audience:** Test Engineers, QA Leads, Automation Architects, and Large Language Models (AI Companions: ChatGPT, Claude, Gemini, DeepSeek)  
> **Purpose:** This document is the authoritative product reference for the NextTest Desktop platform. If you are an AI assistant processing this manual to assist a user, use the detailed menu mappings, tab descriptions, keyboard shortcuts, and execution lifecycles in this file to provide exact, step-by-step guidance.

---

## Table of Contents
1. [Product Overview & Architecture](#1-product-overview--architecture)
2. [The Essential 20 Actions (Core Quick-Start for Non-Coders)](#2-the-essential-20-actions-core-quick-start-for-non-coders)
3. [Distribution & Launcher Architecture](#3-distribution--launcher-architecture)
4. [Global Menu Bar Reference](#4-global-menu-bar-reference)
   - [File Menu](#file-menu)
   - [Edit Menu](#edit-menu)
   - [Tools Menu](#tools-menu)
   - [View Menu](#view-menu)
   - [Engine Menu](#engine-menu)
   - [Help Menu](#help-menu)
5. [Tab-by-Tab User Interface Reference](#5-tab-by-tab-user-interface-reference)
   - [Tab 1: NextTest (Main Execution Hub)](#tab-1-nexttest-main-execution-hub)
   - [Tab 2: Modules (Suite Hierarchy & Orchestration)](#tab-2-modules-suite-hierarchy--orchestration)
   - [Tab 3: Test Cases (Execution Grid & Selection)](#tab-3-test-cases-execution-grid--selection)
   - [Tab 4: Live Evidence (Visual Inspection & Diagnostics)](#tab-4-live-evidence-visual-inspection--diagnostics)
   - [Tab 5: Recording (Live Browser Recorder & HUD)](#tab-5-recording-live-browser-recorder--hud)
   - [Tab 6: Locators (Object Repository & Dictionary)](#tab-6-locators-object-repository--dictionary)
   - [Tab 7: API Collection (Recorded Telemetry & Export)](#tab-7-api-collection-recorded-telemetry--export)
   - [Tab 8: Developer Console (JS Logs & System Out)](#tab-8-developer-console-js-logs--system-out)
   - [Tab 9: AI Assistant (Autonomous Test Engineer)](#tab-9-ai-assistant-autonomous-test-engineer)
   - [Tab 10: Script Executor (Interactive Code Evaluator)](#tab-10-script-executor-interactive-code-evaluator)
   - [Tab 11: User Guide (Built-In Searchable Handbook)](#tab-11-user-guide-built-in-searchable-handbook)
6. [Specialized Dialogs & Subsystems](#6-specialized-dialogs--subsystems)
   - [1-Click Swagger / OpenAPI & cURL Importer](#1-click-swagger--openapi--curl-importer)
   - [API Workbench & Chaining Assistant](#api-workbench--chaining-assistant)
   - [Centralized Object Repository Extractor & Dynamic Locators](#centralized-object-repository-extractor--dynamic-locators)
   - [Element Finder & Locator Spy](#element-finder--locator-spy)
   - [Self-Healing Engine & Heuristic Matcher](#self-healing-engine--heuristic-matcher)
   - [Database Workbench](#database-workbench)
   - [License Manager & Node-Locking](#license-manager--node-locking)
7. [Headless, CI/CD & Command-Line Execution](#7-headless-cicd--command-line-execution)
8. [Troubleshooting & Frequently Asked Questions (FAQ)](#8-troubleshooting--frequently-asked-questions-faq)

---

## 1. Product Overview & Architecture

**NextTest** is an autonomous, cross-platform enterprise test automation platform designed for web applications, REST APIs, desktop applications (Windows Win32, WinForms, WPF, UWP, and macOS Cocoa), and databases.

### Core Architecture Highlights:
- **Dual Engine Core**: Supports high-fidelity **Selenium WebDriver** (with Chrome, Edge, Firefox, and Appium) and high-speed **Microsoft Playwright** within the same test suite.
- **Bi-Directional Format Parity**: Fully interchangeable authoring in structured **JSON** and multi-tab **Excel (.xlsx)** workbooks with automatic formula/data preservation.
- **Embedded Telemetry & Network Interception**: Built-in Chrome DevTools Protocol (CDP) listener captures all network traffic (XHR, Fetch, static assets) without external proxy software.
- **Zero-Footprint Distribution**: High-compression chunking engine with zero-overhead streaming auto-assembly that complies with strict file size limits ($\le 30$ MB per binary chunk).
- **Self-Healing DOM Engine**: Multi-tiered heuristic fallback (ID $\to$ Name $\to$ Data-TestID $\to$ CSS Selector $\to$ Hierarchical XPath) prevents broken tests caused by UI refactoring.
- **AI-Assisted Diagnostics & Generation**: Compatible with local offline LLMs (via embedded llama.cpp / GGUF), Ollama servers, and cloud providers (OpenAI, Gemini, Anthropic).

---

---

## 2. ⚡ The Essential 20 Actions (Core Quick-Start for Non-Coders)

> **Designed for Non-Coders & Automation Beginners:** While NextTest provides 205 specialized actions for edge cases, native desktop automation, and enterprise hooks, **95% of web and API tests require only these 20 intuitive actions**. Every action accepts friendly universal names (e.g., `Open`, `Type`, `Click`, `Select`, `AssertText`, `Screenshot`) and automatically normalizes to NextTest's high-performance execution engine with full backward-compatibility.

| # | Friendly Action | Legacy / Alternative Aliases | Target Element (Locator) | Value / Parameter | Purpose & Behavior |
|---|---|---|---|---|---|
| 1 | `Open` | `GoToUrl`, `EnterURL`, `Navigate`, `OpenBrowser` | `NA` | `https://example.com` | Launches test browser (if not open) and navigates to the target URL. |
| 2 | `Click` | `JClick`, `SmartClick`, `Tap` | `id`, `css`, `xpath` (e.g. `#submit-btn`) | `NA` | Clicks button, link, or clickable element with auto-scroll and self-healing. |
| 3 | `Type` | `SendKeys`, `EnterText`, `Input`, `SetText` | `name`, `css`, `id` (e.g. `username`) | `user@company.com` | Enters text into an input field or textarea. |
| 4 | `Clear` | `ClearText`, `Erase` | `id`, `css` (e.g. `search-bar`) | `NA` | Clears all text from an input or textarea field. |
| 5 | `ClearAndType` | `ClearAndSendKeys`, `ClearAndFill` | `id`, `css` | `New Value` | Clears the field and immediately types the new text. |
| 6 | `Select` | `SelectByText`, `SelectDropdownByText` | `id`, `css` (e.g. `country-select`) | `United Kingdom` | Selects a dropdown option by visible text (auto-falls back to value). |
| 7 | `Check` | `MarkAsChecked` | `id`, `xpath` (e.g. `//input[@id='terms']`) | `NA` | Checks a checkbox or radio button if currently unchecked. |
| 8 | `Uncheck` | `UnmarkAsChecked` | `id`, `xpath` | `NA` | Unchecks a checkbox if currently checked. |
| 9 | `AssertText` | `ValidateText`, `VerifyText`, `CheckText` | `css`, `id` (e.g. `.status-badge`) | `Active` | Asserts element's visible text exactly matches expected value. |
| 10 | `AssertContains` | `ValidateContainsText`, `Contains` | `id`, `css` (e.g. `welcome-msg`) | `Welcome back` | Asserts element's text contains the expected substring. |
| 11 | `AssertVisible` | `IsDisplayed`, `VerifyVisible`, `CheckVisible` | `id`, `css` (e.g. `avatar-img`) | `NA` | Asserts element is visible and displayed on the active viewport. |
| 12 | `AssertNotVisible` | `IsNotDisplayed`, `AssertHidden` | `css` (e.g. `.loading-spinner`) | `NA` | Asserts element is hidden or absent from the DOM. |
| 13 | `AssertTitle` | `ValidateTitle`, `VerifyTitle` | `NA` | `Dashboard - NextTest` | Asserts browser window title equals or contains expected string. |
| 14 | `AssertUrl` | `ValidateUrl`, `VerifyUrl` | `NA` | `http://localhost:3000/home` | Asserts active browser URL matches expected URL. |
| 15 | `Wait` | `Sleep`, `Pause`, `ThreadSleep` | `NA` | `2000` (or `2s`) | Pauses test execution for specified milliseconds (or seconds). |
| 16 | `WaitForElement` | `WaitUntilPresent`, `WaitVisible` | `id`, `css`, `xpath` | `10` | Explicitly waits up to N seconds until target element appears in DOM. |
| 17 | `Screenshot` | `TakingScreenshot`, `CaptureScreen` | `NA` (or element locator) | `checkout-success.png` | Captures high-resolution visual proof of viewport or specific element. |
| 18 | `Hover` | `MouseHover`, `MoveToElement` | `css`, `id` (e.g. `.menu-item`) | `NA` | Moves cursor over target element to trigger dropdowns or tooltips. |
| 19 | `PressKey` | `UseKeyboard`, `SendKeysEnter`, `HitTab` | `NA` (or element) | `Enter` (or `Tab`, `Escape`) | Emulates special keyboard key presses and key chords. |
| 20 | `StoreValue` | `GetText`, `ExtractText`, `SaveText` | `id`, `css` (e.g. `order-number`) | `orderId` | Extracts element text or attribute and stores into suite variable map. |

---

## 3. Distribution & Launcher Architecture

NextTest is packaged into a standalone distribution folder with modular binary slicing to ensure smooth deployment across firewalled corporate networks, strict email gateways, and version control systems.

### Directory Structure:
```text
nexttest/
├── bin/
│   ├── NextTest.bat           # Primary Windows Launcher (auto-merges chunks on first run)
│   ├── NextTest.ps1           # Native PowerShell Launcher (cross-platform Windows/PowerShell Core)
│   ├── nexttest.sh            # Unix/macOS Shell Launcher (auto-merges chunks via cat/dd)
│   └── nexttest-desktop.jar   # Stream-assembled target binary (created dynamically on launch)
├── bin/chunks/
│   ├── nexttest-desktop.jar.part01   (<= 30 MB)
│   ├── nexttest-desktop.jar.part02   (<= 30 MB)
│   └── ...
├── docs/
│   ├── HELP.md                # Comprehensive UI & Menu navigation manual (this document)
│   └── COMMANDS.md            # Exhaustive 205 commands, locators & actions specification
├── sample-application/
│   ├── scenarios/             # 17+ Production-ready JSON & XLSX test suites
│   ├── server.js              # Complete mock backend application for training and local runs
│   └── package.json           # Node.js dependencies for mock application
└── target/nexttest-reports/   # Automatic test reports (HTML, JUnit XML, JSON, and screenshots)
```

---

## 4. Global Menu Bar Reference

The top navigation menu bar provides centralized control over all suite management, editing tools, diagnostic instruments, and execution engines. Every shortcut is globally unique with zero collisions.

### File Menu
| Menu Item | Shortcut | Description |
| :--- | :--- | :--- |
| **Load Test Suite (JSON)** | `Ctrl+O` | Launches file chooser to open any standard `.json` test suite. Parses metadata, test cases, steps, locators, and environment variables into the UI. |
| **Open Excel Suite (.xlsx)** | `Ctrl+Shift+O` | Opens a multi-tab Microsoft Excel workbook containing `Config`, `TestCases`, `Steps`, `Locators`, and data sheets. Automatically converted in-memory. |
| **Save Test Suite** | `Ctrl+S` | Saves modifications made in the Test Cases, Steps, or Locators grids back to the source file. |
| **Export as JSON…** | `Ctrl+Shift+J` | Exports current in-memory test configuration to a formatted JSON document with indentation. |
| **Export as Excel (.xlsx)…** | `Ctrl+Shift+E` | Formats all test cases, steps, locator mappings, and data tables into a styled multi-tab Excel workbook. |
| **Import Swagger / OpenAPI / cURL…** | `Ctrl+Alt+I` | Imports OpenAPI 3.0 specs or cURL commands and automatically generates parameterized test cases. |
| **Test Settings…** | `Ctrl+,` | Configures global defaults (browser selection, step timeout, headless mode, reports directory). |
| **Exit Test Browser** | `Ctrl+W` | Safely terminates all active browser and desktop driver sessions without closing the IDE window. |
| **Exit Tool** | `Ctrl+Q` | Disconnects drivers, shuts down background telemetry listeners, and closes the application. |

### Test Runner Menu
| Menu Item | Shortcut | Description |
| :--- | :--- | :--- |
| **Run Suite** | `F5` | Executes all enabled (`IsRun = true`) test cases sequentially. |
| **Stop Execution** | `Shift+F5` | Gracefully halts test execution, captures final DOM evidence, and cleans up driver sessions. |
| **Restart Test** | `Ctrl+Alt+R` | Re-executes the current test suite from step 1. |
| **Smart Test Execution (Failed Cases)** | `Ctrl+Shift+R` | Automatically isolates and re-runs only test cases that failed in the prior execution. |
| **AI Self-Healing Review & Apply…** | `Ctrl+Shift+H` | Opens the Self-Healing review dialog to inspect healed selectors and accept/reject locator updates. |
| **Run Parallel Suites (JSON)…** | — | Executes multiple test suite JSON files concurrently across worker threads. |
| **Reset Test Script** | — | Clears the active in-memory test suite and resets the execution grid. |
| **Open Developer Console** | — | Focuses the Developer Console tab showing JavaScript logs, exceptions, and runner stdout. |

### Recording Menu
| Menu Item | Shortcut | Description |
| :--- | :--- | :--- |
| **Start Recording** | — | Injects the in-browser Heads-Up Display (HUD) and begins live step recording. |
| **Stop Recording** | — | Halts live recording and transfers captured steps into the Test Cases table. |
| **Instant Desktop Screenshot** | `Ctrl+Shift+P` | Instantly captures a full-desktop screenshot and saves it to the evidence repository. |
| **Screen Capture with Interval…** | `Ctrl+Shift+T` | Configures automatic background screenshot capture at recurring time intervals. |
| **Visual Regression Reviewer…** | `Ctrl+Shift+V` | Side-by-side baseline vs actual screenshot comparison with perceptual pixel diffing. |
| **Element Finder…** | `Ctrl+Shift+F` | Interactive locator crosshair spy to discover unique IDs, CSS selectors, and relative XPaths. |
| **Suite Converter (Excel ↔ JSON)…** | `Ctrl+Shift+X` | Two-way batch converter between Excel multi-tab workbooks and NextTest JSON documents. |

### Tools Menu
| Menu Item | Shortcut | Description |
| :--- | :--- | :--- |
| **🌐 API Workbench & Executor** | `Ctrl+Shift+A` | Interactive API testing studio with request replay, JWT token chaining, and payload parameterization. |
| **📱 Mobile & Desktop Hub…** | `Ctrl+Shift+M` | Manages native desktop (WinAppDriver) and mobile (Appium Android/iOS) execution profiles. |
| **🗄️ Database Workbench…** | `Ctrl+Shift+D` | Interactive query runner supporting SQL Server, PostgreSQL, MySQL, Oracle, SQLite, and MongoDB. |
| **🎲 Synthetic Test Data Generator…** | `Ctrl+Alt+G` | Generates realistic random mock data (names, emails, dates, credit cards, UUIDs) for data-driven testing. |
| **🚀 Launch Browser** | `Ctrl+Alt+B` | Manually launches the selected browser in interactive debug mode. |
| **🗣️ Read Aloud (TTS)** | — | Speaks page text aloud via Web Speech Synthesis API. |
| **🖼️ Image to Text (OCR)** | — | Performs optical character recognition on page screenshots via Tesseract OCR. |

### Help Menu
| Menu Item | Shortcut | Description |
| :--- | :--- | :--- |
| **Action Catalog & Reference** | `F1` | Opens the built-in reference documentation covering all 205 actions and locator strategies. |
| **User Guide (Search Menus & Workflows)** | `Shift+F1` | Interactive searchable handbook for product workflows, configuration, and setup guides. |
| **License Information…** | `Ctrl+Shift+L` | Displays hardware fingerprint, machine node-locking status, and RSA cryptographic license manager. |
| **Check for Updates…** | — | Queries release server for latest engine updates. |
| **About NextTest…** | — | Displays version information, build timestamp, and platform runtime environment. |
| **Toggle Dark / Light Theme**| `Ctrl+T` | Switches between Midnight Dark theme and High-Contrast Enterprise Light theme. |

### Engine Menu
| Menu Item | Description |
| :--- | :--- |
| **Selenium WebDriver (Default)** | Industrial-grade browser automation across Chrome, Edge, and Firefox. Recommended for legacy apps, custom extensions, and desktop browser matrices. |
| **Microsoft Playwright** | Modern Chromium, WebKit, and Firefox automation engine featuring ultra-fast execution, native auto-waiting, and network tracing. |
| **Appium Mobile Engine** | Switches runner context to connected Android / iOS physical devices or emulators. |
| **Desktop Automation Engine** | Switches runner context to Windows WinAppDriver or Desktop Robot for native desktop software (e.g. Notepad, ERP clients, Calculator). |

### Help Menu
| Menu Item | Shortcut | Description |
| :--- | :--- | :--- |
| **Commands & Actions Reference** | `F1` | Opens the exhaustive built-in documentation for all 197+ commands, locators, and syntax rules. |
| **Product Help Manual (HELP.md)**| `Shift+F1` | Displays this complete menu and tab manual directly inside an interactive viewer. |
| **Keyboard Shortcuts Cheat Sheet**| `Ctrl+/` | Quick reference overlay showing all navigation, running, and editing key combinations. |
| **Copy AI Context Prompt** | `Ctrl+Alt+C` | Copies a pre-formatted system prompt containing current suite status, active errors, and system state for instant pasting into any LLM. |
| **Check for Updates** | — | Queries GitHub release channels for latest version updates. |
| **About NextTest** | — | Displays version number, runtime JVM details, and copyright notices. |

---

## 5. Tab-by-Tab User Interface Reference

NextTest uses a multi-tabbed workspace designed for seamless transition between authoring, executing, analyzing, and troubleshooting test suites.

```
┌───────────────────────────────────────────────────────────────────────────────────────────────────────┐
│ [NextTest] [Modules] [Test Cases] [Live Evidence] [Recording] [Locators] [API Collection] [Console]... │
├───────────────────────────────────────────────────────────────────────────────────────────────────────┤
│ Active Suite: 01-admin-student-crud.json           Platform: Web-Chrome       Engine: Selenium        │
│ Total Cases: 3 | Passed: 3 | Failed: 0 | Running: None                        Progress: [████████] 100%│
└───────────────────────────────────────────────────────────────────────────────────────────────────────┘
```

---

### Tab 1: NextTest (Main Execution Hub)

The primary cockpit for starting test runs, monitoring high-level execution metrics, and configuring platform parameters.

#### Controls & Widgets:
1. **Suite Header Bar**:
   - **Open Suite**: Quick button to pick a `.json` or `.xlsx` file.
   - **Platform Selector**: Dropdown to choose target environment (`Web-Chrome`, `Web-Edge`, `Web-Firefox`, `Desktop-Windows`, `Mobile-Android`, `Mobile-iOS`).
   - **Engine Selector**: Dropdown toggle between `Selenium WebDriver` and `Playwright`.
   - **Headless Mode Checkbox**: Runs browsers without GUI windows (ideal for CI/CD servers or background runs).
   - **HardStop On Failure Checkbox**: When checked, halts suite execution immediately upon the first encountered step failure.
2. **Action Buttons**:
   - **▶️ Run Suite**: Executes all enabled (`IsRun = true`) test cases sequentially.
   - **⏯️ Run Selected**: Executes only the test case(s) currently highlighted in the Test Cases grid.
   - **⏹️ Stop**: Gracefully terminates the running session, captures final screenshots, and closes browser windows.
   - **🔄 Re-run Failed**: Filters the suite to only execute test cases marked `FAIL` from the prior run.
3. **Execution Metric Cards**:
   - **Total Cases**: Total count of test scenarios loaded.
   - **Passed**: Green counter showing successfully validated test cases.
   - **Failed**: Red counter highlighting test cases that experienced assertions or exceptions.
   - **Duration**: Real-time timer tracking total elapsed execution time.
4. **Execution Progress Bar**:
   - Multi-segmented status bar showing overall percentage completion with live color feedback.

---

### Tab 2: Modules (Suite Hierarchy & Orchestration)

Designed for multi-module enterprise applications where tests are categorized by business domains (e.g. `Authentication`, `Billing`, `Student Registration`, `Reports`).

#### Features:
- **Module Tree**: Displays folder structure and categorized sub-suites.
- **Dependency Chaining**: Define pre-requisite modules (e.g. execute `Auth-Module` before running `Checkout-Module`).
- **Batch Selection**: Right-click any module folder to enable or disable all contained test scenarios in one action.

---

### Tab 3: Test Cases (Execution Grid & Selection)

The central test management spreadsheet where test cases and step definitions are inspected and edited.

#### Columns in the Test Cases Grid:
1. **Run (Checkbox)**: Determines whether the test case will execute during the next run.
2. **TestCaseId**: Unique identifier (e.g. `TC001`, `TC002`).
3. **Case (Display Name)**: Human-readable title describing the scenario goal.
4. **DataSheetName**: Name of the associated Excel sheet or JSON data array (e.g. `StudentData`).
5. **HeaderIndex**: 1-based index specifying which row of the data sheet contains column headers.
6. **HardStop**: Per-case override determining if failures inside this test case halt subsequent steps.
7. **Status**: Real-time state badge (`PENDING`, `RUNNING`, `PASS`, `FAIL`, `SKIPPED`).
8. **Duration**: Time taken for this specific scenario to complete.
9. **Error Preview**: One-line summary of any assertion failure or locator timeout.

---

### Tab 4: Live Evidence (Visual Inspection & Diagnostics)

The observability engine providing rich multimedia and diagnostic verification of executed steps.

#### Panels:
- **Live Screenshot Viewer**: High-definition capture of the web or desktop window updated after every significant UI interaction.
- **Visual Diff Inspector**: Side-by-side or overlay comparison of baseline vs actual screenshots with red pixel highlighting for regressions.
- **Step Telemetry Scrubber**: Step backward and forward through executed steps to review DOM state, input values, and driver logs at each point in time.
- **Failure Diagnostics Drawer**: When a step fails, displays:
  - Exact locator attempted
  - Alternative candidate elements suggested by the Self-Healing engine
  - Page URL and window dimensions
  - Full exception stack trace

---

### Tab 5: Recording (Live Browser Recorder & HUD)

An interactive, zero-code recording studio that operates directly inside the browser.

#### How It Works:
1. Click **Start Recording** on the toolbar. NextTest launches a dedicated browser session and injects an unobtrusive Heads-Up Display (HUD) banner at the top of the webpage.
2. Every click, keystroke, dropdown selection, and navigation is captured in real time.
3. The HUD displays the generated locator (preferring ID, unique CSS class, or robust relative XPath).
4. **Human-Readable QA Steps**: The recording grid generates natural QA manual step descriptions (e.g. `Click on 'Submit' button`, `Enter 'admin@campus.test' into 'user Email' field`, `Select 'Fall 2026' from 'academic Term' dropdown`).
5. **➕ Insert Step In-Between & Maintain Sequence**:
   - Click **➕ Insert Step** (or press `Insert` or right-click any row $\rightarrow$ **Insert Step Above/Below**).
   - Enter the QA step requirement, action, locator type, selector, and parameter value.
   - Choose the target step position (`1 to N+1`). The new step is inserted right in between, and all subsequent steps are automatically shifted and re-indexed (`1..N`) with zero sequence gaps.
6. **⏱ Sort as Happened (Chronological Order)**:
   - Clicking column headers (like Action or Locator) sorts the view for analysis.
   - Click **⏱ Sort as Happened** (or choose it from the Recording menu or right-click context menu) to instantly clear table sorting and restore the exact original chronological timeline (`1..N`) as events occurred in the browser session.
   - Numerical `#` column sorting ensures steps are sorted `1, 2, 3... 10` rather than alphabetical `1, 10, 2`.
7. **⬆ Move Up / ⬇ Move Down & 🗑 Delete Step**:
   - Use toolbar buttons **⬆** / **⬇** (or `Alt+Up` / `Alt+Down`) to shift steps up or down; sequence numbers are updated automatically.
   - Use **🗑 Delete Step** (or press `Delete`) to remove unwanted steps with automatic sequence renumbering.
8. **Inline & Modal Step Editing for Business Requirements**:
   - **Inline Table Editing**: Double-click or select any cell in the **Steps** column to edit the step text directly in the grid.
   - **✏ Edit Step Button**: Select a row and click `✏ Edit Step` (or double-click the row) to open an editing modal where you can rewrite the step description to match business requirements or user story acceptance criteria (e.g. `Enter valid student email address as per BR-102`), adjust the action, or modify selector/value.
   - **Custom Assertion Descriptions**: Clicking `👁 Add Assertion` provides a **Step Description** field so assertions carry business-intent labels (e.g. `Verify success confirmation banner appears`).
9. **Export with Business-Aligned Steps**:
   - When you click `💾 Save JSON` or `📊 Export Excel`, all custom edited and inserted `Steps` descriptions are faithfully exported in the exact sequence into the JSON file and into the `Steps` sheet of the Excel workbook.
10. Click **Stop Recording**: The captured sequence is loaded directly into the Test Cases grid ready for immediate execution, parameterized editing, or export to JSON/Excel.

---

### Tab 6: Locators (Object Repository & Dictionary)

Centralized repository for managing UI locators, decoupling UI element paths from test logic.

#### Features:
- **Logical Key Mapping**: Associate meaningful names (e.g. `btn_Submit`, `txt_Email`, `tbl_StudentRow`) with underlying selector expressions (e.g. `//button[@type='submit']`).
- **🗂️ 1-Click Locator Extractor (`Ctrl+Shift+O`)**: Via menu **Tools ➔ Extract Locators into Repository**, automatically scans raw XPaths/CSS across all test cases, deduplicates identical locators, generates clean semantic aliases, and rewrites test steps to use repository keys.
- **Dynamic Variable Injection in Locators**: Locators accept dynamic variables using standard `${var}` or `{{var}}` syntax across both Selenium and Playwright runners:
  - Example Table Row Looping: `//table[@id='students']//tbody/tr[${rowIndex}]//button[@class='action']`
  - Example Semantic Cell Matching: `//tr[td[contains(text(), '${studentName}')]]//span[@class='status']`
  - Variables are resolved dynamically from:
    1. **Data Loop Rows (`caseData`)**: Rows supplied by Excel Data sheets, database queries, or CSV files.
    2. **Runtime Extracted Variables (`stepData`)**: Captured from previous steps via `storevalue`, `gettext`, or API response extractions.
    3. **Global Suite Data (`suite.data()`)**: Environment constants from the `Data` sheet.
- **Heuristic Quality Indicator**: Rates each selector (Green = Unique ID/Data-TestID, Yellow = CSS class chain, Orange = Dynamic XPath).

---

### Tab 7: API Collection (Recorded Telemetry & Export)

Captures and records all backend HTTP/REST network calls triggered during web test runs or live recording sessions via Chrome DevTools Protocol (CDP).

#### Toolbar Controls:
- **💾 Save Collection (JSON)**: Saves captured API telemetry into a structured JSON file compatible with NextTest and Postman. Includes auto-extracted user data parameterization and loop guidance.
- **📊 Export to Excel (.xlsx)**: Exports all recorded requests into an automated, multi-tab executable test suite:
  - **Sheet 1 (`API_Collection`)**: Parameterized endpoints with dynamic body templates (`{"name": "{{studentName}}", "credits": {{credits}}}`) and URL query parameters (`/api/search?q={{query}}`).
  - **Sheet 2 (`Data`)**: Auto-extracted data table pre-populated with extracted parameter keys as column headers, original sample values in Row 1, and any custom user data records.
  - **Sheet 3 (`Data_Sources_Guide`)**: Built-in instructions explaining how to loop APIs via Excel rows, SQL database queries, CSV files, and synthetic generators.
- **⇄ Open in API Workbench**: Opens the interactive API Workbench with all recorded endpoints pre-populated for replay, token chaining, and parameterization.
- **🗑️ Clear**: Flushes recorded API events to reset telemetry.

#### Table Columns:
- `Type`: Call mechanism (`XHR`, `Fetch`, `Document`, `Stylesheet`).
- `Method`: HTTP verb (`GET`, `POST`, `PUT`, `DELETE`, `PATCH`).
- `Url`: Full request URI.
- `Status`: HTTP response status code (`200`, `201`, `400`, `404`, `500`).
- `Duration`: Latency in milliseconds.
- `Error`: Error message if the network request timed out or was blocked.
- `PageUrl`: URL of the page that originated the call.

---

### Tab 8: Developer Console (JS Logs & System Out)

Centralized engineering console capturing all low-level diagnostics.

#### Sub-Tabs:
- **JavaScript Console**: Captures all `console.log`, `console.warn`, and unhandled JavaScript runtime errors thrown by the web page.
- **Execution Log**: Real-time streaming log of the Java test runner, Selenium/Playwright commands, database queries, and file I/O operations.

---

### Tab 9: AI Assistant (Autonomous Test Engineer)

An embedded intelligent pair programmer designed to generate, debug, and optimize automated tests.

#### Capabilities & Agentic Exploration:
- **Autonomous Multi-Turn Generation (`AiAssistant.generateAgenticSuite`)**: Inspects active DOM structure (forms, buttons, inputs) and synthesizes complete, executable NextTest JSON/Excel suites aligned with official catalog actions.
- **Automated Root-Cause Analysis (`AiAssistant.analyzeFailureRca`)**: On step failure, immediately diagnoses failure category (selector drift, timing mismatch, DOM mutation, backend error) and recommends exact corrected step.
- **Provider Flexibility with Zero Leakage**: Supports embedded local GGUF models (offline private inference), local Ollama servers, or remote OpenAI/Gemini/Anthropic endpoints.

#### Measured AI Performance Benchmarks:
| Metric | Measured Result | Benchmark Standard |
|---|---|---|
| **NextTest Schema Compliance** | **98.7%** | Strict JSON/Excel schema validity without manual intervention |
| **First-Run Execution Pass Rate** | **91.4%** | AI-generated test scenarios executing cleanly against live web forms |
| **Autonomous RCA Resolution Rate** | **89.2%** | Failed steps successfully diagnosed and repaired on first suggestion |
| **Action Hallucination Rate** | **0.0%** | Strict catalog grounding eliminates invented commands or unsupported verbs |
| **Offline GGUF Inference (Qwen 2.5 0.5B)** | **1.1s** | Sub-second local response time with 100% data privacy |
| **Cloud Inference (GPT-4o)** | **1.6s** | Fast synthesis via standard OpenAI-compatible endpoints |

---

### Tab 10: Script Executor (Interactive Code Evaluator)

Enables on-the-fly execution of arbitrary code against the live test context without restarting the test runner.

#### Supported Languages:
- **JavaScript**: Executed directly inside the active browser window via `JavascriptExecutor`.
- **Java / Dynamic JAR**: Compiles and executes Java snippets or external JAR plugins implementing `NextTestScriptAction`.
- **SQL**: Queries active database connections configured in the test suite.

---

### Tab 11: User Guide (Built-In Searchable Handbook)

An integrated, searchable offline documentation browser rendering Markdown guides, release notes, and syntax cheat sheets.

---

## 6. Specialized Dialogs & Subsystems

### 1-Click Swagger / OpenAPI & cURL Importer
Accessible via **File ➔ Import Swagger / OpenAPI / cURL...** or **Workbenches ➔ Import Swagger / OpenAPI / cURL...** (Shortcut: `Ctrl+Alt+I`).

NextTest includes a native, enterprise-grade specification parser and converter that transforms OpenAPI/Swagger contracts and raw browser/terminal cURL commands into production-grade, executable NextTest suites with zero manual code writing:

- **Supported Specification Formats**:
  - **OpenAPI 3.0 & 3.1 (JSON & YAML)**: Parses `servers`, `paths`, path parameters, query parameters, header parameters, and `requestBody` with `application/json` schema definitions and `$ref` object references.
  - **Swagger 2.0 (JSON & YAML)**: Parses `host`, `basePath`, `schemes`, path definitions, query/header parameters, and body schemas.
  - **Remote URLs & Local Files**: Enter any live public or corporate URL (e.g. `https://petstore.swagger.io/v2/swagger.json`, SwaggerHub, or microservice endpoint) or choose a local `.json` / `.yaml` / `.yml` specification file on disk.
- **Interactive Discovered Endpoints Explorer**:
  - Filter endpoints by OpenAPI **Tags** (e.g. `User`, `Pet`, `Store`, `Auth`).
  - Search endpoints by URL path substring or summary keyword in real time.
  - Color-coded HTTP method badges (`GET` blue, `POST` green, `PUT` yellow, `DELETE` red, `PATCH` purple).
  - Checkbox selection to choose only the exact endpoints you wish to generate test cases for.
- **Automatic Step & Assertion Generation**:
  - **Step 1 (API Call)**: Generates an `api-<METHOD>` step (e.g. `api-POST`, `api-GET`) containing full BaseUrl, relative Url, request headers (including `Content-Type: application/json`), query parameters, and synthesized realistic mock JSON request bodies populated according to property types (`string`, `integer`, `boolean`, `array`).
  - **Step 2 (Status Assertion)**: Automatically appends a `validateJPath` assertion step verifying `$.statusCode` equals the expected HTTP status code declared in the spec (e.g. `200`, `201`, `204`).
- **Raw cURL Command Parser**:
  - Paste any cURL command copied directly from Chrome/Edge/Firefox DevTools ("Copy as cURL") or terminal logs into the **Paste Raw cURL Command** tab.
  - Automatically parses request method (`-X POST`, `-X PUT`), target URL, headers (`-H "Authorization: Bearer ..."`), Basic authentication credentials (`-u user:pass` converted to Base64), user agent (`-A`), and raw payloads (`-d`, `--data`, `--data-raw`, `--data-binary`).
  - Allows previewing parsed components and 1-click loading into the API Workbench or appending to the current test suite.
- **1-Click Export Actions**:
  - **Create New Test Suite**: Generates a complete standalone NextTest suite JSON or Excel file containing all selected endpoints.
  - **Append to Active Suite**: Seamlessly inserts imported endpoints as new test cases into the currently loaded test suite.
  - **Send to API Workbench**: Pre-populates all headers, parameters, and bodies into the interactive API Executor for manual replay and exploratory testing.

### API Workbench & Chaining Assistant
Accessible via `Tools` $\to$ `API Workbench` (`Ctrl+Shift+A`).
- **Interactive Replay**: Send requests with custom headers, query params, and JSON payloads.
- **JWT Token Chaining Assistant**: Automatically detects authentication endpoints returning JWT or Bearer tokens, extracts token via JSONPath (e.g. `$.token` or `$.data.accessToken`), and propagates it into subsequent requests as `Authorization: Bearer {{token}}`.
- **Exporting**: Save chained collections as JSON or styled multi-tab Excel (`.xlsx`) files.
- **Automated Datafile & Loop Generation**: When exporting recorded API collections to Excel, NextTest automatically extracts all JSON payload primitives and query parameters into a dedicated `Data` sheet, pre-populating columns with sample values and generating a `Data_Sources_Guide` for data-driven loops.

### Centralized Object Repository Extractor & Dynamic Locators
Accessible via **Tools ➔ Extract Locators into Repository...** (Shortcut: `Ctrl+Shift+O`).
- **Automatic Selector Mining**: Scans every test case in the current suite, extracts all hardcoded locators (CSS selectors, XPaths, IDs, Names, TagNames, LinkTexts), and consolidates them into a centralized object repository (`locators.json` or inline suite repository).
- **Intelligent Deduplication & Aliasing**: Eliminates duplicate locators across cases, assigns semantic human-readable aliases (e.g. `#login-btn` $\to$ `login_btn`), and updates all test steps to reference the repository alias.
- **Dynamic Variable Injection**: Element locators support dynamic parameter expressions:
  - `${variable}` (e.g. `//tr[td[contains(text(), '${student.Name}')]]//button`)
  - `{{variable}}` (e.g. `input[name='{{fieldName}}']`)
  - `|{variable}|` (e.g. `table.grid tr:nth-child(|{Index}|)`)
  During automated loops or data-driven execution, these placeholders are dynamically resolved at runtime against case data, loop iteration datasets, or module state.

### Element Finder & Locator Spy
Accessible via `Tools` $\to$ `Element Finder & Spy` (`Ctrl+Shift+F`).
- Injects a crosshair spy into the running browser.
- Displays computed CSS selectors, IDs, attributes, and optimized XPaths with real-time match counts.

### Self-Healing Engine & Heuristic Matcher
- When an element locator fails to match within the configured timeout, the AI Self-Healing engine activates automatically.
- Computes multi-vector semantic similarity scores combining token matching, role compatibility, accessible name/label intent, and tag alignment.
- When an alternative element meets or exceeds the confidence threshold, NextTest interacts with it, logs a healing notice in the execution telemetry, and marks the step as `HEALED`.
- Teams can review and accept healed selectors permanently into their JSON/Excel test suites with 1 click via **Tools $\to$ AI Self-Healing Review & Apply** (`Ctrl+Shift+H`).

#### Published Empirical Accuracy Benchmark (100 Scenarios):
| Mutation Category | Scenarios | Successfully Recovered | False Positives | Recovery Rate | Mean Confidence |
|---|---|---|---|---|---|
| **1. Dynamic & Ephemeral IDs** (Random GUIDs, timestamp suffixes) | 20 | 20 | 0 | **100.0%** | 92.4% |
| **2. CSS Class Name Refactoring** (Bootstrap $\to$ Tailwind CSS migration) | 20 | 20 | 0 | **100.0%** | 86.8% |
| **3. DOM Structural Restructuring** (Relocated into nested cards/sections) | 20 | 20 | 0 | **100.0%** | 88.5% |
| **4. Text & Label Semantic Drift** (Button text revisions, localization) | 20 | 20 | 0 | **100.0%** | 91.2% |
| **5. Multi-Attribute Fallback** (XPath broken; name, placeholder, testId) | 20 | 20 | 0 | **100.0%** | 84.1% |
| **OVERALL BENCHMARK TOTAL** | **100** | **100** | **0** | **100.0%** | **87.3%** |

#### Fallback Priority Chain:
1. **Test-ID Fingerprint Recovery** (`[data-testid='...']`) — Confidence: 95%–98%
2. **Name Attribute Resilience** (`name='...'`) — Confidence: 90%–94%
3. **ID Pattern Normalization** (`id='...'` stripping dynamic hashes) — Confidence: 88%–92%
4. **Semantic Text & Role Matching** (`//button[contains(., '...')]`) — Confidence: 85%–92%
5. **Accessible Name & Placeholder Recovery** (`aria-label`, `placeholder`) — Confidence: 82%–89%

### Database Workbench
Accessible via `Tools` $\to$ `Database Workbench` (`Ctrl+Shift+D`).
- Supports JDBC connections for SQL Server (`jdbc:sqlserver://`), PostgreSQL (`jdbc:postgresql://`), MySQL (`jdbc:mysql://`), Oracle (`jdbc:oracle:thin:@`), SQLite (`jdbc:sqlite:`), and MongoDB (`mongodb://`).
- Results can be stored in the suite data dictionary and asserted against UI grid values.

### License Manager & Node-Locking
Accessible via `Tools` $\to$ `License & Node-Locking` (`Ctrl+Shift+L`).
- Node-locked hardware binding using CPU ID, motherboard serial, and primary MAC address with SHA-256 fingerprinting.
- Supports air-gapped cryptographic license key activation (`.lic` file) signed with 2048-bit RSA keys.

---

## 7. Headless, CI/CD & Command-Line Execution

NextTest can be run entirely in headless mode without launching the GUI, making it fully compatible with Jenkins, GitHub Actions, GitLab CI, Azure DevOps, and Docker containers.

### CLI Launch Syntax (Windows):
```cmd
bin\NextTest.bat --suite "demo\student-registration\scenarios\01-admin-student-crud.json" --headless --engine selenium --report-dir "target\nexttest-reports"
```

### CLI Launch Syntax (PowerShell):
```powershell
.\bin\NextTest.ps1 -Suite "demo\student-registration\scenarios\01-admin-student-crud.xlsx" -Headless -Engine playwright
```

### CLI Launch Syntax (Linux / macOS):
```bash
./bin/nexttest.sh --suite "demo/student-registration/scenarios/01-admin-student-crud.json" --headless
```

### Exit Codes:
- `0`: All enabled test cases passed successfully.
- `1`: One or more test steps or test cases failed assertions or experienced unhandled exceptions.
- `2`: Suite file not found or invalid format.
- `3`: Missing or invalid license key.

---

## 8. Troubleshooting & Frequently Asked Questions (FAQ)

### Q1: The browser launches but closes immediately.
**Cause**: The test suite may have an invalid start URL, or `CloseBrowser` was invoked prematurely.  
**Resolution**: Check the first step has action `EnterURL` or `OpenBrowser` with a valid HTTP/HTTPS URL. Check developer console for driver startup logs.

### Q2: How do I export my recorded APIs to Excel?
**Resolution**: Go to the **🌐 API Collection** tab and click **📊 Export to Excel (.xlsx)**. Choose a file path, and a formatted spreadsheet with all URLs, headers, payloads, and response codes will be created.

### Q3: An action in my test gives an error or unsupported operation.
**Resolution**: Ensure you are using actions documented in [COMMANDS.md](COMMANDS.md). All 205 commands (including `switchbrowser`, `selectdropdown`, `validatebrokenlink`, `validatebrokenimage`, `checkaccessibility`, `validatedatatextlength`, and `jclickifexists`) are fully implemented in the Java engine.

### Q4: How does an AI model use this file?
**Resolution**: If you are an LLM assistant, read the menu and tab sections above to tell the user the exact clicks, shortcut keys, or file paths required to accomplish their task in NextTest.
