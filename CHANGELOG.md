# NextTest Changelog

All notable changes to the NextTest test automation platform are documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---

## [1.0.0] - 2026-11-09

### Added
- **Native AES-GCM 256-bit Password Encryption**:
  - Authenticated encryption format (`ENC:GCM:<IV>:<Ciphertext>`) with PBKDF2 key derivation and random 96-bit IVs.
  - Zero-config default master key with instant override via `File` ➔ `Test Settings` ➔ `Security & Encryption`.
  - Secure action `enterEncryptedPassword` available across Web (Selenium & Playwright), Mobile (Appium), and Desktop (WinAppDriver & Robot).
  - Dynamic `{{PASSWORD}}` resolution in step values, request headers (`Authorization: Bearer {{PASSWORD}}`), and API payloads.
  - Password Masking: All passwords automatically masked with `••••••••` in logs, test evidence panels, and HTML reports.
  - Interactive **Password Encryptor (AES-GCM)** dialog (`Tools` ➔ `Password Encryptor`) with 1-click token generation, decrypt verification, and clipboard copy.
  - Live Browser Recorder auto-captures and auto-encrypts typed passwords directly into suite datasets.
  - Dedicated `Data` sheet in exported Excel files preserving `PASSWORD` key mappings.
- **Action Catalogue Verification & Harmonization**:
  - Reconciled action catalog to single source of truth: **214 actions, prefixes, and keyword directives** (200 core test execution actions, 3 dynamic syntax prefixes, 5 Java engine extensions, and 6 integrated platform capabilities in `help-actions.json`).
  - Implemented and verified all 11 previously missing action handlers across Selenium and Playwright runners: `api-GET`, `api-POST`, `api-PUT`, `api-DELETE`, `api-PATCH`, `typeAppend`, `selectDropDownValue`, `switchToIFrame`, `switchToDefaultFrame`, `acceptAlert`, and `scrollIntoView`.
  - Indexed and fully verified 7 core actions in `help-actions.json`: `type`, `switchTab`, `takeScreenshot`, `clearAndSendKeys`, `refresh`, `mouseHover`, and `validateVisualBaseline`.
  - Added dedicated sample verification suite in JSON and Excel formats: `sample-application/scenarios/20-verified-api-and-ui-actions.json` and `.xlsx`.
  - Added complete, numbered 1-to-214 index in `RUN_GUIDE.md`.
  - Realigned AI benchmarks and grounded documentation with engineering reality in `COMMANDS.md` and `HELP.md`.
  - Added `--report-dir` and `--reports-dir` CLI parameter support in `CiCdCliRunner`.
- **Packaging, Enterprise CI/CD & Open Source**:
  - Apache License 2.0 (`LICENSE`) across all distribution packages and source repositories.
  - Production-ready CI/CD templates for GitHub Actions (`github-actions-nexttest.yml`), Jenkins (`Jenkinsfile`), and GitLab CI (`gitlab-ci.yml`).
  - Removed duplicate 288MB fat JAR payload and redundant binary chunk copies in `create-distribution.ps1`.
- **Dual Automation Engines**: Seamlessly switch between Selenium WebDriver and Microsoft Playwright at runtime or via `--engine`.
- **AI Self-Healing Locators**: Automatic recovery on DOM shifts with multi-vector heuristic scoring and 1-click permanent suite updates.
- **Live In-Browser HUD Recorder**: Zero-extension floating heads-up display with element inspector and one-click assertion builder.
- **Executive Visual Reporting Dashboard**: Self-contained, air-gapped HTML reports with SVG animated donuts and latency waterfalls.
- **Perceptual Visual Regression**: Automated pixel diffing with split comparison and threshold overrides.
- **Cloud Grid Connectors**: Native support for BrowserStack, Sauce Labs, LambdaTest, and Selenium Grid v4 clusters.
- **Database Workbench**: Multi-connection SQL workbench for MSSQL, Oracle, MySQL, Postgres, SQLite, and MongoDB.

### Fixed
- Fixed Excel and JSON round-trip row preservation in data sheets and test suites.
- Fixed stale paths (`demo/student-registration/scenarios/...` ➔ `sample-application/scenarios/...`) and broken references in `RUN_GUIDE.md` and `HELP.md`.
- Removed all legacy branding (`MindQA` ➔ `NextTest`).
- Purged retired `.NET` references and exceptions from all runtime modules and guides.
- Fixed duplicate case label in `TestRunner.java`.
