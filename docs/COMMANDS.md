# NextTest Commands and AI Test Authoring Guide

This document describes the JSON test-suite format and the actions used by the NextTest Java runner. It is also loaded into the in-app AI assistant as reference context.

## Instructions for AI test generation

When asked to create or edit a test:

1. Return a **NextTest JSON suite** unless the user explicitly requests Excel or source code. A NextTest suite is data; it is not Java, JavaScript, Python, Selenium, or Playwright source code.
2. Use the schema and examples below. Keep the user’s requested test intent, app URL, selectors, and assertions. Do not invent page elements, credentials, capabilities, action names, or expected results.
3. Prefer actions shown in the examples and in `TestRunner.normalizeActionName` / `TestRunner.executeExtended`. Use the closest shipped sample for specialized actions. A known action is not necessarily available on every engine or platform.
4. If a selector, expected result, login secret, device, or environment setting is unknown, ask for it or leave an explicit `TODO` in the explanation. Do not put made-up data in a runnable suite.
5. Never copy a real password or API secret into a suite. Use suite data placeholders and tell the user what value they must provide securely before execution.
6. Preserve valid JSON: double quotes, no comments, no trailing commas. Explain assumptions outside the JSON block.
7. Do not claim a generated suite passed. It is only verified after it is loaded and run against the target app.

The Java loader accepts JSON property names without regard to case. Use the lowercase field names shown below, except the test-case name field, which is conventionally `Case`. Keep action names as shown in working samples for readability.

## Suite structure

```json
{
  "name": "CampusFlow login page smoke",
  "platform": "WEB",
  "engine": "SELENIUM",
  "data": {
    "baseUrl": "http://127.0.0.1:3100"
  },
  "locatorFiles": [],
  "dataFiles": [],
  "testCases": [
    {
      "testCaseId": "LOGIN-001",
      "Case": "Login page opens",
      "isRun": true,
      "hardStop": true,
      "tagNames": ["smoke", "login"],
      "testSteps": [
        {
          "steps": "Open the sample app",
          "action": "openBrowserChrome",
          "value": "${baseUrl}",
          "isRun": true,
          "hardStop": true
        },
        {
          "steps": "Check the page title",
          "action": "validateTitle",
          "value": "CampusFlow · Student Services",
          "isRun": true
        },
        {
          "steps": "Close the browser",
          "action": "closeBrowser",
          "isRun": true
        }
      ]
    }
  ]
}
```

This example uses the bundled CampusFlow sample app. Start it from the distribution’s `sample-application` directory with `npm install` (first run only) and `npm start`. The sample listens at `http://127.0.0.1:3100`.

## JSON fields

### Suite fields

| Field | Type | Purpose |
|---|---|---|
| `name` | string | Human-readable suite name. |
| `platform` | string | `WEB` by default; desktop/mobile configurations may use `WINDOWS`, `MACOS`, `ANDROID`, or `IOS`. Platform execution requires the appropriate local driver/device setup. |
| `engine` | string | `SELENIUM` by default. `PLAYWRIGHT` selects the Playwright browser runner; do not assume every Selenium action is supported by Playwright. |
| `serverUrl`, `appPath`, `appPackage`, `appActivity`, `bundleId`, `deviceName`, `automationName`, `capabilities` | string/object | Platform driver configuration. Copy these from a working platform sample and the target environment. |
| `data` | object | Inline string data used for `${key}` substitution. The JSON loader reads scalar values from this object as strings. |
| `locators` | object | Optional inline locator dictionary. |
| `locatorFiles` | array | External locator file references, each with `name` and optional `prefix`. Paths are relative to the suite file. |
| `dataFiles` | array | External data/locator file references, each with `name` and optional `prefix`. JSON, XLSX, and XLS are supported. Paths are relative to the suite file. |
| `testData` | object | Named arrays of row objects used for data-driven execution. Follow the shipped data-driven examples. |
| `testCases` | array | Test cases in execution order. |

### Test case fields

| Field | Type | Purpose |
|---|---|---|
| `testCaseId` | string | Stable case identifier. |
| `Case` | string | Display name. `caseName` is also accepted. |
| `isRun` | boolean | Whether the case is enabled. Use `true` for generated cases unless asked otherwise. |
| `hardStop` | boolean | If true, a failing step stops the current case. Default is false. |
| `retries` | integer | Optional case retry count. Use only when the user requests retry behavior. |
| `tagNames` | string array | Optional labels for grouping. |
| `dataSheetName` | string | Optional data table name associated with this case. |
| `testSteps` | array | Ordered actions for the case. |

