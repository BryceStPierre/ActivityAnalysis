function extractGoogleBrowserHistory (data) {
    let records = data['Browser History'];

    let array = records.map(o => {
        return {
            title: o.title,
            url: o.url,
            date: new Date(o.time_usec / 1000.0).toISOString()
        };
    });

    return array;
}

module.exports = extractGoogleBrowserHistory;