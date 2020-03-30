//
//  ViewController.swift
//  Set
//
//  Created by Asal Macbook 1 on 22/03/2020.
//  Copyright © 2020 Mustafa Birat. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    var cards: [Card] = [Card]()
    var chosenCardsTitles: [String: String] = [String: String]()
    var chosenCardsIndices: [Int: Int] = [Int: Int]()
    var setGenerator: SetGenerator = SetGenerator(numOfCards: 24)
    var numOfClickedCards: Int = 0
    var score: Int = 0 {
        didSet{
            scoreLabel.text = "\(score)"
        }
    }
    
    let rightGuessLabelAttrs: [NSAttributedString.Key: Any] = [
        .strokeWidth: 5,
        .strokeColor: UIColor.green,
    ]
    let wrongGuessLabelAttrs: [NSAttributedString.Key: Any] = [
        .strokeWidth: 5,
        .strokeColor: UIColor.red,
    ]
    
    
    @IBOutlet weak var PlayAgainBtn: UIButton!
    @IBOutlet weak var Deal3CardsBtn: UIButton!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var CardsCollection: [UIButton]!
    @IBOutlet weak var FeedbackLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cards = setGenerator.initiateCards()
        displayCards()
    }
    
    @IBAction func CardIsPressed(_ sender: UIButton) {
        
        let cardIndex = sender.tag
        
        print(cards[cardIndex].content ?? "default")
        
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
        setGenerator = SetGenerator(numOfCards: 24)
        cards = setGenerator.initiateCards()
        displayCards()
        sender.isHidden = true
        Deal3CardsBtn.isHidden = false
        
        
    }
    
    private func displayCards() -> Void {
        
        
        for i in 0 ..< setGenerator.numOfCards {
            
            if !cards[i].isVisible {
                
                CardsCollection[i].layer.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                CardsCollection[i].setImage(nil, for: .normal)
                CardsCollection[i].isEnabled = false
            } else {
                //display the content to the card ...
                CardsCollection[i].setImage(UIImage(named: cards[i].content ?? "default"), for: .normal)
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
                    //show a green stroke to score label
                    scoreLabel.attributedText = NSAttributedString(string: scoreLabel.text ?? "Score: 0", attributes: rightGuessLabelAttrs)
                    //show a simple feedback to the player
                    FeedbackLabel.isHidden = false
                    FeedbackLabel.attributedText = NSAttributedString(string: "Great Work!", attributes: rightGuessLabelAttrs)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                        self.FeedbackLabel.isHidden = true
                    }
                    //show 3 new cards if room is not full
                    _  =  deal3MoreCards()
                    
                } else {
                    //clicked cards is a mismatch
                    threeCardsAreSelected(isAMatch: false)
                    
                    //decrement score
                    score -= 2
                    //show a red stroke to socre label
                    scoreLabel.attributedText = NSAttributedString(string: scoreLabel.text ?? "Score: 0", attributes: wrongGuessLabelAttrs)
                    //show a simple feedback to the player
                    FeedbackLabel.isHidden = false
                    FeedbackLabel.attributedText = NSAttributedString(string: "Oh No!", attributes: wrongGuessLabelAttrs)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                        self.FeedbackLabel.isHidden = true
                    }
                }
            }
        } else {
            numOfClickedCards -= 1
        }
    }
    
    
    
    private func cardIsAMatch( card: UIButton , isAMatch: Bool) -> Void {
        
        if isAMatch{
            card.layer.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            card.setImage(nil, for: .normal)
            card.isEnabled = false
        }
        card.layer.borderWidth = 0
    }
    
    
    
    private func threeCardsAreSelected(isAMatch: Bool) -> Void {
        
        numOfClickedCards = 0
        
        for (key,index) in chosenCardsIndices {
            
            // if three cards are a match .... hide cards
            if isAMatch {
                
                cardIsAMatch(card: CardsCollection[index] ,isAMatch: true)
                cards[index].isClicked = false
                
            } else {
                //else deselct 2 older cards
                numOfClickedCards = 1
                if key < 3 {
                    cardIsAMatch(card: CardsCollection[index] ,isAMatch: false)
                    cards[index].isClicked = false
                }else {
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
            for index in 0 ..< CardsCollection.count {
                
                if !CardsCollection[index].isEnabled, numOfCards < 3{
                    
                    //we need 3 buttons that are disapled to turn them enabled and provide them with random image -card-
                    CardsCollection[index].isEnabled = true
                    CardsCollection[index].layer.backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
                    
                    // connect the button with its mapped card
                    cards[index].isClicked = false
                    cards[index].isVisible = true
                    
                    if let _ = _3cards[numOfCards] {
                        
                        CardsCollection[index].setImage(UIImage(named: _3cards[numOfCards]!), for: .normal)
                        cards[index].content = _3cards[numOfCards]
                        numOfCards += 1
                    }
                }
                // to check that there's still room for more cards ,, otherwise hide deal btn and show play again one
                if !CardsCollection[index].isEnabled {
                    numOfEnabledCards += 1
                }
            }
        } else {
            // set deck is Empty!!!
            alert(title: "Game is Over! Set Deck is Empty", message: "Your Score is \(score) would you like to play again?")
        }
        
        if numOfEnabledCards == 0 {
            Deal3CardsBtn.isHidden = true
            PlayAgainBtn.isHidden = false
        }
    }
    
    
    private func matchCards() -> Bool {
        return Rules.match(card1: chosenCardsTitles["1"]!, card2:chosenCardsTitles["2"]!, card3: chosenCardsTitles["3"]!)
    }
    
    private func alert(title: String, message: String) -> Void {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Play Again!", style: .cancel, handler: {
            action in
            self.PlayAgain(self.PlayAgainBtn)
        }))
        
        self.present(alert, animated: true)
    }
}

