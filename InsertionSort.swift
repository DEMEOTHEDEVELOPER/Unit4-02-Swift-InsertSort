import Foundation
import Glibc
//
//  FileIO.swift
//
//  Created by Alex De Meo
//  Created on 2023/02/11
//  Version 1.0
//  Copyright (c) 2023 Alex De Meo. All rights reserved.
//
// This program calculates reverses a string

// creating constants and variables
var errorMessage = ""

// Defining the file paths
let inputFile = "input.txt"
let outputFile = "output.txt"
var outputData = ""


// opening the input file for reading
guard let input = FileHandle(forReadingAtPath: inputFile) else {
    print("Error: Cannot open input file.")
    exit(1)
}

// opening the output file for writing
guard let output = FileHandle(forWritingAtPath: outputFile) else {
    print("Error: Cannot open output file.")
    exit(1)
}

// Reading contents of input file
let inputData = input.readDataToEndOfFile()

// Converting data to a string
guard let inputString = String(data: inputData, encoding: .utf8) else {
    print("Error: Cannot convert data to string.")
    exit(1)
}

// Splitting string into separate lines
let lines = inputString.components(separatedBy: .newlines)

for line in lines{
    var continueProgram = true
    if (line.count == 0) {
        outputData = "ERROR: Empty line"
        output.write(outputData.data(using: .utf8)!)
    } else {
        var numbers = line.split(separator: " ").compactMap { Int($0) }
        let newNums = insertionSort(numbers)
        outputData = ""
        for num in newNums {
            outputData += "\(num)"
        }
        outputData += "\n"
        output.write(outputData.data(using: .utf8)!)
    }
    
}

func insertionSort(_ numbers: [Int]) -> [Int] {
    var tempArray = numbers
    // first loop is for how many times to go through the array
    for c1 in 1...tempArray.count - 1 {
        // setting the number that will be compared to everything else
        let number = tempArray[c1]
        // setting the second counter, this one is used to go down through
        // the array to compare numbers.
        var c2 = c1 - 1
        // This loop goes through the list and compares numbers until either
        // A - it is not bigger than the next number or B - it has hit i = 0
        while (c2 >= 0 && tempArray[c2] > number) {
            // moving the numbers up 1 index
            tempArray[c2 + 1] = tempArray[c2]
            c2 -= 1
        }
        // resetting the number for comparison
        tempArray[c2 + 1] = number
    }
    return tempArray
}