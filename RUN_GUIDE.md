# NextTest Test Execution Guide & Command Reference

This guide details how to execute tests in NextTest (GUI, Headless CLI, and Parallel JSON/Excel Suite Runner), explains the fallback locator retry mechanism and prefix matrix, and provides a **clean, numbered index of all NextTest actions** without descriptions for quick reference and memorization.

For in-depth explanations, formulas, and working code examples for each action, refer to [NEXTTEST_COMMANDS_HELP.md](NEXTTEST_COMMANDS_HELP.md).

---

## 1. How to Run Tests in NextTest

### A. Interactive GUI Runner with Pause & Resume
1. Start NextTest Desktop:
   ```powershell
   java -jar nexttest/target/nexttest-desktop.jar
   ```
2. Click **📂 Open suite** (or `File → Load Test Suite…`).
3. Select any `.json` or `.xlsx` test suite (e.g. `nexttest/demo/student-registration/scenarios/06-complete-actions-master-suite.json` or `.xlsx`).
4. Click the green **▶ Run tests** button in the header toolbar (or `Test Runner → Start Execution`).
5. **Interactive Controls**:
   - **⏸ Pause**: Click the visible **⏸ Pause** button in the header toolbar at any time. Execution will pause immediately before the next step.
   - **Continue other work while paused**: While paused, the browser remains open, you can switch tabs, inspect locators, or even click **● Record** to capture additional steps.
   - **▶ Resume**: Click the prominent **▶ Resume** button to continue test execution from where it was paused.
   - **⏹ Stop**: Click **⏹ Stop** to cancel the execution safely.

---

### B. Headless Execution (Without Opening Browser Window)

nexttest supports running tests completely headlessly in the background without opening any browser window:

#### Option 1: Via Suite JSON
Add `"headless": true` in the suite-level `"data"` block:
```json
{
  "name": "Headless Test Suite",
  "data": {
    "headless": true,
    "baseUrl": "http://127.0.0.1:3100"
  },
  "testCases": [ ... ]
}
```

#### Option 2: Via Command Line (CLI Mode)
Run directly from terminal without launching the Swing GUI:
```powershell
java -jar nexttest/target/nexttest-desktop.jar --suite nexttest/demo/student-registration/scenarios/01-admin-student-crud.json --headless
```
You can also choose the browser:
```powershell
java -jar nexttest/target/nexttest-desktop.jar --suite nexttest/demo/student-registration/scenarios/01-admin-student-crud.json --headless --browser Firefox
```

#### Option 3: Via Test Settings
Open `File → Test Settings`, go to the **General** tab, and tick **Run browser headless (without opening browser window)**.

---

### C. Parallel Test Suite Execution from JSON Config

Run multiple test suites concurrently across multiple CPU threads, with aggregated execution results and an HTML report.

#### 1. Configuration File Format (`parallel-config.json`)
```json
{
  "threads": 3,
  "headless": true,
  "browser": "Chrome",
  "reportPath": "target/reports/parallel-report.html",
  "suites": [
    "nexttest/demo/student-registration/scenarios/01-admin-student-crud.json",
    "nexttest/demo/student-registration/scenarios/02-fee-grid-search.json",
    "nexttest/demo/student-registration/scenarios/04-jwt-api-and-protected-data.json"
  ]
}
```
*(Also supports a simple JSON array of suite paths: `["suite1.json", "suite2.json"]`)*.

#### 2. Running Parallel Suites from CLI
```powershell
java -jar nexttest/target/nexttest-desktop.jar --parallel nexttest/demo/student-registration/scenarios/parallel-config.json
```
- Executes suites in parallel across the configured thread count.
- Prints a progress table to the terminal.
- Generates a dark-themed HTML report at the specified `reportPath`.

#### 3. Running on Cloud Grids (BrowserStack / Sauce Labs / LambdaTest / Selenium Grid v4)
```powershell
java -jar nexttest/target/nexttest-desktop.jar --run ./demo/student-registration/scenarios/01-admin-student-crud.json --grid-url https://hub-cloud.browserstack.com/wd/hub --grid-provider BrowserStack --grid-user myUser --grid-key myKey
```

#### 4. Live Recording & Element Inspecting via CLI
```powershell
java -jar nexttest/target/nexttest-desktop.jar --record Chrome http://127.0.0.1:3100 --output my-recorded-suite.json
```

#### 5. Running Parallel Suites from GUI
1. Open NextTest.
2. Go to menu `🧪 Test Runner → ⚡ Run Parallel Suites (JSON)…`.
3. Select your `parallel-config.json`.
4. The runner executes in the background, logs progress in the **Developer Console**, and pops up an execution summary dialog with a direct button to open the HTML report in your browser.

---

## 2. Fallback Locator Splitter (`:,:`) & Retry Logic

When elements are dynamic or have alternative DOM representations:
1. Separate fallback selectors using `:,:`, for example:
   - `LocatorType`: `css:,:xpath`
   - `LocatorTypeValue`: `button.submit-btn:,://form//button[@type='submit']`
