# NextTest Test Execution Guide & Command Reference

This guide details how to execute tests in NextTest (GUI, Headless CLI, and Parallel JSON/Excel Suite Runner), explains the fallback locator retry mechanism and prefix matrix, and provides a **clean, numbered index of all NextTest actions** without descriptions for quick reference and memorization.

For in-depth explanations, formulas, and working code examples for each action, refer to [COMMANDS.md](COMMANDS.md).

---

## 1. How to Run Tests in NextTest

### A. Interactive GUI Runner with Pause & Resume
1. Start NextTest Desktop:
   ```powershell
   java -jar nexttest-desktop.jar
   ```
2. Click **📂 Open suite** (or `File → Load Test Suite…`).
3. Select any `.json` or `.xlsx` test suite (e.g. `sample-application/scenarios/06-complete-actions-master-suite.json` or `.xlsx`).
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
java -jar nexttest-desktop.jar --suite sample-application/scenarios/01-admin-student-crud.json --headless
```
You can also choose the browser:
```powershell
java -jar nexttest-desktop.jar --suite sample-application/scenarios/01-admin-student-crud.json --headless --browser Firefox
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
    "sample-application/scenarios/01-admin-student-crud.json",
    "sample-application/scenarios/02-fee-grid-search.json",
    "sample-application/scenarios/04-jwt-api-and-protected-data.json"
  ]
}
```
*(Also supports a simple JSON array of suite paths: `["suite1.json", "suite2.json"]`)*.

#### 2. Running Parallel Suites from CLI
```powershell
java -jar nexttest-desktop.jar --parallel sample-application/scenarios/parallel-config.json
```
- Executes suites in parallel across the configured thread count.
- Prints a progress table to the terminal.
- Generates a dark-themed HTML report at the specified `reportPath`.

#### 3. Running on Cloud Grids (BrowserStack / Sauce Labs / LambdaTest / Selenium Grid v4)
```powershell
java -jar nexttest-desktop.jar --run sample-application/scenarios/01-admin-student-crud.json --grid-url https://hub-cloud.browserstack.com/wd/hub --grid-provider BrowserStack --grid-user myUser --grid-key myKey
```

#### 4. Live Recording & Element Inspecting via CLI
```powershell
java -jar nexttest-desktop.jar --record Chrome http://127.0.0.1:3100 --output my-recorded-suite.json
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

## 3. Dynamic Prefix Modifiers & Expressions

NextTest provides native support for dynamic prefix modifiers and expressions across all test suites and engines:

| Prefix | Format / Example | Scope / Purpose | Supported |
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

Below is the exhaustive, numbered catalogue of all **214 implemented NextTest actions, prefixes, and keyword directives** registered in the NextTest runtime engine and in-app Help system (`help-actions.json`):

