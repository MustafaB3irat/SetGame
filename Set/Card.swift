
import Foundation

struct Card {
    
    var isVisible: Bool
    var isClicked: Bool
    var isClickable: Bool
    var content: String?
    
    init(isVisible: Bool, isClicked: Bool, isClickable: Bool, content: String? ){
        
        self.isVisible = isVisible
        self.isClicked = isClicked
        self.isClickable = isClickable
        self.content = content
    }
    
    
    
}
