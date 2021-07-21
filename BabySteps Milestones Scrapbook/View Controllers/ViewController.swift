//
//  ViewController.swift
//  BabySteps Milestones Scrapbook
//
//  Created by Tyler Zwiep on 2021-07-19.
//

import UIKit

class ViewController: UIViewController {

    // reference to the core data context for access to core data
    // cast as AppDelegate > access persistent container property of delegate > viewContext of persistent container
    // private so it is only accessible within view controller
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    // outlets
    @IBOutlet weak var tableView: UITableView!
    
    // array of Milestone objects
    var milestones = [Milestone]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // get milestones from core data
        do
        {
            milestones = try context.fetch(Milestone.fetchRequest())
        }
        catch
        {
            print("Milestones not retrieved from DB")
        }
        // set this view contoller as the delgate and the data source of the tableview
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    // modify prepare() method...the method called when seque happens
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       // prevent nil row selection
        if tableView.indexPathForSelectedRow == nil {
            return
        }
        // selected milestone from selected table row
        let selectedMilestone = self.milestones[tableView.indexPathForSelectedRow!.row]
        // create reference to MilesotneViewController to pass selected milestone
        let milestoneVC = segue.destination as! MilestoneViewController
        // set the milestone property in MilestoneViewController from the selected row
        milestoneVC.milestone = selectedMilestone
        
    }

}
// extension for view controller for conforming  to dataSource and delegate protocols
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    // auto generated protocol methods
    
    // number of rows in table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return milestones.count
    }
    // return custom table cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        // call reference to table cell
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.MilestoneCell) as! MilestoneTableViewCell
        
        // get the milestone
        let m = self.milestones[indexPath.row]
        
        // call set cell method
        cell.setTableCell(m)
        
        return cell
    }


}
