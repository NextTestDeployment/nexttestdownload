# CampusFlow student registration sample

CampusFlow is a React and Node.js sample application for MindQA browser/API scenarios. It includes JWT login and role-aware student notes, classmate sharing, teacher review, and JSON-backed create/read/update/delete workflows.

## Start

Requires Node.js 18 or newer. From this directory:

```sh
npm install
npm start
```

`npm start` builds the React client, creates the initial fixture files when needed, then starts the Node.js API and web app at `http://127.0.0.1:3100`.

## Demo logins

All sample accounts use `CampusDemo!26`:

- Administrator: `admin@campus.test`
- Teacher: `teacher@campus.test`
- Student: `student1@campus.test` (students 1–30 have individual accounts)

## Initial data and reset

The app reads and writes `data/db.json`. `data/initial-data.json` is the pristine fixture. The student, course, teacher, subject, fee-payment, and study-note collections each contain 30 initial records. There are also an administrator, a teacher, and 30 student accounts.

Restore every JSON record from the command line with:

```sh
npm run reset-data
```

An administrator can also choose **Reset data** in the application header. All edits otherwise persist in `db.json` across restarts.

## NextTest automated scenarios

All scenarios are available in both **JSON (`.json`)** and **Excel (`.xlsx`)** in `scenarios/`:

- `01-admin-student-crud.json` — Add, edit, and delete a student registration.
- `02-fee-grid-search.json` — Find a fee receipt in the payment ledger.
- `03-student-notes-share-and-teacher-review.json` — Share a note, then submit teacher review.
- `04-jwt-api-and-protected-data.json` — Authenticate against the REST API and chain JWT Bearer token.
- `05-data-driven-campus-tables.json` — Data-driven iteration across student, course, and fee tables.
- `06-complete-actions-master-suite.json` — Comprehensive integration master suite (UI, API, dynamic !D->, |{Index}|, auth chaining).
- `13-desktop-notepad-calc-workflow.json` — Windows Notepad & Calculator cross-app workflow.
- `14-desktop-notepad-focus-timer.json` — Window focus monitoring, focus timers, and validation.
- `15-desktop-notepad-loop-logger.json` — Iterative loop logging with counter increments and text verification.
- `16-api-login-and-multi-tab-data.json` — Full REST API authentication and querying all 7 CampusFlow modules (Summary, Students, Courses, Teachers, Subjects, Fees, Notes).
- `17-scenario-with-api-testing.json` — Dual-format collection and automated test suite compatible with both the CLI runner and API Workbench.

## Security note

This is a local automation fixture, not a production server. The development JWT secret and demo passwords are public. Set `JWT_SECRET` and replace the seed credentials before exposing any instance to a network. JSON file persistence is intended for predictable local test data, not concurrent production writes.
