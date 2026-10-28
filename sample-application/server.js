'use strict';
const express = require('express');
const fs = require('node:fs');
const path = require('node:path');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');

const app = express();
const port = Number(process.env.PORT || 3100);
const dataDir = path.join(__dirname, 'data');
const dbFile = path.join(dataDir, 'db.json');
const initialFile = path.join(dataDir, 'initial-data.json');
const resources = new Set(['students','courses','teachers','subjects','feePayments','notes']);
const prefixes = {students:'ST',courses:'CO',teachers:'TE',subjects:'SU',feePayments:'FP',notes:'NO'};
const jwtSecret = process.env.JWT_SECRET || 'mindqa-campus-demo-only-change-before-deploy';

function readData(file = dbFile) { return JSON.parse(fs.readFileSync(file, 'utf8')); }
function writeData(next) {
  const temp = dbFile + '.tmp';
  fs.writeFileSync(temp, JSON.stringify(next, null, 2));
  fs.renameSync(temp, dbFile);
  db = next;
}
let db = readData();
app.use(express.json({limit:'1mb'}));

function safeUser(user) { const {passwordHash, ...safe} = user; return safe; }
function auth(req,res,next) {
  const token=(req.headers.authorization||'').replace(/^Bearer\s+/i,'');
  if(!token)return res.status(401).json({error:'Sign in to continue.'});
  try { const claim=jwt.verify(token,jwtSecret); const user=db.users.find(x=>x.id===claim.sub); if(!user)return res.status(401).json({error:'Account is no longer available.'}); req.user=user;next(); }
  catch { return res.status(401).json({error:'Your session has expired. Sign in again.'}); }
}
function roles(...allowed) { return (req,res,next)=>allowed.includes(req.user.role)?next():res.status(403).json({error:'Your role cannot perform this action.'}); }
function nextId(resource) { const max=db[resource].reduce((n,x)=>Math.max(n,Number(String(x.id).match(/(\d+)$/)?.[1]||0)),0);return prefixes[resource]+String(max+1).padStart(3,'0'); }
function cleanShareList(input) {
  const emails=Array.isArray(input)?input:String(input||'').split(',').map(x=>x.trim()).filter(Boolean);
  const normalized=[...new Set(emails.map(x=>String(x).trim().toLowerCase()))];
  const unknown=normalized.filter(email=>!db.users.some(u=>u.email.toLowerCase()===email&&u.role==='STUDENT'));
  if(unknown.length)throw new Error(`Share only with registered student accounts. Unknown: ${unknown.join(', ')}`);
  return normalized;
}

app.get('/api/health',(_req,res)=>res.json({status:'ok',app:'CampusFlow Student Services',storage:'JSON'}));
app.post('/api/auth/login',async(req,res)=>{
  const email=String(req.body?.email||req.body?.username||'').trim().toLowerCase(), password=String(req.body?.password||'');
  const user=db.users.find(u=>u.email.toLowerCase()===email);
  if(!user||!await bcrypt.compare(password,user.passwordHash))return res.status(401).json({error:'Email or password is incorrect.'});
  const token=jwt.sign({sub:user.id,role:user.role},jwtSecret,{expiresIn:'8h'});
  return res.json({token,user:safeUser(user)});
});
app.get('/api/auth/me',auth,(req,res)=>res.json(safeUser(req.user)));
app.get('/api/summary',auth,(req,res)=>{
  const own=(rows,key)=>req.user.role==='STUDENT'?rows.filter(x=>x[key]===req.user.studentId):rows;
  const fees=own(db.feePayments,'studentId');
  const paid=fees.filter(x=>x.status==='Paid').reduce((sum,x)=>sum+Number(x.amount),0);
  const due=fees.filter(x=>x.status!=='Paid').reduce((sum,x)=>sum+Number(x.amount),0);
  const notes=req.user.role==='STUDENT'?db.notes.filter(x=>x.studentId===req.user.studentId||x.sharedWith.includes(req.user.email)):db.notes;
  res.json({students:req.user.role==='STUDENT'?1:db.students.length,courses:db.courses.length,teachers:db.teachers.length,subjects:db.subjects.length,fees:fees.length,paid,due,notes:notes.length,pendingReview:db.notes.filter(x=>x.status==='Submitted').length});
});

