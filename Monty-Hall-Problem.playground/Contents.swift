//: Playground - noun: a place where people can play

import UIKit

enum Strategy {
    case Change // 更改选择
    case Stay // 不更改选择
} // 选择策略


func play(strategy:Strategy,repeats:Int) -> Int {
    var wins = 0
    
    for _ in 0..<repeats {
        
        let car = Int(arc4random_uniform(3)) // 随机一个汽车所在的门的索引
        
        var playerChoice = Int(arc4random_uniform(3)) // 随机一个选择
        
        if strategy == Strategy.Change {
            
            if playerChoice == car {
                // 如果你第一次就选择到车，那么改变策略就没用了，因为注定你第二次选不到车
                var remainingDoors = [0,1,2]
                remainingDoors.removeAtIndex(playerChoice)
                playerChoice = remainingDoors[Int(arc4random_uniform(2))]
            } else {
                // 如果第一次选中的是羊，则被开启的门是另一只羊，如果你选择改变策略，则一定会选择到汽车
                playerChoice = car
            }
            
        }
        
        // 如果你最终选择的索引等于汽车所在的门的索引，则加上一次赢的次数
        if car == playerChoice {
            wins++
        }
    }
    
    return wins
}

var repeats = 100000

var winsStrategyChange = play(.Change, repeats: repeats)
var winsStrategyStay = play(.Stay, repeats: repeats)

var quoteStrategyChange = Double(winsStrategyChange) / Double(repeats)
var quoteStrategyStay = Double(winsStrategyStay) / Double(repeats)