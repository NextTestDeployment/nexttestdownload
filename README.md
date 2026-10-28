# NextTest Standalone Distribution

NextTest is an autonomous, AI-assisted, cross-platform test automation platform for modern web, REST API, native desktop, dynamic Java, and visual regression testing workflows.

## Package Structure

- `nexttest-desktop.jar` / `nexttest-desktop-v1.0.0.jar` - Standalone executable fat JAR containing all UI, runtime engines, drivers, and visual diffing tools.
- `chunks/` - Versioned, max 30MB binary slices (`nexttest-desktop-v1.0.0.part01`, `part02`, etc.) ensuring Git/GitHub and CDN safety (<30MB per chunk).
- `NextTest.bat` - Windows launcher (with automatic first-run chunk assembly; uses existing merged binary directly on all subsequent runs).
- `NextTest.ps1` - PowerShell launcher with auto-merge check.
- `nexttest.sh` - Linux/macOS bash launcher with auto-merge check.
- `HELP.md` - Complete Product & UI navigation manual detailing all menus (File, Edit, Tools, View, Engine, Help), all tabs, panels, shortcuts, and dialogs. Share this file with any AI model (ChatGPT, Claude, Gemini, DeepSeek) for immediate context and guidance!
- `COMMANDS.md` - Comprehensive master catalog of all 205 verified commands, locators, prefix modifiers (`!D->`, `!M->`, `!Gen->`, `!print->`), REST API methods, database queries, and desktop actions.
- `sample-application/` - Complete Node.js / Express CampusFlow test target with 17 scenario suites in **both Excel (.xlsx) and JSON (.json)** formats.
- `docs/HELP.md` - Complete Product & UI navigation manual (duplicate in docs directory).
- `docs/COMMANDS.md` - Master catalog of all 205 commands (duplicate in docs directory).
- `version.v` - Current version descriptor (`1.0.0`).
- `templates/ci-cd/` - Enterprise CI/CD pipeline automation templates (GitHub Actions, Jenkins).

## ðŸš€ Key Enterprise Capabilities

- **ðŸŽ¬ Live Test Recorder & Inspector**: Built-in in-browser floating HUD with hover inspection, 1-click assertion builder, pause/resume, and CLI recording (`--record`).
- **â˜ï¸ Cloud Grid Connectors**: Seamless remote execution on BrowserStack, Sauce Labs, LambdaTest, and Selenium Grid v4 clusters (`--grid-url`, `--grid-provider`).
- **ðŸ“Š Executive Visual Reporting Dashboard**: 100% self-contained, air-gapped safe HTML reporting with SVG animated donut chart, latency waterfall, live search, and error trace copy (`nexttest-report.html`).
- **âš¡ Dual Automation Engine**: Interchangeable execution across Selenium WebDriver and Playwright (`--engine selenium|playwright`).
- **ðŸ©¹ AI Self-Healing Engine**: Real-time recovery from broken IDs and dynamic DOM changes (`--self-healing`, `--apply-healing`).
- **ðŸ‘ï¸ Perceptual Visual Regression**: Automated pixel diffing with split comparison and threshold overrides.

## ðŸ“¦ Binary Chunking & Auto-Merge Policy (Max 30MB)

To comply with GitHub's 50MB/100MB file limits and cloud distribution constraints:
1. The fat JAR is sliced into max **30MB versioned chunks** (`chunks/nexttest-desktop-v1.0.0.part*`).
2. **First Run:** Launchers (`NextTest.bat`, `NextTest.ps1`, `nexttest.sh`) detect if the merged JAR is missing, quickly assemble the chunks once, and proceed.
3. **Subsequent Runs:** Launchers detect that `nexttest-desktop-v1.0.0.jar` already exists and execute it immediately without re-merging.
4. If manually reassembling without a launcher:
   - **Windows:** `copy /b chunks\nexttest-desktop-v1.0.0.part* nexttest-desktop-v1.0.0.jar`
   - **Linux / macOS:** `cat chunks/nexttest-desktop-v1.0.0.part* > nexttest-desktop-v1.0.0.jar`

## Quick Start

### 1. Launch the Desktop GUI
On Windows:
Double-click `NextTest.bat`

Or run from terminal:
```bash
java -jar nexttest-desktop.jar
```

### 2. Headless CLI Execution in CI/CD
```bash
java -jar nexttest-desktop.jar --suite sample-application/scenarios/nexttest-suite.json --browser chrome --headless
```
Or with an Excel test suite:
```bash
java -jar nexttest-desktop.jar --suite sample-application/scenarios/01-browser-lifecycle-and-navigation.xlsx --browser chrome --headless
```

### 3. Running the Sample Application
Navigate to `sample-application`:
```bash
cd sample-application
npm install
npm start
```
CampusFlow will start at `http://127.0.0.1:3100`.

### 4. License Policy
NextTest runs in **Full Unrestricted Community Edition mode until March 31, 2027**. No license file or activation is required.
