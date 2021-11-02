//
//  BottleRocketController.swift
//  Restaurant Project
//
//  Created by Yevgeniy Ivanov on 11/2/21.
//

import Foundation

import Foundation

import WebKit


class BottleRocketController: UIViewController, WKUIDelegate {
    
    var webView: WKWebView!
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)

        view = webView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myURL = URL(string:"https://www.bottlerocketstudios.com")
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
    }}
