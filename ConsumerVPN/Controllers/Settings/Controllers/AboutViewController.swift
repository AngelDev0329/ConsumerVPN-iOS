//
//  AboutViewController.swift
//  ConsumerVPN
//
//  Created by Amir Nazari on 9/20/16.
//  Copyright © 2018 Stackpath. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {

    @IBOutlet weak var daWebView: UIWebView!
    @IBOutlet weak var versionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup Colors
        versionLabel.textColor = .primaryFont
        view.backgroundColor = .primaryBackground
        
        populateText()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loadWebview()
    }
    
    func loadWebview() {
        
        let htmlURL = Bundle.main.path(forResource: "tos", ofType: "html")
        do {
            let contents = try String(contentsOfFile: htmlURL!, encoding: String.Encoding.utf8)
            daWebView.loadHTMLString(contents, baseURL: Bundle.main.bundleURL)
        } catch {
            print("There was an error loading the webview")
        }
    }
    
    func populateText() {
    
        guard let buildNumber = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") else {return}
        guard let versionNumber = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") else {return}
        
        //TODO: Replace with localized string constant
        versionLabel.text = "Version \(versionNumber) (\(buildNumber))"
        versionLabel.textColor = .primaryFont
    }
}

extension AboutViewController : UIWebViewDelegate {
    
    /// This will open an external web browser whenever a link is selected.
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebView.NavigationType) -> Bool {
        if navigationType == UIWebView.NavigationType.linkClicked {
            UIApplication.shared.open(request.url!)
            return false
        }
        return true
    }
}



