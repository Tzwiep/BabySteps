//
//  NotesViewController.swift
//  BabySteps Milestones Scrapbook
//
//  Created by Tyler Zwiep on 2021-07-19.
//
/*
import UIKit
import CoreData

class DescriptionViewController: UIViewController {

    //properties
    var milestone:Milestone?
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var fetchedDescriptionRC:NSFetchedResultsController<Description>?
    
    //outlets
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        refresh()
    }
    
    func refresh(){
        // check if milestone is set
        if let milestone = milestone {
            //fetch request
            let request:NSFetchRequest<Description> = Description.fetchRequest()
            //specify descriptons wanted from core data using predicate
            request.predicate = NSPredicate(format: "milestone = %@", milestone)
            
            //sort
            let sort = NSSortDescriptor(key: "notes", ascending: false)
            request.sortDescriptors = [sort]
            
            do{
                // create a fetched results controller
               fetchedDescriptionRC = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
                
                //excecute fetch
                try fetchedDescriptionRC!.performFetch()
            }
            catch{ }
            
            // reload table data
            tableView.reloadData()
        }
    }
    
    @IBAction func addDescriptionClicked(_ sender: Any) {
        // display view for adding description
        let addDescriptionVC = storyboard?.instantiateViewController(identifier: "AddDescriptionVC") as! AddDescriptionViewController
        
        // pass milestone object
        addDescriptionVC.milestone = milestone
        
        // config presentation style to show over view
        addDescriptionVC.modalPresentationStyle = .overCurrentContext
        
        // then present it
        present(addDescriptionVC, animated: true, completion: nil)
    }


}
*/
