const fs = require('fs');

function extractInstagramPosts (inputPath, callback) {

    fs.readFile(inputPath, (err, data) => {
        if (err) throw err;

        let json = JSON.parse(data);
        let records1 = json['photos'];
        let records2 = json['videos'];

        let array = [];
        records1.forEach(o => {
            array.push({
                taken_at: o.taken_at ? o.taken_at : null,
                caption: o.caption ? o.caption.split('\n').join('') : null,
                location: o.location ? o.location : null,
                type: 'photo'
            });
        });
        records2.forEach(o => {
            array.push({
                taken_at: o.taken_at ? o.taken_at : null,
                caption: o.caption ? o.caption.split('\n').join('') : null,
                location: o.location ? o.location : null,
                type: 'video'
            });
        });

        callback(array);
    });
}

module.exports = extractInstagramPosts;