### Test step fields

| Field | Type | Purpose |
|---|---|---|
| `steps` | string | Human-readable intent for this step. |
| `action` | string | NextTest action name. |
| `locatorType` | string | Locator strategy; omit for browser/session actions that do not target an element. |
| `locatorTypeValue` | string | Locator value. |
| `value` | string | Action input or expected value, depending on the action. |
| `actualValue` | string | Secondary input used by some API, extraction, database, and legacy actions. Follow a matching sample. |
| `condition` | string | Optional flow-control condition. Do not invent condition syntax; copy a working loop sample. |
| `isRun` | boolean | Whether the step is enabled. |
| `hardStop` | boolean | Whether this step’s failure stops the case. |

Fields such as `isPassed`, `status`, `durationMs`, and `executedTime` are execution results; generated input suites normally omit them.

## Locators

For browser and Appium element steps, `TestRunner.toBy` supports:

| Locator type | Example |
|---|---|
| `id` | `login-submit` |
| `name` | `email` |
| `className` / `class` | `primary-button` |
| `css` / `cssSelector` | `form button[type='submit']` |
| `xpath` | `//button[@type='submit']` |
| `linkText` | `Forgot password?` |
| `partialLinkText` | `Forgot password` |
| `tagName` / `tag` | `button` |
| `accessibilityId` | Appium accessibility label |
| `androidUIAutomator` | Android UiAutomator selector |
| `iOSClassChain` | iOS class chain selector |
| `iOSNsPredicateString` | iOS predicate selector |

Use selectors found in the actual DOM/app or supplied by the user. Prefer stable IDs, accessible names, or test IDs when they exist. Do not guess selectors from screenshots alone.

## Common browser actions

Names are case-insensitive. The runner also normalizes whitespace, `_`, and `-` for action matching. Prefer the canonical sample names below instead of relying on aliases.

| Action | Required fields | Behavior |
|---|---|---|
| `openBrowserChrome` | `value`: optional URL | Opens Chrome; navigates when the value is a URL. |
| `openBrowserFirefox` | `value`: optional URL | Opens Firefox; navigates when the value is a URL. |
| `openBrowserEdge` | `value`: optional URL | Opens Edge; navigates when the value is a URL. |
| `enterUrl` | `value`: URL | Navigates the current browser; opens a session if needed. |
| `refresh` | none | Reloads current page. |
| `browserBack`, `browserForward` | none | Browser history navigation. |
| `closeBrowser` | none | Closes the current browser session. |
| `click`, `doubleClick`, `contextClick` | `locatorType`, `locatorTypeValue` | Clicks a located element. |
| `sendKeys` | locator + `value` | Types the value into a located element. Auto-decrypts `ENC:GCM:...` tokens if encountered. |
| `clearAndSendKeys` | locator + `value` | Clears then types. Auto-decrypts `ENC:GCM:...` tokens if encountered. |
| `enterEncryptedPassword` | locator + `value` | Decrypts AES-256-GCM encrypted token or `{{PASSWORD}}` placeholder in memory and types plaintext into element without logging plaintext. Supported on Web, Mobile (Appium), and Desktop. |
| `clear` | locator | Clears a text field. |
| `selectDropdownByText` | locator + `value` | Selects an option by visible text. |
| `selectDropdownByValue` | locator + `value` | Selects an option by its value. |
| `selectDropdownByIndex` | locator + `value` | Selects an option by index. |
| `markAsChecked`, `markAsNotChecked` | locator | Sets checkbox state. |
| `mouseHover` | locator | Moves pointer over an element. |
| `scrollIntoView` | locator | Scrolls element into view. |
| `windowSize` | `value`: `width,height` | Sets browser window size, e.g. `1280,800`. |
| `takingScreenshot` | optional `value`: filename | Captures a screenshot. |

## Common assertions and test data actions

