'use strict';

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

let strategy = '';

switch (dataSetName) {
    case 'FacebookComments':
        strategy = './strategies/extractFacebookComments'; break;
    case 'FacebookExternalShares':
        strategy = './strategies/extractFacebookExternalShares'; break;
    case 'FacebookLikesReactions':
        strategy = './strategies/extractFacebookLikesReactions'; break;
    case 'FacebookLoginActivity':
        strategy = './strategies/extractFacebookLoginActivity'; break;
    case 'FacebookMessages':
        strategy = './strategies/extractFacebookMessages'; break;
    case 'FacebookPosts':
        strategy = './strategies/extractFacebookPosts'; break;
    case 'GoogleBrowserHistory':
        strategy = './strategies/extractGoogleBrowserHistory'; break;
    default:
        strategy = null; break;
}

require(strategy)(inputPath, (records) => {
    let result = writeTextFile(outputPath, records);

    if (result === -1)
        console.log('No records were extracted.\n');
    else
        console.log(`JSON data set processed: ${result} records extracted.\n`);

    if (DEBUG)
        exitPrompt();
    else
        process.exit(0);
});
