#!/usr/bin/swift sh
import Foundation
import RegexBuilder

//let inputFilename = "day-6-1-test.txt"
let inputFilename = "day-6-prod.txt"

// ----------
let input = try! String(contentsOfFile: inputFilename)
let lines = input.split(separator: "\n")
// ----------

