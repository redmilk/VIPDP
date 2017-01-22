//
//  ComposeViewController.swift
//  DneprVip
//
//  Created by Artem on 1/17/17.
//  Copyright © 2017 ApiqA. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ComposeViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    
    var ref: FIRDatabaseReference?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.ref = FIRDatabase.database().reference()
    }
    
   

    @IBAction func postButtonHandler(_ sender: UIBarButtonItem) {
        
        
        
        presentingViewController?.dismiss(animated: true, completion: nil)

        
    }

}
