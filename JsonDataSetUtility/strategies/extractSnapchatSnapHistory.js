const fs = require('fs');

function extractSnapchatSnapHistory (inputPath, callback) {

    fs.readFile(inputPath, (err, data) => {
        if (err) throw err;

        let json = JSON.parse(data);
        let records1 = json['Received Snap History'];
        let records2 = json['Sent Snap History'];

        let array = [];
        records1.forEach(o => {
            array.push({
                'Created': o['Created'] ? new Date(o['Created']).toISOString() : null,
                'Contact': o['From'] ? o['From'] : null,
                'Media_Type': o['Media Type'] ? o['Media Type'] : null,
                'Direction': 'Received'
            });
        });
        records2.forEach(o => {
            array.push({
                'Created': o['Created'] ? new Date(o['Created']).toISOString() : null,
                'Contact': o['To'] ? o['To'] : null,
                'Media_Type': o['Media Type'] ? o['Media Type'] : null,
                'Direction': 'Sent'
            });
        });

        callback(array);
    });
}

module.exports = extractSnapchatSnapHistory;