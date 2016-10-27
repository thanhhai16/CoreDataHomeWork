//
//  ViewController.swift
//  Class_Student
//
//  Created by Hai on 10/25/16.
//  Copyright © 2016 Hai. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var classTableView : UITableView!
    
    var classCourses = DataManager.share.listClassCourse()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.classTableView.delegate = self
        self.classTableView.dataSource = self
        print("avava", classCourses?.count)
        let addButton   = UIBarButtonItem(title: "Add",  style: .plain, target: self, action: #selector(didTapAddButton))
        
        self.navigationItem.rightBarButtonItem = addButton
        
        if classCourses?.count == 0 {
            classTableView.separatorStyle = .none
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        classCourses = DataManager.share.listClassCourse()
        if classCourses?.count != 0 {
            classTableView.separatorStyle = .singleLine
        }
        classTableView.reloadData()
    }
    func didTapAddButton(sender: AnyObject) {
        let addClassViewController = self.storyboard?.instantiateViewController(withIdentifier: "AddClassViewController") as! AddClassViewController
        
        self.navigationController?.pushViewController(addClassViewController, animated: true)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return classCourses!.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let studentControllerView = self.storyboard?.instantiateViewController(withIdentifier: "StudentViewController") as! StudentViewController
        let row = indexPath.row
        studentControllerView.classCourse = classCourses?[row]
        studentControllerView.title = (classCourses?[row].name)! + " Class"
        self.navigationController?.pushViewController(studentControllerView, animated: true)
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            DataManager.share.deleteClass(classCourse: (classCourses?[indexPath.row])!)
            classCourses = DataManager.share.listClassCourse()
            classTableView.reloadData()
            
        }
    }
    
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "classCourseCell", for: indexPath)
        
        let nameClassCourse = cell.contentView.viewWithTag(1) as! UILabel
        nameClassCourse.text = classCourses?[indexPath.row].name
        
        let numberOfStundentClass = cell.contentView.viewWithTag(2) as! UILabel
        let number = classCourses![indexPath.row].number
        let numberAsString = "\(number)"
        numberOfStundentClass.text = numberAsString
        
        return cell
    }
   
}

