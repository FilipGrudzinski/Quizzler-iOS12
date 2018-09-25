//
//  ViewController.swift
//  Quizzler
//
//  Created by Angela Yu on 25/08/2015. edited by FG in 24.09.2018
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //Place your instance variables here
    
    let allQuestion = QuestionBank()
    var answerPicked: Bool = false
    var questionCounter: Int  = 0
    var score: Int = 0
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var progressBar: UIView!
    @IBOutlet weak var progressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nextQuestion()
        updateUI()
        
    }


    @IBAction func answerPressed(_ sender: AnyObject) {
        
        if sender.tag == 1 {
            
            answerPicked = true
            
        } else if sender.tag == 2 {
            
            answerPicked = false
            
        }
        
        checkAnswer()
        
        questionCounter += 1
        
        nextQuestion()
        
    }
    
    
    func updateUI() {
      
        scoreLabel.text = "Score: \(score)"
        progressLabel.text = "\(questionCounter + 1)/13"
        progressBar.frame.size.width = (view.frame.size.width / 13) * CGFloat(questionCounter + 1)
        
    }
    

    func nextQuestion() {
        
        if questionCounter <= 12 {
            
            questionLabel.text = allQuestion.list[questionCounter].questionText
            updateUI()
            
        } else {
            
            let alert = UIAlertController(title: "Awesome", message: "You've finished all the questions, do you want to start over?", preferredStyle: .alert)
            
            let restartAction = UIAlertAction(title: "Restart", style: .default) { (UIAlertAction) in
                self.startOver()
            }
            
            alert.addAction(restartAction)
            
            present(alert, animated: true, completion: nil)
            
        }
        
    }
    
    
    func checkAnswer() {
            
        let questionAnswer = allQuestion.list[questionCounter].answer
        
        if answerPicked == questionAnswer {
            
            ProgressHUD.showSuccess("Correct")
            score += 1
               
        } else {
            
            ProgressHUD.showError("Wrong!")
           
            
        }
        
    }
    
    
    func startOver() {
        
        questionCounter = 0
        score = 0
        nextQuestion()

       
    }
    

    
}
