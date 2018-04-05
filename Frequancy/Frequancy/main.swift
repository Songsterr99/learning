//
//  main.swift
//  Frequancy
//
//  Created by Veronichka Yastrebova on 4/4/18.
//  Copyright © 2018 Veronichka Yastrebova. All rights reserved.
//

import Foundation


func countWords(text: String) -> String {
    var words = [String]()
    var wordsDictionary = [String: Int]()
    words = text.components(separatedBy: " ")
    for word in words{
        if let amount = wordsDictionary[word] {
            wordsDictionary[word] = amount + 1
        }
        else {
            wordsDictionary[word] = 1
        }
    }
    var result:String = ""
    var i:Int = 0
    for (keyWord, valueWord) in wordsDictionary.sorted(by: { $0.value > $1.value }) {
        if i == 5 {
            break
        }
        else{
            i += 1
        }
        result += "\(keyWord): \(valueWord) "
    }
    return result
}

func printTest(input: String, test: String){
    let result:String = countWords(text: input)
    print("input:  " + input)
    print("\nresult: " + result)
    print("\ntest: " + test)
    if test == result{
        print("\nequal: yes")
    }
    else{
        print("\neqaul: no")
    }
    print("\n\n")
}

var input:String = "foo bar foo bar"
var test:String = "bar: 2 foo: 2 "
printTest(input: input, test: test)

input = "1 2 3 4 5 1 2 3 4 5 6 7 8 9"
test = "2: 2 1: 2 4: 2 3: 2 5: 2 "
printTest(input: input, test: test)

input = "Hello World"
test = "World: 1 Hello: 1 "
printTest(input: input, test: test)

input = "test record created"
test = "test: 1 record: 1 created: 1 "
printTest(input: input, test: test)



