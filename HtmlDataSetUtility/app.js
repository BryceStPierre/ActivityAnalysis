'use strict';

// Required packages.
const fs = require('fs');

// Custom packages.
const exitPrompt = require('./exitPrompt');
const writeTextFile = require('./writeTextFile');

const extractYouTubeSearchHistory = require('./strategies/extractYouTubeSearchHistory');
const extractYouTubeViewingHistory = require('./strategies/extractYouTubeViewingHistory');

// Constants.
const DEBUG = true;

// Main program.
if (process.argv.length < 5) { // First two arguments: node.exe, app.js.
    console.log('The input or output path argument(s) have not been provided...\n');

    if (DEBUG)
        exitPrompt();
    else
        process.exit(-1);
}

console.log('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~');
console.log(' Activity Analysis: HTML Data Set Utility ');
console.log('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n');

const dataSetName = process.argv[2];
const inputPath = process.argv[3];
const outputPath = process.argv[4];

console.log(`Data set name: ${dataSetName}`);
console.log(`Input path: ${inputPath}`);
console.log(`Output path: ${outputPath}\n`);

console.log('Extracting records from HTML data set...')

fs.readFile(inputPath, (err, data) => {
    if (err) throw err;

    let records;

    switch (dataSetName) {
        case 'YouTubeSearchHistory':
            records = extractYouTubeSearchHistory(data); break;
        case 'YouTubeViewingHistory':
            records = extractYouTubeViewingHistory(data); break;
        default:
            records = []; break;
    }

    let result = writeTextFile(outputPath, records);
    
    if (result === -1)
        console.log('No records were extracted.\n');
    else
        console.log(`HTML data set processed: ${result} records extracted.\n`);

    if (DEBUG)
        exitPrompt();
});
