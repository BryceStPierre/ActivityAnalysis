const fs = require('fs');

function extractFacebookLoginActivity (inputPath, callback) {

    fs.readFile(inputPath, (err, data) => {
        if (err) throw err;

        let json = JSON.parse(data);
        let records = json['account_accesses'];

        let array = records.map(o => {
            return {
                timestamp: o.timestamp ? new Date(o.timestamp * 1000.0).toISOString() : null,
                action: o.action ? o.action : null,
                site: o.site ? o.site : null,
                ip_address: o.ip_address ? o.ip_address : null
            };
        });

        callback(array);
    });
}

module.exports = extractFacebookLoginActivity;