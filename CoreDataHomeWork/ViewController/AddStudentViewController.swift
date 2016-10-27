//
//  AddStudentViewController.swift
//  Class_Student
//
//  Created by Hai on 10/26/16.
//  Copyright © 2016 Hai. All rights reserved.
//

import UIKit
import CoreData

class AddStudentViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    var classCourse : ClassEntity?
    var date: NSDate?
    
    @IBOutlet weak var studentName : UITextField!
    @IBOutlet weak var studentAddress : UITextField!
    //@IBOutlet weak var studentDate : UIDatePicker!
    @IBOutlet weak var studentDate : UITextField!
    @IBOutlet weak var studentPictrure : UIImageView!
    @IBOutlet weak var addButton : UIButton!
    
    let imagePicker = UIImagePickerController()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Add Student"

        
        studentName.delegate = self
        studentAddress.delegate = self
        studentPictrure.image = UIImage(named: "user.png")
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapImage))
        studentPictrure.addGestureRecognizer(tapGesture)
        
        

        // Do any additional setup after loading the view.
    }
    
    func tapImage() {
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func addStudent(_ sender: AnyObject) {
        if let picture = UIImageJPEGRepresentation(studentPictrure.image!, 1) as NSData? {
        DataManager.share.createStundent(name: studentName.text!, address: studentAddress.text!, date: date!,classCourse : classCourse!, pictrure: picture )
        }
        addButton.isEnabled = false
        
        self.navigationController?.popViewController(animated: true)
        
    }

    @IBAction func dateTextFieldEdit(_ sender: UITextField) {
        var datePicker : UIDatePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.locale = Locale(identifier: "vi_VN")
        datePicker.frame.size.height = 100
        sender.inputView = datePicker
        datePicker.addTarget(self, action: #selector(didChange(sender:)), for: .valueChanged)
        

    }
        func didChange(sender: UIDatePicker) {
        let dateFormat = DateFormatter()
        dateFormat.dateStyle = .long
        dateFormat.locale = Locale(identifier: "vi_VN")
        date = sender.date as NSDate?
        studentDate.text = dateFormat.string(from: sender.date)
        
        
    }
    func touchesBegan(touches: NSSet!, withEvent event: UIEvent!) {
        self.view.endEditing(true)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.studentPictrure.image = pickedImage
        }
        dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)

    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == self.studentDate {
            self.studentDate.resignFirstResponder()
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if (textField == self.studentName) {
            self.studentAddress.becomeFirstResponder()
        }
        if (textField == self.studentAddress) {
            self.studentDate.becomeFirstResponder()
        }
                return true
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
   

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
