
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
        
        
        for _ in 0 ..< numOfCards {
            cards.append(Card(isVisible: false , isMatched: false , isClicked: false))
        }
        initiateCards()
        
    }
    
    
    private func initiateCards(){
        
        let uniqueNumbers: Set<Int>  = generateUniqueRandomNumbers(size: numOfCards/2, range: numOfCards)
        
        for i in uniqueNumbers {
            cards[i] = Card(isVisible: true , isMatched: false, isClicked: false)
        }
    }
    
    private func generateUniqueRandomNumbers(size: Int , range: Int) -> Set<Int> {
        
        var uniqueNumbers: Set<Int> = Set<Int>()
        
        while uniqueNumbers.count < size {
            
            uniqueNumbers.insert(Int.random(in: 0 ..< range ))
        }
        
        
        return uniqueNumbers
        
    }
    
    
    func matchCards()->Bool{
        
        return rulesSet.match(card1: chosenCardsTitles["1"]!, card2:chosenCardsTitles["2"]!, card3: chosenCardsTitles["3"]!)
        
        
    }
    
}

