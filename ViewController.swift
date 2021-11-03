//
//  ViewController.swift
//  wolfVsSheep V2
//
//  Created by Richson Sedjie on 22/09/21.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    let gambarWolf = UIImage(named: "wolf")    
   
    var cell = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24]
    var WolfPosition : Int = 0
    var sheepPosition : Int = 0
    var buttonPressed : Int = 0
    var a : Int = 1
    
    var player: AVAudioPlayer!
    var bellPlayer : AVAudioPlayer!
    
    var wolfPositionIndex : Int = 0
    var sheepPositionIndex : Int = 0
    
    var turnLeft : Int = 5
    
    @IBOutlet weak var timeLabel: UILabel!
    var timer = Timer()
    var counterTimer = 0
    
    
    @IBOutlet var buttonView: [UIButton]!
    @IBOutlet weak var wolfTurnLabel: UILabel!
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        buttonPressed = Int(sender.title(for: .normal)!)!
        
        
        //startTimer()
        moveWolf()
        
        wolfTurnLabel.text = String(turnLeft) + " Left"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        randomimage()
        wolfTurnLabel.text = "WOLF's TURN LEFT"
        startTimer()
    }
    
    func startTimer(){
        counterTimer = 0
        timeLabel.text = "Timer : \(counterTimer)"
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    func gameOver() -> Bool {
        if WolfPosition == sheepPosition{
            print("Masuk Game Over")
            for i in 0...24 {
                if Int(buttonView[i].currentTitle!) == sheepPosition{
                    let logoImage = UIImage(named: "wolf")
                    let logoImageAlwaysOriginal = logoImage?.withRenderingMode(.alwaysOriginal)
                    buttonView[i].setImage(logoImageAlwaysOriginal, for: .normal)
                    buttonView[i].contentMode = .scaleAspectFit
                }
            }
            
            gameOverAlert()
            return true
        }
        else{
            return false
        }
    }
    
    func moveWolf(){
        turnLeft -= 1
        checkTurnHabis()
        
        buttonView[sheepPosition].setImage(nil, for: .normal)
        buttonView[WolfPosition].setImage(nil, for: .normal)
        var plusSatu : Int = 0
        var minSatu : Int = 0
        var plusLima : Int = 0
        var minLima : Int = 0
        
        
        plusSatu = WolfPosition + 1
        minSatu = WolfPosition - 1
        plusLima = WolfPosition + 5
        minLima = WolfPosition - 5
        let logoImage = UIImage(named: "wolf")
        let logoImageAlwaysOriginal = logoImage?.withRenderingMode(.alwaysOriginal)
        
        
        //Posisi 5, 10, 15, 20 - Wolf tidak boleh minus 1
        if WolfPosition == 5 || WolfPosition == 10 || WolfPosition == 15 || WolfPosition == 20{
            if buttonPressed == plusSatu || buttonPressed == plusLima || buttonPressed == minLima {
                WolfPosition = buttonPressed
                buttonView[WolfPosition].setImage(logoImageAlwaysOriginal, for: .normal)
                buttonView[WolfPosition].contentMode = .scaleAspectFit
                print("Satu")
            }
            else{
                buttonView[WolfPosition].setImage(logoImageAlwaysOriginal, for: .normal)
                buttonView[WolfPosition].contentMode = .scaleAspectFit
            }
        }
        //Posisi 4, 9, 14, 19 - Wolf tidak boleh plus 1
        else if WolfPosition == 4 || WolfPosition ==  9 || WolfPosition == 14 || WolfPosition == 19{
            if buttonPressed == minSatu || buttonPressed == plusLima || buttonPressed == minLima {
                WolfPosition = buttonPressed
                buttonView[WolfPosition].setImage(logoImageAlwaysOriginal, for: .normal)
                buttonView[WolfPosition].contentMode = .scaleAspectFit
                print("Satu")
            }
            else{
                buttonView[WolfPosition].setImage(logoImageAlwaysOriginal, for: .normal)
                buttonView[WolfPosition].contentMode = .scaleAspectFit
            }
        }
        else{
            if buttonPressed == plusSatu || buttonPressed == minSatu || buttonPressed == plusLima || buttonPressed == minLima {
                WolfPosition = buttonPressed
                buttonView[WolfPosition].setImage(logoImageAlwaysOriginal, for: .normal)
                buttonView[WolfPosition].contentMode = .scaleAspectFit
                print("Satu")
            }
            else{
                buttonView[WolfPosition].setImage(logoImageAlwaysOriginal, for: .normal)
                buttonView[WolfPosition].contentMode = .scaleAspectFit
            }
        }
        
        
        
        let sheepImage = UIImage(named: "sheep")
        let sheepImageAlwaysOriginal = sheepImage?.withRenderingMode(.alwaysOriginal)
        
        if gameOver() == false{
            
            var sheepRun = true
            
            while sheepRun == true{
                
                //Posisi 5, 10, 15, 20 - Wolf tidak boleh minus 1
                if sheepPosition == 5 || sheepPosition == 10 || sheepPosition == 15 || sheepPosition == 20{
                    let randomSheepKiri = Int.random(in: 0...2)
                    if randomSheepKiri == 0 && sheepPosition + 1 < 24{ //Plus satu
                        buttonView[sheepPosition + 1].setImage(sheepImageAlwaysOriginal, for: .normal)
                        buttonView[sheepPosition].contentMode = .scaleAspectFit
                        sheepPosition = sheepPosition + 1
                        sheepRun = false
                        //print("Sheep 1")
                    }
                    else if randomSheepKiri == 1 && sheepPosition + 5 < 24{ // Plus Lima
                        buttonView[sheepPosition + 5].setImage(sheepImageAlwaysOriginal, for: .normal)
                        buttonView[sheepPosition].contentMode = .scaleAspectFit
                        sheepPosition = sheepPosition + 5
                        sheepRun = false
                        //print("Sheep 3")
                    }
                    else if randomSheepKiri == 2 && sheepPosition - 5 > 0{ // Minus Lima
                        buttonView[sheepPosition - 5].setImage(sheepImageAlwaysOriginal, for: .normal)
                        buttonView[sheepPosition].contentMode = .scaleAspectFit
                        sheepPosition = sheepPosition - 5
                        sheepRun = false
                        //print("Sheep 4")
                    }
                }
                
                //Posisi 4, 9, 14, 19 - Sheep tidak boleh plus 1
                else if sheepPosition == 4 || sheepPosition == 9 || sheepPosition == 14 || sheepPosition == 19{
                    let randomSheepKanan = Int.random(in: 0...2)
                    if randomSheepKanan == 0 && sheepPosition - 1 > 0{ //Plus satu
                        buttonView[sheepPosition + 1].setImage(sheepImageAlwaysOriginal, for: .normal)
                        buttonView[sheepPosition].contentMode = .scaleAspectFit
                        sheepPosition = sheepPosition + 1
                        sheepRun = false
                        //print("Sheep 1")
                    }
                    else if randomSheepKanan == 1 && sheepPosition + 5 < 24{ // Plus Lima
                        buttonView[sheepPosition + 5].setImage(sheepImageAlwaysOriginal, for: .normal)
                        buttonView[sheepPosition].contentMode = .scaleAspectFit
                        sheepPosition = sheepPosition + 5
                        sheepRun = false
                        //print("Sheep 3")
                    }
                    else if randomSheepKanan == 2 && sheepPosition - 5 > 0{ // Minus Lima
                        buttonView[sheepPosition - 5].setImage(sheepImageAlwaysOriginal, for: .normal)
                        buttonView[sheepPosition].contentMode = .scaleAspectFit
                        sheepPosition = sheepPosition - 5
                        sheepRun = false
                        //print("Sheep 4")
                    }
                }
                else if sheepPosition != 5 && sheepPosition != 10 && sheepPosition != 15 && sheepPosition != 20 && sheepPosition != 4 && sheepPosition != 9 && sheepPosition != 14 && sheepPosition != 19{
                
                let randomSheep = Int.random(in: 0...3)
                print("Rand Sheep = " + String(randomSheep))
                
                if randomSheep == 0 && sheepPosition + 1 < 24{ //Plus satu
                    buttonView[sheepPosition + 1].setImage(sheepImageAlwaysOriginal, for: .normal)
                    buttonView[sheepPosition].contentMode = .scaleAspectFit
                    sheepPosition = sheepPosition + 1
                    sheepRun = false
                    print("Sheep 1")
                }
                else if randomSheep == 1 && sheepPosition - 1 > 0{ //Min satu
                    buttonView[sheepPosition - 1].setImage(sheepImageAlwaysOriginal, for: .normal)
                    buttonView[sheepPosition].contentMode = .scaleAspectFit
                    sheepPosition = sheepPosition - 1
                    sheepRun = false
                    print("Sheep 2")
                }
                else if randomSheep == 2 && sheepPosition + 5 < 24{ // Plus Lima
                    buttonView[sheepPosition + 5].setImage(sheepImageAlwaysOriginal, for: .normal)
                    buttonView[sheepPosition].contentMode = .scaleAspectFit
                    sheepPosition = sheepPosition + 5
                    sheepRun = false
                    print("Sheep 3")
                }
                else if randomSheep == 3 && sheepPosition - 5 > 0{ // Minus Lima
                    buttonView[sheepPosition - 5].setImage(sheepImageAlwaysOriginal, for: .normal)
                    buttonView[sheepPosition].contentMode = .scaleAspectFit
                    sheepPosition = sheepPosition - 5
                    sheepRun = false
                    print("Sheep 4")
                }
                }
            }
            if sheepPosition == WolfPosition {
                let logoImage = UIImage(named: "wolf")
                let logoImageAlwaysOriginal = logoImage?.withRenderingMode(.alwaysOriginal)
                buttonView[sheepPosition].setImage(logoImageAlwaysOriginal, for: .normal)
                buttonView[sheepPosition].contentMode = .scaleAspectFit
                
                gameOverAlert()

            }
        }
        /*print ("Button Pressed : " + String(buttonPressed))
        print(String(plusSatu) + " " + String(minSatu) + " " + String(plusLima) + " " + String(minLima))
        print(String(buttonPressed+1) + " " + String(buttonPressed-1) + " " + String(buttonPressed+5) + " " + String(buttonPressed-5))*/
        print("Current Wolf Position = " + String(WolfPosition))
        
        print("Current Sheep Position = " + String(sheepPosition))
    }
    
    func randomimage(){
        turnLeft = 5
        wolfTurnLabel.text = "WOLF's TURN LEFT"
        var cellrandom = cell.randomElement()
        let sheepCellRandom = cell.randomElement()
        
        WolfPosition = cellrandom!
        sheepPosition = sheepCellRandom!
        
        if WolfPosition == sheepPosition{
            cellrandom = cell.randomElement()
            WolfPosition = cellrandom!
        }
        
        let sheepImage = UIImage(named: "sheep")
        let sheepImageAlwaysOriginal = sheepImage?.withRenderingMode(.alwaysOriginal)
        let logoImage = UIImage(named: "wolf")
        let logoImageAlwaysOriginal = logoImage?.withRenderingMode(.alwaysOriginal)
        
        buttonView[WolfPosition].setImage(logoImageAlwaysOriginal, for: .normal)
        buttonView[WolfPosition].contentMode = .scaleAspectFit
        
        buttonView[sheepPosition].setImage(sheepImageAlwaysOriginal, for: .normal)
        buttonView[sheepPosition].contentMode = .scaleAspectFit
        
    }
    
    func deleteImage(animal: String){
        for i in 0...24{
            buttonView[i].setImage(nil, for: .normal)
        }
    }
    
    func gameOverAlert(){
        let alert = UIAlertController(title: "GAME OVER !", message: "Wolf Win!", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "New Game", style: .cancel, handler: { [self]action in deleteImage(animal: "Wolf")
            randomimage()
            startTimer();
        }))
        
        present(alert, animated: true)
        timer.invalidate()
        playSound()
    }
    
    func checkTurnHabis(){
        if turnLeft == 0 {
            //gameOver() == true
            //gameOverAlert()
            timesUpAlert()
            timer.invalidate()
            
        }
    }
    
    func timesUpAlert(){
        let alert = UIAlertController(title: "TURN OVER", message: "WOLF LOSE", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Try Again", style: .cancel, handler: { [self]action in deleteImage(animal: "Wolf")
            randomimage()
            startTimer();
        }))
        
        //wolfTurnLabel.text = "GAME OVER!"
        playSoundBell()
        present(alert, animated: true)
    }
    
    func playSound(){
        let url = Bundle.main.url(forResource: "roar", withExtension: "wav")
        player = try! AVAudioPlayer(contentsOf:url!)
        player.play()
    }
    
    func playSoundBell(){
        let url = Bundle.main.url(forResource: "alarm", withExtension: "wav")
        bellPlayer = try! AVAudioPlayer(contentsOf:url!)
        bellPlayer.play()
    }
    
    @objc func updateTimer() {
        if counterTimer >= 0{
            timeLabel.text = "TIME : \(counterTimer) seconds"
            counterTimer += 1
        }
        else{
            timer.invalidate()
            timeLabel.text = "Game Over"
            timesUpAlert()        }
    }
}

