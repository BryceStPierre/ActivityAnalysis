const fs = require('fs');

function extractInstagramLikes (inputPath, callback) {

    fs.readFile(inputPath, (err, data) => {
        if (err) throw err;

        let json = JSON.parse(data);
        let records1 = json['media_likes'];
        let records2 = json['comment_likes'];

        let array = [];
        records1.forEach(a => {
            array.push({
                date: a[0] ? a[0] : null,
                author: a[1] ? a[1] : null,
                type: 'Media'
            });
        });
        records2.forEach(a => {
            array.push({
                date: a[0] ? a[0] : null,
                author: a[1] ? a[1] : null,
                type: 'Comment'
            });
        });

        callback(array);
    });
}

module.exports = extractInstagramLikes;