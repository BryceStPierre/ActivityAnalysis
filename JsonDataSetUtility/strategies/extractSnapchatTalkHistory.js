const fs = require('fs');

function extractSnapchatTalkHistory (inputPath, callback) {

    fs.readFile(inputPath, (err, data) => {
        if (err) throw err;

        let json = JSON.parse(data);
        let records = json['Chat Sessions'];

        let array = records.map(o => {
            return {
                'Date & Time': o['Date & Time'] ? new Date(o['Date & Time']).toISOString() : null,
                'People in Chat': o['People in Chat'] ? o['People in Chat'] : null,
                'City': o['City'] ? o['City'] : null,
                'Country': o['Country'] ? o['Country'] : null,
                'Length (sec)': o['Length (sec)'] ? o['Length (sec)'] : null,
                'Network': o['Network'] ? o['Network'] : null
            };
        });

        callback(array);
    });
}

module.exports = extractSnapchatTalkHistory;