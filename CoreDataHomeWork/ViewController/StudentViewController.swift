//
//  StudentViewController.swift
//  Class_Student
//
//  Created by Hai on 10/26/16.
//  Copyright © 2016 Hai. All rights reserved.
//

import UIKit
import CoreData

class StudentViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    var classCourse : ClassEntity!
    @IBOutlet weak var studentTableView : UITableView!
    var students = [StudentEntity]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.studentTableView.delegate = self
        self.studentTableView.dataSource = self
        
        students = DataManager.share.listStudent(classCourse: classCourse)!
        
        
        let addButton   = UIBarButtonItem(title: "Add",  style: .plain, target: self, action: #selector(didTapAddButton))
        
        self.navigationItem.rightBarButtonItem = addButton
        
        if students.count == 0 {
            studentTableView.separatorStyle = .none
        }
        

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        students.removeAll()
        students = DataManager.share.listStudent(classCourse: classCourse)!
        if students.count != 0 {
            studentTableView.separatorStyle = .singleLine
        }
        studentTableView.reloadData()


    }
    
    
    func didTapAddButton(sender: AnyObject) {
        let addStudentViewController = self.storyboard?.instantiateViewController(withIdentifier: "AddStudentViewController") as! AddStudentViewController
        addStudentViewController.classCourse = classCourse
        self.navigationController?.pushViewController(addStudentViewController, animated: true)
        
        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
       func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(
        _ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let students = DataManager.share.listStudent(classCourse: classCourse)
        return (students?.count)!
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        
        
        students = DataManager.share.listStudent(classCourse: classCourse)!
        
        let student = students[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "studentCourseCell", for: indexPath)
        
        let studentName = cell.contentView.viewWithTag(1) as! UILabel
        studentName.text = student.name
        
        
        let studentAddress = cell.contentView.viewWithTag(2) as! UILabel
        studentAddress.text = student.address
        
        let studentPicture = cell.contentView.viewWithTag(3) as! UIImageView
        studentPicture.image = UIImage(data: student.picture as! Data)
        studentPicture.clipsToBounds = true
        
        let studentDate = cell.contentView.viewWithTag(4) as! UILabel
        let dateFormater = DateFormatter()
        dateFormater.dateStyle = .short
        dateFormater.locale = Locale(identifier: "vi_VN")
        studentDate.text = dateFormater.string(from: student.date as! Date)
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            students = DataManager.share.listStudent(classCourse: classCourse)!
            DataManager.share.deleteStudent(student: students[indexPath.row], classCourse: classCourse)
            if students.count == 0 {
                studentTableView.separatorStyle = .none
            }
            studentTableView.reloadData()
            
        }
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
