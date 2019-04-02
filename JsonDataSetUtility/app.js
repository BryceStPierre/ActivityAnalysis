'use strict';

// Required packages.
const fs = require('fs');

// Custom packages.
const exitPrompt = require('./exitPrompt');
const writeTextFile = require('./writeTextFile');

// Constants.
const DEBUG = true;

// Main program.
if (process.argv.length < 5) { // First two arguments: node.exe, app.js.
    console.log('Required arguments: dataSetName, inputPath, outputPath.\n');

    if (DEBUG)
        exitPrompt();
    else
        process.exit(-1);
}

console.log('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~');
console.log(' Activity Analysis: JSON Data Set Utility ');
console.log('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n');

const dataSetName = process.argv[2];
const inputPath = process.argv[3];
const outputPath = process.argv[4];

console.log(`Data set name: ${dataSetName}`);
console.log(`Input path: ${inputPath}`);
console.log(`Output path: ${outputPath}\n`);

console.log('Extracting records from JSON data set...')

fs.readFile(inputPath, (err, data) => {
    if (err) throw err;

    let records;
    let json = JSON.parse(data);

    switch (dataSetName) {
        case 'GoogleBrowserHistory':
            records = require('./strategies/extractGoogleBrowserHistory')(json); break;
        default:
            records = []; break;
    }

    let result = writeTextFile(outputPath, records);

    if (result === -1)
        console.log('No records were extracted.\n');
    else
        console.log(`JSON data set processed: ${result} records extracted.\n`);

    if (DEBUG)
        exitPrompt();
    else
        process.exit(0);
})