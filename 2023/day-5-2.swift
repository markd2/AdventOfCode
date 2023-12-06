#!/usr/bin/swift sh
import Foundation
import RegexBuilder

//let inputFilename = "day-5-1-test.txt"
let inputFilename = "day-5-prod.txt"

// ----------
let input = try! String(contentsOfFile: inputFilename)
let lines = input.split(separator: "\n")
// ----------

// first line are the seeds

let seedsLine = lines[0].split(separator: ":")
let seedRanges: [Int] = seedsLine[1].split(separator: " ").map { Int(String($0))! }

class Map {
    struct SubMap {
        let destinationCategory: Int
        let sourceCategory: Int
        let rangeLength: Int

        func contains(_ value: Int) -> Bool {
            value >= sourceCategory && value <= sourceCategory + rangeLength
        }

        func convert(_ source: Int) -> Int {
            let delta = source - sourceCategory
            assert(delta >= 0 && delta <= rangeLength)
            return destinationCategory + delta
        }
    }

    var submaps: [SubMap] = []

    func append(_ submap: SubMap) {
        submaps.append(submap)
    }

    func convert(_ source: Int) -> Int {
        for submap in submaps {
            if submap.contains(source) {
                return submap.convert(source)
            }
        }
        return source
    }
}

var seedToSoilMap = Map()
var soilToFertilizerMap = Map()
var fertilizerToWaterMap = Map()
var waterToLightMap = Map()
var lightToTemperatureMap = Map()
var temperatureToHumidityMap = Map()
var humidityToLocationMap = Map()

var currentMap: Map = seedToSoilMap

for line in lines.dropFirst() {
    
    if line == "" { continue }
    switch line {
    case "seed-to-soil map:":
        currentMap = seedToSoilMap
        continue
    case "soil-to-fertilizer map:":
        currentMap = soilToFertilizerMap
        continue
    case "fertilizer-to-water map:":
        currentMap = fertilizerToWaterMap
        continue
    case "water-to-light map:":
        currentMap = waterToLightMap
        continue
    case "light-to-temperature map:":
        currentMap = lightToTemperatureMap
        continue
    case "temperature-to-humidity map:":
        currentMap = temperatureToHumidityMap
        continue
    case "humidity-to-location map:":
        currentMap = humidityToLocationMap
        continue
    default:
        break
    }
    
    let triple = line.split(separator: " ").map { Int($0)! }
    guard triple.count == 3 else {
        print("unexpected non-triple for \(line)")
        continue
    }
    
    let submap = Map.SubMap(destinationCategory: triple[0],
                            sourceCategory: triple[1],
                            rangeLength: triple[2])
    currentMap.append(submap)
}

var min = Int.max

for i in stride(from: 0, to: seedRanges.count, by: 2) {
    let low = seedRanges[i]
    let high = low + seedRanges[i + 1]
    print("stride \(high - low)")

    for seed in low ..< high {
        let soil = seedToSoilMap.convert(seed)
        let fert = soilToFertilizerMap.convert(soil)
        let water = fertilizerToWaterMap.convert(fert)
        let light = waterToLightMap.convert(water)
        let temperature = lightToTemperatureMap.convert(light)
        let humiditty = temperatureToHumidityMap.convert(temperature)
        let location = humidityToLocationMap.convert(humiditty)

        if location < min {
            print("ticking down to \(location)")
            min = location
        }
    }
}

NSLog("done with seeds")

print(min)
