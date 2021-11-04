//
//  BottleRocketController.swift
//  Restaurant Project
//
//  Created by Yevgeniy Ivanov on 11/2/21.
//

import WebKit

protocol BottleRocketVCDelegate {
    func done()
}
class BottleRocketController: UIViewController, WKUIDelegate {
    var delegate:BottleRocketVCDelegate?
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
        setupNavBar()
    }
    
    func setupNavBar(){
        
        self.navigationController?.navigationBar.titleTextAttributes =
        [NSAttributedString.Key.foregroundColor: UIColor(red: 1, green: 1, blue: 1, alpha: 1.0),
         NSAttributedString.Key.font: UIFont(name:"Avenir Next Demi Bold",size:17) ?? 0]
        
        let backLeftBarButton  = UIBarButtonItem(image: UIImage(named: "ic_webBack"), style: .done, target: self, action: nil)
        let refreshLeftBarButton = UIBarButtonItem(image: UIImage(named: "ic_webRefresh"), style: .done, target: self, action: nil)
        let forwardLeftBarButton = UIBarButtonItem(image: UIImage(named: "ic_webForward"), style: .done, target: self, action: nil)
        
        backLeftBarButton.tintColor = .white
        refreshLeftBarButton.tintColor = .white
        forwardLeftBarButton.tintColor = .white
        
        navigationItem.leftBarButtonItems = [backLeftBarButton, refreshLeftBarButton,forwardLeftBarButton]
        
        title = "Lunch Tyme"
       view.backgroundColor = UIColor(red: 67/255, green: 232/255, blue: 149/255, alpha: 1.0)
        self.navigationController?.navigationBar.backgroundColor = UIColor(red: 67/255, green: 232/255, blue: 149/255, alpha: 1.0)
    }
    
}

//extension BottleRocketController: UINavigationBarDelegate
//{
//    func position(for bar: UIBarPositioning) -> UIBarPosition {
//        return .topAttached
//    }
//
//}
