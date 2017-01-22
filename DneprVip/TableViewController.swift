//
//  ViewController.swift
//  DneprVip
//
//  Created by Artem on 1/17/17.
//  Copyright © 2017 ApiqA. All rights reserved.
//

import UIKit
import FirebaseDatabase
import PCLBlurEffectAlert

/*
 
 ref?.child("Posts").childByAutoId().setValue(self.textView.text!)
 
 
 */


class TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var data = [String]()
    var keys = [String]()
    
    var ref: FIRDatabaseReference?
    var dataBaseHandle: FIRDatabaseHandle?
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var tapGesture: UITapGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(TableViewController.hideKeyboard))
        tapGesture.cancelsTouchesInView = true
        tableView.addGestureRecognizer(tapGesture)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        ref = FIRDatabase.database().reference()
        
        dataBaseHandle = ref?.child("Posts").observe(.childAdded, with: { (snapshot) in
            //add listener to our Posts, of event child Added
            //take the value from snapshot
            
            let post = snapshot.value as? String
            if let actualPost = post {
                
                self.data.append(actualPost)
                self.keys.append(snapshot.key)
                self.tableView.reloadData()
            }
        })
    }
    
    func hideKeyboard() {
        tableView.endEditing(true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "Cell")
        cell?.textLabel?.text = self.data[indexPath.row]
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //dismiss keyboard input
        self.view.endEditing(true)
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        //knopka DELETE ALL (ex share)
        let share = UITableViewRowAction(style: .default, title: "Delete All", handler: { (action, indexPath)-> Void in
            
            self.deleteAllPostsFromDatabaseAndTableView()
            
            ///activity controller
            //self.activityControllerInit()
        })
        
        //knopka udalit' post
        let delete = UITableViewRowAction(style: .default, title: "Delete", handler: { (action, indexPath) -> Void in
            
            ///delete from database
            self.ref?.child("Posts").child(self.keys[indexPath.row]).removeValue()
            
            ///delete from app
            self.data.remove(at: indexPath.row)
            self.keys.remove(at: indexPath.row)
            
            self.tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.fade)
        })
        
        share.backgroundColor = UIColor.black
        delete.backgroundColor = UIColor.magenta
        
        return [share, delete]
    }
    
    @IBAction func sendButtonPressed(_ sender: UIButton) {
        if textView.text != "" {
            ref?.child("Posts").childByAutoId().setValue(self.textView.text!)
            textView.text = ""
        }
    }
    
    func deleteAllPostsFromDatabaseAndTableView() {
        //delete all posts
        self.ref?.child("Posts").setValue(nil)
        self.data.removeAll()
        self.keys.removeAll()
        self.tableView.reloadData()
    }
    
    //for share button //unused
    func activityControllerInit() {
        let activityController = UIActivityViewController(activityItems: ["Text here"], applicationActivities: nil)
         self.present(activityController, animated: true, completion: nil)

    }
}

