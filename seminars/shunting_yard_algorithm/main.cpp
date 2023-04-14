#include <string>
#include <stack>
#include <sstream>

using namespace std;

class PolishToken {
public:
    virtual void Apply(stack<int>& stack) = 0;
    virtual string ToString() const = 0;
    virtual ~PolishToken() {}
};

enum TokenType { None, Number, Operator, OpeningBracket, ClosingBracket };
    
class Token {
public:
    virtual TokenType Type() const = 0;
    virtual ~Token() {}
};

class NumToken: public Token, public PolishToken {
    int val_;
public:
    TokenType Type() const {
        return Number;
    }

    NumToken(int val): val_(val) {}

    void Apply(stack<int>& stack) {
        stack.push(val_);
    }
    
    string ToString() const {
        stringstream ss;
        ss << val_ << " ";
        return ss.str();
    }
};

class BinaryPlusToken: public Token, public PolishToken {
public:
    TokenType Type() const {
        return Operator;
    }

    void Apply(stack<int>& stack) {
        int rhs = stack.top();
        stack.pop();
        int lhs = stack.top();
        stack.pop();
        int res = lhs + rhs;
        stack.push(res);
    }
    
    string ToString() const {
        return "+ ";
    }
};

class BinaryMinusToken: public Token, public PolishToken {
public:
    TokenType Type() const {
        return Operator;
    }

    void Apply(stack<int>& stack) {
        int rhs = stack.top();
        stack.pop();
        int lhs = stack.top();
        stack.pop();
        int res = lhs - rhs;
        stack.push(res);
    }
    
    string ToString() const { 
        return "- "; 
    }
};

class UnaryMinusToken: public Token, public PolishToken {
public:
    TokenType Type() const {
        return Operator;
    }

    void Apply(stack<int>& stack) {
        int val = stack.top();
        stack.pop();
        stack.push(-val);
    }
    
    string ToString() const {
        return "-";
    }
};

class OpeningBracketToken: public Token {
public:
    TokenType Type() const {
        return OpeningBracket;
    }
};

class ClosingBracketToken: public Token {
public:    
    TokenType Type() const {
        return ClosingBracket;
    }
};

template<typename Iterator>
int ReadNum(Iterator& it, Iterator endit) {
    int res = 0;
    do {
        res = res * 10 + (*it - '0');
        it++;
        if (*it == ' ') break;
        if (*it >= '0' && *it <= '9') continue;
        break;
    } while (it != endit);
    
    return res;
}

// Shunting_yard_algorithm
vector<PolishToken*> ToReversePolish(const vector<Token*>& tokens) {
    vector<PolishToken*> output;
    stack<Token*> st;

    for (Token* token: tokens) {
        switch (token->Type()) {
            case Number:
                output.push_back(dynamic_cast<PolishToken*>(token));
                break;
            case Operator:
                while (st.size() != 0 && st.top()->Type() == Operator) {
                    output.push_back(dynamic_cast<PolishToken*>(st.top()));
                    st.pop();
                }
                st.push(token);
                break;
            case OpeningBracket:
                st.push(token);
                break;
            case ClosingBracket:
                while (st.top()->Type() != OpeningBracket) {
                    // todo: empty stack check
                    output.push_back(dynamic_cast<PolishToken*>(st.top()));
                    st.pop();
                }
                // todo: empty stack check
                st.pop();
                break;
            default: 
                stringstream ss;
                ss << "Bad token " << token->Type();
                throw logic_error(ss.str());
        }
    }

    while (st.size() != 0) {
        if (st.top()->Type() == Operator) {
            output.push_back(dynamic_cast<PolishToken*>(st.top()));
            st.pop();
        } else {
            throw logic_error("Missed Brackets");
        }
    }

    return output;
}

vector<Token*> Tokenize(string s) {
    vector<Token*> tokens;

    bool is_binary = false;

    auto it = s.begin();
    while (it != s.end()) {
        Token* token;

        if (*it == ' ') {
            it++;
            continue; // skip empty space
        }
        
        if (*it >= '0' && *it <= '9') {
            int num = ReadNum(it, s.end());
            token = new NumToken(num);
            is_binary = true;
        } else if (*it == '+') {
            token = new BinaryPlusToken();
            it++;
        } else if (*it == '-') {
            if (is_binary) {
                token = new BinaryMinusToken();
            } else {
                token = new UnaryMinusToken();
            }
            it++;
        } else if (*it == '(') {
            token = new OpeningBracketToken();
            is_binary = false;   
            it++;
        } else if (*it == ')') {
            token = new ClosingBracketToken();
            is_binary = true;
            it++;
        } else {
            it++;
            continue;
        }

        tokens.push_back(token);
    }

    return tokens;
}

int EvalPolish(const vector<PolishToken*>& tokens) {
    stack<int> nums;

    for (const auto& token: tokens) {
        token->Apply(nums);
    }

    if (nums.size() == 0) {
        throw out_of_range("Empty polish stack");
    };
    return nums.top();
}

class Solution {
public:
    int calculate(string s) {
        auto tokens = Tokenize(s);
        auto sorted_tokens = ToReversePolish(tokens);
        // cout << "'";
        // for (auto token: sorted_tokens) {
        //     cout << token->ToString();
        // }
        // cout << "'";
        int res = EvalPolish(sorted_tokens);
        
        return res;
    }
};