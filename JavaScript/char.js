const text = 'abcdefghijklmnopqrstuvwxyz'
console.log(text[0])

function ceaser(text) {
  for (let i = 0; i < text.length; i++) {
    text[i] = text[i]+3;
    if (text[i] > 'z') {
      text[i] = text[i] - 'z' + 'a' - 1;
    }
  }
  console.log(text)
}

ceaser("erd")

text.substring()