const fs = require('fs');

function extractGoogleBrowserHistory (inputPath, callback) {

    fs.readFile(inputPath, (err, data) => {
        if (err) throw err;

        let json = JSON.parse(data);
        let records = json['Browser History'];

        let array = records.map(o => {
            return {
                title: o.title,
                url: o.url,
                date: new Date(o.time_usec / 1000.0).toISOString()
            };
        });
        
        callback(array);
    });
}

module.exports = extractGoogleBrowserHistory;
