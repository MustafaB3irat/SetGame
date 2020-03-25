//
//  ViewController.swift
//  Set
//
//  Created by Asal Macbook 1 on 22/03/2020.
//  Copyright © 2020 Mustafa Birat. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var setGenerator: SetGenerator = SetGenerator(numOfCards: 24)
    
    
    
    @IBOutlet weak var Deal3CardsBtn: UIButton!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var CardsCollection: [UIButton]!
    
    
    var score: Int = 0 {
        
        didSet{
            scoreLabel.text = String ( Int(scoreLabel.text!)! +  score)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        displayCards()
    }
    
    private func displayCards(){
        
        var uniqueImageSet: Set<String> = Set<String>()
        
        for i in 0..<setGenerator.numOfCards {
            
            if !setGenerator.cards[i].isVisible {
                CardsCollection[i].layer.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                CardsCollection[i].setImage(nil, for: .normal)
                CardsCollection[i].isEnabled = false
            }else{
                
                
                
                //genereates unique images
                var cardTitle = SetRules.allCases.randomElement()!
                
                while  uniqueImageSet.contains(cardTitle.rawValue) {
                    
                    cardTitle = SetRules.allCases.randomElement()!
                    
                }
                
                uniqueImageSet.insert(cardTitle.rawValue)
                
                
                
                //display the image to the card ...
                CardsCollection[i].setImage(UIImage(named: cardTitle.rawValue), for: .normal)
                CardsCollection[i].restorationIdentifier = cardTitle.rawValue
                
                
            }
            
        }
        
    }
    
    @IBAction func CardIsPressed(_ sender: UIButton) {
        
        
        //cards can be unselected since number of clicked cards is less than 3
        if setGenerator.numOfClickedCards < 3 {
            
            
            if sender.layer.borderWidth == 0 {
                
                sender.layer.borderWidth = 4
                sender.layer.borderColor = #colorLiteral(red: 0.9872592135, green: 0.2078811415, blue: 0.05133768179, alpha: 1)
                checkCard(card: sender, clicked: true)
                
            }else{
                
                sender.layer.borderWidth = 0
                
                checkCard(card: sender, clicked: false)
            }
            
        }
    }
    
    
    private func checkCard(card: UIButton , clicked: Bool){
        
        for i in setGenerator.cards.indices {
            
            if CardsCollection[i] == card {
                
                setGenerator.cards[i].isClicked = clicked
                
                if clicked {
                    setGenerator.numOfClickedCards += 1
                    
                    // store the clicked cards title in a dictionary
                    setGenerator.chosenCardsTitles["\(setGenerator.numOfClickedCards)"] = card.restorationIdentifier
                    
                    //check for matching cards ....
                    
                    if setGenerator.numOfClickedCards == 3 {
                        
                        if setGenerator.matchCards() {
                            
                            // card is matched
                            threeCardsAreSelected(isAMatch: true)
                            
                            // increment score
                            score = 5
                            
                            //show 3 new cards if room is not full
                            
                            deal3MoreCards()
                            
                        }else{
                            //clicked cards is a mismatch
                            threeCardsAreSelected(isAMatch: false)
                            
                            //decrement score
                            score = -2
                        }
                        
                    }
                    
                }else{
                    setGenerator.numOfClickedCards -= 1
                }
                break
            }
            
        }
        
    }
    
    
    
    func cardIsAMatch( card: UIButton , isAMatch: Bool){
        
        
        if isAMatch{
            card.layer.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            card.setImage(nil, for: .normal)
            card.isEnabled = false
        }
        card.layer.borderWidth = 0
        
    }
    
    
    
    func threeCardsAreSelected(isAMatch: Bool){
        
        setGenerator.numOfClickedCards = 0
        
        for j in setGenerator.cards.indices {
            
            //get the selected cards
            if setGenerator.cards[j].isClicked {
                
                // if three cards are a match .... hide cards
                if isAMatch {
                    
                    cardIsAMatch(card: CardsCollection[j] ,isAMatch: true)
                    
                    setGenerator.cards[j].isClicked = false
                    
                    
                }else {
                    //else remove the border around them
                    cardIsAMatch(card: CardsCollection[j] ,isAMatch: false)
                    
                    setGenerator.cards[j].isClicked = false
                    
                }
                
            }
            
            
        }
    }
    
    
    
    private func deal3MoreCards(){
        
        var uniqueImageSet : Set<String> = Set<String>()
        
        var numOfCards = 0
        
        for card in CardsCollection.indices {
            
            if !CardsCollection[card].isEnabled , numOfCards < 3{
                
                
                //we need 3 buttons that are disapled to turn them enabled and provide them with random image -card-
                CardsCollection[card].isEnabled = true
                CardsCollection[card].layer.backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
                
                // connect the button with its mapped card
                setGenerator.cards[card].isClicked = false
                setGenerator.cards[card].isVisible = true
                
                
                //provide the card with random image
                var cardImage = SetRules.allCases.randomElement()!.rawValue
                
                //check that it's unique
                while uniqueImageSet.contains(cardImage){
                    cardImage = SetRules.allCases.randomElement()!.rawValue
                }
                
                uniqueImageSet.insert(cardImage)
                
                
                CardsCollection[card].setImage(UIImage(named: cardImage), for: .normal)
                CardsCollection[card].restorationIdentifier = cardImage
                
                numOfCards += 1
                
                
            }
            
        }
        
        
    }
    
    
    @IBAction func Deal3MoreCardsButtonIsPressed(_ sender: UIButton) {
        
        deal3MoreCards()
    }
    
}

