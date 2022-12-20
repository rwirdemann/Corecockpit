//
//  Constants.swift
//  Fitnesscockpit
//
//  Created by Ralf Wirdemann on 18.12.22.
//

struct Constants {
    static let PHASES = ["Warmup", "Workout"]
    
    static let CORE = "Core"
    static let BACK = "Back"
    static let UPPER_BODY = "Upper Body"
    static let LOWER_BODY = "Lower Body"
    static let BODY_PARTS = [CORE, BACK, LOWER_BODY, UPPER_BODY]

    static let REPITITIONS_FIVE_FIVE = "5/5"
    static let REPITITIONS_TEN = "10"
    static let REPITITIONS_TEN_TEN = "10/10"
    static let REPITITIONS_TWELVE_TWELVE = "12/12"
    static let REPITITIONS_TWELVE = "12"

    static let REPITITIONS = [
        "5", REPITITIONS_FIVE_FIVE,
        "8", "8/8",
        REPITITIONS_TEN,
        REPITITIONS_TEN_TEN,
        REPITITIONS_TWELVE, REPITITIONS_TWELVE_TWELVE, "15"]
    
    
    static let RUBBER_NONE = "none"
    static let RUBBER_RED = "red"
    static let RUBBER_YELLOW = "yellow"
    static let RUBBER_RED_BLACK = "red / black"
    static let RUBBER_GREEN = "green"
    static let RUBBER = [RUBBER_NONE, RUBBER_YELLOW, RUBBER_RED, "blue",
                         RUBBER_GREEN, "black", RUBBER_RED_BLACK]
    
    
}
