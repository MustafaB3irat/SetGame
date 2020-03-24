

import Foundation


enum SetRules : String,CaseIterable {
    
    case OVAL_3_GREEN , OVAL_2_GREEN , OVAL_1_GREEN , DIAMOND_3_GREEN , DIAMOND_2_GREEN , DIAMOND_1_GREEN , SQUIGGLE_3_GREEN , SQUIGGLE_2_GREEN , SQUIGGLE_1_GREEN
    
    case SQUIGGLE_3_RED , SQUIGGLE_2_RED , SQUIGGLE_1_RED , DIAMOND_3_RED , DIAMOND_2_RED , DIAMOND_1_RED , OVAL_3_RED , OVAL_2_RED , OVAL_1_RED
    
    case OVAL_3_PURPLE , OVAL_2_PURPLE , OVAL_1_PURPLE , DIAMOND_3_PURPLE , DIAMOND_2_PURPLE , DIAMOND_1_PURPLE , SQUIGGLE_3_PURPLE, SQUIGGLE_2_PURPLE , SQUIGGLE_1_PURPLE
    
}



class Rules {
    
    
    func match(card1: String , card2: String  , card3: String ) -> Bool {
        
        
        let card1Attributes = card1.split(separator: "_")
        let card2Attributes = card2.split(separator: "_")
        let card3Attributes = card3.split(separator: "_")
        
        var aMatch : Bool = true
        
        for attr in 0 ..< 3 {
            
            
            if card1Attributes[attr] == card2Attributes[attr]  && card1Attributes[attr] == card3Attributes[attr] {
                attr < 1 ? ( aMatch = true) : (aMatch = aMatch && true)
            }else if (card1Attributes[attr] != card2Attributes[attr] && card1Attributes[attr] == card3Attributes[attr]) || (card1Attributes[attr] != card3Attributes[attr] && card1Attributes[attr] == card2Attributes[attr]) || (card1Attributes[attr] != card2Attributes[attr] && card2Attributes[attr] == card3Attributes[attr]){
                
                aMatch = false
                
            }else if (card1Attributes[attr] != card2Attributes[attr] && card2Attributes[attr] != card3Attributes[attr] && card1Attributes[attr] != card3Attributes[attr]){
                
                aMatch = aMatch && true
            }
        }
        
        return aMatch
        
        
    }
    
    
}
