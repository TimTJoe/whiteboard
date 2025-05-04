function findEven(p_numbers = []) {
    if (!Array.isArray(p_numbers)) new Error("Parameter must be array");
    let numbers = [];
    for (let n = 0; n < p_numbers.length; n++) {
        if (n % 2 === 0) numbers.push(p_numbers[n]);
    }
    return numbers;
}

let arr = [1, 2, 3, 4, 5, 6, 7, 8, 9, 0];

console.log(findEven(arr))