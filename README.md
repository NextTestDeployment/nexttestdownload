# NextTest Standalone Distribution

NextTest is an autonomous, AI-assisted, cross-platform test automation platform for modern web, REST API, native desktop, dynamic Java, and visual regression testing workflows.

## Package Structure

- `nexttest-desktop.jar` - Standalone executable fat JAR containing all UI, runtime engines, drivers, and visual diffing tools.
- `chunks/` - Versioned, max 30MB binary slices (`nexttest-desktop-v1.0.0.part01`, `part02`, etc.) ensuring Git/GitHub and CDN safety (<30MB per chunk).
- `NextTest.bat` - Windows launcher (with automatic first-run chunk assembly; uses existing merged binary directly on all subsequent runs).
- `NextTest.ps1` - PowerShell launcher with auto-merge check.
- `nexttest.sh` - Linux/macOS bash launcher with auto-merge check.
- `split-chunks.bat` / `split-chunks.ps1` - Standalone binary chunk splitter utility.
- `merge-chunks.bat` / `merge-chunks.ps1` - Standalone binary chunk merger utility.
- `docs/` - Complete documentation directory containing:
  - `docs/HELP.md` - Comprehensive Product & UI navigation manual detailing all menus, tabs, panels, and shortcuts.
  - `docs/COMMANDS.md` - Master catalog and AI authoring grounding for all 214 implemented commands, locators, and syntax rules.
  - `docs/RUN_GUIDE.md` - Step-by-step execution guide, numbered action index, and CLI usage.
  - `docs/TRAINING_BOOK.md` - Complete 8-module test automation masterclass handbook.
  - `docs/CHANGELOG.md` - Complete version release history.
- `LICENSE` - Apache License 2.0 (100% free and open-source).
- `sample-application/` - Complete Node.js / Express CampusFlow test target with scenario suites in both Excel (.xlsx) and JSON (.json) formats.
- `version.v` - Current version descriptor (`1.0.0`).
- `templates/ci-cd/` - Enterprise CI/CD pipeline automation templates (GitHub Actions, Jenkinsfile, GitLab CI).

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
3. **Subsequent Runs:** Launchers detect that `nexttest-desktop.jar` already exists and execute it immediately without re-merging.
4. If manually reassembling without a launcher:
   - **PowerShell:** `.\merge-chunks.ps1`
   - **Windows CMD:** `copy /b chunks\nexttest-desktop-v1.0.0.part* nexttest-desktop.jar`
   - **Linux / macOS:** `cat chunks/nexttest-desktop-v1.0.0.part* > nexttest-desktop.jar`

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
NextTest is **100% Free & Open Source under the Apache License 2.0**. Completely unrestricted for personal, commercial, and enterprise usage with no license keys, node locks, or expiration dates.

### 5. Training & Learning in Detail
If anyone wants to learn NextTest in detail, explore hands-on test automation training, or get expert guidance, connect with [Quickitdotnet](https://quickitdotnet.in/) or contact `NextTest@quickitdotnet.in`.

### 6. Automation-as-a-Service
If you want end-to-end test automation built, managed, or maintained as a service, connect with [Quickitdotnet](https://quickitdotnet.in/) or the NextTest team at `NextTest@quickitdotnet.in`.
