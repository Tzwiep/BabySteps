//
//  AddDescriptionViewController.swift
//  BabySteps Milestones Scrapbook
//
//  Created by Tyler Zwiep on 2021-07-20.
//
/*
import UIKit
import CoreData

class AddDescriptionViewController: UIViewController {

  //properties
    var milestone:Milestone?
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    //outlets
    @IBOutlet weak var descriptionText: UITextView!
    
    @IBOutlet weak var cardView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        cardView.layer.cornerRadius = 5
        cardView.layer.shadowColor = CGColor(srgbRed: 0, green: 0, blue: 0, alpha: 1)
        cardView.layer.shadowRadius = 5
        cardView.layer.shadowOpacity = 0.5
    }
    // override function - dismiss popup when clicking off popup window
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismiss(animated: true, completion: nil)
    }
    // function for when cancel button clicked... dismisses popup window
    @IBAction func cancelBtnClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    //function for when save button clicked
    @IBAction func saveBtnClicked(_ sender: Any) {
        
        // create new description object
        let d = Description(context: context)
        d.notes = descriptionText.text
        d.milestone = milestone
        
        // save to core data
        appDelegate.saveContext()
        
        //dismiss popup after saving
        dismiss(animated: true, completion: nil)
    }
}

 */
