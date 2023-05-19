import {reader} from "./reader";

function foo(a: number) {
  console.log(a + 4);
}

const a = 42;

foo(a);

console.log(reader('test'));