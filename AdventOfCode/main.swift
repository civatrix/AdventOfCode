//
//  main.swift
//  Advent of Code
//
//  Created by DanielJohns on 2022-11-08.
//

import Foundation
import AppKit

func run(_ day: Int) {
    let url = FileManager.default.homeDirectoryForCurrentUser
        .appendingPathComponent("Documents", isDirectory: true)
        .appendingPathComponent("AdventOfCode", isDirectory: true)
        .appendingPathComponent("Day\(day)", isDirectory: true)
        .appendingPathComponent("input", isDirectory: false)
    
    guard let input = try? String(contentsOf: url) else {
        debugPrint("Unable to find input for day \(day)")
        return
    }
    
    guard let dayClass = Bundle.main.classNamed("AdventOfCode.Day\(day)") as? Day.Type else {
        debugPrint("Unable to create Day class for \(day)")
        return
    }
    
    let day = dayClass.init()
    let result = day.run(input: input)
    print(result)
    NSPasteboard.general.setString(result, forType: .string)
}

if let day = Int(CommandLine.arguments.dropFirst().first ?? "") {
    run(day)
} else {
    debugPrint("Missing day argument")
}

