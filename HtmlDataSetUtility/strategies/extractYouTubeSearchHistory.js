const cheerio = require('cheerio');

function extractYouTubeSearchHistory (data) {
    let array = [];
    const $ = cheerio.load(data);

    $('.content-cell.mdl-cell.mdl-cell--6-col.mdl-typography--body-1').filter((i, e) => {
        return !$(e).hasClass('mdl-typography--text-right');
    }).each((i, e) => {
        let html = $(e).html();

        let $s = cheerio.load(html);

        let query = $s('a').text();
        let dateRaw = html.split('<br>')[1];
        let date = new Date(dateRaw.trim()).toISOString();

        array.push({ query, date });
    });

    return array;
}

module.exports = extractYouTubeSearchHistory;