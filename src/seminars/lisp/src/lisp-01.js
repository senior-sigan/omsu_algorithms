const EOF = '';

class Reader {
  constructor (text) {
    this.text = text;
    this.idx = 0;
  }

  next () {
    this.idx += 1;
  }

  peek () {
    if (this.idx >= this.text.length) {
      return ''; // EOF
    }
    return this.text[this.idx];
  }

  empty () {
    return this.idx >= this.text.length;
  }
}

function skipLine (reader) {
  while (true) {
    const char = reader.peek();
    if (char === EOF || char === '\n' || char === '\r') return;
    reader.next();
  }
}

function isNum (char) {
  return char === '0' ||
    char === '1' ||
    char === '2' ||
    char === '3' ||
    char === '4' ||
    char === '5' ||
    char === '6' ||
    char === '7' ||
    char === '8' ||
    char === '9';
}

function isSpace (char) {
  return char === '\n' ||
    char === '\r' ||
    char === ' ' ||
    char === '\t' ||
    char === EOF;
}

function readNumber (reader) {
  let num = 0;
  while (true) {
    const char = reader.peek();
    if (isSpace(char) || char === ')') {
      return num;
    }
    if (char === '.') {
      // TODO: read as float
      reader.next();
      continue;
    }
    if (isNum(char)) {
      reader.next();
      num = num * 10 + parseInt(char);
      continue;
    }

    return 'NaN';
  }
}

function readList (reader) {
  // (1 2 3 4) - это список
  // только ( уже считали

  /**
   * Пока не встретили )
   * надо читать выражения
   * и складывать их в массив
   */
  reader.next(); // считать (

  const list = [];
  while (true) {
    const ast = readExpr(reader);
    if (ast === ')') {
      return list;
    }
    if (ast === null) {
      console.warn('unclosed (');
      return null;
    }
    list.push(ast);
  }
}

function readExpr (reader) {
  while (true) {
    const char = reader.peek();
    switch (char) {
      case EOF: {
        return null;
      }
      case ' ':
      case '\t': {
        reader.next();
        break;
      }
      case '\n':
      case '\r': {
        // TODO: increment line index
        reader.next();
        break;
      }
      case ';': {
        skipLine(reader);
        reader.next();
        break;
      }
      case '(': {
        return readList(reader);
      }
      case ')': {
        return ')';
      }
      case '0':
      case '1':
      case '2':
      case '3':
      case '4':
      case '5':
      case '6':
      case '7':
      case '8':
      case '9': {
        return readNumber(reader);
      }
      default:
        console.log(`UNKNOWN TOKEN: "${char}"`);
        reader.next();
        break;
    }
  }
}

function READ (text) {
  const reader = new Reader(text);
  const ast = readExpr(reader);
  // В конце работы reader должены быть вычитан весь
  // console.log(reader.empty());
  return ast;
}

function EVAL (ast) {
  return ast;
}

function PRINT (result) {
  console.log('RESULT:', result);
}

const text = `
(42 13)
;(+ 12  (* 4 8))
; this is comment
;(+ 1 3)
`;

PRINT(EVAL(READ(text)));
