//
//  WebViewController.swift
//  Guess the Fighter, Угадай Бойца
//
//  Created by Artem on 12/4/16.
//  Copyright © 2016 piqapp. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var link: String!
    var currentTitle: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.currentTitle = "Realtime Database"
        self.titleLabel.text = self.currentTitle
        
        self.link = "https://console.firebase.google.com/project/dpvip-5fe49/database/data"
        let url = URL (string: link)
        let requestObj = URLRequest(url: url!)
        webView.loadRequest(requestObj)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func closeButtonPressed(_ sender: UIButton) {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    @IBAction func forwardButton(_ sender: UIButton) {
        self.webView.goForward()
    }
    @IBAction func backButton(_ sender: UIButton) {
        self.webView.goBack()
    }
    
    @IBAction func stopButton(_ sender: UIButton) {
        self.webView.stopLoading()
    }
    
    @IBAction func refreshButton(_ sender: UIButton) {
        self.webView.reload()
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
