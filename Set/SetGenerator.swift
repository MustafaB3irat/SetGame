
import Foundation

class SetGenerator{
    
    var cards: [Card]
    var numOfCards: Int
    var numOfClickedCards : Int = 0
    var rulesSet: Rules
    
    
    var chosenCardsTitles: [String:String] = [:]
    
    init( numOfCards: Int){
        
        self.rulesSet = Rules()
        self.numOfCards = numOfCards
        self.cards = [Card]()
        self.numOfClickedCards = 0
        
        
        initiateCards()
        
    }
    
    
    private func initiateCards(){
        
        
        for i in 0 ..< numOfCards {
            
            if i < 12{
                cards.append(Card(isVisible: false ,  isClicked: false))
                
            }else{
                cards.append(Card(isVisible: true ,isClicked: false))
            }
        }
        
        cards.shuffle()
    }
    
    func matchCards()->Bool{
        
        return rulesSet.match(card1: chosenCardsTitles["1"]!, card2:chosenCardsTitles["2"]!, card3: chosenCardsTitles["3"]!)
        
        
    }
    
}

