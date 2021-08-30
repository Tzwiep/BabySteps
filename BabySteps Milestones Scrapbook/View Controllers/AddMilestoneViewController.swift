//
//  AddMilestoneViewController.swift
//  BabySteps
//
//  Created by Tyler Zwiep on 2021-07-25.
//

import UIKit
import CoreLocation

class AddMilestoneViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    //outlets
    
    @IBOutlet weak var titleText: UITextField!
    
    @IBOutlet weak var dateDatePicker: UIDatePicker!
    
    @IBOutlet weak var addressText: UITextField!
    
    @IBOutlet weak var summaryText: UITextField!
    
    @IBOutlet weak var imageImageView: UIImageView!
    
    @IBOutlet weak var saveBtn: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet weak var errorAddressLabel: UILabel!
    
    @IBOutlet weak var errorImageLabel: UILabel!
    
    @IBOutlet weak var chooseImgBtn: UIButton!
    
    var milestones = [Milestone]()
    
    // reference to managed object context
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // round button corners
        saveBtn.layer.cornerRadius = 10.0
    }
  
    /*
     This function is called when the choose image btn is clicked. Calls the UIImagePicker Controller to choose image from photo library.
     This action function is derived from infromataion found here:
     https://www.hackingwithswift.com/read/10/4/importing-photos-with-uiimagepickercontroller
     */
    @IBAction func chooseImageBTN(_ sender: UIButton) {
        // reset error label for image
        errorImageLabel.text = ""
        // create ref to UIImagePicker view controller
        let imagePicker = UIImagePickerController()
        // Don't allow editing
        imagePicker.allowsEditing = false
        // use the Photo library as source
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        // set delegate as self to confrom to necessaary UIImagePickerControllerDelegate and UINavigationControllerDelegate protocols
        imagePicker.delegate = self
        // display image picker
        present(imagePicker, animated: true, completion: nil)
    }
    
   
    /*
     This function is called when the user selects an image from the image picker... it assigns the selected image to the ImageView
     */
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // get ref to selected image
        if let image = info[UIImagePickerController.InfoKey.originalImage]
        {
            // set ImageView to selectd image
            imageImageView.image = image as? UIImage
        }
        else {
            // error
            print("Something went wrong setting image")
        }
       
        // dismiss image picker
        self.dismiss(animated: true, completion: nil)
    }

    /*
        This function is called when editing starts ... it is used to remove the red background that was added if the required title field was left empty
     */
    @IBAction func resetTitleBG(_ sender: UITextField) {
        // set field back to white
        titleText.backgroundColor = UIColor.white
        // and remove error msg
        errorLabel.text = ""
    }
    /*
        This function is called when editing starts ... it is used to remove the red background if the required address  field was left empty
     */
    @IBAction func resetAddressBG(_ sender: UITextField) {
        // set field back to white
        addressText.backgroundColor = UIColor.white
        // remove error label
        errorAddressLabel.text = ""
    }
    /*
     This method is called when the save button is clicked. it creates a new milestone object and saves it to core data
     */
    @IBAction func saveBtnClicked(_ sender: Any) {
        // form validation to avoid nil errors
        // if title textfield empty
        if (titleText.text!.isEmpty)
        {
            // set field to red
            titleText.backgroundColor = UIColor(red: 255/255, green: 206/255, blue: 206/255, alpha: 1.0)
            
            errorLabel.text = "Please enter a title"
            return
        }
        // else if the address textfield is empty
        else if (addressText.text!.isEmpty){
            addressText.backgroundColor = UIColor(red: 255/255, green: 206/255, blue: 206/255, alpha: 1.0)
            errorAddressLabel.text = "Please enter an address"
            return
        }
        // else if the imageview is empty
        else if (imageImageView!.image == nil) {
            errorImageLabel.text = "Please choose an image"
            return
        }
        // Otherwise Save the New Milestone into Core Data
        else {
            // new milestone object
            let newMilestone = Milestone(context: self.context)
            
            //configure properties of milestone:
            // title
            newMilestone.title = titleText.text
            
            // store date as string
            // ref to DateFormatter() class
            let dateFormatter = DateFormatter()
            // desired String format
            dateFormatter.dateFormat = "yyyy-MM-dd"
            // set new milestone date as a string matching the above format from datepicker Date value
            newMilestone.date =  dateFormatter.string(from: dateDatePicker.date)
                
             // summary
            newMilestone.summary = summaryText.text
        
            // save image
            newMilestone.image = imageImageView.image?.jpegData(compressionQuality: 1.0)
            
            /*
                Convert string address to lat and long coordinates for core data storage.
                This method is derived from information found at:
                https://stackoverflow.com/questions/42279252/convert-address-to-coordinates-swift
            */
            // var holding text from address textfield
            let address = addressText.text
            // referecne to the CLGeocoder() class
            let geoCoder = CLGeocoder()
            // Use the geodcodeAddressString() method from the CLGeocoder class to convert string to lat and long
            geoCoder.geocodeAddressString(address!) {
                placemarks, error in
                // get placemark from string address given as parameter
                let placemark = placemarks?.first
                // get lat and long and set to NewMilestone lat and long properties
                newMilestone.lat = (placemark?.location?.coordinate.latitude)!
                newMilestone.long = (placemark?.location?.coordinate.longitude)!
            }
            // save the new milestone to core data
            do{
                try self.context.save()
           }
            catch{
                // error message
                print("Error saving new milestone")
            }

            // return to main vew of navigation controller
            _ = navigationController?.popToRootViewController(animated: true)
            
        } // end of else
    } // end of btn action
}
