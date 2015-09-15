//
//  ViewController.swift
//  SwiftHoedownDemoiOS
//
//  Created by Niels de Hoog on 15/09/15.
//  Copyright © 2015 Invisible Pixel. All rights reserved.
//

import UIKit
import WebKit
import SwiftHoedown

class WebViewController: UIViewController {
    let webView = WKWebView()
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func loadView() {
        self.view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let sampleFile = NSBundle.mainBundle().pathForResource("sample", ofType: "md")
        let markdown = try! String(contentsOfFile: sampleFile!)
        if let html = Hoedown.renderHTMLForMarkdown(markdown) {
            webView.loadHTMLString(html, baseURL: nil)
        }
    }
}

