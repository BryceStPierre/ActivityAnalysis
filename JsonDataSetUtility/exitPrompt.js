const readline = require('readline');

const rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout
});

function exitPrompt () {
    rl.question('Press any key to continue...', () => {
        rl.close();
        process.exit(0);
    });
}

module.exports = exitPrompt;