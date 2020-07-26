// 卸载插件时会node运行此文件
const fs = require('fs');
const path = require('path');

let androidPath = path.resolve(process.cwd(), 'platforms/android/eeuiApp');
let to = path.resolve(androidPath, 'app/src/main/res/drawable');

let f1 = path.resolve(to, 'push.png');
let f2 = path.resolve(to, 'push_small.png');
fs.existsSync(f1) && fs.unlinkSync(f1);
fs.existsSync(f2) && fs.unlinkSync(f2);