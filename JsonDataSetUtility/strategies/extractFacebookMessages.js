const fs = require('fs');
const path = require('path');

function isDirectory (p) {
    return fs.lstatSync(p).isDirectory();
}

function extractFacebookMessages (inputPath, callback) {
    
    let paths = fs.readdirSync(inputPath)
        .map(directory => path.join(inputPath, directory))
        .filter(isDirectory)
        .map(directory => path.join(directory, 'message.json'));

    let array = [];

    paths.forEach(p => {
        let data = fs.readFileSync(p);
        let json = JSON.parse(data);

        let records = json['messages'];
        records.forEach(o => {
            array.push({
                timestamp: o.timestamp_ms ? new Date(o.timestamp_ms).toISOString() : null,
                sender_name: o.sender_name ? o.sender_name : null,
                content: o.content ? encodeURI(o.content.replace('\r', '').replace('\n', '')).split('%20').join(' ') : null,
                link: o.share ? o.share.link : null,
                type: o.type ? o.type : null
            });
        });

        console.log(`Extracted: ${p}`);
    });
    
    callback(array);
}

module.exports = extractFacebookMessages;