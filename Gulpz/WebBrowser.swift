//
//  WebBrowser.swift
//  Gulpz
//
//  Created by Jett on 3/8/19.
//  Copyright © 2019 Jett. All rights reserved.
//

import UIKit
import WebKit

class WebBrowser: UIViewController, WKNavigationDelegate {
    var url: String?
    static func create() -> WebBrowser {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WebBrowser") as! WebBrowser
    }
    
    var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let url = url, let finalUrl = URL(string: url) {
            webView = WKWebView()
            webView.navigationDelegate = self
            view = webView
            webView.load(URLRequest(url: finalUrl))
            webView.allowsBackForwardNavigationGestures = true
        }
    }
    
}
