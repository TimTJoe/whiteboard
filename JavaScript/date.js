const d = new Date();
const postFix = `d${d.getUTCFullYear().toString().padStart(4, `0`)}${(
    d.getUTCMonth() + 1
)
    .toString()
    .padStart(2, `0`)}${d.getUTCDate().toString().padStart(2, `0`)}t${d
        .getUTCHours()
        .toString()
        .padStart(2, `0`)}${d.getUTCMinutes().toString().padStart(2, `0`)}${d
            .getUTCSeconds()
            .toString()
            .padStart(2, `0`)}`
console.log(postFix)