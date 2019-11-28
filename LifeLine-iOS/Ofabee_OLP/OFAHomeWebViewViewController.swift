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
        webKitHome.allowsLinkPreview = false
        
        let url = Bundle.main.url(forResource: "Lifeline_Linked_Sites/lifeline_btns", withExtension: "html")!
        let request = URLRequest(url: URL(string: url.absoluteString)!)
        webKitHome.load(request)
        self.view.addSubview(webKitHome)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = "Home"
    }
   
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.setNavigationBarItem(isSidemenuEnabled: true)
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
//                (UIApplication.shared.delegate as! AppDelegate).initializeMyCourse() MyCoursesContainerVC
                let myCoursePage = self.storyboard?.instantiateViewController(withIdentifier: "MyCoursesContainerVC") as! OFAMyCoursesContainerViewController
                myCoursePage.isFromHomePage = true
                self.navigationItem.title = ""
                self.navigationController?.pushViewController(myCoursePage, animated: true)
            }else if navigationAction.request.url!.absoluteString.contains("https://api.whatsapp.com"){
                guard let whatsappURL = URL(string: navigationAction.request.url!.absoluteString) else { return }
                if UIApplication.shared.canOpenURL(whatsappURL){
                    UIApplication.shared.open(whatsappURL, options: [:], completionHandler: nil)
                }else{
                    self.navigationController?.pushViewController(webKitPreview, animated: true)
                }
            }else if navigationAction.request.url!.absoluteString.contains("mailto:"){
                guard let mailURL = URL(string: navigationAction.request.url!.absoluteString) else { return }
                if UIApplication.shared.canOpenURL(mailURL){
                    UIApplication.shared.open(mailURL, options: [:], completionHandler: nil)
                }else{
                    let mailAlert = UIAlertController(title: "Sorry", message: "Seems like you don't have any mailing application. Do you want to copy email address?", preferredStyle: .alert)
                    mailAlert.addAction(UIAlertAction(title: "Copy", style: .default, handler: { (action) in
                        let emailAddress = mailURL.absoluteString.emailAddresses()
                        print(emailAddress)
                        let pasteboard = UIPasteboard.general
                        pasteboard.string = emailAddress[0]
                        OFAUtils.showToastWithTitle("Email Address copied to clipboard")
                    }))
                    mailAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) in
                        
                    }))
                    self.present(mailAlert, animated: true, completion: nil)
                }
            }else{
                self.navigationController?.pushViewController(webKitPreview, animated: true)
            }
            return
        }else{
            print("no link")
            decisionHandler(WKNavigationActionPolicy.allow)
        }
    }
    
}

extension String {
    /** Get email addresses in a string, discard any other content. */
    func emailAddresses() -> [String] {
        var addresses = [String]()
        if let detector = try? NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue) {
            let matches = detector.matches(in: self, options: [], range: NSMakeRange(0, self.count))
            for match in matches {
                if let matchURL = match.url,
                    let matchURLComponents = URLComponents(url: matchURL, resolvingAgainstBaseURL: false),
                    matchURLComponents.scheme == "mailto"
                {
                    let address = matchURLComponents.path
                    addresses.append(String(address))
                }
            }
        }
        return addresses
    }
}
