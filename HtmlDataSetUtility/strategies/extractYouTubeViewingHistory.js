const cheerio = require('cheerio');

function extractYouTubeViewingHistory (data) {
    let array = [];
    const $ = cheerio.load(data);

    $('.content-cell.mdl-cell.mdl-cell--6-col.mdl-typography--body-1').filter((i, e) => {
        return !$(e).hasClass('mdl-typography--text-right');
    }).each((i, e) => {
        let html = $(e).html();

        let parts = html.split('<br>');

        let $t = cheerio.load(parts[0]);
        let title = $t('a').text();

        let $c = cheerio.load(parts[1]);
        let channel = $c('a').text();

        let date = parts[2] ? new Date(parts[2].trim()).toISOString() : '';

        array.push({ title, channel, date });
    });

    return array;
}

module.exports = extractYouTubeViewingHistory;