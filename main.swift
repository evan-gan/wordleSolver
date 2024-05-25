//
//  main.swift
//  wordleSolverV2
//
//  Created by Evan Gan on 1/20/24.
//

import Foundation

var searcher = wordleSearch()
searcher.printList(searcher.filterWords(wordLength: 5, includes: "asth", excludes: "girelouy", includesSpecific: ["","","a","s",""], excludesSpecific: ["","h","","t","t"]))

class wordleSearch {
    static let words = fileParser.parse("Words_ranked.txt")

    func printList(_ words: [word]) {
        print("Number of results: \(words.count)")
        var itemToPrint = ""
        for item in words {
            itemToPrint.append("\(item.word) Value:\(item.value) Repeats:\(item.repeats) Vowels:\(item.vowels) Weight:\(item.weight)\n")
        }
        print(itemToPrint)
    }
    
    func filterWords(wordLength:Int,includes:String,excludes:String,includesSpecific:[String],excludesSpecific:[String]) -> [word] {
        //check input
        guard (includesSpecific.count == wordLength || excludesSpecific.count == wordLength) else {fatalError("Not all arguments for excludes and includes spisifc given")}
        print("sorting...")
        let output = wordleSearch.words
            .filter{return $0.word.count == wordLength}
            .filter{return Set($0.word.map{String($0)}).isDisjoint(with: excludes.map{String($0)})}
            .filter{return includes == "" ? true : Set($0.word.map{String($0)}).isSuperset(of: includes.map{String($0)})}
            .filter{
                for (index, letter) in $0.word.enumerated() {
                    if ((includesSpecific[index].contains(letter) ? false : includesSpecific[index] != "") || excludesSpecific[index].contains(letter)) {
                        return false
                    }
                }
                return true
            }
        
        return sortWords(output)
    }
    func sortWords(_ words:[word]) -> [word] {
        return words.sorted{
            if ($0.vowels != $1.vowels) {
                return $0.vowels > $1.vowels
            } else if ($0.repeats != $1.repeats) {
                return $0.repeats < $1.repeats
            } else {
                return ($0.value+$0.weight)/2 > ($1.value+$1.weight)/2
            }
        }
    }
}

class fileParser {
    static let weights:[String:Int] = [
        "e": 12000, "f": 2500,
        "t": 9000, "w": 2000, "y": 2000,
        "a": 8000, "i": 8000, "n": 8000, "o": 8000, "s": 8000,
        "g": 1700, "p": 1700,
        "h": 6400,
        "b": 1600,
        "r": 6200,
        "v": 1200,
        "d": 4400,
        "k": 800,
        "l": 4000,
        "q": 500,
        "u": 3400,
        "j": 400, "x": 400,
        "c": 3000, "m": 3000,
        "z": 200
    ]
    
    static func parse(_ filename:String) -> [word] {
        return fileParser.parseFile(fileContents: fileParser.readFile(filename: filename))
    }
    
    private static func parseFile(fileContents:String) -> [word] {
        return fileContents.split(separator: "\n").map{
            let wordAndValue = String($0).split(separator: "\u{0009}")
            return word(word: String(wordAndValue[0]),
                        value: Int(wordAndValue[1]) ?? 0,
                        repeats: wordAndValue[0].count - Set(wordAndValue[0].map{String($0)}).count,
                        vowels: Set(wordAndValue[0].filter("aeiou".contains).map{String($0)}).count,
                        weight: wordAndValue[0].map{String($0)}.reduce(0, {$0 + (weights[$1] ?? 0)*8})*376
            )
        }
    }
    
    private static func readFile(filename:String) -> String {
        let basePath = "REPLACE WITH DIRECTORY"
        do{
            return try String(contentsOfFile:basePath+filename)
        } catch {
            fatalError("File not found, did you include the extention? (ex: .txt) The directory you are accessing is: \(basePath)")
        }
    }
}

struct word {
    let word: String
    let value: Int
    let repeats: Int
    let vowels: Int
    let weight: Int
}
