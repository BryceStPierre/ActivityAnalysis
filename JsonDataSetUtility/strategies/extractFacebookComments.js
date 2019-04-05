const fs = require('fs');

function extractFacebookComments (inputPath, callback) {

    fs.readFile(inputPath, (err, data) => {
        if (err) throw err;
        
        let json = JSON.parse(data);
        let records = json['comments'];

        let array = records.map(o => {
            let data = {};
            if (o.data.length > 0)
                data = o.data[0].comment;
            
            return {
                timestamp: o.timestamp ? new Date(o.timestamp * 1000.0).toISOString() : null,
                title: o.title ? o.title : null,
                author: data.author ? data.author : null,
                comment: data.comment ? encodeURI(data.comment.replace('\r', '').replace('\n', '')).split('%20').join(' ') : null
            };
        });

        callback(array);
    });
}

module.exports = extractFacebookComments;