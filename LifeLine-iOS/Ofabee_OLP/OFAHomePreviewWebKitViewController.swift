//
//  OFAHomePreviewWebKitViewController.swift
//  Life_Line
//
//  Created by Enfin on 18/11/19.
//  Copyright © 2019 Administrator. All rights reserved.
//

import UIKit
import WebKit

class OFAHomePreviewWebKitViewController: UIViewController {

    var contentURLRequest : URLRequest?
    var pageHeading = ""
    
    @IBOutlet weak var webKitPreview: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.webKitPreview.load(contentURLRequest!)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = self.pageHeading
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
