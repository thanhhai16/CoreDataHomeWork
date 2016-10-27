//
//  AdClassCourseViewController.swift
//  Class_Student
//
//  Created by Hai on 10/25/16.
//  Copyright © 2016 Hai. All rights reserved.
//

import UIKit
import CoreData

class AddClassViewController: UIViewController {
    
    @IBOutlet weak var addClassField : UITextField!
    @IBOutlet weak var addButton : UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Add Class"
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addClass(_ sender: AnyObject) {
        
        DataManager.share.creatNewClass(name: addClassField.text!)
        addButton.isEnabled = false
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
