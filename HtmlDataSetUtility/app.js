'use strict';

const fs = require('fs');
const readline = require('readline');
const cheerio = require('cheerio');

const DEBUG = true;

const rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout
});

// First two arguments are node.exe and app.js.
if (process.argv.length < 4) {
    console.log('The input or output path argument(s) have not been provided...\n');

    if (DEBUG) {
        rl.question('Press any key to continue...', (response) => {
            rl.close();
            process.exit(-1);
        });
    } else {
        process.exit(-1);
    }
}

const inputPath = process.argv[2];
const outputPath = process.argv[3];

console.log(process.argv.length);

console.log(`Input path: ${inputPath}`);
console.log(`Output path: ${outputPath}`);

fs.readFile()

console.log('HTML conversion complete.\n');

if (DEBUG) {
    rl.question('Press any key to continue...', (response) => {
        rl.close();
        process.exit(0);
    });
}
