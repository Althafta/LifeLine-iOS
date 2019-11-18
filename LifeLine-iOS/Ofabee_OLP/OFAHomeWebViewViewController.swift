//
//  OFAHomeWebViewViewController.swift
//  Life_Line
//
//  Created by Enfin on 18/11/19.
//  Copyright © 2019 Administrator. All rights reserved.
//

import UIKit
import WebKit

class OFAHomeWebViewViewController: UIViewController,WKScriptMessageHandler,WKNavigationDelegate {

    //@IBOutlet var webKitHome: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let configuration = WKWebViewConfiguration()
        configuration.userContentController.add(self, name: "Ofabee_OLP")
        
        let webKitHome = WKWebView(frame: self.view.frame, configuration: configuration)
        webKitHome.navigationDelegate = self
        
        let url = Bundle.main.url(forResource: "Lifeline_Linked_Sites/lifeline_btns", withExtension: "html")!
        let request = URLRequest(url: URL(string: url.absoluteString)!)
        webKitHome.load(request)
        self.view.addSubview(webKitHome)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = "Lifeline"
    }
   
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.setNavigationBarItem(isSidemenuEnabled: false)
    }

    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        print("Recieved Message :- \(message)")
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if navigationAction.navigationType == .linkActivated{
            print(navigationAction.request.url!.absoluteString)
            decisionHandler(WKNavigationActionPolicy.cancel)
            let webKitPreview = self.storyboard?.instantiateViewController(withIdentifier: "HomePreviewVC") as! OFAHomePreviewWebKitViewController
            webKitPreview.contentURLRequest = navigationAction.request
            webKitPreview.pageHeading = "Lifeline"
            self.navigationItem.title = ""
            if navigationAction.request.url!.absoluteString.contains("https://elearning.lifelinemcs.org"){
                (UIApplication.shared.delegate as! AppDelegate).initializeMyCourse()
            }
            self.navigationController?.pushViewController(webKitPreview, animated: true)
            return
        }else{
            print("no link")
            decisionHandler(WKNavigationActionPolicy.allow)
        }
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        OFAUtils.showLoadingViewWithTitle(nil)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        OFAUtils.removeLoadingView(nil)
    }
    
}
