//
//  DetailsViewController.swift
//  BabySteps Milestones Scrapbook
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
    
    // called eachtime view loads... set label to summary of Milestone
    override func viewWillAppear(_ animated: Bool) {
        summaryLabel.text = milestone?.summary
    }

}
