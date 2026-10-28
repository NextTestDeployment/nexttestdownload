const fs = require('node:fs');
const path = require('node:path');
const data = path.join(__dirname, '..', 'data');
const initial = path.join(data, 'initial-data.json');
if (!fs.existsSync(initial)) {
  console.error('Initial data is missing. Run npm run seed:initial first.');
  process.exit(1);
}
const value = JSON.parse(fs.readFileSync(initial, 'utf8'));
const target = path.join(data, 'db.json');
const temp = target + '.tmp';
fs.writeFileSync(temp, JSON.stringify(value, null, 2));
fs.renameSync(temp, target);
console.log(`Restored initial data: ${value.students.length} students, ${value.courses.length} courses, ${value.teachers.length} teachers, ${value.subjects.length} subjects, ${value.feePayments.length} fees, ${value.notes.length} notes.`);
