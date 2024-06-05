//
//  DocsSite.swift
//  KraftyDraftOfficial
//
//  Created by Richard Miller on 4/12/18.
//  Copyright © 2018 TechPro Solutions. All rights reserved.
//

import Foundation
import UIKit
import WebKit

class PPSite: UIViewController {
    
    var webView: WKWebView!
    var transferText = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        webView = WKWebView()
        view.addSubview(webView)
        
        parent?.title = transferText
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let frame = CGRect(x: 0, y: 0, width: self.view .bounds.width, height: self.view.bounds.height)
        self.webView.frame = frame
        //let urlStr = self.transferText
        let urlStr = "http://krafty.mytechproshop.com/PPTOS/privacy_policy.html"
        let url = URL(string: urlStr)!
        let request = URLRequest(url: url)
        
        self.webView.load(request)
        self.webView.autoresizingMask = [.flexibleWidth, .flexibleHeight,]
        
        
    }
}

