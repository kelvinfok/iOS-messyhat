//
//  WebViewController.swift
//  messyhat-ios
//
//  Created by kelvinfok on 4/8/16.
//  Copyright © 2016 kelvinfok. All rights reserved.
//

import UIKit

class WebViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var webView: UIWebView!
    
    var URLKey = ""
    
    @IBOutlet weak var activityMonitor: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.webView.delegate = self
        self.tabBarController?.tabBar.hidden = true
        print("URL KEY IS \(URLKey)")
        
        if URLKey.rangeOfString("http://") != nil || URLKey.rangeOfString("https://") != nil {
        }
        else {
            URLKey = "http://" + URLKey
        }

        let url = NSURL(string: "\(URLKey)")!
        webView.loadRequest(NSURLRequest(URL: url))
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        activityMonitor.startAnimating()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func webViewDidStartLoad(webView: UIWebView) {
        activityMonitor.hidden = false
        activityMonitor.startAnimating()
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        activityMonitor.stopAnimating()
        activityMonitor.hidden = true
    }
    
    


}
