//
//  DetailsViewController.swift
//  BabySteps
//
//  Created by Tyler Zwiep on 2021-07-19.
//

import UIKit

class DetailsViewController: UIViewController {

    //outlets
    
    @IBOutlet weak var summaryLabel: UILabel!
    
    
    // properties
    var milestone:Milestone?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // called each time view loads... set label to summary of Milestone
    override func viewWillAppear(_ animated: Bool) {
        summaryLabel.text = milestone?.summary
    }
    
}
