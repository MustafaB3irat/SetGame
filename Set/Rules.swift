import Foundation

class Rules {
  
  static func match(card1: String , card2: String  , card3: String ) -> Bool {
    
    let card1Attributes = card1.split(separator: "_")
    let card2Attributes = card2.split(separator: "_")
    let card3Attributes = card3.split(separator: "_")
    
    print(card1Attributes , card2Attributes , card3Attributes)
    
    var shapes = ["\(card1Attributes[0])" , "\(card2Attributes[0])", "\(card3Attributes[0])"]
    var numbers = ["\(card1Attributes[1])" , "\(card2Attributes[1])", "\(card3Attributes[1])"]
    var colors = ["\(card1Attributes[2])" , "\(card2Attributes[2])", "\(card3Attributes[2])"]
    var shadings = ["\(card1Attributes[3])" , "\(card2Attributes[3])", "\(card3Attributes[3])"]
    
    
    return (shapes.allAreEqual() || shapes.allAreDifferent()) &&
      (numbers.allAreEqual() || numbers.allAreDifferent()) &&
      (colors.allAreEqual() || colors.allAreDifferent()) &&
      (shadings.allAreEqual() || shadings.allAreDifferent())
    
    
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
        break
      }
    }
    return isEqual
  }
  
  
  mutating func allAreDifferent() -> Bool {
    
    for index in 0 ..< self.count {
      
      let element = self.remove(at: index)
      
      if self.contains(element) {
        return false
      } else {
        self.append(element)
      }
      
    }
    return true
  }
  
}