1. `!D->` — *Other*
2. `!File->` — *Other*
3. `!MTC->` — *Other*
4. `!print->` — *Action*
5. `acceptAlert` — *Action*
6. `AccessibilityAudit` — *Java Extension*
7. `ActionSendkeys` — *Action*
8. `AddTab` — *Action*
9. `AddWindow` — *Action*
10. `AlertAccept` — *Action*
11. `alertDismiss` — *Action*
12. `alertSendKeys` — *Action*
13. `alertSetAuthenticationCredentials` — *Action*
14. `Alt` — *Action*
15. `AltShift` — *Action*
16. `api-call` — *Action*
17. `api-DELETE` — *Action*
18. `api-GET` — *Action*
19. `api-PATCH` — *Action*
20. `api-POST` — *Action*
21. `api-PUT` — *Action*
22. `Backspace` — *Action*
23. `blur` — *Action*
24. `BrowserBack` — *Action*
25. `BrowserForward` — *Action*
26. `Cancel` — *Action*
27. `checkWindowFocus` — *Action*
28. `clear` — *Action*
29. `clearAndSendKeys` — *Action*
30. `click` — *Action*
31. `ClickAndHold` — *Action*
32. `clickAndRelease` — *Action*
33. `closeAllPopUpWindow` — *Action*
34. `closeBrowser` — *Action*
35. `CloudGridConnectors` — *Feature*
36. `confirmccept` — *Action*
37. `ContextClick` — *Action*
38. `Control` — *Action*
39. `ControlAlt` — *Action*
40. `Count` — *Action*
41. `Delete` — *Action*
42. `DoubleClick` — *Action*
43. `DragAndDrop` — *Action*
44. `DragAndDropByOffset` — *Action*
45. `DropdownValidation` — *Action*
46. `ElementExistsAndThrow` — *Action*
47. `ElementExistsSetModule` — *Action*
48. `Elementjavascriptexecutor` — *Action*
49. `ElementNotExistsAndThrow` — *Action*
50. `ElementNotExistsSetModule` — *Action*
51. `enterEncryptedPassword` — *Action*
52. `enterurl` — *Action*
53. `ExecuteDataBaseQuery` — *Action*
54. `ExecuteJar` — *Java Extension*
55. `ExecuteJavaMethod` — *Java Extension*
56. `ExecuteScript` — *Java Extension*
57. `ExecuteScriptFile` — *Java Extension*
58. `Extract-Locators-Repository` — *Feature*
59. `FileUpload` — *Action*
60. `fullscreen` — *Action*
61. `fullscreenshotappender` — *Action*
62. `generateTestData` — *Action*
63. `GetdropdownCount` — *Action*
64. `GetText` — *Action*
65. `goto` — *Action*
66. `hasclass` — *Action*
67. `HitTab` — *Action*
68. `ImageReadText` — *Action*
69. `ImageToText` — *Action*
70. `Import-cURL` — *Feature*
71. `Import-OpenAPI-Swagger` — *Feature*
72. `INCREMENTMODULENUMBER` — *Action*
73. `isDisabled` — *Action*
74. `isDisplayed` — *Action*
75. `isEnabled` — *Action*
76. `isNotDisplayed` — *Action*
77. `isNotSelected` — *Action*
78. `isSelected` — *Action*
79. `IsTableSorted` — *Action*
80. `IsTableSortedAsc` — *Action*
81. `IsTableSortedDesc` — *Action*
82. `javascriptExecutor` — *Action*
83. `javascriptexecutorBackIfTrue` — *Action*
84. `Jclick` — *Action*
85. `JXpathclick` — *Action*
86. `LiveTestRecorder` — *Feature*
87. `MakeFail` — *Action*
88. `MarkAsChecked` — *Action*
89. `MarkAsNotChecked` — *Action*
90. `maximize` — *Action*
91. `mobileView` — *Action*
92. `MockApiResponse` — *Action*
93. `MouseBackClick` — *Action*
94. `MouseForwardClick` — *Action*
95. `mouseHover` — *Action*
96. `mousemove` — *Action*
97. `MoveByOffsetFromElement` — *Action*
98. `MoveByOffsetFromViewport` — *Action*
99. `MoveOffsetfromCurrentPointerLocation` — *Action*
100. `MoveToElement` — *Action*
101. `MoveToElementBuild` — *Action*
102. `openAndMaximizebrowser` — *Action*
103. `openbrowser` — *Action*
104. `openbrowser-record` — *Action*
105. `openbrowserChrome` — *Action*
106. `openbrowserChromeWithHistory` — *Action*
107. `openbrowserEdge` — *Action*
108. `openbrowserEdgeWithHistory` — *Action*
109. `openbrowserFireFox` — *Action*
110. `openbrowserFireFoxWithHistory` — *Action*
111. `openbrowserWithHistory` — *Action*
112. `PageRefresh` — *Action*
113. `ParentChildClick` — *Action*
114. `ParentChildStartWithClick` — *Action*
115. `Print` — *Action*
116. `quitBrowser` — *Action*
117. `refresh` — *Action*
118. `removeAlert` — *Action*
119. `ResetNetwork` — *Action*
120. `scrollBy` — *Action*
121. `scrollIntoView` — *Action*
122. `scrollTo` — *Action*
123. `scrollToElement` — *Action*
124. `scrollToElementAndClick` — *Action*
125. `selectdropdown` — *Action*
126. `selectdropdownByIndex` — *Action*
127. `selectdropdownByText` — *Action*
128. `selectdropdownByValue` — *Action*
129. `selectDropDownValue` — *Action*
130. `sendkeys` — *Action*
131. `sendkeysAndBlur` — *Action*
132. `sendkeysDown` — *Action*
133. `sendkeysEncrypt` — *Action*
134. `sendkeysEnter` — *Action*
135. `SendKeysRandomString` — *Action*
136. `sendkeysUp` — *Action*
137. `SetBaseWindowHandle` — *Action*
138. `SetDate` — *Action*
139. `SetDOMAttribute` — *Action*
140. `SetDomProperty` — *Action*
141. `SetImageText` — *Action*
142. `SetModuleNumber` — *Action*
143. `SetModuleText` — *Action*
144. `SetModuleTextFromJpath` — *Action*
145. `SetModuleTextValue` — *Action*
146. `SetPopUpParentWindow` — *Action*
147. `SetPreviousWebElement` — *Action*
148. `SetTestCaseText` — *Action*
149. `SetTestCaseTextValue` — *Action*
150. `SetTestStepText` — *Action*
151. `SetTestStepTextValue` — *Action*
152. `SetUrl` — *Action*
153. `SetWindowCount` — *Action*
154. `Shift` — *Action*
155. `sleep` — *Action*
156. `SpeakSelectedText` — *Action*
157. `StartNewBrowser` — *Action*
158. `SwitchBrowser` — *Action*
159. `switchTab` — *Action*
160. `SwitchToBaseWindow` — *Action*
161. `switchToDefaultFrame` — *Action*
162. `switchToFrame` — *Action*
163. `switchToFrameByIndex` — *Action*
164. `switchToIFrame` — *Action*
165. `switchToLastWindow` — *Action*
166. `switchToLastWindowAndClose` — *Action*
167. `switchToParentFrame` — *Action*
168. `SwitchToPopUpParentWindow` — *Action*
169. `SwitchToPopUpWindow` — *Action*
170. `switchToWindowByIndex` — *Action*
171. `takeScreenshot` — *Action*
172. `takingelementscreenshot` — *Action*
173. `takingscreenshot` — *Action*
174. `takingscreenshotappender` — *Action*
175. `takingscreenshotappenderwithPath` — *Action*
176. `ThrottleNetwork` — *Action*
177. `type` — *Action*
178. `typeAppend` — *Action*
179. `UseKeyboard` — *Action*
180. `UseMouse` — *Action*
181. `validatealertText` — *Action*
182. `validateAttribute` — *Action*
183. `validateContainsText` — *Action*
184. `ValidateContainsUrl` — *Action*
185. `ValidateCount` — *Action*
186. `validateCssValue` — *Action*
187. `validateDataText` — *Action*
188. `ValidateDateSorted` — *Action*
189. `validateDomAttribute` — *Action*
190. `validateDomProperty` — *Action*
191. `validatedropdownCount` — *Action*
192. `validatedropdownText` — *Action*
193. `validatedropdownValue` — *Action*
194. `validateEndsWithText` — *Action*
195. `validateIsChecked` — *Action*
196. `validateIsNotChecked` — *Action*
197. `validateJPath` — *Action*
198. `validateNotDuplicate` — *Action*
199. `validateNotMatchedText` — *Action*
200. `ValidateNumberSorted` — *Action*
201. `validateRegularExpression` — *Action*
202. `ValidateSorted` — *Action*
203. `validateStartsWithText` — *Action*
204. `validateText` — *Action*
205. `ValidateTextAndThrow` — *Action*
206. `validateTextLength` — *Action*
207. `validateTextWithoutSpace` — *Action*
208. `validateTitle` — *Action*
209. `ValidateUrl` — *Action*
210. `ValidateUrlAndThrow` — *Action*
211. `validateVisualBaseline` — *Action*
212. `VisualReportingDashboard` — *Feature*
213. `WindowDialogHandle` — *Action*
214. `WindowSize` — *Action*

---
*For full syntax rules, parameter mappings, and working code examples for each of these 214 actions, see [COMMANDS.md](COMMANDS.md).*
