const fs = require('fs');

function extractFacebookPosts (inputPath, callback) {

    fs.readFile(inputPath, (err, data) => {
        if (err) throw err;

        let json = JSON.parse(data);
        let records = json['status_updates'];

        let array = records.map(o => {

            let place = null;
            let post = null;
            let url = null;

            if (o.data && o.data.length > 0) {
                o.data.forEach(d => {
                    if (d.post)
                        post = d.post;
                });
            }

            if (o.attachments && o.attachments.length > 0) {
                o.attachments.forEach(a => {
                    if (a.data && a.data.length > 0) {
                        a.data.forEach(d => {
                            if (d.external_context)
                                url = d.external_context.url;
                            if (d.media)
                                post = d.media.description;
                            if (d.place)
                                place = d.place.name;
                        });
                    }
                });
            }
            
            return {
                timestamp: o.timestamp ? new Date(o.timestamp * 1000.0).toISOString() : null,
                title: o.title ? o.title : null,
                post: post ? encodeURI(post.replace('\r', '').replace('\n', '')).split('%20').join(' ') : null,
                url: url,
                place: place
            };
        });

        callback(array);
    });
}

module.exports = extractFacebookPosts;