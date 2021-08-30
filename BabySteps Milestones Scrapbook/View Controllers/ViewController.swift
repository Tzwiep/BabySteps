//
//  ViewController.swift
//  BabySteps
//
//  Created by Tyler Zwiep on 2021-07-19.
//

import UIKit
import CoreData

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
        // set this view contoller as the delgate and the data source of the tableview
        tableView.dataSource = self
        tableView.delegate = self
    }
    /*
        This function retreives the milesetones using fetchMiletones() method... override fuction called anytime the view loads
     */
    override func viewWillAppear(_ animated: Bool) {
        
        // get milestones from core data
        fetchMilestones()
    }
    /*
        This is a reusable function to fetch the milestone objects from core data, sort them by date (from most recent to oldest),
        and reload the table view UI
     */
    func fetchMilestones() {
        // fetch data from core data, sort them by date, and reload table view
        do {
            // request milestones here to perform sorting
            let request = Milestone.fetchRequest() as NSFetchRequest<Milestone>
            
            // sort the returned milestones by date
            let sortDescriptor = NSSortDescriptor(key: "date", ascending: false)
            
            // sortDescriptors wants an array... for chaining sorting
            request.sortDescriptors = [sortDescriptor]
            
            // pass the request into the fetch method to retrivee the sorted milestones
            self.milestones = try context.fetch(request)
            
            // reload table
            self.tableView.reloadData()
            
        } catch {
            // Error Catching
            print("Error: Milestones not retrieved from DB")
        }
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
            
        // clear selected milestone for returning back to view
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPath, animated: true)
        }
        
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "milestoneCell") as! MilestoneTableViewCell
        
        // get the milestone
        let m = self.milestones[indexPath.row]
        
        // call set cell method
        cell.setTableCell(m)
        
        return cell
    }
    
    /*
     This function configures the trailing swipe action to delete the milestone from the selected row after providing an alert confimation box.
     Method for deleting using the trailingSwipeAction was derived from infromation found at:
     https://medium.com/nerd-for-tech/swift-uitableview-swipe-actions-4c1069d5717c
     */
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let action = UIContextualAction( style: .destructive, title: "Delete") { (action, view, completionHandler) in
            
            // add animation
            completionHandler(true)
            // ref to milestone associated with the table row
            let milestoneToRemove = self.milestones[indexPath.row]
            
            /*
             Process for creating an alert button, derviced from infromation found at:
             https://developer.apple.com/documentation/uikit/windows_and_screens/getting_the_user_s_attention_with_alerts_and_action_sheets
             */
            //create alert
            let alert = UIAlertController(title: "Delete Confirmation", message: "Are you sure you would like to delete this milestone?", preferredStyle: .alert)
            // configure submit button to delete milestone
            let submitButton = UIAlertAction(title: "Delete", style: .destructive) { (action) in

                // delete the milestone from core data
                self.context.delete(milestoneToRemove)
            
                // save data
                do {
                try self.context.save()
                } catch{
                    print("Error Deleting From Core Data")
                }
            
            // re-fetch milestones
            self.fetchMilestones()
            }
            // configure cancel button
            let cancelButton = UIAlertAction(title: "Cancel", style: .cancel)
            
            // add buttons
            alert.addAction(cancelButton)
            alert.addAction(submitButton)
            
            // present alert
            self.present(alert, animated: true, completion: nil)
            
        }
            return UISwipeActionsConfiguration(actions: [action])
    }
    
    /*
     This function configures the leading swipe action to  lead the user to the edit page for the milestone selected from the table
     How to configure custom swipe actions derived from infromation found at:
     https://programmingwithswift.com/uitableviewcell-swipe-actions-with-swift/
     */
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction( style: .normal, title: "Edit") { (action, view, completionHandler) in
            
            // add animation
            completionHandler(true)
            
            // refernce to milestone to be edited from table row
            let milestoneToEdit = self.milestones[indexPath.row]
            
            // reference to the view
            let editVC = self.storyboard?.instantiateViewController(identifier: "EditMilestoneVC") as! EditMilestoneViewController
            
            // set the milestone object for the view to the selected milestone
            editVC.milestone = milestoneToEdit
            
           // show view
            editVC.modalPresentationStyle = .fullScreen
            self.present(editVC, animated: true, completion: nil)
            
        }
        action.backgroundColor = .systemBlue
        return UISwipeActionsConfiguration(actions: [action])
    }


}