app.post('/api/admin/reset',auth,roles('ADMIN'),(_req,res)=>{
  try { const fresh=readData(initialFile);writeData(fresh);res.json({message:'Initial sample data restored.',counts:Object.fromEntries([...resources].map(k=>[k,fresh[k].length]))}); }
  catch(err){res.status(500).json({error:`Could not restore sample data: ${err.message}`});}
});

app.get('/api/:resource',auth,(req,res)=>{
  const {resource}=req.params;if(!resources.has(resource))return res.status(404).json({error:'Unknown data collection.'});
  let rows=[...db[resource]];
  if(resource==='notes'&&req.user.role==='STUDENT')rows=rows.filter(x=>x.studentId===req.user.studentId||x.sharedWith.includes(req.user.email));
  if(resource==='students'&&req.user.role==='STUDENT')rows=rows.filter(x=>x.id===req.user.studentId);
  if(resource==='feePayments'&&req.user.role==='STUDENT')rows=rows.filter(x=>x.studentId===req.user.studentId);
  const q=String(req.query.q||'').trim().toLowerCase();if(q)rows=rows.filter(x=>JSON.stringify(x).toLowerCase().includes(q));
  for(const field of ['status','courseId','subjectId','studentId','teacherId'])if(req.query[field])rows=rows.filter(x=>String(x[field])===String(req.query[field]));
  res.json(rows);
});

app.get('/api/:resource/:id',auth,(req,res)=>{
  const {resource,id}=req.params;if(!resources.has(resource))return res.status(404).json({error:'Unknown data collection.'});
  const row=db[resource].find(x=>x.id===id);if(!row)return res.status(404).json({error:'Record not found.'});
  if(resource==='notes'&&req.user.role==='STUDENT'&&row.studentId!==req.user.studentId&&!row.sharedWith.includes(req.user.email))return res.status(404).json({error:'Record not found.'});
  res.json(row);
});

app.post('/api/:resource',auth,(req,res)=>{
  const {resource}=req.params;if(!resources.has(resource))return res.status(404).json({error:'Unknown data collection.'});
  if(resource==='notes'){
    if(req.user.role==='STUDENT'&&req.body.studentId&&req.body.studentId!==req.user.studentId)return res.status(403).json({error:'Students can only create their own notes.'});
    if(!['ADMIN','TEACHER','STUDENT'].includes(req.user.role))return res.status(403).json({error:'Not allowed.'});
  }else if(resource==='feePayments') {if(!['ADMIN','TEACHER'].includes(req.user.role))return res.status(403).json({error:'Only staff can manage fees.'});}
  else if(req.user.role!=='ADMIN')return res.status(403).json({error:'Only administrators can manage this master list.'});
  try {
    const row={...req.body,id:nextId(resource)};delete row.passwordHash;
    if(resource==='notes'){
      if(req.user.role==='STUDENT')row.studentId=req.user.studentId;
      row.sharedWith=cleanShareList(row.sharedWith);row.status=row.status||'Draft';if(req.user.role==='STUDENT'&&row.status==='Reviewed')throw new Error('Only a teacher can mark a note as reviewed.');row.teacherId=row.teacherId||db.subjects.find(x=>x.id===row.subjectId)?.teacherId||'';row.updatedAt=new Date().toISOString();
    }
    validate(resource,row);db[resource].push(row);writeData(db);res.status(201).json(row);
  }catch(err){res.status(400).json({error:err.message});}
});

