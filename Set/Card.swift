
import Foundation

class Card {
    
     var isVisible: Bool
    
     var isMatched: Bool
    
    var isClicked:Bool
    
    init(isVisible: Bool , isMatched: Bool , isClicked: Bool){
        
        self.isVisible = isVisible
        self.isMatched = isMatched
        self.isClicked = isClicked
    }
    
    
    
}
