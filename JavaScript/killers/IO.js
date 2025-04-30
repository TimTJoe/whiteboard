const callback = (entries) => {
  entries.forEach((entry) => {
    if(entry.isIntersecting) {
      alert(`${entry.target.id} is visible`)
    }
  });
}

const options = {
  threshold: 1.0
}

const observer = new IntersectionObserver(callback, options);
const one = document.getElementById("#one");
const two = document.getElementById("#two");

observer.observe(one);
observer.observe(two);