//
//  AddMedicineViewController.swift
//  TrackMyMeds
//


import UIKit
import ActionSheetPicker_3_0
import CoreData

class AddMedicineViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // passed from search page
    var passName = String()
    var passBrand = String()
    
    var seguePerformed = Bool()
    

    @IBOutlet var dosageField: UITextField!
    @IBOutlet var mediName: UITextField!
    @IBOutlet var brandField: UITextField!
    @IBOutlet var descriptionField: UITextField!
    
    
    @IBOutlet var Med1: UIButton!
    @IBOutlet var Med2: UIButton!
    @IBOutlet var Med3: UIButton!
    @IBOutlet var Med4: UIButton!
    @IBOutlet var Med5: UIButton!
    
    @IBOutlet var whiteButton: UIButton!
    @IBOutlet var blackButton: UIButton!
    @IBOutlet var brownButton: UIButton!
    @IBOutlet var orangeButton: UIButton!
    @IBOutlet var greenButton: UIButton!
    @IBOutlet var blueButton: UIButton!
    @IBOutlet var yellowButton: UIButton!
    @IBOutlet var pinkButton: UIButton!
   
    @IBOutlet weak var takeImgButton: UIButton!
    
    var medi: Medicine?
    var appearImage: String?
    var colorImage: String?
    var dosageText: String?
    var mediText: String?
    var brandText: String?
    var descText: String?
    
    
    var imageData:NSData?
    
   
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.dosageField.delegate = self
        
        dosageField.layer.cornerRadius = 10.0
        mediName.layer.cornerRadius = 10.0
        brandField.layer.cornerRadius = 10.0
        descriptionField.layer.cornerRadius = 10.0
        
        whiteButton.layer.cornerRadius = 10.0
        blackButton.layer.cornerRadius = 10.0
        brownButton.layer.cornerRadius = 10.0
        orangeButton.layer.cornerRadius = 10.0
        greenButton.layer.cornerRadius = 10.0
        blueButton.layer.cornerRadius = 10.0
        yellowButton.layer.cornerRadius = 10.0
        pinkButton.layer.cornerRadius = 10.0
        
        Med1.layer.cornerRadius = 10.0
        Med2.layer.cornerRadius = 10.0
        Med3.layer.cornerRadius = 10.0
        Med4.layer.cornerRadius = 10.0
        Med5.layer.cornerRadius = 10.0
        
        self.takeImgButton.layer.cornerRadius = 10.0
        self.takeImgButton.layer.borderWidth = 1.0
        self.takeImgButton.layer.borderColor = UIColor.black.cgColor
        self.takeImgButton.clipsToBounds = true
        
        self.navigationItem.title = "Add Medicine"
        
        if seguePerformed == true {
            mediName.text = passName
            brandField.text = passBrand
        } else {
            dosageField.delegate = self
            mediName.delegate = self
        }
        descriptionField.delegate = self
        brandField.delegate = self

        let rightBarButtonItem1: UIBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addTapped))
        navigationItem.rightBarButtonItems = [rightBarButtonItem1]

        // Do any additional setup after loading the view.
        seguePerformed = false
    }
    
    
    @IBAction func takingImageBtnClicked(_ sender: Any) {
        let imagePickerViewController = UIImagePickerController()
        imagePickerViewController.delegate = self
        imagePickerViewController.sourceType = .camera
        self.present(imagePickerViewController, animated: true, completion: nil)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
           
            imageData = pickedImage.jpeg(.lowest) as NSData?
            let imageis = UIImage(data:self.imageData! as Data,scale:0.3)
           
            self.takeImgButton.setImage(imageis, for: .normal)
            
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    func addTapped() {
        
//        if !(mediName.text?.isEmpty)! && !(dosageField.text?.isEmpty)! && !(appearImage==nil) && !(colorImage==nil) {
        if mediText != nil && dosageText != nil && appearImage != nil && colorImage != nil {
            if medi==nil {
                let tempMedi = Medicine.mr_createEntity()
                
                tempMedi?.appearImg = appearImage
                tempMedi?.colorImg = colorImage
                tempMedi?.noOfTimesTaken = 0
                tempMedi?.medDosage = dosageText
                tempMedi?.medName = mediText
                tempMedi?.brandName = brandText
                tempMedi?.mediDescription = descText
                tempMedi?.medImgData = self.imageData
               

                NSManagedObjectContext.mr_default().mr_saveToPersistentStoreAndWait()
                
                _ = self.navigationController?.popToRootViewController(animated: true)
            }
            else
            {
                medi?.appearImg = appearImage
                medi?.colorImg = colorImage
                medi?.noOfTimesTaken = 0
                medi?.medDosage = dosageText
                medi?.medName = mediText
                medi?.brandName = brandText
                medi?.mediDescription = descText
                medi?.medImgData = self.imageData
             

                NSManagedObjectContext.mr_default().mr_saveToPersistentStoreAndWait()
                
                _ = self.navigationController?.popToRootViewController(animated: true)
            }
        }
        else
        {
            let alert = UIAlertController(title: "Error", message: "Required fields are missing", preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
        }

    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        /*
        if textField == dosageField
        {
            self.view.endEditing(true)
            showDosagePicker(textField: textField)
            return false
        }
        else
        {
            return true
        }*/
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == dosageField {
          dosageText = textField.text
        }else if textField == mediName{
          mediText = textField.text
        }else if textField == brandField {
            brandText = textField.text
        }else {
            descText = textField.text
        }
        dosageText = textField.text
        textField.resignFirstResponder()
        
    }
    
  
    
    

    /*
    func showDosagePicker(textField: UITextField) {
        
        ActionSheetStringPicker.show(withTitle: "Select Dosage", rows: ["10mg", "20mg", "30mg", "40mg"], initialSelection: 1, doneBlock: {
            picker, index, value  in
            
            if let dosageValue = value as? String {
                textField.text = dosageValue
            }
            
            //textField.text = "\(value!)"
            
            return
        }, cancel: { ActionStringCancelBlock in return }, origin: textField)
        
    }*/

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func Med1Pressed(_ sender: Any) {
        
        Med1.backgroundColor = UIColor.lightGray
        Med2.backgroundColor = UIColor.clear
        Med3.backgroundColor = UIColor.clear
        Med4.backgroundColor = UIColor.clear
        Med5.backgroundColor = UIColor.clear
        
        appearImage = "Med1"
        
        /*
        ActionSheetMultipleStringPicker.show(withTitle: "Multiple String Picker", rows: [
            ["One", "Two", "A lot"],
            ["Many", "Many more", "Infinite"]
            ], initialSelection: [2, 2], doneBlock: {
                picker, indexes, values in
                
                print("values = \(values)")
                print("indexes = \(indexes)")
                print("picker = \(picker)")
                return
        }, cancel: { ActionMultipleStringCancelBlock in return }, origin: sender)*/
        
    }

    @IBAction func Med2Pressed(_ sender: Any) {
        
        Med1.backgroundColor = UIColor.clear
        Med2.backgroundColor = UIColor.lightGray
        Med3.backgroundColor = UIColor.clear
        Med4.backgroundColor = UIColor.clear
        Med5.backgroundColor = UIColor.clear
        
        appearImage = "Med2"
    }
    
    @IBAction func Med3Pressed(_ sender: Any) {
        
        Med1.backgroundColor = UIColor.clear
        Med2.backgroundColor = UIColor.clear
        Med3.backgroundColor = UIColor.lightGray
        Med4.backgroundColor = UIColor.clear
        Med5.backgroundColor = UIColor.clear
        
        appearImage = "Med3"
        
    }

    @IBAction func Med4Pressed(_ sender: Any) {
        
        Med1.backgroundColor = UIColor.clear
        Med2.backgroundColor = UIColor.clear
        Med3.backgroundColor = UIColor.clear
        Med4.backgroundColor = UIColor.lightGray
        Med5.backgroundColor = UIColor.clear
        
        appearImage = "Med4"
        
    }
    
    @IBAction func Med5Pressed(_ sender: Any) {
        
        Med1.backgroundColor = UIColor.clear
        Med2.backgroundColor = UIColor.clear
        Med3.backgroundColor = UIColor.clear
        Med4.backgroundColor = UIColor.clear
        Med5.backgroundColor = UIColor.lightGray
        
        appearImage = "Med5"
        
    }
    
    
    
    @IBAction func whiteButtonPressed(_ sender: Any) {
        
        whiteButton.backgroundColor = UIColor.lightGray
        pinkButton.backgroundColor = UIColor.clear
        yellowButton.backgroundColor = UIColor.clear
        blueButton.backgroundColor = UIColor.clear
        greenButton.backgroundColor = UIColor.clear
        orangeButton.backgroundColor = UIColor.clear
        brownButton.backgroundColor = UIColor.clear
        blackButton.backgroundColor = UIColor.clear
        
        colorImage = "White"
        
    }
    
    @IBAction func pinkButtonPressed(_ sender: Any) {
        whiteButton.backgroundColor = UIColor.clear
        pinkButton.backgroundColor = UIColor.lightGray
        yellowButton.backgroundColor = UIColor.clear
        blueButton.backgroundColor = UIColor.clear
        greenButton.backgroundColor = UIColor.clear
        orangeButton.backgroundColor = UIColor.clear
        brownButton.backgroundColor = UIColor.clear
        blackButton.backgroundColor = UIColor.clear
        
        colorImage = "Pink"
        
    }
    
    @IBAction func yellowButtonPressed(_ sender: Any) {
        whiteButton.backgroundColor = UIColor.clear
        pinkButton.backgroundColor = UIColor.clear
        yellowButton.backgroundColor = UIColor.lightGray
        blueButton.backgroundColor = UIColor.clear
        greenButton.backgroundColor = UIColor.clear
        orangeButton.backgroundColor = UIColor.clear
        brownButton.backgroundColor = UIColor.clear
        blackButton.backgroundColor = UIColor.clear
        
        colorImage = "Yellow"
    }
    
    @IBAction func blueButtonPressed(_ sender: Any) {
        whiteButton.backgroundColor = UIColor.clear
        pinkButton.backgroundColor = UIColor.clear
        yellowButton.backgroundColor = UIColor.clear
        blueButton.backgroundColor = UIColor.lightGray
        greenButton.backgroundColor = UIColor.clear
        orangeButton.backgroundColor = UIColor.clear
        brownButton.backgroundColor = UIColor.clear
        blackButton.backgroundColor = UIColor.clear
        
        colorImage = "Blue"
    }
    
    @IBAction func greenButtonPressed(_ sender: Any) {
        whiteButton.backgroundColor = UIColor.clear
        pinkButton.backgroundColor = UIColor.clear
        yellowButton.backgroundColor = UIColor.clear
        blueButton.backgroundColor = UIColor.clear
        greenButton.backgroundColor = UIColor.lightGray
        orangeButton.backgroundColor = UIColor.clear
        brownButton.backgroundColor = UIColor.clear
        blackButton.backgroundColor = UIColor.clear
        
        colorImage = "Green"
    }
    
    @IBAction func orangeButtonPressed(_ sender: Any) {
        whiteButton.backgroundColor = UIColor.clear
        pinkButton.backgroundColor = UIColor.clear
        yellowButton.backgroundColor = UIColor.clear
        blueButton.backgroundColor = UIColor.clear
        greenButton.backgroundColor = UIColor.clear
        orangeButton.backgroundColor = UIColor.lightGray
        brownButton.backgroundColor = UIColor.clear
        blackButton.backgroundColor = UIColor.clear
        
        colorImage = "Orange"
    }

    @IBAction func brownButtonPressed(_ sender: Any) {
        whiteButton.backgroundColor = UIColor.clear
        pinkButton.backgroundColor = UIColor.clear
        yellowButton.backgroundColor = UIColor.clear
        blueButton.backgroundColor = UIColor.clear
        greenButton.backgroundColor = UIColor.clear
        orangeButton.backgroundColor = UIColor.clear
        brownButton.backgroundColor = UIColor.lightGray
        blackButton.backgroundColor = UIColor.clear
        
        colorImage = "Brown"
    }

    @IBAction func blackButtonPressed(_ sender: Any) {
        whiteButton.backgroundColor = UIColor.clear
        pinkButton.backgroundColor = UIColor.clear
        yellowButton.backgroundColor = UIColor.clear
        blueButton.backgroundColor = UIColor.clear
        greenButton.backgroundColor = UIColor.clear
        orangeButton.backgroundColor = UIColor.clear
        brownButton.backgroundColor = UIColor.clear
        blackButton.backgroundColor = UIColor.lightGray
        
        colorImage = "Black"
    }
}


extension UIImage {
    enum JPEGQuality: CGFloat {
        case lowest  = 0
        case low     = 0.25
        case medium  = 0.5
        case high    = 0.75
        case highest = 1
    }
   
    var png: Data? { return UIImagePNGRepresentation(self) }
    
    /// Returns the data for the specified image in JPEG format.
    /// If the image object’s underlying image data has been purged, calling this function forces that data to be reloaded into memory.
    /// - returns: A data object containing the JPEG data, or nil if there was a problem generating the data. This function may return nil if the image has no data or if the underlying CGImageRef contains data in an unsupported bitmap format.
    func jpeg(_ quality: JPEGQuality) -> Data? {
        return UIImageJPEGRepresentation(self, quality.rawValue)
    }
}