| Action | Required fields | Behavior |
|---|---|---|
| `validateTitle` | `value`: expected title | Asserts the current page title. |
| `validateUrl` | `value`: expected URL | Asserts the current URL. |
| `validateText` | locator + `value` | Asserts element text equals the expected value. |
| `validateContainsText` | locator + `value` | Asserts element text contains the value. |
| `validateStartsWithText`, `validateEndsWithText` | locator + `value` | Asserts a text prefix/suffix. |
| `isDisplayed`, `isEnabled`, `isDisabled`, `isSelected` | locator | Asserts element state. |
| `elementExistsAndThrow` | locator | Fails if the element is missing. |
| `getText` | locator + `actualValue`: output key | Stores element text in suite data. |
| `setModuleTextValue` | `actualValue`: key, `value`: text | Stores suite-level data. |
| `setModuleNumber` | `actualValue`: key, `value`: number | Stores numeric suite data. |
| `incrementModuleNumber` | `actualValue`: key | Increments numeric suite data. |
| `sleep` | `value`: milliseconds | Fixed delay. Prefer explicit waits for elements when possible. |

## Variable and data-file syntax

- `${key}`, `{{key}}`, and `|{key}|` substitute a matching key from suite, case, or step data in ordinary values.
- `!Data->key` looks up a value in data, locator, case, or step dictionaries.
- `!D->row->Column` reads a column from a data-driven row. Follow `05-data-driven-campus-tables.json` or `10-data-driven-table-looping.json` for exact row setup.
- `!H->Column` reads a column from the active data row.
- `!M->...` supports module/case template replacement. Use only when needed and copy the precise syntax from a shipped sample.
- `!MTC->...` builds a value from module, case, and step data. Its forms are specialized; copy a matching API example rather than constructing it from memory.
- `!File->path` loads file contents for supported step fields. The path is resolved from the process working directory; verify it for the target run.
- `!Gen->...` invokes synthetic test data generation. Use examples from `08-synthetic-test-data-generation.json`.

For credentials, keep values in user-provided suite data and avoid literal secrets in generated documentation or checked-in suites. A recorded password field is represented by `{{PASSWORD}}`; tell the user to populate that value securely before replay.

## API action example

The API actions use `value` for the endpoint and `actualValue` for request configuration. This shape is taken from `09-api-automation-and-token-chaining.json`:

```json
{
  "steps": "Request protected students",
  "action": "api-GET",
  "value": "/api/students",
  "actualValue": "{\"BaseUrl\":\"http://127.0.0.1:3100\",\"Url\":\"/api/students\",\"Headers\":{\"Authorization\":\"Bearer {{authToken}}\",\"Content-Type\":\"application/json\"}}",
  "isRun": true
}
```

That suite obtains `authToken` with an earlier login request and `SetModuleTextFromJpath-authToken`. Do not generate a protected request without a valid authentication setup. Supported API details depend on the action; mirror a complete shipped API example.

## Platform-specific examples and limits

The bundled scenarios are the safest source for specialized configuration:

| Scenario | Use it for |
|---|---|
| `sample-application/scenarios/01-browser-lifecycle-and-navigation.json` | Basic browser lifecycle and navigation. |
| `sample-application/scenarios/01-admin-student-crud.json` | UI form workflow against CampusFlow. |
| `sample-application/scenarios/04-jwt-api-and-protected-data.json` | API login and token chaining. |
| `sample-application/scenarios/05-data-driven-campus-tables.json` | External data and row-driven tests. |
| `sample-application/scenarios/06-complete-actions-master-suite.json` | Broad action examples; not a promise that every action was tested on every platform. |
| `sample-application/scenarios/07-desktop-windows-calc-notepad.json` | Windows desktop/Appium configuration. Requires Windows Application Driver and desktop apps. |
| `sample-application/scenarios/08-desktop-macos-calculator.json` | macOS desktop example; requires macOS and its driver. |
| `sample-application/scenarios/09-mobile-android-calculator.json` | Android Appium example; requires an Appium server and Android device/emulator. |
| `sample-application/scenarios/10-database-validation-suite.json` | Database query setup and SQL example. |
| `sample-application/scenarios/06-javascript-and-script-files.json` | Browser JavaScript and script-file examples. |

These are examples, not proof of compatibility with every browser, operating system, device, or database. Do not generate mobile or native desktop actions for a web-only request.

## JavaScript and Java extension actions

- `executeScript` runs browser JavaScript in the current page context.
- `javascriptFile` runs a JavaScript file using the runner’s supported path/context. Use the JavaScript sample.
- `executeMethod` / delegate actions are Java extension mechanisms. Use `07-dynamic-java-and-delegates.json` and its Java source sample.
- A test suite’s `testSteps` are not a place for arbitrary Node.js, Python, or Playwright test code. Use the specific supported extension action and its sample.

