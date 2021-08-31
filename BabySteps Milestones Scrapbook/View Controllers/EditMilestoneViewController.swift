//
//  EditMilestoneViewController.swift
//  BabySteps
//
//  Created by Tyler Zwiep on 2021-08-03.
//

import UIKit
import Foundation
import CoreLocation

class EditMilestoneViewController: UIViewController,  UIImagePickerControllerDelegate, UINavigationControllerDelegate  {

    // properties
    var milestone:Milestone?
    
    // reference to managed object context
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    //outlets
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var dateDatePicker: UIDatePicker!
    
    @IBOutlet weak var addressTextField: UITextField!
    
    @IBOutlet weak var notesTextView: UITextView!
    
    @IBOutlet weak var imageImageView: UIImageView!
    
    @IBOutlet weak var saveBtn: UIButton!
    
    @IBOutlet weak var addressErrorLabel: UILabel!
    
    @IBOutlet weak var titleErrorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // round button corners
        saveBtn.layer.cornerRadius = 10.0
    }
    
    // preload the data from the milestone selected for editing into the appropriate fields in the view
    override func viewWillAppear(_ animated: Bool) {
        
        // set title text field to miletstone title
        titleTextField.text = milestone?.title
        
        // format core data string back into date using DateFormatter() class
        // var hoilding string date from core data
        let dateString = (milestone?.date)!
        // ref to DateFormatter class
        let dateFormatter = DateFormatter()
        // set locale and format
        dateFormatter.locale = Locale(identifier: "en_CA")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        // use the date() function of the dateformatter to convert string into a Date type
        if let date = dateFormatter.date(from: dateString)
        {
            // set DatePicker to that Date value
            dateDatePicker.date = date
        }
       
        // format lat and long back into string
        // set variable to the lat and long coordinates from milestone
        let addressLat = milestone?.lat
        let addressLong = milestone?.long
        
        /*
            Converting lat/long back to String for the address textfield. This process was derived from the Apple documentation:
            https://developer.apple.com/documentation/corelocation/converting_between_coordinates_and_user-friendly_place_names
         */
        //create a CLLocation object to hold  location object the milestone coordinates from core data
        let location = CLLocation(latitude: addressLat!, longitude: addressLong!)
        // ref to CLGeocoder class
        let geoCoder = CLGeocoder()
        // use the reverseGeocodeLocation() method of the CLGeocoder class to retrive the string address from lat/long location given as a paramter
        geoCoder.reverseGeocodeLocation(location)  { [self]
            placemarks, error in
            let placemark = placemarks?.first
            // Because the adress is being converted back to string address,
            // an 'if' statement is used to prevent a nil address location from crashing the app
            if placemark?.locality != nil && placemark?.country != nil {
            addressTextField.text = (placemark?.locality)! + ", " + (placemark?.country)!
            }
            // otherwise... provide an error label so the user can re-enter an address and save again
            else
            {
                //set error label text
                addressErrorLabel.text = "No Location"
                // set field to red
                addressTextField.backgroundColor = UIColor(red: 255/255, green: 206/255, blue: 206/255, alpha: 1.0)
                // no location.. so make sure textfield is empty
                addressTextField.text = ""
            }
        }
        
        // set notes text field to milestone summary notes
        notesTextView.text = milestone?.summary
      
        // set image View to milestone image
        imageImageView.image = UIImage(data: milestone!.image!)
        
    }   // end of viewWillAppear
    
    
    /*
        This IBAction function is called when the save button is clicked. It checks to make sure the  title and address fields are not empty, and then proceeds to save the new information to the current milestone.
     */
    @IBAction func saveBtnClicked(_ sender: UIButton) {
        // form validation to avoid nil errors
        
        // if ttitle field is empty
        if (titleTextField.text!.isEmpty)
        {
            // if title text field is empty.. set field to red
            titleTextField.backgroundColor = UIColor(red: 255/255, green: 206/255, blue: 206/255, alpha: 1.0)
            // set title error label
            titleErrorLabel.text = "Please enter a title"
            // exit function
            return
        }
        // else if address field is empty
        else if (addressTextField.text!.isEmpty)
        {
            // if address text field is empty.. set field to red
            addressTextField.backgroundColor = UIColor(red: 255/255, green: 206/255, blue: 206/255, alpha: 1.0)
            // set address error label
            addressErrorLabel.text = "Please enter an address"
            // exit function
            return
        }
       // else.. if the address and title fields are not empty save the edited milestone
        else {
            
        //configure properties of milestone:
            
        // title from title textfield
       milestone?.title = titleTextField.text
        
        // use DateFormatter() class again to store date as string in core data
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        milestone?.date =  dateFormatter.string(from: dateDatePicker.date)
            
         // set summary notes to notes text field
        milestone?.summary = notesTextView.text
    
        // save image
       milestone?.image = imageImageView.image?.jpegData(compressionQuality: 1.0)
        
        // convert string address to lat and long coordinates for core data
        // this method is derived from information found at:
        // https://stackoverflow.com/questions/42279252/convert-address-to-coordinates-swift
        let address = addressTextField.text
        // ref to CLGEocoder class
        let geoCoder = CLGeocoder()
            // geocodeAddressString() method of the CLGeocoder class
            // accepts a string and creates a placemark from it
            geoCoder.geocodeAddressString(address!) { [self]
            placemarks, error in
            let placemark = placemarks?.first
            // get lat and long cooordinated from the placemark
            milestone?.lat = (placemark?.location?.coordinate.latitude)!
            milestone?.long = (placemark?.location?.coordinate.longitude)!
        }
        // save the new milestone to core data
        do{
            try self.context.save()
       }
        catch{
            //error message
            print("Error saving new milestone")
        }
        
        // dismiss view
            dismiss(animated: true, completion: nil)
        
        } // end of else
    } // end of action
    
    
    /*
     This IBAction function is called when the choose image btn is clicked. Calls the UIImagePicker Controller to choose image from photo library
     This action function is derived from infromataion found here:
     https://www.hackingwithswift.com/read/10/4/importing-photos-with-uiimagepickercontroller
     */
    @IBAction func chooseImageBTN(_ sender: UIButton) {
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
     This function is called when the user selects an image from the image picker and assigns the image to the ImageView
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
     This function is used to reset the error message if the user starts editing the address textfield after an error
     */
    @IBAction func resetAddressError(_ sender: UITextField) {
        // set text field back to white
        addressTextField.backgroundColor = UIColor.white
        // set address error label bacnk to empty string
        addressErrorLabel.text = ""
        
    }
    
  

}
