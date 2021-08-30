//
//  AppDelegate.swift
//  BabySteps
//
//  Created by Tyler Zwiep on 2021-07-19.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //call load default data function that checks if first time opening app
        preloadData()
        
        return true
    }
    /*
        This function calls all the preload milestone functions to load, loading default data into the app if it is the first time the app is opened,
        and save it to core data database
     */
    func preloadData(){
        
        // create instance of UserDefaults class - for interacting with defaults system
        let defaults = UserDefaults.standard
        
        // store bool data type in defaults as a flag variable to determine if first time running app
        // returns true is key exists
        if defaults.bool(forKey: "launchFlag") == false {
        
            // call the preload data functions
            loadMilestone1()
            loadMilestone2()
            loadMilestone3()
            loadMilestone4()
            loadMilestone5()
            loadMilestone6()
            loadMilestone7()
                
            //set flag to return true next time app opens, to avoid loading data again
            defaults.set(true, forKey: "launchFlag")
        }
    }
    
    // -------------------  Default Data Functions ---------------------------
    // hardcoded default data to preload into the application
    
    func loadMilestone1(){
        // reference to core data context
        let context = persistentContainer.viewContext
        
        // create new milestone object
        let milestone1 = Milestone(context: context)
        milestone1.title = "Wish You Were Here!"
        milestone1.image = UIImage(named: "firstMail")?.jpegData(compressionQuality: 1)
        milestone1.summary = "Baby's first mail arrived today... a postcard from his Aunt N in Hawaii! He was soooooo excited to read it!"
        milestone1.lat = 44.492495
        milestone1.long = -80.221031
        milestone1.date = "2021-06-21"
        
        // save milestone
        self.saveContext()
    }
    
    func loadMilestone2(){
        // reference to core data context
        let context = persistentContainer.viewContext
        
        // create new milestone object
        let milestone2 = Milestone(context: context)
        milestone2.title = "First Father's Day"
        milestone2.image = UIImage(named: "fathersDay")?.jpegData(compressionQuality: 1)
        milestone2.summary = "First Father's Day... but sadly, I had to do a Swift midterm!? Luckily it was easy, and I got time with my little guy!"
        milestone2.lat = 44.492495
        milestone2.long = -80.221031
        milestone2.date = "2021-06-20"
        
        // save milestone
        self.saveContext()
    }
    
    func loadMilestone3(){
        // reference to core data context
        let context = persistentContainer.viewContext
        
        // create new milestone object
        let milestone3 = Milestone(context: context)
        milestone3.title = "Meeting Uncle C"
        milestone3.image = UIImage(named: "meetingUncle")?.jpegData(compressionQuality: 1)
        milestone3.summary = "It was a dark and stormy night... when Baby finally met his Uncle! Trapped in Colorado because of COVID, it was so electric when they finally got to meet that the power went out!"
        milestone3.lat = 44.492495
        milestone3.long = -80.221031
        milestone3.date = "2021-06-25"
        
        // save milestone
        self.saveContext()
    }
    
    func loadMilestone4(){
        // reference to core data context
        let context = persistentContainer.viewContext
        
        // create new milestone object
        let milestone4 = Milestone(context: context)
        milestone4.title = "1/2 Year Old"
        milestone4.image = UIImage(named: "sixMonths")?.jpegData(compressionQuality: 1)
        milestone4.summary = "I can't believe this cute dude is 6 months old! Time has gone by so fast, it feels like soon he'll be off at college!"
        milestone4.lat = 44.492495
        milestone4.long = -80.221031
        milestone4.date = "2021-07-30"
        
        // save milestone
        self.saveContext()
    }
    
    func loadMilestone5(){
        // reference to core data context
        let context = persistentContainer.viewContext
        
        // create new milestone object
        let milestone5 = Milestone(context: context)
        milestone5.title = "Three Months Old"
        milestone5.image = UIImage(named: "threeMonths")?.jpegData(compressionQuality: 1)
        milestone5.summary = "Still such a little nugget... crazy to think one day this hat will fit him!"
        milestone5.lat = 44.492495
        milestone5.long = -80.221031
        milestone5.date = "2021-04-30"
        
        // save milestone
        self.saveContext()
    }
 
    func loadMilestone6(){
        // reference to core data context
        let context = persistentContainer.viewContext
        
        // create new milestone object
        let milestone6 = Milestone(context: context)
        milestone6.title = "First Swing Ride"
        milestone6.image = UIImage(named: "swing")?.jpegData(compressionQuality: 1)
        milestone6.summary = "Not Sure how he felt about the trying the swing, but he loved to watch the other kids play!"
        milestone6.lat = 44.492495
        milestone6.long = -80.221031
        milestone6.date = "2021-07-03"
        
        // save milestone
        self.saveContext()
    }
    
    func loadMilestone7(){
        // reference to core data context
        let context = persistentContainer.viewContext
        
        // create new milestone object
        let milestone7 = Milestone(context: context)
        milestone7.title = "First Smile"
        milestone7.image = UIImage(named: "firstSmile")?.jpegData(compressionQuality: 1)
        milestone7.summary = "First smile where he is looking at the camera (and doesn't have gas)! We took so many pictures, but this one is the cutest!!"
        milestone7.lat = 44.492495
        milestone7.long = -80.221031
        milestone7.date = "2021-03-06"
        
        // save milestone
        self.saveContext()
    }
    
    
    
    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "BabySteps_Milestones_Scrapbook")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

