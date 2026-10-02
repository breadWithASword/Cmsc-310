#include <iostream>
#include <string>
using namespace std;

class Greeting {
private:
    string greetingMessage;

public:
    Greeting(string message) {   
        greetingMessage = message;
    }

    void greet() {
    cout << greetingMessage << endl;
    }
};

int main() {
    Greeting msg("Hello World!");
    msg.greet();

    return 0;
}