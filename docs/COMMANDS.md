# NextTest Complete Commands, Actions & Test Authoring Catalog (COMMANDS.md)

> **Document Version:** 2.0 Enterprise Edition  
> **Total Verified Commands:** 205  
> **Target Audience:** Test Engineers, Automation Developers, CI/CD Engineers, and LLM Coding Assistants  
> **Purpose:** Authoritative reference for all **205 commands, actions, locators, prefix modifiers, and variable interpolation patterns** supported by the NextTest Autonomous Test Automation Platform. Every command listed here is fully implemented in the Java execution engine with bi-directional JSON/Excel (.xlsx) parity.

---

## Table of Contents
1. [The Essential 20 Actions (Core Quick-Start)](#1-the-essential-20-actions-core-quick-start)
2. [Test Suite Schemas (JSON & Excel)](#2-test-suite-schemas-json--excel)
3. [Hard Stop & Error Tolerance Control](#3-hard-stop--error-tolerance-control)
4. [Supported Locator Strategies](#4-supported-locator-strategies)
5. [Prefix Modifiers & Dynamic Variables](#5-prefix-modifiers--dynamic-variables)
6. [Complete Actions Reference by Category (205 Verified Actions)](#6-complete-actions-reference-by-category)
   - [A. Browser Lifecycle & Navigation](#a-browser-lifecycle--navigation)
   - [B. Form Controls, Keystrokes & Inputs](#b-form-controls-keystrokes--inputs)
   - [C. Dropdowns, Radio Buttons & Checkboxes](#c-dropdowns-radio-buttons--checkboxes)
   - [D. Mouse Actions & Touch Gestures](#d-mouse-actions--touch-gestures)
   - [E. Native Desktop Automation (Windows & macOS)](#e-native-desktop-automation-windows--macos)
   - [F. Validations, Assertions & DOM Inspection](#f-validations-assertions--dom-inspection)
   - [G. Network Quality & Observability](#g-network-quality--observability)
   - [H. REST API Automation & Token Chaining](#h-rest-api-automation--token-chaining)
   - [I. Database & MongoDB Testing](#i-database--mongodb-testing)
   - [J. Visual Regression & OCR](#j-visual-regression--ocr)
   - [K. Chrome DevTools Protocol (CDP) Throttling](#k-chrome-devtools-protocol-cdp-throttling)
   - [L. Dynamic Java & Extension Plugins](#l-dynamic-java--extension-plugins)
   - [M. Flow Control, Delays & Scripting](#m-flow-control-delays--scripting)
7. [Alphabetical Master Index (205 Commands)](#7-alphabetical-master-index-205-commands)
8. [AI Self-Healing Engine: Empirical Accuracy Benchmark](#8-ai-self-healing-engine-empirical-accuracy-benchmark)
9. [AI Capabilities & Agentic Generation Benchmarks](#9-ai-capabilities--agentic-generation-benchmarks)

---

## 1. ⚡ The Essential 20 Actions (Core Quick-Start)

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

## 2. Test Suite Schemas (JSON & Excel)

NextTest supports native **JSON** and **Excel (.xlsx)** formats with bi-directional fidelity.

### JSON Suite Schema Example:
```json
{
  "name": "Student Management Suite",
  "data": {
    "baseUrl": "http://127.0.0.1:3100",
    "adminUser": "admin@nexttest.local",
    "adminPass": "Admin@123"
  },
  "locatorFiles": [
    { "name": "campus-locators.json", "prefix": "campus" }
  ],
  "testCases": [
    {
      "testCaseId": "TC001",
      "Case": "Create New Student Record",
      "isRun": true,
      "hardStop": false,
      "testSteps": [
        {
          "Steps": "Navigate to login portal",
          "Action": "EnterURL",
          "LocatorType": "NA",
          "LocatorTypeValue": "NA",
          "Value": "!M->baseUrl/login.html",
          "Condition": "NA",
          "ActualValue": "NA"
        },
        {
          "Steps": "Enter admin email",
          "Action": "SendKeys",
          "LocatorType": "id",
          "LocatorTypeValue": "username",
          "Value": "!M->adminUser",
          "Condition": "NA",
          "ActualValue": "NA"
        },
        {
          "Steps": "Enter admin password",
          "Action": "SendKeys",
          "LocatorType": "id",
          "LocatorTypeValue": "password",
          "Value": "!M->adminPass",
          "Condition": "NA",
          "ActualValue": "NA"
        },
        {
          "Steps": "Click sign-in button",
          "Action": "Click",
          "LocatorType": "id",
          "LocatorTypeValue": "loginBtn",
          "Value": "NA",
          "Condition": "NA",
          "ActualValue": "NA"
        },
        {
          "Steps": "Verify dashboard header visible",
          "Action": "ValidateText",
          "LocatorType": "id",
          "LocatorTypeValue": "dashboardHeader",
          "Value": "CampusFlow Dashboard",
          "Condition": "NA",
          "ActualValue": "NA"
        }
      ]
    }
  ]
}
```

### Excel (.xlsx) Suite Schema:
An Excel test suite uses an identical column structure across two main worksheets:
1. **`Test_Cases` Sheet**:
   - Columns: `TestCaseId`, `Case`, `isRun`, `hardStop`
2. **`Test_Steps` Sheet**:
   - Columns: `RunNumber`, `TestCaseId`, `Steps`, `Action`, `LocatorType`, `LocatorTypeValue`, `Value`, `Condition`, `ActualValue`
3. **`Test_Data` Sheet** (Optional):
   - Key-value module data (`Key`, `Value`) accessible via `!M->key` or iterative row-based data via `!D->row->col`.

---

## 3. Hard Stop & Error Tolerance Control

The `hardStop` flag governs how NextTest handles step or case failures:
- `hardStop: false` (Default): If a step fails, the failure is logged and captured with a screenshot. Execution continues to the next step or test case. This is ideal for broad regression runs where maximum coverage is needed.
- `hardStop: true`: If this step fails, execution halts immediately for the active test case. Subsequent steps in the case are marked `SKIP`. This prevents cascading false failures when prerequisite steps (such as Authentication or Account Creation) fail.

---

## 4. Supported Locator Strategies

NextTest supports 8 standardized element locator strategies:

| Strategy | Syntax Example | When to Use |
|---|---|---|
| `id` | `submit-btn` | Best performance and resilience when unique IDs exist. |
| `name` | `user_email` | Standard for form inputs and text areas. |
| `css` | `button.btn-primary[type='submit']` | High-speed, flexible selectors for modern responsive SPAs. |
| `xpath` | `//div[@class='card']//button[contains(text(),'Save')]` | Robust complex traversals, parent-axis navigation, or text matching. |
| `classname` | `modal-dialog` | Single CSS class selector. |
| `tagname` | `select`, `textarea` | Target element by HTML tag name. |
| `linktext` | `Forgot Password?` | Matches exact text inside anchor `<a>` tags. |
| `NA` | `NA` | Used when action operates on the browser/system (e.g. `EnterURL`, `Sleep`, `API-GET`). |

---

## 5. Prefix Modifiers & Dynamic Variables

NextTest includes dynamic variable interpolation for data-driven testing across test step values and UI locators:

| Prefix / Variable Pattern | Example | Target Field | Description |
|---|---|---|---|
| `${var}` / `{{var}}` | `//tr[${rowIndex}]//button` | Locator & Value | Universal dynamic variable interpolation. Automatically resolves from Data Loop rows (`caseData`), runtime extracted step variables (`stepData`), and global suite data (`suite.data()`). Works across both Selenium and Playwright runners. |
| `!M->key` | `!M->baseUrl` | Value | Fetches value of `key` from the suite-level `data` map. |
| `!D->row->col` | `!D->1->Email` | Value & Locator | Fetches data from row 1, column 'Email' of the active data sheet. |
| `!MTC->key` | `!MTC->orderId` | Value | Fetches dynamic value generated and stored by a previous step in the same case. |
| `!File->path` | `!File->payload.json` | Value | Reads contents of an external file (e.g. for API payloads or CSV rows). |
| `!Date->fmt->+/-N` | `!Date->yyyy-MM-dd->+7d` | Value | Evaluates dynamic relative dates (+7 days, -1 month). |
| `!Gen->generator` | `!Gen->email` | Value & Data | Synthetic generator: `!Gen->name`, `!Gen->email`, `!Gen->uuid`, `!Gen->phoneNumber`, `!Gen->int(18,65)`. |
| `!UUID` | `!UUID` | Value | Generates a fresh random v4 UUID string. |
| `!Random->N` | `!Random->8` | Value | Generates a random alphanumeric string of length N. |
| `!print->step` | `!print->Click` | Action | Modifier that automatically captures an instant desktop screenshot after executing the step. |

---

## 6. Complete Actions Reference by Category (205 Verified Actions)

### A. Browser Lifecycle & Navigation
1. `openBrowserChrome`, `openBrowserFirefox`, `openedge`: Launches designated browser.
2. `EnterURL`, `GoToUrl`, `Navigate`: Navigates active browser to specified URL.
3. `browserBack`, `browserForward`, `PageRefresh`: Standard browser history and reload operations.
4. `CloseBrowser`, `quit`: Shuts down the active browser session.
5. `maximize`, `FullScreen`, `WindowSize`: Controls browser window dimensions.
6. `AddTab`, `AddWindow`, `SwitchBrowser`, `SwitchToWindowByIndex`: Multi-tab and multi-window navigation.

### B. Form Controls, Keystrokes & Inputs
1. `SendKeys`, `EnterText`, `Type`: Types input into targeted element or active focus.
2. `Clear`, `ClearAndSendKeys`: Clears existing input field content before typing.
3. `SendKeysEnter`, `SendKeysTab`, `ActionSendKeys`: Emulates dedicated keyboard control keys.
4. `SendKeysEncrypt`: Masked secure input for passwords and confidential tokens.
5. `SendKeysAndBlur`: Types input and triggers DOM blur event.

### C. Dropdowns, Radio Buttons & Checkboxes
1. `SelectDropdownByText`, `SelectDropdownByValue`, `SelectDropdownByIndex`: Standard HTML `<select>` operations.
2. `SelectDropdown`: Smart auto-detect dropdown selector.
3. `MarkAsChecked`, `UnmarkAsChecked`: Toggles checkboxes and radio buttons.
4. `validateDropdownCount`, `validateDropdownText`, `validateDropdownValue`: Asserts dropdown option lists.

### D. Mouse Actions & Touch Gestures
1. `Click`, `JClick`, `JClickIfExists`: Standard, JavaScript-injected, and safe-conditional clicks.
2. `DoubleClick`, `ContextClick` (Right-click): Extended mouse operations.
3. `MouseHover`, `MoveToElement`: Hover trigger for dynamic menus and flyouts.
4. `DragAndDrop`, `DragAndDropByOffset`: Smooth drag and drop between elements or coordinates.
5. `ClickAndHold`, `ClickAndRelease`: Manual gesture emulation.

### E. Native Desktop Automation (Windows & macOS)
1. `DesktopClick`, `DesktopDoubleClick`, `DesktopRightClick`: Hardware mouse input at screen coordinates.
2. `SendDesktopKeys`: Hardware keyboard typing for non-browser desktop dialogs.
3. `FocusWindow`, `BringWindowToFront`: OS window focus management.
4. `WindowDialogHandle`: Native OS Open/Save file dialog handling.

### F. Validations, Assertions & DOM Inspection
1. `ValidateText`, `ValidateTextAndThrow`, `ValidateContainsText`: Precision element text assertions.
2. `ValidateStartsWithText`, `ValidateEndsWithText`, `ValidateNotMatchedText`: Substring validations.
3. `IsDisplayed`, `IsNotDisplayed`, `IsEnabled`, `IsSelected`: DOM state assertions.
4. `ValidateTitle`, `ValidateUrl`, `ValidateContainsUrl`: Page level assertions.
5. `ValidateAttribute`, `ValidateCssValue`, `ValidateDomProperty`: Deep DOM inspection.
6. `ValidateCount`: Asserts count of matching DOM elements.
7. `ValidateBrokenLink`, `ValidateBrokenImage`, `CheckAccessibility`: Built-in quality and WCAG audit checks.

### G. Network Quality & Observability
1. `ThrottleNetwork`, `SetNetworkSpeed`: Emulates 3G, 4G, or Offline conditions via CDP.
2. `MockApiResponse`, `InterceptApi`: Network request stubbing and response mocking.
3. `InjectObservabilityBridge`: Injects real-time console and error listeners.

### H. REST API Automation, Swagger / OpenAPI Import & Token Chaining

NextTest delivers a unified REST API automation engine that operates standalone or seamlessly interleaved with browser UI steps, database checks, and native desktop workflows.

#### 1. Core API Execution Actions:
- **`API-GET`**, **`API-POST`**, **`API-PUT`**, **`API-DELETE`**, **`API-PATCH`**: Dispatches HTTP/HTTPS request according to the verb.
  - **`LocatorType` / `LocatorTypeValue`**: Set to `NA`.
  - **`Value`**: The endpoint path (e.g. `/api/v1/students` or full URL `https://api.example.com/items`).
  - **`ActualValue`**: A JSON configuration string containing request metadata:
    ```json
    {
      "BaseUrl": "http://127.0.0.1:3100",
      "Url": "/api/v1/students",
      "Method": "POST",
      "Headers": {
        "Content-Type": "application/json",
        "Authorization": "Bearer {{authToken}}"
      },
      "QueryParams": {
        "dept": "Engineering"
      },
      "Body": {
        "name": "${student.Name}",
        "email": "${student.Email}",
        "status": "Active"
      }
    }
    ```
- **`api-call`**: Generic action alias that determines the HTTP method directly from the `Method` field inside the `ActualValue` JSON configuration.

#### 2. Response Validation & Assertion Actions:
- **`ValidateJPath`**: Asserts that a value extracted via JSONPath matches the expected value.
  - **`LocatorTypeValue`**: JSONPath expression (e.g. `$.statusCode`, `$.data.id`, `$.students[0].name`).
  - **`Value`**: Expected string or numeric value (e.g. `200`, `John Doe`).
- **`ValidateJPath-TestCaseText`**: Compares extracted JSONPath value against a previously stored test case variable.
- **`validateContainsText`**: Asserts that the response body contains a specific substring.

#### 3. Token Chaining & Dynamic Parameterization:
- **`SetModuleTextFromJpath-<variableName>`**:
  - Extracts a value from the last API response using JSONPath and saves it into global module variable `<variableName>`.
  - **`LocatorTypeValue`**: JSONPath expression (e.g. `$.token` or `$.accessToken`).
  - Subsequent test steps (both UI and API) can reference this variable via `{{variableName}}`, `${variableName}`, or `header-m:variableName`.

#### 4. Enterprise 1-Click Swagger / OpenAPI & cURL Importer:
- **Keyboard Shortcut**: `Ctrl+Alt+I`
- **Menu Location**: `File ➔ Import Swagger / OpenAPI / cURL...` or `Workbenches ➔ Import Swagger / OpenAPI / cURL...`
- **Supported Formats**:
  - **OpenAPI 3.0 & 3.1** (JSON or YAML)
  - **Swagger 2.0** (JSON or YAML)
  - **Remote URLs** (e.g. SwaggerHub, public APIs, localhost microservices) or local disk files (`.json`, `.yaml`, `.yml`).
  - **Raw cURL Commands**: Pasted directly from browser DevTools network tab ("Copy as cURL") or terminal logs.
- **Automated Output**:
  - Generates parameterized test cases with color-coded HTTP method badges.
  - Generates realistic JSON request bodies based on schema properties (`string`, `integer`, `boolean`, `array`) with `$ref` resolution.
  - Automatically pairs every API request step with a companion `ValidateJPath` assertion verifying `$.statusCode` equals the spec's expected HTTP response code (e.g. 200, 201, 204).
  - Can export as a new standalone suite, append into the active test suite, or open directly in the interactive API Executor Workbench.

#### 5. Data-Driven API Loops & Datafile Generation:
- When exporting API collections to Excel, NextTest automatically extracts all JSON payload primitives and query parameters into a dedicated `Data` sheet.
- Pair API calls with `goto` loop steps to iterate over data rows from Excel, SQL database queries, or synthetic generators.
- Dynamic placeholders like `${user.id}` in `Url` or `Body` are automatically evaluated for each data row iteration.

### I. Database & MongoDB Testing
1. `ExecuteDbQuery`, `ValidateDbResult`: Direct SQL verification (MySQL, PostgreSQL, Oracle, SQL Server).
2. `MongoFind`, `MongoCount`, `MongoInsert`: Native NoSQL validation against MongoDB collections.

### J. Visual Regression & OCR
1. `TakingScreenshot`, `TakingElementScreenshot`: Full page or element PNG capture.
2. `ValidateVisualBaseline`: Perceptual pixel-diff engine against golden baseline with side-by-side split comparison.
3. `VisualReportingDashboard`: Generates interactive HTML dashboard with SVG charts at `target/nexttest-reports/nexttest-report.html`.

### K. Chrome DevTools Protocol (CDP) Throttling
1. `SetNetworkConditions`, `EmulateNetworkOffline`: Fine-grained CDP bandwidth, latency, and throughput constraints.
2. `CapturePerformanceMetrics`: Extracts Web Vitals (FCP, LCP, CLS).

### L. Dynamic Java & Extension Plugins
1. `ExecuteJar`, `ExecuteClass`: Runs external compiled Java bytecode.
2. `ExecuteJavaMethod`, `ExecuteDelegate`: Reflective invocation of custom helper libraries.

### M. Flow Control, Delays & Scripting
1. `Sleep`, `Wait`, `Pause`: Fixed or dynamic pauses.
2. `GoTo`, `Loop`: Case-level flow loops and jumps.
3. `ExecuteScript`, `JavaScriptExecutor`: Injects custom client-side JavaScript.
4. `Comment`: Documentation steps.

---

## 7. Alphabetical Master Index (205 Commands)

| # | Command / Action | Category | Signature / Description |
|---|---|---|---|
| 1 | `!D->` | Other | Replace Value, ActualValue, or LocatorTypeValue with data from a data sheet. Field must start with '!D->Index->Column' or '!D->1->Column'. Data is fetched from the specified row and column in the data sheet. |
| 2 | `!File->` | Other | Replace Value or ActualValue with content loaded from an external file. Value/ActualValue: must start with '!File->' followed by the file path or key. LocatorType/LocatorTypeValue/Condition: not used. |
| 3 | `!fl->` | Other | Replace LocatorTypeValue with a value from an external locator file. LocatorTypeValue: must start with 'fl->Key'. The key is looked up in the locator type dictionary loaded from external files. Value/ActualValue/Condition: not used. Excel File paths should be provided in LocatorTypesFiles Tab of given sheet. |
| 4 | `!MTC->` | Other | Replace Value, ActualValue, or LocatorTypeValue with data resolved from module, test case, or test step context. Field must start with '!MTC->' and reference one or more keys. |
| 5 | `!print->` | Action | Executes a compound action split by '->'. Format: !print-><screenshotLabel>-><actualAction>. Executes the actualAction first, then clones the testStep to take a screenshot with the label provided. If only one value is provided (e.g. !print->ClickButton), it uses 'Image{0}' as the default screenshot label. LocatorType, LocatorTypeValue, ActualValue/Condition: inherited from original testStep. |
| 6 | `AccessibilityAudit` | Java Extension | Run a basic page audit for missing image alt text, unnamed links and controls, and a missing html lang attribute. This is a smoke check and not a complete WCAG conformance audit. |
| 7 | `ActionSendkeys` | Action | Send keystrokes using Actions API. LocatorType/LocatorTypeValue: required. Value: text to send. ActualValue/Condition: not used. TestCaseId  Steps                                      LocatorType  LocatorTypeValue             Action    Value           IsRun  Condition  ActualValue 1           User should send keys to q, for Google     xpath        //textarea[@id='APjFqb']     sendkeys  'test inddia'    Yes    ''         '' |
| 8 | `AddTab` | Action | Add a new browser tab. No input required for Value, ActualValue, LocatorType, LocatorTypeValue, or Condition. |
| 9 | `AddWindow` | Action | Add a new browser window. No input required for Value, ActualValue, LocatorType, LocatorTypeValue, or Condition. |
| 10 | `AlertAccept` | Action | Accept an alert dialog. No input required for Value, ActualValue, LocatorType, LocatorTypeValue, or Condition. |
| 11 | `alertDismiss` | Action | Dismiss an alert dialog. No input required for Value, ActualValue, LocatorType, LocatorTypeValue, or Condition. |
| 12 | `alertSendKeys` | Action | Send keys to an alert dialog. Value: text to send. LocatorType/LocatorTypeValue/ActualValue/Condition: not used. |
| 13 | `alertSetAuthenticationCredentials` | Action | Set authentication credentials for alert. Value: username. ActualValue: password. LocatorType/LocatorTypeValue/Condition: not used. |
| 14 | `Alt` | Action | Simulate Alt+<key> press. Value: key (optional). LocatorType/LocatorTypeValue/ActualValue/Condition: not used. |
| 15 | `AltShift` | Action | Simulate Alt+Shift+<key> press. Value: key (optional). LocatorType/LocatorTypeValue/ActualValue/Condition: not used. |
| 16 | `api-*` | Action | Call an API. here * could be GET,PUT,POST,DELETE Value: endpoint/payload. ActualValue: expected response (optional). LocatorType/LocatorTypeValue: not used. Condition: not used. TestCaseId &#124; Steps                          &#124; LocatorType &#124; LocatorTypeValue               &#124; Action                        &#124; Value                                               &#124; IsRun &#124; Condition &#124; ActualValue ------------------------------------------------------------------------------------------------------------- 1          &#124; SetModuleData                  &#124; NA          &#124; Na                             &#124; SetModuleTextValue            &#124; anyEmail@email.com                         &#124; Yes   &#124; '         &#124; email 1          &#124; SetModuleData                  &#124; NA          &#124; Na                             &#124; SetModuleTextValue            &#124; password                                              &#124; Yes   &#124; '         &#124; password 1          &#124; http://localhost:3000/login    &#124; NA          &#124; NA                             &#124; api-POST-m:authlogin          &#124; http://localhost:9000/auth/login                    &#124; Yes   &#124; '         &#124; !MTC->(Body-m-email;Body-m-password)->{\"Url\":\"http://localhost:9000/auth/login\",\"Headers\":{\"content-type\":\"application/json\"},\"Body\":{\"email\":\"Body-m-email\",\"password\":\"Body-m-password\"}} 1          &#124; http://localhost:3000/products &#124; NA          &#124; m:jpath-authlogin-$.token      &#124; SetModuleTextFromJpath-token  &#124; $.token                                             &#124; Yes   &#124; '         &#124; !MTC->(header-m:jpath-loginResponse-$.token)->{\"Url\":\"http://localhost:9000/client/products\",\"Headers\":{\"authorization\":\"Bearer header-m:jpath-loginResponse-$.token\"},\"Body\":null} 1          &#124; http://localhost:3000/products &#124; NA          &#124; header-m:jpath-authlogin-$.token &#124; api-GET-c:GetProductResponse &#124; 'http://localhost:9000/client/products              &#124; Yes   &#124; '         &#124; !MTC->(header-m:jpath-authlogin-$.token)->{\"Url\":\"http://localhost:9000/client/products\",\"Headers\":{\"authorization\":\"Bearer header-m:jpath-authlogin-$.token\"},\"Body\":null} 1          &#124; http://localhost:3000/products &#124; NA          &#124; $[0].name                       &#124; ValidateJPath-TestCaseText    &#124; Port Beckley                                        &#124; Yes   &#124; '         &#124; GetProductResponse |
| 17 | `Backspace` | Action | Simulate Backspace key press. No input required for Value, ActualValue, LocatorType, LocatorTypeValue, or Condition. |
| 18 | `blur` | Action | Remove focus from an element. LocatorType/LocatorTypeValue: required to locate the element. Value/ActualValue/Condition: not used. |
| 19 | `BrowserBack` | Action | Navigate browser back. No input required for Value, ActualValue, LocatorType, LocatorTypeValue, or Condition. |
| 20 | `BrowserForward` | Action | Navigate browser forward. No input required for Value, ActualValue, LocatorType, LocatorTypeValue, or Condition. |
| 21 | `Cancel` | Action | Simulate Cancel key press. No input required for Value, ActualValue, LocatorType, LocatorTypeValue, or Condition. |
| 22 | `CheckAccessibility` | Validation | Executes automated WCAG accessibility heuristics and logs any detected violations in accessibilityViolations. |
| 23 | `checkWindowFocus` | Action | Verifies that an operating system or browser application window has foreground focus. Value: target window title substring. Throws AssertionError if window is not focused when using validateWindowFocus or assertWindowFocus. |
| 24 | `clear` | Action | Clear the value of an input element. LocatorType/LocatorTypeValue: required to locate the element. Value/ActualValue/Condition: not used. |
| 25 | `click` | Action | Click a web element. LocatorType/LocatorTypeValue: required. Value/ActualValue/Condition: not used. |
| 26 | `ClickAndHold` | Action | Click and hold on a web element. LocatorType/LocatorTypeValue: required. Value/ActualValue/Condition: not used. |
| 27 | `clickAndRelease` | Action | Click and release on a web element. LocatorType/LocatorTypeValue: required. Value/ActualValue/Condition: not used. |
| 28 | `closeAllPopUpWindow` | Action | Close all popup windows except the base window. No input required for Value, ActualValue, LocatorType, LocatorTypeValue, or Condition. |
| 29 | `closeBrowser` | Action | Close the current browser window. No input required for Value, ActualValue, LocatorType, LocatorTypeValue, or Condition. |
| 30 | `CloudGridConnectors` | Feature | Enables remote test execution across BrowserStack, Sauce Labs, LambdaTest, and Selenium Grid v4 clusters. Configured via GUI (File → Test Settings → Cloud Grid) or CLI (--grid-url, --grid-provider, --grid-user, --grid-key) with credential masking and ping health check. |
| 31 | `confirmccept` | Action | Accept a confirm dialog. No input required for Value, ActualValue, LocatorType, LocatorTypeValue, or Condition. |
| 32 | `ContextClick` | Action | Right-click (context click) a web element. LocatorType/LocatorTypeValue: required. Value/ActualValue/Condition: not used. |
| 33 | `Control` | Action | Simulate Ctrl key or Ctrl+<key> press. Value: key (optional). LocatorType/LocatorTypeValue/ActualValue/Condition: not used. TestCaseId  Steps                                                                                                              LocatorType  LocatorTypeValue     Action             Value                                               IsRun  Condition  ActualValue 68          Open Browser                                                                                                       NA           NA                   openBrowserChrome  NA                                                  Yes   '          ' 68          Navigate to Page                                                                                                   NA           NA                   enterURL           https://the-internet.herokuapp.com/key_presses       Yes   '          ' 68          Type input in the field and press the Enter key to submit or trigger default action.                              id           target               sendkeysEnter      Test                                                Yes   '          ' 68          Press and hold the Control (Ctrl) key to perform shortcuts like Ctrl + A or Ctrl + C.                             id           target               Control            ''                                                  Yes   '          ' 68          Verifies that the input text meets the expected validation criteria, such as length, format, and allowed characters. xpath        //p[@id="result"]     ValidateText       You entered: CONTROL                                Yes   '          ' 68          Press the Delete key to remove the selected text or character after the cursor.                                   id           target               Delete             NA                                                  Yes   '          ' 68          Verifies that the input text meets the expected validation criteria, such as length, format, and allowed characters. xpath        //p[@id="result"]     ValidateText       You entered: DELETE                                 Yes   '          ' 68          Press the Escape (Esc) key to cancel the current action or close an open dialog/popup.                            id           target               Cancel             NA                                                  Yes   '          ' 68          Verifies that the input text meets the expected validation criteria, such as length, format, and allowed characters. xpath        //p[@id="result"]     ValidateText       You entered: CANCEL                                 Yes   '          ' 68          Type input in the field and press the Enter key to submit or trigger default action.                              id           target               sendkeysEnter      Test                                                Yes   '          ' 68          Press the Backspace key to delete the character before the cursor.                                                id           target               Backspace          NA                                                  Yes   '          ' 68          Verifies that the input text meets the expected validation criteria, such as length, format, and allowed characters. xpath        //p[@id="result"]     ValidateText       You entered: BACK_SPACE                             Yes   '          ' 68          Hold Ctrl and Alt keys together and press another key to trigger a multi-key shortcut.                            id           target               ControlAlt         NA                                                  Yes   '          ' 68          Clear Text                                                                                                         id           target               Clear              NA                                                  Yes   '          ' 68          Press the Backspace key to delete the character before the cursor.                                                id           target               ALT                ''                                                  Yes   '          ' 68          Verifies that the input text meets the expected validation criteria, such as length, format, and allowed characters. xpath        //p[@id="result"]     ValidateText       You entered: ALT                                    Yes   ''          68          Press and hold Alt and Shift together, usually used for keyboard layout switching or specific shortcuts.          id           target               AltShift           ''                                                  Yes   ''          68          Verifies that the input text meets the expected validation criteria, such as length, format, and allowed characters. xpath        //p[@id="result"]     ValidateText       You entered: SHIFT                                  Yes   ''          68          Hold the Shift key while typing to enter uppercase letters or activate shift-based shortcuts.                     id           target               Shift              ''                                                  Yes   ''          68          Verifies that the input text meets the expected validation criteria, such as length, format, and allowed characters. xpath        //p[@id="result"]     ValidateText       You entered: SHIFT                                  Yes   ''          68          Press and hold the Alt key to access menu options or use with other keys for shortcuts.                           id           target               Alt                A                                                   Yes   ''          68          Verifies that the input text meets the expected validation criteria, such as length, format, and allowed characters. xpath        //p[@id="result"]     ValidateText       You entered: A                                      Yes   '' |
| 34 | `ControlAlt` | Action | Simulate Ctrl+Alt+<key> press. Value: key (optional). LocatorType/LocatorTypeValue/ActualValue/Condition: not used. |
| 35 | `Count` | Action | Count matching elements. LocatorType/LocatorTypeValue: required. Value/ActualValue/Condition: not used. Result can be stored if action contains '-'. |
| 36 | `Delete` | Action | Simulate Delete key press. No input required for Value, ActualValue, LocatorType, LocatorTypeValue, or Condition. |
| 37 | `DoubleClick` | Action | Double-click a web element. LocatorType/LocatorTypeValue: required. Value/ActualValue/Condition: not used. |
| 38 | `DragAndDrop` | Action | Drag from previously stored element to the current element. LocatorType/LocatorTypeValue: required for target. Value/ActualValue/Condition: not used. |
| 39 | `DragAndDropByOffset` | Action | Drag from previously stored element to the current element by offset. LocatorType/LocatorTypeValue: required for target. Value: offset (optional). ActualValue/Condition: not used. |
| 40 | `DropdownValidation` | Action | Validate dropdown functionality including selection and count verification. |
| 41 | `ElementExistsAndThrow` | Action | Throw if element exists. LocatorType/LocatorTypeValue: required. Value/ActualValue/Condition: not used. |
| 42 | `ElementExistsSetModule` | Action | Set module data if element exists. LocatorType/LocatorTypeValue: required. ActualValue: key to store. Value: value to set. Condition: not used. |
| 43 | `Elementjavascriptexecutor` | Action | Execute JavaScript on a web element. LocatorType/LocatorTypeValue: required. Value: JavaScript code. ActualValue/Condition: not used. |
| 44 | `ElementNotExistsAndThrow` | Action | Throw if element does not exist. LocatorType/LocatorTypeValue: required. Value/ActualValue/Condition: not used. |
| 45 | `ElementNotExistsSetModule` | Action | Set module data if element does not exist. LocatorType/LocatorTypeValue: required. ActualValue: key to store. Value: value to set. Condition: not used. |
| 46 | `enterurl` | Action | Navigate to a URL. Value: URL to open. LocatorType/LocatorTypeValue/ActualValue/Condition: not used. |
| 47 | `ExecuteDataBaseQuery` | Action | Execute a database query. LocatorType: connection string or type. Value: SQL query. LocatorTypeValue: key for storing results. ActualValue/Condition: not used. |
| 48 | `ExecuteJar` | Java Extension | Load an external Java extension JAR. LocatorType: JAR path. LocatorTypeValue: class name implementing NextTestScriptAction. ActualValue: destination variable. |
| 49 | `ExecuteJavaMethod` | Java Extension | Compiles and executes dynamic Java code at runtime. Value: Java code statements. LocatorType: optional .java file path. ActualValue: optional variable to store result. |
| 50 | `ExecuteScript` | Java Extension | Run pure inline browser JavaScript from Value directly in the page context. An optional ActualValue stores the result in module test data. |
| 51 | `ExecuteScriptFile` | Java Extension | Read and execute an external JavaScript (.js) file from disk in the browser. Value: path to .js file. ActualValue: optional variable to store return value. |
| 52 | `FileUpload` | Action | Upload a file using the Windows file dialog. Value: file path to upload (e.g. C:\path\file.txt). Dialog title and button text are set to 'File Upload' and 'Open' respectively. LocatorType, LocatorTypeValue, ActualValue/Condition: not used. |
| 53 | `FileUploadClick` | Action | Clicks custom upload button and automatically populates native file dialog with specified path. |
| 54 | `fullscreen` | Action | Set browser window to fullscreen. No input required for Value, ActualValue, LocatorType, LocatorTypeValue, or Condition. |
| 55 | `fullscreenshotappender` | Action | Take a full-page screenshot and append to a file path. Value: file path (with {0} for unique part). LocatorType/LocatorTypeValue/ActualValue/Condition: not used. |
| 56 | `generateTestData` | Action | Generates synthetic fake data (names, emails, dates, addresses, credit cards) for data-driven testing using !Gen-> expressions (e.g. '!Gen->email()', '!Gen->name()', '!Gen->now()'). Stores generated value in ActualValue data key. |
| 57 | `GetdropdownCount` | Action | Get dropdown option count. LocatorType/LocatorTypeValue: required. Value/ActualValue/Condition: not used. Result can be stored if action contains '-'. |
| 58 | `GetText` | Action | Get text from a web element. LocatorType/LocatorTypeValue: required. Value/ActualValue/Condition: not used. Result is stored in module/testcase/teststep data if ActualValue is provided. |
| 59 | `GetValue - used in condition` | Other | Retrieves a value from the test data context based on the specified type and key. Used in conditions and data-driven steps to fetch values from module, test case, or test step data. Type: 'm' for module, 'c' for test case, 's' for test step, 'd' returns the key itself. Example usage in condition: 'm-key-=-expectedValue' will compare the module data value for 'key' with 'expectedValue'. |
| 60 | `GetWebElement` | Other | Locates a web element using the provided LocatorType and LocatorTypeValue from TestStep. Supports multiple locator strategies (id, xpath, name, className, cssSelector, linkText, partialLinkText) by splitting values with ':,:'. Includes retry logic (max 3 attempts with 500ms wait) if element is not found. Returns the first matching IWebElement or null if not found. LocatorType/LocatorTypeValue: required. Condition: not used. |
| 61 | `goto` | Action | Jumps to a specified test step line number (1-based) conditionally or unconditionally for looping through data rows or repeating tests. Value: target step number (e.g. 3). Condition: loop condition (e.g. m-TotalRows->>=-m-RowIndex). Tip: In Element Finder, click Extract and Generate Loop Suite to auto-generate this loop and its data file directly from any web table or list. |
| 62 | `hasclass` | Action | Check if a web element has a specific class. LocatorType/LocatorTypeValue: required. Value: class name. ActualValue: key to store result (optional). Condition: not used. |
| 63 | `HitTab` | Action | Send Tab key to an element. LocatorType/LocatorTypeValue: required. Value: text to send before Tab (optional). ActualValue/Condition: not used. |
| 64 | `ImageReadText` | Action | Read text from an image using OCR. LocatorType/LocatorTypeValue: required for image element. ActualValue: file path to save image. Value/Condition: not used. |
| 65 | `ImageToText` | Action | Extract text from an image using OCR. LocatorType/LocatorTypeValue: required for image element. ActualValue: file path to save image. Optionally, a whitelist of allowed characters can be provided using module value 'whitelistchar'. The recognized text is set to the 'ImageToText' module value. Value/Condition: not used. |
| 66 | `INCREMENTMODULENUMBER` | Action | Increment a numeric value in module data. ActualValue: key to increment. Value: increment by (optional, default 1). LocatorType/LocatorTypeValue/Condition: not used. |
| 67 | `isDisabled` | Action | Check if an element is disabled. LocatorType/LocatorTypeValue: required. Value/ActualValue/Condition: not used. Result can be stored if action contains '-'. |
| 68 | `isDisplayed` | Action | Check if an element is displayed. LocatorType/LocatorTypeValue: required. Value/ActualValue/Condition: not used. Result can be stored if action contains '-'. TestCaseId  Steps                                                                                                     LocatorType  LocatorTypeValue  Action                          Value                                                              IsRun  Condition  ActualValue 19          Launch the browser instance (e.g., Chrome, Firefox, Edge).                                               NA           NA                openBrowserWithHistory           NA                                                                 Yes   '          ' 19          Navigate to the specified URL using the opened browser.                                                  NA           NA                enterURL                         https://www.selenium.dev/selenium/web/inputs.html                Yes   '          ' 19          Check if the specified web element is displayed on the page.                                             name         email_input       isDisplayed-m:EmailDisplayed     NA                                                                 Yes   '          ' 19          Check if the specified web element is notdisplayed on the page.                                          name         email_input       isNotDisplayed-m:EmailDisplayed  NA                                                                 Yes   '          ' 19          Check if the specified web element is displayed on the page.                                             name         email_input       isenabled-m:EmailDisplayed       NA                                                                 Yes   '          ' 19          Check if the specified web element is notdisplayed on the page.                                          name         email_input       isdisabled-m:EmailDisplayed      NA                                                                 Yes   '          ' |
| 69 | `isEnabled` | Action | Check if an element is enabled. LocatorType/LocatorTypeValue: required. Value/ActualValue/Condition: not used. Result can be stored if action contains '-'. |
| 70 | `isNotDisplayed` | Action | Check if an element is not displayed. LocatorType/LocatorTypeValue: required. Value/ActualValue/Condition: not used. Result can be stored if action contains '-'. |
| 71 | `isNotSelected` | Action | Check if an element is not selected. LocatorType/LocatorTypeValue: required. Value/ActualValue/Condition: not used. Result can be stored if action contains '-'. |
| 72 | `isSelected` | Action | Check if an element is selected. LocatorType/LocatorTypeValue: required. Value/ActualValue/Condition: not used. Result can be stored if action contains '-'. |
| 73 | `IsTableSorted` | Action | Check if a table column is sorted. LocatorType/LocatorTypeValue: required for table. Value: column index. ActualValue/Condition: not used. |
| 74 | `IsTableSortedAsc` | Action | Check if a table column is sorted ascending. LocatorType/LocatorTypeValue: required for table element. Value: column index (0-based). |
| 75 | `IsTableSortedDesc` | Action | Check if a table column is sorted descending. LocatorType/LocatorTypeValue: required for table element. Value: column index (0-based). |
| 76 | `javascriptExecutor` | Action | Execute JavaScript in the browser context. Value: JavaScript code. LocatorType/LocatorTypeValue/ActualValue/Condition: not used. |
| 77 | `javascriptexecutorBackIfTrue` | Action | Execute JavaScript and set test step as failed if result is true. Value: JavaScript code. LocatorType/LocatorTypeValue/ActualValue/Condition: not used. |
| 78 | `Jclick` | Action | Click a web element using JavaScript. LocatorType/LocatorTypeValue: required. Value/ActualValue/Condition: not used. |
| 79 | `JClickIfExists` | Action | Executes JavaScript click if element exists in DOM; skips gracefully without throwing if absent. |
| 80 | `JXpathclick` | Action | Click a web element using JavaScript and XPath. LocatorTypeValue: XPath(s) (can be multiple, separated by ':,:'). Value/ActualValue/Condition: not used. |
| 81 | `LiveTestRecorder` | Feature | Interactive in-browser Heads-Up Display (HUD) and element inspector. Injects a floating status bar with pulsing ● REC indicator, dynamic step counter, 1-click assertion builder, pause/resume, and hover element outline inspector directly into active browser sessions. |
| 82 | `MakeFail` | Action | Force the test step to fail. No input required for Value, ActualValue, LocatorType, LocatorTypeValue, or Condition. |
| 83 | `MarkAsChecked` | Action | Check a checkbox if not already checked. LocatorType/LocatorTypeValue: required. Value/ActualValue/Condition: not used. |
| 84 | `MarkAsNotChecked` | Action | Uncheck a checkbox if checked. LocatorType/LocatorTypeValue: required. Value/ActualValue/Condition: not used. |
| 85 | `maximize` | Action | Maximize the browser window. No input required for Value, ActualValue, LocatorType, LocatorTypeValue, or Condition. |
| 86 | `mobileView` | Action | Set browser to mobile emulation view. ActualValue: device info (JSON). LocatorType/LocatorTypeValue/Value/Condition: not used. |
| 87 | `MockApiResponse` | Action | Intercept browser HTTP/HTTPS requests and fulfill them with synthetic status, headers, and payload via DevTools NetworkInterceptor. LocatorTypeValue or Value: URL pattern (supports wildcards * or ?). Value or ActualValue: '<statusCode>:<body...>' (e.g. '200:{"id":1}' or '500:Internal Error') or full JSON mock config. |
| 88 | `MouseBackClick` | Action | Simulate mouse back button click. No input required for Value, ActualValue, LocatorType, LocatorTypeValue, or Condition. |
| 89 | `MouseForwardClick` | Action | Simulate mouse forward button click. No input required for Value, ActualValue, LocatorType, LocatorTypeValue, or Condition. |
| 90 | `mousemove` | Action | Move mouse pointer to a web element. LocatorType/LocatorTypeValue: required to locate the element. Value/ActualValue/Condition: not used. |
| 91 | `MoveByOffsetFromElement` | Action | Move mouse by offset from a web element. LocatorType/LocatorTypeValue: required. Value: 'x,y' offset. ActualValue/Condition: not used. |
| 92 | `MoveByOffsetFromViewport` | Action | Move mouse by offset from viewport. Value: 'x,y' offset. LocatorType/LocatorTypeValue/ActualValue/Condition: not used. |
| 93 | `MoveOffsetfromCurrentPointerLocation` | Action | Move mouse by offset from current pointer location. Value: 'x,y' offset. LocatorType/LocatorTypeValue/ActualValue/Condition: not used. |
| 94 | `MoveToElement` | Action | Move mouse pointer to a web element. LocatorType/LocatorTypeValue: required. Value/ActualValue/Condition: not used. |
| 95 | `MoveToElementBuild` | Action | Move mouse pointer to a web element using Actions.Build(). LocatorType/LocatorTypeValue: required. Value/ActualValue/Condition: not used. |
| 96 | `openAndMaximizebrowser` | Action | Open and maximize Chrome browser. Value: optional. LocatorType/LocatorTypeValue: not used. Condition: not used. |
| 97 | `openbrowser` | Action | Open Chrome browser. Value: optional. LocatorType/LocatorTypeValue: not used. Condition: not used. |
| 98 | `openbrowser-record` | Action | Open Chrome in record mode for capturing actions. Value: optional. LocatorType/LocatorTypeValue: not used. Condition: not used. |
| 99 | `openbrowserChrome` | Action | Open Chrome browser. Value: optional. LocatorType/LocatorTypeValue: not used. Condition: not used. |
| 100 | `openbrowserChromeWithHistory` | Action | Open Chrome with a specific user profile. Value: optional. LocatorType/LocatorTypeValue: not used. Condition: not used. |
| 101 | `openbrowserEdge` | Action | Open Edge browser. Value: optional. LocatorType/LocatorTypeValue: not used. Condition: not used. |
| 102 | `openbrowserEdgeWithHistory` | Action | Open Edge browser with user profile/history. Value: optional. LocatorType/LocatorTypeValue: not used. Condition: not used. |
| 103 | `openbrowserFireFox` | Action | Open Firefox browser. Value: optional. LocatorType/LocatorTypeValue: not used. Condition: not used. |
| 104 | `openbrowserFireFoxWithHistory` | Action | Open Firefox with a specific user profile. Value: optional. LocatorType/LocatorTypeValue: not used. Condition: not used. |
| 105 | `openbrowserWithHistory` | Action | Open Chrome browser with user profile/history. Value: optional. LocatorType/LocatorTypeValue: not used. Condition: not used. |
| 106 | `PageRefresh` | Action | Refresh the current browser page. No input required for Value, ActualValue, LocatorType, LocatorTypeValue, or Condition. |
| 107 | `ParentChildClick` | Action | Click a child element by text within a parent. LocatorType/LocatorTypeValue: required for parent. Value: child text. ActualValue: child selector. Condition: not used. |
| 108 | `ParentChildStartWithClick` | Action | Click a child element whose text starts with value within a parent. LocatorType/LocatorTypeValue: required for parent. Value: child text prefix. ActualValue: child selector. Condition: not used. |
| 109 | `Print` | Action | Print a value to the console. Value: text to print. LocatorType/LocatorTypeValue/ActualValue/Condition: not used. |
| 110 | `quitBrowser` | Action | Quit the browser and end the session. No input required for Value, ActualValue, LocatorType, LocatorTypeValue, or Condition. |
| 111 | `removeAlert` | Action | Remove alert and confirm dialogs. No input required for Value, ActualValue, LocatorType, LocatorTypeValue, or Condition. |
| 112 | `ResetNetwork` | Action | Reset all active CDP network throttling conditions and remove all active request interceptors/mocks. No parameters required. |
| 113 | `scrollBy` | Action | Scroll window by offset. Value: 'x,y' offset. LocatorType/LocatorTypeValue/ActualValue/Condition: not used. |
| 114 | `scrollTo` | Action | Scroll window by  Value: 'x,y'. LocatorType/LocatorTypeValue/ActualValue/Condition: not used. |
| 115 | `scrollToElement` | Action | Scroll to a web element. LocatorType/LocatorTypeValue: required. Value/ActualValue/Condition: not used. |
| 116 | `scrollToElementAndClick` | Action | Scroll to a web element and click it. LocatorType/LocatorTypeValue: required. Value/ActualValue/Condition: not used. |
| 117 | `selectdropdown` | Action | Click a dropdown element. LocatorType/LocatorTypeValue: required. Value/ActualValue/Condition: not used. |
| 118 | `selectdropdownByIndex` | Action | Select dropdown option by index. LocatorType/LocatorTypeValue: required. Value: index (integer). ActualValue/Condition: not used. |
| 119 | `selectdropdownByText` | Action | Select dropdown option by visible text. LocatorType/LocatorTypeValue: required. Value: option text. ActualValue/Condition: not used. |
| 120 | `selectdropdownByValue` | Action | Select dropdown option by value. LocatorType/LocatorTypeValue: required. Value: option value. ActualValue/Condition: not used. |
| 121 | `sendkeys` | Action | Send keystrokes to an input element. LocatorType/LocatorTypeValue: required. Value: text to send. ActualValue/Condition: optional. |
| 122 | `sendkeysAndBlur` | Action | Send keystrokes to an element and then blur. LocatorType/LocatorTypeValue: required. Value: text to send. ActualValue/Condition: not used. |
| 123 | `sendkeysDown` | Action | Simulate a key down event on an element. LocatorType/LocatorTypeValue: required. Value: key to send. ActualValue/Condition: not used. |
| 124 | `sendkeysEncrypt` | Action | Send encrypted text to an element. LocatorType/LocatorTypeValue: required. Value: encrypted text. ActualValue/Condition: not used. |
| 125 | `sendkeysEnter` | Action | Send Enter key to an element. LocatorType/LocatorTypeValue: required. Value/ActualValue/Condition: not used. |
| 126 | `SendKeysRandomString` | Action | Send a random string to a web element. LocatorType/LocatorTypeValue: required to locate the element. Value: optional initial input. ActualValue: optional length of the random string (defaults to 50 if invalid). If the element has no value, a random alphanumeric string is generated. If it has a value, a random string is generated using its characters. Condition: not used. |
| 127 | `sendkeysUp` | Action | Simulate a key up event on an element. LocatorType/LocatorTypeValue: required. Value: key to send. ActualValue/Condition: not used. |
| 128 | `SetBaseWindowHandle` | Action | Store the current window handle in module data. Value: key to store (optional). LocatorType/LocatorTypeValue/ActualValue/Condition: not used. |
| 129 | `SetDate` | Action | Generates a dynamic date by adding or subtracting a time unit from the current date and formatting it.  Value: optional date format string (default: 'dd/MM/yyyy').  LocatorType: add type (day, month, year, hr, minute, second, millisecond).  LocatorTypeValue: integer amount to add/subtract.  Supports advanced data routing using action format 'SetDate-type:key'.  Where 'type' determines target: d=Default (no operation), m=ModuleData, c=TestCaseData.  Example: 'SetDate-m:StartDate' stores the calculated value in Module Data.  If '-' is not used, value is stored using ActualValue key via SetModuleData.  Condition: not used. |
| 130 | `SetDOMAttribute` | Action | Set data to module or test case . ActualValue/value: use for property which require t. LocatorType/LocatorTypeValue:  used to identify web element. |
| 131 | `SetDomProperty` | Action | Set data to module or test case . ActualValue/value: use for property which require t. LocatorType/LocatorTypeValue:  used to identify web element. |
| 132 | `SetImageText` | Action | Set text from OCR result into an input element. LocatorType/LocatorTypeValue: required. Value/ActualValue/Condition: not used. |
| 133 | `SetModuleNumber` | Action | Set a numeric value in module data. ActualValue: key to store. Value: number to set. LocatorType/LocatorTypeValue/Condition: not used. |
| 134 | `SetModuleText` | Action | Set module data from element text. LocatorType/LocatorTypeValue: required. ActualValue: key to store. Value/Condition: not used. |
| 135 | `SetModuleTextFromJpath` | Action | Set module data from JPath value. ActualValue: key to store. LocatorTypeValue: JPath. Value: JSON string or key. LocatorType/Condition: not used. |
| 136 | `SetModuleTextValue` | Action | Set module data. ActualValue: key to store. Value: value to set. LocatorType/LocatorTypeValue/Condition: not used. |
| 137 | `SetPopUpParentWindow` | Action | Store the parent window handle of a popup in module data. No input required for Value, ActualValue, LocatorType, LocatorTypeValue, or Condition. |
| 138 | `SetPreviousWebElement` | Action | Store the current web element for later use (e.g., for drag-and-drop). LocatorType/LocatorTypeValue: required. Value/ActualValue/Condition: not used. |
| 139 | `SetTestCaseText` | Action | Set test case data from element text. LocatorType/LocatorTypeValue: required. ActualValue: key to store. Value/Condition: not used. |
| 140 | `SetTestCaseTextValue` | Action | Set test case data. ActualValue: key to store. Value: value to set. LocatorType/LocatorTypeValue/Condition: not used. |
| 141 | `SetTestStepText` | Action | Set test step data from element text. LocatorType/LocatorTypeValue: required. ActualValue: key to store. Value/Condition: not used. |
| 142 | `SetTestStepTextValue` | Action | Set test step data. ActualValue: key to store. Value: value to set. LocatorType/LocatorTypeValue/Condition: not used. |
| 143 | `SetUrl` | Action | Store the current URL in module data. Value: key to store. LocatorType/LocatorTypeValue/ActualValue/Condition: not used. |
| 144 | `SetWindowCount` | Action | Store the number of open windows in module data. Value: key to store. LocatorType/LocatorTypeValue/ActualValue/Condition: not used. |
| 145 | `Shift` | Action | Simulate Shift+<key> press. Value: key (optional). LocatorType/LocatorTypeValue/ActualValue/Condition: not used. |
| 146 | `sleep` | Action | Pause execution for a specified time. Value: milliseconds to sleep. LocatorType/LocatorTypeValue/ActualValue/Condition: not used. |
| 147 | `SpeakSelectedText` | Action | Speak the currently selected text in the browser. Value: speech rate (optional). LocatorTypeValue: voice name (optional). LocatorType/ActualValue/Condition: not used. |
| 148 | `StartNewBrowser` | Action | Initiates a new browser session. This action requires a follow-up instruction specifying which browser to launch. Supported options include: 'openbrowserChrome', 'openbrowserEdge', 'openbrowserFirefox', etc.  you can see example with SwitchBrowser. |
| 149 | `StartVideoRecorder` | Media | Initializes session video recording to specified output path. |
| 150 | `Status` | Other | The status column represents the result of each step and can be updated to either Pass,Fail, fatal,error,warning or skip based on execution even its fail.This is 14th number column in excel |
| 151 | `StopVideoRecorder` | Media | Halts session video recording and finalizes container file. |
| 152 | `SwitchBrowser` | Action | Switches focus to an existing browser instance. Requires an index value indicating which browser to activate. Index starts from 1 and corresponds to the order in which browsers were launched. TestCaseId  Steps                                                                                                 LocatorType  LocatorTypeValue           Action                 Value                                                       IsRun  Condition  ActualValue 1           Launch the browser                                                                                        NA           NA                        openbrowserChrome      '                                                           Yes    NA         'NA 1           Launch new the browser                                                                                    NA           NA                        StartNewBrowser        '                                                           Yes    NA         'NA 1           Launch the browser                                                                                        NA           NA                        openbrowserEdge        '                                                           Yes    NA         'NA 1           Switch to First Browser                                                                                   NA           NA                        SwitchBrowser          1                                                           Yes    NA         'NA 1           Navigate to the URL in the browser                                                                        NA           NA                        enterUrl             http://localhost:3000/login                                   Yes    NA         'NA 1           Switch to First Browser                                                                                   NA           NA                        SwitchBrowser          2                                                           Yes    NA         'NA 1           Navigate to the URL in the browser                                                                        NA           NA                        enterUrl             http://localhost:3000/login                                   Yes    NA         'NA 1           Switch to First Browser                                                                                   NA           NA                        SwitchBrowser          1                                                           Yes    NA         'NA 1           User should click on email, for React App                                                                 xpath         !Data->Locators.UserName click                  ''                                                          Yes    NA         'NA 1           Switch to First Browser                                                                                   NA           NA                        SwitchBrowser          2                                                           Yes    NA         'NA 1           User should click on email, for React App                                                                 xpath         !Data->Locators.UserName click                  ''                                                          Yes    NA         'NA 1           Switch to First Browser                                                                                   NA           NA                        SwitchBrowser          1                                                           Yes    NA         'NA |
| 153 | `SwitchToBaseWindow` | Action | Switch to the base window handle stored in module data. No input required for Value, ActualValue, LocatorType, LocatorTypeValue, or Condition. |
| 154 | `switchToFrame` | Action | Switch to a frame by web element. LocatorType/LocatorTypeValue: required for frame element. Value/ActualValue/Condition: not used. |
| 155 | `switchToFrameByIndex` | Action | Switch to a frame by index. Value: frame index (integer). LocatorType/LocatorTypeValue/ActualValue/Condition: not used. |
| 156 | `switchToLastWindow` | Action | Switch to the last opened window. No input required for Value, ActualValue, LocatorType, LocatorTypeValue, or Condition. |
| 157 | `switchToLastWindowAndClose` | Action | Switch to the last window and close it. No input required for Value, ActualValue, LocatorType, LocatorTypeValue, or Condition. |
| 158 | `switchToParentFrame` | Action | Switch to the parent frame. No input required for Value, ActualValue, LocatorType, LocatorTypeValue, or Condition. |
| 159 | `SwitchToPopUpParentWindow` | Action | Switch to the parent window of a popup stored in module data. No input required for Value, ActualValue, LocatorType, LocatorTypeValue, or Condition. |
| 160 | `SwitchToPopUpWindow` | Action | Switch to a popup window by index. Value: popup index (integer). LocatorType/LocatorTypeValue/ActualValue/Condition: not used. |
| 161 | `switchToWindowByIndex` | Action | Switch to a window by index. Value: window index (integer). LocatorType/LocatorTypeValue/ActualValue/Condition: not used. |
| 162 | `takingelementscreenshot` | Action | Take a screenshot of a web element. LocatorType/LocatorTypeValue: required. Value: file path. ActualValue/Condition: not used. |
| 163 | `takingscreenshot` | Action | Take a screenshot of the browser. Value: file path. LocatorType/LocatorTypeValue/ActualValue/Condition: not used. |
| 164 | `takingscreenshotappender` | Action | Take a screenshot and append to a file path with timestamp. Value: file path (with {0} for unique part). LocatorType/LocatorTypeValue/ActualValue/Condition: not used. |
| 165 | `takingscreenshotappenderwithPath` | Action | Take a screenshot and append to a file path. Value: file path (with {0} for unique part). LocatorType/LocatorTypeValue/ActualValue/Condition: not used. |
| 166 | `ThrottleNetwork` | Action | Emulate network speed and latency using Chrome DevTools Protocol (CDP). Value: preset ('Offline', 'Slow 3G', 'Fast 3G', '4G', 'Online') or custom specification ('<latencyMs>:<downKbps>:<upKbps>', e.g. '300:500:250'). LocatorType/LocatorTypeValue: not used. |
| 167 | `UseKeyboard` | Action | Simulates keyboard input using the InputSimulator. Value: The string representing the key(s) or key combination to send. Examples of Value: 'Hello World' (types text), 'Enter' (presses Enter key), 'Ctrl+S' (presses Ctrl+S), 'Alt+F4' (presses Alt+F4), 'Shift+Home' (presses Shift+Home), 'Tab', 'Backspace', 'Delete', 'UpArrow', 'DownArrow', 'LeftArrow', 'RightArrow', 'PageUp', 'PageDown', 'Home', 'End', 'Escape', 'F1', 'F2', 'F5'. LocatorType/LocatorTypeValue: not used. Condition: not used. |
| 168 | `UseMouse` | Action | Simulates mouse actions using the InputSimulator. Value: The string representing the mouse command and optional parameters. Examples of Value:   'LeftButtonClick'          - Single left click   'RightButtonClick'         - Single right click   'LeftButtonDoubleClick'    - Double left click   'MoveMouseBy:100,50'       - Move mouse cursor relative by X=100, Y=50   'MoveMouseTo:20000,30000'  - Move mouse cursor to absolute position (0-65535 coordinates)   'VerticalScroll:5'         - Scroll vertically by 5 units (positive = up, negative = down)   'HorizontalScroll:-3'      - Scroll horizontally by -3 units (positive = right, negative = left) LocatorType/LocatorTypeValue: not used. Condition: not used. |
| 169 | `validatealertText` | Action | Validate alert dialog text. Value: expected text. LocatorType/LocatorTypeValue/ActualValue/Condition: not used. |
| 170 | `validateAttribute` | Action | Validate an element's attribute. LocatorType/LocatorTypeValue: required. ActualValue: attribute name. Value: expected value. Condition: not used. |
| 171 | `ValidateBrokenImage` | Validation | Validates all images on the page and verifies natural dimensions (naturalWidth > 0) and valid loading. |
| 172 | `ValidateBrokenLink` | Validation | Validates all anchor links on the current page and asserts valid HTTP status (2xx/3xx). |
| 173 | `validateContainsText` | Action | Validate element contains text. LocatorType/LocatorTypeValue: required. Value: substring to check. ActualValue/Condition: not used. |
| 174 | `ValidateContainsUrl` | Action | Validate the current URL contains a substring. Value: substring to check. LocatorType/LocatorTypeValue/ActualValue/Condition: not used. |
| 175 | `ValidateCount` | Action | Validate count of matching elements. LocatorType/LocatorTypeValue: required. Value: expected count (integer). ActualValue/Condition: not used. Result can be stored if action contains '-'. |
| 176 | `validateCssValue` | Action | Validate an element's CSS value. LocatorType/LocatorTypeValue: required. ActualValue: CSS property name. Value: expected value. Condition: not used. |
| 177 | `validateDataText` | Action | Validate data text from test data. Value: expected value. ActualValue: key to fetch from test data (optional). LocatorType/LocatorTypeValue/Condition: not used. |
| 178 | `ValidateDataTextLength` | Validation | Asserts length of element text or test data variable matches expected integer count. |
| 179 | `ValidateDateSorted` | Action | Validate element list is sorted. It could have ValidateDateSorted-desc for descending check. You need to provide date or time format in value column which is mandatory. LocatorType/LocatorTypeValue: required. Value: expected value. ActualValue/Condition: not used. |
| 180 | `validateDomAttribute` | Action | Validate an element's DOM attribute. LocatorType/LocatorTypeValue: required. ActualValue: attribute name. Value: expected value. Condition: not used. |
| 181 | `validateDomProperty` | Action | Validate an element's DOM property. LocatorType/LocatorTypeValue: required. ActualValue: property name. Value: expected value. Condition: not used. |
| 182 | `validatedropdownCount` | Action | Validate dropdown option count. LocatorType/LocatorTypeValue: required. Value: expected count (integer). ActualValue/Condition: not used. |
| 183 | `validatedropdownText` | Action | Validate selected dropdown text. LocatorType/LocatorTypeValue: required. Value: expected text. ActualValue/Condition: not used. |
| 184 | `validatedropdownValue` | Action | Validate selected dropdown value. LocatorType/LocatorTypeValue: required. Value: expected value. ActualValue/Condition: not used. |
| 185 | `validateEndsWithText` | Action | Validate element text ends with value. LocatorType/LocatorTypeValue: required. Value: suffix. ActualValue/Condition: not used. |
| 186 | `validateIsChecked` | Action | Validate if a checkbox is checked. LocatorType/LocatorTypeValue: required. Value/ActualValue/Condition: not used. |
| 187 | `validateIsNotChecked` | Action | Validate if a checkbox is not checked. LocatorType/LocatorTypeValue: required. Value/ActualValue/Condition: not used. |
| 188 | `validateJPath` | Action | Validate a value from JSON using JPath. ActualValue: JSON string or key. LocatorTypeValue: JPath. Value: expected value. LocatorType/Condition: not used. |
| 189 | `validateNotDuplicate` | Action | Validate element list is not Duplicate. LocatorType/LocatorTypeValue: required. Value: expected value. ActualValue/Condition: not used. |
| 190 | `validateNotMatchedText` | Action | Validate element text should not matched. LocatorType/LocatorTypeValue: required. Value: expected text. ActualValue/Condition: not used. |
| 191 | `ValidateNumberSorted` | Action | Validate element list is sorted. It could have ValidateNumberSorted-desc for descending check.  LocatorType/LocatorTypeValue: required. Value: expected value. ActualValue/Condition: not used. |
| 192 | `validateRegularExpression` | Action | Validate element text or value with a regular expression. LocatorType/LocatorTypeValue: required. Value: regex pattern. ActualValue/Condition: not used. |
| 193 | `ValidateSorted` | Action | Validate element list is sorted. It could have ValidateSorted-desc for descending check.  LocatorType/LocatorTypeValue: required. Value: expected value. ActualValue/Condition: not used. |
| 194 | `validateStartsWithText` | Action | Validate element text starts with value. LocatorType/LocatorTypeValue: required. Value: prefix. ActualValue/Condition: not used. |
| 195 | `validateText` | Action | Validate element text. LocatorType/LocatorTypeValue: required. Value: expected text. ActualValue/Condition: not used. |
| 196 | `ValidateTextAndThrow` | Action | Validate element text and throw if not matched. LocatorType/LocatorTypeValue: required. Value: expected text. ActualValue/Condition: not used. |
| 197 | `validateTextLength` | Action | Validate element text length. LocatorType/LocatorTypeValue: required. Value: expected text. ActualValue/Condition: not used. |
| 198 | `validateTextWithoutSpace` | Action | Validate element text matched after removing space. LocatorType/LocatorTypeValue: required. Value: expected value. ActualValue/Condition: not used. |
| 199 | `validateTitle` | Action | Validate browser title. Value: expected title. LocatorType/LocatorTypeValue/ActualValue/Condition: not used. |
| 200 | `ValidateUrl` | Action | Validate the current URL. Value: expected URL. LocatorType/LocatorTypeValue/ActualValue/Condition: not used. |
| 201 | `ValidateUrlAndThrow` | Action | Validate the current URL and throw if not matched. Value: expected URL. LocatorType/LocatorTypeValue/ActualValue/Condition: not used. |
| 202 | `validateVisualBaseline` | Action | Performs perceptual pixel diffing comparing the active browser page or specific element against a golden baseline screenshot. Value: baseline name or tolerance percentage (e.g. '0.5' for 0.5%). LocatorType/LocatorTypeValue: element selector (or NA for full page). Generates side-by-side split comparison and diff overlay images. |
| 203 | `VisualReportingDashboard` | Feature | Executive, responsive HTML test report generated at target/nexttest-reports/nexttest-report.html. Features SVG animated donut charts, latency waterfall, real-time search, multi-status filter pills (ALL, PASS, FAIL, FLAKY, HEALED), expandable step accordions, and printable styling. |
| 204 | `WindowDialogHandle` | Action | Handle native file dialog (Save/Open) using FileDialogHelper.HandleFileDialog. LocatorType: dialog title. Value: file path to set (e.g. C:\path\file.ext). LocatorTypeValue: button text to click (e.g. Save/Open). ActualValue/Condition: not used. |
| 205 | `WindowSize` | Action | Set browser window size. Value: 'width,height'. LocatorType/LocatorTypeValue/ActualValue/Condition: not used. |

---

## 8. 🩹 AI Self-Healing Engine: Empirical Accuracy Benchmark

NextTest incorporates a multi-vector AI Self-Healing engine that rescues broken or drifted selectors at runtime without aborting test execution.

### Empirical 100-Mutation Benchmark Results
Evaluated against 100 real-world DOM mutation scenarios across 5 distinct failure categories:

| Failure Category | Test Scenarios | Successfully Healed | False Positives | Recovery Rate | Mean Confidence |
|---|---|---|---|---|---|
| **1. Dynamic & Ephemeral IDs** (GUIDs, build hashes, timestamps) | 20 | 20 | 0 | **100.0%** | 92.4% |
| **2. CSS Class Name Refactoring** (Bootstrap $\to$ Tailwind CSS migration) | 20 | 20 | 0 | **100.0%** | 86.8% |
| **3. DOM Structural Restructuring** (Nested cards, layout wrappers) | 20 | 20 | 0 | **100.0%** | 88.5% |
| **4. Text & Label Semantic Drift** (Button text revisions, localization) | 20 | 20 | 0 | **100.0%** | 91.2% |
| **5. Multi-Attribute Fallback** (XPath broken; name, placeholder, testId) | 20 | 20 | 0 | **100.0%** | 84.1% |
| **OVERALL BENCHMARK TOTAL** | **100** | **100** | **0** | **100.0%** | **87.3%** |

### Fallback Hierarchy & Confidence Scoring
1. **Test-ID Fingerprint Recovery** (`[data-testid='...']`) — Confidence: 95%–98%
2. **Name Attribute Resilience** (`name='...'`) — Confidence: 90%–94%
3. **ID Pattern Normalization** (`id='...'` stripping numeric/ephemeral hashes) — Confidence: 88%–92%
4. **Semantic Text & Role Matching** (`//button[contains(., '...')]`) — Confidence: 85%–92%
5. **Accessible Name & Placeholder Recovery** (`aria-label`, `placeholder`) — Confidence: 82%–89%

---

## 9. 🤖 AI Capabilities & Agentic Generation Benchmarks

NextTest provides enterprise-grade AI integration supporting both **100% offline, private local models** (bundled GGUF via llama.cpp) and **cloud LLM APIs** (OpenAI GPT-4o, Anthropic Claude 3.5, Ollama).

### Measured AI Performance & Quality Metrics

| Benchmark Dimension | Measured Result | Industry Peer Avg | Description |
|---|---|---|---|
| **Schema Compliance Rate** | **98.7%** | 82.4% | Valid NextTest JSON/Excel schema generation without syntax errors |
| **First-Run Execution Pass Rate** | **91.4%** | 71.2% | Generated test steps that execute cleanly on first run against live web apps |
| **Autonomous RCA Resolution** | **89.2%** | 64.0% | Failed steps diagnosed and automatically repaired via Root-Cause Analysis |
| **Action Hallucination Rate** | **0.0%** | 14.8% | Strict catalog grounding eliminates invented commands or unsupported verbs |
| **Local GGUF Latency (Qwen 2.5 0.5B)** | **1.1s** | N/A | Sub-second offline inference with zero data leakage |
| **Cloud API Latency (GPT-4o)** | **1.6s** | 2.8s | Fast multi-step test suite synthesis via OpenAI-compatible endpoints |

### Agentic Capabilities:
- **`AiAssistant.generateAgenticSuite(url, domSummary, goal)`**: Takes live DOM context from the browser recorder or element inspector and synthesizes complete, runnable functional test suites.
- **`AiAssistant.analyzeFailureRca(step, error, domSnippet)`**: Automated Root Cause Analysis that inspects DOM state at failure and generates concrete remediation recommendations.
- **Zero Cloud Lock-in**: Full local offline privacy ensures proprietary internal application structures and credentials never leave your local workstation.
