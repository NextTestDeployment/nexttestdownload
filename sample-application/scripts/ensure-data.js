const fs=require('node:fs');
const path=require('node:path');
const data=path.join(__dirname,'..','data');
if(!fs.existsSync(path.join(data,'initial-data.json'))||!fs.existsSync(path.join(data,'db.json'))){require('./create-initial-data');}
