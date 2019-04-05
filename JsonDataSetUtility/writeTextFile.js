const fs = require('fs');

function createTabSeparatedLine (array) {
    let line = '';
    for (let i = 0; i < array.length; i++) {
        if (i === array.length - 1)
            line += (array[i] ? array[i] : ' ') + '\r\n';
        else
            line += (array[i] ? array[i] : ' ') + '\t';
    }
    return line;
}

function writeTextFile (path, records) {
    if (records.length === 0)
        return -1;

    let data = '';
    let fieldNames = Object.keys(records[0]).map(f => f.toLowerCase());

    // Append header row.
    data += createTabSeparatedLine(fieldNames);

    // Append data rows.
    records.forEach((record, i) => {
        let dataValues = Object.values(record);
        data += createTabSeparatedLine(dataValues);
    });

    // Write file.
    fs.writeFileSync(path, data);

    return records.length;
}

module.exports = writeTextFile;
