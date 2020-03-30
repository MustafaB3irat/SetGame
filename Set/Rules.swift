

import Foundation


enum SetRules : String,CaseIterable {//SET GAME DECK CONSISTS OF 81 UNIQUE CARD
    
    case OVAL_3_GREEN_FILLED , OVAL_2_GREEN_FILLED , OVAL_1_GREEN_FILLED , DIAMOND_3_GREEN_FILLED , DIAMOND_2_GREEN_FILLED , DIAMOND_1_GREEN_FILLED , SQUIGGLE_3_GREEN_FILLED , SQUIGGLE_2_GREEN_FILLED , SQUIGGLE_1_GREEN_FILLED
    
    case OVAL_3_GREEN_OPEN , OVAL_2_GREEN_OPEN , OVAL_1_GREEN_OPEN , DIAMOND_3_GREEN_OPEN , DIAMOND_2_GREEN_OPEN , DIAMOND_1_GREEN_OPEN , SQUIGGLE_3_GREEN_OPEN , SQUIGGLE_2_GREEN_OPEN , SQUIGGLE_1_GREEN_OPEN
    
    case OVAL_3_GREEN_SCRATCHED , OVAL_2_GREEN_SCRATCHED , OVAL_1_GREEN_SCRATCHED , DIAMOND_3_GREEN_SCRATCHED , DIAMOND_2_GREEN_SCRATCHED , DIAMOND_1_GREEN_SCRATCHED , SQUIGGLE_3_GREEN_SCRATCHED , SQUIGGLE_2_GREEN_SCRATCHED , SQUIGGLE_1_GREEN_SCRATCHED
    
    case SQUIGGLE_3_RED_FILLED , SQUIGGLE_2_RED_FILLED , SQUIGGLE_1_RED_FILLED , DIAMOND_3_RED_FILLED , DIAMOND_2_RED_FILLED , DIAMOND_1_RED_FILLED , OVAL_3_RED_FILLED , OVAL_2_RED_FILLED , OVAL_1_RED_FILLED
    
    case SQUIGGLE_3_RED_SCRATCHED , SQUIGGLE_2_RED_SCRATCHED , SQUIGGLE_1_RED_SCRATCHED , DIAMOND_3_RED_SCRATCHED , DIAMOND_2_RED_SCRATCHED , DIAMOND_1_RED_SCRATCHED , OVAL_3_RED_SCRATCHED , OVAL_2_RED_SCRATCHED , OVAL_1_RED_SCRATCHED
    
    case SQUIGGLE_3_RED_OPEN , SQUIGGLE_2_RED_OPEN , SQUIGGLE_1_RED_OPEN , DIAMOND_3_RED_OPEN , DIAMOND_2_RED_OPEN , DIAMOND_1_RED_OPEN , OVAL_3_RED_OPEN , OVAL_2_RED_OPEN , OVAL_1_RED_OPEN
    
    
    case OVAL_3_PURPLE_FILLED , OVAL_2_PURPLE_FILLED , OVAL_1_PURPLE_FILLED , DIAMOND_3_PURPLE_FILLED , DIAMOND_2_PURPLE_FILLED , DIAMOND_1_PURPLE_FILLED , SQUIGGLE_3_PURPLE_FILLED, SQUIGGLE_2_PURPLE_FILLED , SQUIGGLE_1_PURPLE_FILLED
    
    case OVAL_3_PURPLE_OPEN , OVAL_2_PURPLE_OPEN , OVAL_1_PURPLE_OPEN , DIAMOND_3_PURPLE_OPEN , DIAMOND_2_PURPLE_OPEN , DIAMOND_1_PURPLE_OPEN , SQUIGGLE_3_PURPLE_OPEN, SQUIGGLE_2_PURPLE_OPEN , SQUIGGLE_1_PURPLE_OPEN
    
    case OVAL_3_PURPLE_SCRATCHED , OVAL_2_PURPLE_SCRATCHED , OVAL_1_PURPLE_SCRATCHED , DIAMOND_3_PURPLE_SCRATCHED , DIAMOND_2_PURPLE_SCRATCHED , DIAMOND_1_PURPLE_SCRATCHED , SQUIGGLE_3_PURPLE_SCRATCHED, SQUIGGLE_2_PURPLE_SCRATCHED , SQUIGGLE_1_PURPLE_SCRATCHED
}


class Rules {
    
    static func match(card1: String , card2: String  , card3: String ) -> Bool {
        
        let card1Attributes = card1.split(separator: "_")
        let card2Attributes = card2.split(separator: "_")
        let card3Attributes = card3.split(separator: "_")
        
        let shapes = ["\(card1Attributes[0])" , "\(card2Attributes[0])", "\(card3Attributes[0])"]
        let numbers = ["\(card1Attributes[1])" , "\(card2Attributes[1])", "\(card3Attributes[1])"]
        let colors = ["\(card1Attributes[2])" , "\(card2Attributes[2])", "\(card3Attributes[2])"]
        
        
        return (shapes.allAreEqual() || shapes.allAreDifferent()) &&
            (numbers.allAreEqual() || numbers.allAreDifferent()) &&
            (colors.allAreEqual() || colors.allAreDifferent())
        
        
    }
}


extension Array where Element == String {
    
    func allAreEqual() -> Bool {
        
        var isEqual = true
        var previousElement: String? = self.first
        
        for element in self{
            
            if element == previousElement {
                isEqual = isEqual && true
                previousElement = element
            } else {
                isEqual = false
            }
        }
        return isEqual
    }
    
    
    func allAreDifferent() -> Bool {
        
        for elementIndex in 0 ..< self.count - 1 {
            
            for otherElementsIndicies in 0 ..< self.count - elementIndex - 1 {
                
                if self[otherElementsIndicies] == self[otherElementsIndicies + 1] {
                    return false
                }
            }
        }
        return true
    }
    
}
