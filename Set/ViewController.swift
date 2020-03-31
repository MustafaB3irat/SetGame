//
//  ViewController.swift
//  Set
//
//  Created by Asal Macbook 1 on 22/03/2020.
//  Copyright © 2020 Mustafa Birat. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet weak var playAgainBtn: UIButton!
  @IBOutlet weak var deal3CardsBtn: UIButton!
  @IBOutlet weak var scoreLabel: UILabel!
  @IBOutlet var cardsCollection: [UIButton]!
  @IBOutlet weak var feedbackLabel: UILabel!
  
  private var chosenCardsTitles: [String: String] = [String: String]()
  private var chosenCardsIndices: [Int: Int] = [Int: Int]()
  private lazy var setGenerator: SetGenerator = SetGenerator(numOfCards: 24)
  private var cards: [Card] = []
  private var numOfClickedCards: Int = 0
  private let DEFAULT_CARD_IMAGE = "default"
  private var score: Int = 0 {
    didSet{
      scoreLabel.text = "\(score)"
    }
  }
  private let rightGuessLabelAttrs: [NSAttributedString.Key: Any] = [
    .strokeWidth: 5,
    .strokeColor: UIColor.green,
  ]
  private let wrongGuessLabelAttrs: [NSAttributedString.Key: Any] = [
    .strokeWidth: 5,
    .strokeColor: UIColor.red,
  ]
  
  //lifcycle methods
  override func viewDidLoad() {
    super.viewDidLoad()
    cards = setGenerator.initiateCards()
    displayCards()
  }
  
  
  @IBAction func CardIsPressed(_ sender: UIButton) {
    
    let cardIndex = sender.tag
    
    //cards can be unselected since number of clicked cards is less than 3
    if numOfClickedCards < 3 {
      
      if !cards[cardIndex].isClicked {
        
        sender.layer.borderWidth = 4
        sender.layer.borderColor = #colorLiteral(red: 0.9872592135, green: 0.2078811415, blue: 0.05133768179, alpha: 1)
        checkCard(card: sender, clicked: true)
        
      } else {
        sender.layer.borderWidth = 0
        checkCard(card: sender, clicked: false)
      }
    }
  }
  
  @IBAction func Deal3MoreCardsButtonIsPressed(_ sender: UIButton) {
    
    //if there's enough room for cards the deal 3 cards butn is available otherwise it 's coverted for Play again btn
    deal3MoreCards()
  }
  
  @IBAction func PlayAgain(_ sender: UIButton) {
    
    score = 0
    refreshCards()
    setGenerator = SetGenerator(numOfCards: 24)
    cards = setGenerator.initiateCards()
    displayCards()
    numOfClickedCards = 0
    sender.isHidden = true
    deal3CardsBtn.isHidden = false
  }
  
  private func refreshCards() -> Void {
    
    for card in cardsCollection {
      card.layer.borderWidth = 0
    }
  }
  
  private func displayCards() -> Void {
    
    for i in 0 ..< setGenerator.numOfCards {
      
      if !cards[i].isVisible {
        
        cardsCollection[i].layer.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        cardsCollection[i].setImage(nil, for: .normal)
        cardsCollection[i].isEnabled = false
        
      } else {
        //display the content to the card ...
        cardsCollection[i].setImage(UIImage(named: cards[i].content ?? DEFAULT_CARD_IMAGE), for: .normal)
      }
    }
  }
  
  
  private func checkCard(card: UIButton , clicked: Bool) -> Void {
    
    let index = card.tag
    
    cards[index].isClicked = clicked
    
    if clicked {
      
      numOfClickedCards += 1
      
      // store the clicked cards title in a dictionary
      chosenCardsTitles["\(numOfClickedCards)"] = cards[index].content
      chosenCardsIndices[numOfClickedCards] = index
      
      //check for matching cards ....
      if numOfClickedCards == 3 {
        
        if matchCards() {
          
          // card is matched
          threeCardsAreSelected(isAMatch: true)
          // increment score
          score += 5
          
          showFeedback(message: "Great Work!", attributes: rightGuessLabelAttrs)
          //show 3 new cards if room is not full
          _  =  deal3MoreCards()
          
        } else {
          //clicked cards is a mismatch
          threeCardsAreSelected(isAMatch: false)
          
          //decrement score
          score -= 2
          showFeedback(message: "Oh No!", attributes: wrongGuessLabelAttrs)
        }
      }
    } else {
      numOfClickedCards -= 1
    }
  }
  
  
  private func showFeedback(message: String, attributes: [NSAttributedString.Key: Any] ) -> Void {
    
    //show a green stroke to score label
    scoreLabel.attributedText = NSAttributedString(string: scoreLabel.text ?? "Score: 0", attributes: attributes)
    //show a simple feedback to the player
    feedbackLabel.isHidden = false
    feedbackLabel.attributedText = NSAttributedString(string: message, attributes: attributes)
    DispatchQueue.main.asyncAfter(deadline: .now() + 2){
      self.feedbackLabel.isHidden = true
    }
  }
  
  
  private func updateCardUI( card: UIButton , isAMatch: Bool) -> Void {
    
    if isAMatch{
      card.layer.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
      card.setImage(nil, for: .normal)
      card.isEnabled = false
      cards[card.tag].isClickable = false
    }
    card.layer.borderWidth = 0
  }
  
  
  
  private func threeCardsAreSelected(isAMatch: Bool) -> Void {
    
    numOfClickedCards = 0
    
    for (key,index) in chosenCardsIndices {
      
      // if three cards are a match .... hide cards
      if isAMatch {
        
        updateCardUI(card: cardsCollection[index] ,isAMatch: true)
        cards[index].isClicked = false
        
      } else {
        //else deselct 2 older cards
        numOfClickedCards = 1
        if key < 3 {
          updateCardUI(card: cardsCollection[index] ,isAMatch: false)
          cards[index].isClicked = false
        } else {
          chosenCardsIndices[0] = chosenCardsIndices[key]
          chosenCardsTitles["1"] = chosenCardsTitles["3"]
        }
        
      }
    }
  }
  
  
  private func deal3MoreCards() -> Void {
    
    var numOfEnabledCards = 0
    let deal3Cards = setGenerator.generate3UniqueCards()
    let _3cards = deal3Cards.cards
    let numOfRemainingCards = deal3Cards.numOdRemainingCards
    var numOfCards = 0
    
    if numOfRemainingCards > 0 {
      for index in 0 ..< cardsCollection.count {
        
        if !cards[index].isClickable && !cardsCollection[index].isEnabled, numOfCards < 3{
          
          //we need 3 buttons that are disapled to turn them enabled and provide them with random image -card-
          cardsCollection[index].isEnabled = true
          cards[index].isClickable = true
          cardsCollection[index].layer.backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
          
          // connect the button with its mapped card
          cards[index].isClicked = false
          cards[index].isVisible = true
          
          if let cardContent = _3cards[numOfCards] {
            
            cardsCollection[index].setImage(UIImage(named: cardContent), for: .normal)
            cards[index].content = cardContent
            numOfCards += 1
          }
        }
        // to check that there's still room for more cards ,, otherwise hide deal btn and show play again one
        if !cardsCollection[index].isEnabled {
          numOfEnabledCards += 1
        }
      }
    } else {
      // set deck is Empty!!!
      alert(title: "Game is Over! Set Deck is Empty", message: "Your Score is \(score) would you like to play again?")
    }
    
    if numOfEnabledCards == 0 {
      deal3CardsBtn.isHidden = true
      playAgainBtn.isHidden = false
    }
  }
  
  
  private func matchCards() -> Bool {
    return Rules.match(card1: chosenCardsTitles["1"]!, card2:chosenCardsTitles["2"]!, card3: chosenCardsTitles["3"]!)
  }
  
  
  private func alert(title: String, message: String) -> Void {
    
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    
    alert.addAction(UIAlertAction(title: "Play Again!", style: .cancel, handler: { [weak self] action in
      if let weakSelf = self {
        weakSelf.PlayAgain(weakSelf.playAgainBtn)
      }
    }))
    
    self.present(alert, animated: true)
  }
}

