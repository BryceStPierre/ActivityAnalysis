const fs = require('fs');

function extractFacebookExternalShares (inputPath, callback) {

    fs.readFile(inputPath, (err, data) => {
        if (err) throw err;

        let json = JSON.parse(data);
        let records = json['app_posts'];

        let array = records.map(o => {
            let data = {};
            if (o.attachments) {
                if (o.attachments.length > 0) {
                    if (o.attachments[0].data) {
                        if (o.attachments[0].data.length > 0) {
                            data = o.attachments[0].data[0].external_context
                        }
                    }
                }
            }

            if (!data)
                data = {};
            
            return {
                timestamp: o.timestamp ? new Date(o.timestamp * 1000.0).toISOString() : null,
                title: o.title ? o.title : null,
                name: data.name ? encodeURI(data.name.replace('\r', '').replace('\n', '')).split('%20').join(' ') : null,
                url: data.url ? data.url : null
            };
        });

        callback(array);
    });
}

module.exports = extractFacebookExternalShares;