app.put('/api/:resource/:id',auth,(req,res)=>{
  const {resource,id}=req.params;if(!resources.has(resource))return res.status(404).json({error:'Unknown data collection.'});
  const index=db[resource].findIndex(x=>x.id===id);if(index<0)return res.status(404).json({error:'Record not found.'});
  const old=db[resource][index];
  if(resource==='notes'){
    if(req.user.role==='STUDENT'&&old.studentId!==req.user.studentId)return res.status(403).json({error:'You can only edit your own notes.'});
    if(req.user.role==='TEACHER'){
      if(!['Submitted','Reviewed'].includes(req.body.status))return res.status(403).json({error:'Teachers can update the review status and feedback.'});
      db.notes[index]={...old,status:req.body.status,feedback:String(req.body.feedback||''),reviewedBy:req.user.name,updatedAt:new Date().toISOString()};
      writeData(db);return res.json(db.notes[index]);
    }
    if(!['ADMIN','STUDENT'].includes(req.user.role))return res.status(403).json({error:'Not allowed.'});
  } else if(resource==='feePayments') {if(!['ADMIN','TEACHER'].includes(req.user.role))return res.status(403).json({error:'Only staff can manage fees.'});}
  else if(req.user.role!=='ADMIN')return res.status(403).json({error:'Only administrators can manage this master list.'});
  try {
    const row={...old,...req.body,id:old.id};delete row.passwordHash;
    if(resource==='notes'){if(req.user.role==='STUDENT'){row.studentId=old.studentId;if(row.status==='Reviewed')throw new Error('Only a teacher can mark a note as reviewed.');if(old.status==='Reviewed')row.status='Draft';row.feedback=old.feedback;row.reviewedBy=old.reviewedBy;}row.sharedWith=cleanShareList(row.sharedWith);row.updatedAt=new Date().toISOString();}
    validate(resource,row);db[resource][index]=row;writeData(db);res.json(row);
  }catch(err){res.status(400).json({error:err.message});}
});

app.delete('/api/:resource/:id',auth,(req,res)=>{
  const {resource,id}=req.params;if(!resources.has(resource))return res.status(404).json({error:'Unknown data collection.'});
  const index=db[resource].findIndex(x=>x.id===id);if(index<0)return res.status(404).json({error:'Record not found.'});
  const row=db[resource][index];
  if(resource==='notes'&&req.user.role==='STUDENT'&&row.studentId===req.user.studentId){}else if(req.user.role==='ADMIN'){}else if(resource==='feePayments'&&req.user.role==='TEACHER'){}else return res.status(403).json({error:'You cannot delete this record.'});
  db[resource].splice(index,1);writeData(db);res.json({message:'Record deleted.',id});
});

function validate(resource,row){
  const required={students:['studentNo','firstName','lastName','email','courseId'],courses:['code','name','level'],teachers:['employeeNo','name','email'],subjects:['code','name','courseId','teacherId'],feePayments:['receiptNo','studentId','amount','dueDate','status'],notes:['studentId','subjectId','title','content']};
  for(const field of required[resource]||[])if(row[field]===undefined||row[field]===null||String(row[field]).trim()==='')throw new Error(`${field} is required.`);
  if(resource==='notes'&&!['Draft','Submitted','Reviewed'].includes(row.status))throw new Error('Note status must be Draft, Submitted, or Reviewed.');
  if(resource==='notes'&&!db.students.some(x=>x.id===row.studentId))throw new Error('Select a registered student.');
  if(resource==='notes'&&!db.subjects.some(x=>x.id===row.subjectId))throw new Error('Select a subject.');
}

const dist=path.join(__dirname,'client','dist');
app.use(express.static(dist));
app.get('*',(req,res)=>{if(req.path.startsWith('/api/'))return res.status(404).json({error:'API route not found.'});res.sendFile(path.join(dist,'index.html'),err=>{if(err)res.status(503).send('Frontend is not built. Run npm start to build the React app.');});});
app.listen(port,process.env.HOST||'127.0.0.1',()=>console.log(`CampusFlow ready at http://127.0.0.1:${port} (JSON data store)`));
