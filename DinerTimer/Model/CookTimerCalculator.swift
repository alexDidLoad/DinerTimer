//
//  CookTimerCalculator.swift
//  DinerTimer
//
//  Created by Alexander Ha on 12/20/20.
//

import UIKit

struct CookTimeCalculator {
    
    var cookTime = 0.0
    
    public mutating func calculateCookTime(for item: String, method: String, doneness: String) -> Double {
        if item == egg {
            calculateEggs(method: method, doneness: doneness)
        } else if item == bacon {
            calculateBacon(method: method, doneness: doneness)
        } else if item == pancake {
            calculatePancakes(method: method, doneness: doneness)
        } else {
            calculateHashbrowns(method: method, doneness: doneness)
        }
        return cookTime
    }
    //MARK: - Helpers
    
    private mutating func calculateEggs(method: String, doneness: String) {
        switch method {
        case pan:
            switch doneness {
            case sunnyside:
                cookTime = 480
            case overEasy:
                cookTime = 300
            case overMedium:
                cookTime = 360
            default:
                cookTime = 540
            }
        default:
            switch doneness {
            case softBoil:
                cookTime = 360
            case mediumBoil:
                cookTime = 480
            default:
                cookTime = 720
            }
        }
    }
    
    private mutating func calculateBacon(method: String, doneness: String) {
        switch method {
        case pan:
            switch doneness {
            case chewy:
                cookTime = 480
            case crispy:
                cookTime = 600
            default:
                cookTime = 720
            }
        default:
            switch doneness {
            case chewy:
                cookTime = 600
            case crispy:
                cookTime = 780
            default:
                cookTime = 900
            }
        }
    }
    
    private mutating func calculatePancakes(method: String, doneness: String) {
        switch method {
        case pan:
            switch doneness {
            case light:
                cookTime = 120
            case brown:
                cookTime = 180
            default:
                cookTime = 240
            }
        default:
            switch doneness {
            case light:
                cookTime = 300
            case brown:
                cookTime = 360
            default:
                cookTime = 420
            }
        }
    }
    
    private mutating func calculateHashbrowns(method: String, doneness: String) {
        switch method {
        case pan:
            switch doneness {
            case light:
                cookTime = 240
            case crispy:
                cookTime = 360
            default:
                cookTime = 420
            }
        default:
            switch doneness {
            case light:
                cookTime = 1200
            case crispy:
                cookTime = 1620
            default:
                cookTime = 1800
            }
        }
    }
}

