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

class TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var data = [String]()
    var keys = [String]()
    
    var ref: FIRDatabaseReference?
    var dataBaseHandle: FIRDatabaseHandle?
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        //knopka share
        let share = UITableViewRowAction(style: .default, title: "Share", handler: { (action, indexPath)-> Void in
            let activityController = UIActivityViewController(activityItems: ["Text here"], applicationActivities: nil)
            self.present(activityController, animated: true, completion: nil)
            
        })
        
        //knopka udalit' restoran
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

}

