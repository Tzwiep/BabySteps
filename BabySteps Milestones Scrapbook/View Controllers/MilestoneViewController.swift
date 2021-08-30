//
//  MilestoneViewController.swift
//  BabySteps
//
//  Created by Tyler Zwiep on 2021-07-19.
//

import UIKit

class MilestoneViewController: UIViewController {

    // properties
    var milestone:Milestone?
    
    // computed properties for the two child view controllers
    // use of lazy to prevent code from running prior to user selection
    lazy var detailsViewContoller:DetailsViewController = {
        // create an instance of DetailsViewController
        let detailsVC = self.storyboard?.instantiateViewController(identifier: "DetailsVC") as! DetailsViewController
        return detailsVC
    }()

    lazy var mapViewContoller:MapViewController = {
        // create an instance of MapViewController
        let mapVC = self.storyboard?.instantiateViewController(identifier: "MapVC") as! MapViewController
        return mapVC
    }()
    
    // outlets
    @IBOutlet weak var milestoneImage: UIImageView!
    
    @IBOutlet weak var yearLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBOutlet weak var containerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    // modify viewWillAppear... called every time the view is displayed
    override func viewWillAppear(_ animated: Bool) {
        // set milestone image if not nil
        if milestone?.image != nil {
            milestoneImage.image = UIImage(data: milestone!.image!)
            }
        // set milestone title
        titleLabel.text = milestone?.title
        // set milestone date
        yearLabel.text = milestone?.date
        
        // make sure first segment is displayed
        segmentValueChanged(self.segmentedControl)
    }
    

    // this function is used to switch between the childViewControllers - summary and map
    func switchChildViewControllers(_ childVC: UIViewController) {
        // make it a child view controller of the MilestoneViewController
        addChild(childVC)
        // set as subview of containerView view outlet
        containerView.addSubview(childVC.view)
        
        // set UI frame and sizing
        childVC.view.frame = containerView.bounds
        childVC.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // indicate that its now a child view contoller
        childVC.didMove(toParent: self)
    }

    // Actions
    // this action uses a switch statement to call one of the two segmented values and direct it to the appropriate childView
    // also sets the milestone property of each view to the selected Milestone
    @IBAction func segmentValueChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            detailsViewContoller.milestone = self.milestone
            switchChildViewControllers(detailsViewContoller)
        case 1:
            mapViewContoller.milestone = self.milestone
            switchChildViewControllers(mapViewContoller)
        default:
            switchChildViewControllers(detailsViewContoller)
        }
    }
    
}