## Enterprise AES-GCM Encrypted Passwords & Secrets

NextTest supports authenticated **AES-256-GCM** encryption for passwords, credentials, and API tokens across Web, Mobile, Desktop, and REST API testing:

- **Placeholder**: Use `{{PASSWORD}}` in test steps (e.g. `value: "{{PASSWORD}}"`) or reference external data arrays.
- **Encrypted Token Format**: `ENC:GCM:<Base64-12Byte-IV>:<Base64-CiphertextAndTag>`.
- **Primary Action**: `enterEncryptedPassword` (aliases: `enterPassword`, `typePassword`, `sendEncryptedKeys`, `setEncryptedPassword`). Resolves `{{PASSWORD}}`, decrypts the ciphertext in memory, and types it into the element. Plaintext is never exposed in logs or reports (`••••••••`).
- **REST API Auto-Decryption**: `api-GET`, `api-POST`, `api-PUT`, `api-DELETE`, and `api-PATCH` automatically decrypt embedded `ENC:GCM:...` tokens within URLs, HTTP headers, and JSON request bodies at transmission time.
- **Built-in Master Key**: Out of the box, NextTest uses a built-in default master key (`NextTest$Enterprise#AES256*MasterKey!2026`) so encrypted suites run seamlessly across team members and CI/CD pipelines. Custom keys can be configured in **File ➔ Test Settings ➔ Security & Encryption** or via `NEXTTEST_ENCRYPTION_KEY`.
- **Encryptor Tool**: Open **Tools ➔ Password Encryptor & Secret Generator…** (`Ctrl+Alt+P`) to encrypt passwords and copy tokens with one click.
- **Sample Scenario**: See `sample-application/scenarios/19-encrypted-passwords-and-aes-gcm.json` and `.xlsx` as well as `sample-application/scenarios/20-verified-api-and-ui-actions.json` and `.xlsx`.

## CLI execution

From a published distribution folder, use the launcher at that folder’s root:

```powershell
.\NextTest.bat --run .\sample-application\scenarios\01-browser-lifecycle-and-navigation.json --headless --output-dir .\reports --report-formats junit,html
```

The Java CLI equivalent after assembly is:

```powershell
java -jar .\nexttest-desktop.jar --run .\sample-application\scenarios\01-browser-lifecycle-and-navigation.json --headless --output-dir .\reports --report-formats junit,html
```

The CLI accepts `--run` / `-r` (also `--suite` / `-s`), `--browser`, `--engine`, `--headless`, `--no-headless`, `--output-dir` / `-o` (or `--report-dir` / `--reports-dir`), `--report-formats`, `--self-healing`, `--apply-healing`, and retry/grid options. Check `java -jar <jar> --help` for the exact options of the release being used. `--parallel` is a separate application entry point and takes a parallel config file; it is not a `CiCdCliRunner` option.

## Generation validation checklist

Before presenting a generated suite as ready:

- Confirm the requested behavior and expected results are specified.
- Confirm every selector exists in supplied HTML, an inspected DOM, app source, or user-provided locator data.
- Confirm action fields match a shipped example and the intended engine/platform.
- Confirm local file paths resolve relative to the suite or documented working directory.
- Confirm data-driven loops use the exact sample structure and have a bounded number of rows/iterations.
- Parse the output as JSON. Do not silently drop steps to make it parse.
- Provide the exact command and prerequisites to run it; state that execution is still required to verify behavior.

## Catalog scope and evidence

The NextTest runtime catalogue registers **214 actions, prefixes, and keyword directives** (200 core test execution actions, 3 dynamic syntax prefixes, 5 Java engine extensions, and 6 integrated platform capabilities) defined in `help-actions.json`. The Java runner is the implementation authority: `TestRunner.normalizeActionName`, `TestRunner.executeStep`, `TestRunner.executeExtended`, `DeviceDriverFactory`, and `PlaywrightTestRunner` determine accepted names, normalization rules, and platform support. Use exact shipped scenario samples for complex actions.

No AI-generated-suite pass rate or industry comparison is asserted by this guide. The self-healing benchmark in the source tests uses generated fixtures; it is not a live customer-app study. Any externally published benchmark must include its reproducible method, version, dataset, and limitations.
