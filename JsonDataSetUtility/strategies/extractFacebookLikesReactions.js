const fs = require('fs');

function extractFacebookLikesReactions (inputPath, callback) {

    fs.readFile(inputPath, (err, data) => {
        if (err) throw err;

        let json = JSON.parse(data);
        let records = json['reactions'];

        let array = records.map(o => {
            let data = {};
            if (o.data && o.data.length > 0)
                data = o.data[0].reaction;

            return {
                timestamp: o.timestamp ? new Date(o.timestamp * 1000.0).toISOString() : null,
                reaction: data.reaction ? data.reaction : null,
                author: data.actor ? data.actor : null,
                title: o.title ? o.title : null
            };
        });

        callback(array);
    });
}

module.exports = extractFacebookLikesReactions;