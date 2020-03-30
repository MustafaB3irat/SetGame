
import Foundation

struct SetGenerator{
    
    
    var numOfCards: Int
    var cardContents: [Int: String] = [:]
    
    init( numOfCards: Int){
        self.numOfCards = numOfCards
        initiateCardsContent()
    }
    
    mutating func initiateCardsContent() -> Void {
        
        var index = 0
        
        for content in SetRules.allCases {
            cardContents[index] = content.rawValue
            index += 1
        }
    }
    
    mutating func initiateCards() -> [Card] {
        
        var cards: [Card] = [Card]()
  
        for i in 0 ..< numOfCards {
            
            if i < numOfCards / 2 {
                cards.append(Card(isVisible: false ,
                                  isClicked: false ,
                                  isClickable:  false ,
                                  content: nil))
            } else {
                cards.append( Card(isVisible: true,
                                   isClicked: false,
                                   isClickable: true,
                                   content: generateUniqueCardContent()))
            }
        }
        cards.shuffle()
        
        return cards
    }
    
    
    mutating func generateUniqueCardContent() -> String? {
        
        //genereates unique, random card content
        let card = cardContents.randomElement()
        let content = card?.value
        
        cardContents.removeValue(forKey: card?.key ?? -1)
        
        return content
        
    }
    
    mutating func generate3UniqueCards() -> (cards: [String?], numOdRemainingCards: Int ){
        
        let numOfCards = 3
        var cards : [String?] = []
        
        //genereates unique, 3 random card content for deal 3 cards
        for _ in 0 ..< numOfCards {
            cards.append(cardContents.removeValue(forKey:(cardContents.randomElement()?.key ?? -1)))
        }
        return (cards, cardContents.count)
    }
}