2. **Retry on Element Not Found**:
   - If earlier candidate selectors fail, nexttest evaluates the **last locator** in the splitter.
   - nexttest automatically retries the last locator **2 or 3 times** (based on configuration).
   - nexttest pauses **200 milliseconds** between each retry attempt.
3. **Configuring Retries**:
   - In Suite Data: `"locatorRetries": 3` (or `2`)
   - In System Property: `-Dnexttest.locator.retries=3`
   - In UI: `File → Test Settings → General → Locator retry count (on splitter :,:)`

---

## 3. Prefix Verification: .NET vs Java

Every prefix from the .NET framework is fully implemented and supported in Java:

| Prefix | Format / Example | Scope / Purpose | Supported in Java |
| :--- | :--- | :--- | :---: |
| `!print->` | `!print->Label->click` | Executes action and immediately takes screenshot | ✅ Yes |
| `!MTC->` | `!MTC->(var1;var2)->{"id":"var1"}` | Multi-context variable replacement (`(...)` and `{...}`) | ✅ Yes |
| `!D->` | `!D->Index->ColumnHeader` | Dynamic cell extraction from data-sheet row | ✅ Yes |
| `!Data->` | `!Data->variableKey` | Dictionary lookup from data or locators | ✅ Yes |
| `!H->` | `!H->ColumnHeader` | Current row column header lookup in data-driven test cases | ✅ Yes |
| `!M->` | `!M->Template m:{key} c:{key2}` | Module & Case data string interpolation | ✅ Yes |
| `!File->` | `!File->C:\data\body.json` | Reads raw content from external local file | ✅ Yes |
| `!V->` | `!V->variableKey` | Value variable alias resolution | ✅ Yes |

---

## 4. Complete Numbered Actions Index (Without Descriptions)

Below is the complete, numbered list of all nexttest actions:

1. openBrowserChrome
2. openBrowserFirefox
3. openBrowserEdge
4. openBrowser
5. openAndMaximizeBrowser
6. enterURL
7. navigate
8. gotourl
9. closeBrowser
10. quitBrowser
11. exitBrowser
12. close
13. quit
14. closeAllPopUpWindow
15. startNewBrowser
16. switchBrowser
17. switchToWindowByIndex
18. switchToFrame
19. switchToParentFrame
20. pageRefresh
21. refresh
22. browserBack
23. browserForward
24. maximize
25. fullscreen
26. windowSize
27. addTab
28. addWindow
29. click
30. doubleClick
31. contextClick
32. rightClick
33. mouseHover
34. moveByOffset
35. verticalScroll
36. scrollToBottom
37. scrollToTop
38. scrollIntoView
39. dragAndDrop
40. sendKeys
41. sendKeysEnter
42. sendKeysTab
43. clear
44. clearAndSendKeys
45. blur
46. selectDropdownByText
47. selectDropdownByValue
48. selectDropdownByIndex
49. selectOptionByText
50. selectOptionByValue
51. selectOptionByIndex
52. markAsChecked
53. unmarkAsChecked
54. selectByIndex
55. deselectByIndex
56. selectByValue
57. deselectByValue
58. selectByVisibleText
59. deselectByVisibleText
60. alertAccept
61. alertDismiss
62. alertSendKeys
63. windowDialogHandle
64. takingScreenshot
65. takingElementScreenshot
66. !print->
67. getText
68. getAttribute
69. getCssValue
70. getModuleData
71. getTestCaseData
72. getTestStepData
73. setModuleTextValue
74. setModuleNumber
75. incrementModuleNumber
76. setDate
77. validateText
78. validateTextAndThrow
79. validateContainsText
80. validateStartsWithText
81. validateEndsWithText
82. validateTextLength
83. validateTextWithoutSpace
84. validateTitle
85. validateUrl
86. validateContainsUrl
87. validateAttribute
88. validateCssValue
89. validateCount
90. validateDuplicate
91. validateNotDuplicate
92. validateSorted
93. validateNumberSorted
94. validateDateSorted
95. validateRegularExpression
96. isDisplayed
97. isNotDisplayed
98. isEnabled
99. isDisabled
100. isSelected
101. isNotSelected
102. elementExists
103. elementNotExists
104. elementExistsAndThrow
105. elementExistsSetModule
106. elementNotExistsSetModule
107. parentChildClick
108. parentChildStartWithClick
109. getColumnValues
110. getRowValues
111. count
112. sleep
113. wait
114. pause
115. userPause
116. threadSleep
117. makeFail
118. api-GET
119. api-POST
120. api-PUT
121. api-PATCH
122. api-DELETE
123. api-HEAD
124. api-OPTIONS
125. setModuleTextFromJpath
126. validateJPath
127. validateObjectJSON
128. executeScript
129. javascriptFile
130. executeMethod
131. executeJar
132. executeDataBaseQuery
133. accessibilityAudit
134. speakSelectedText
135. readAloud
136. imageToTextOCR
