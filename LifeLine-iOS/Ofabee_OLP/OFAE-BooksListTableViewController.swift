//
//  OFAE-BooksListTableViewController.swift
//  Life_Line
//
//  Created by Syam PJ on 25/09/18.
//  Copyright © 2018 Administrator. All rights reserved.
//

import UIKit
import THPDFKit

class OFAE_BooksListTableViewController: UITableViewController {

    lazy var pdfView: PDFViewControllerWrapper? = {
        let pdfView = self.storyboard?.instantiateViewController(withIdentifier: "THPDFKit") as! PDFViewControllerWrapper
        return pdfView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.backgroundColor = OFAUtils.getColorFromHexString(ofabeeCellBackground)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        self.navigationItem.title = "My Books"
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "E-BookCell", for: indexPath) as! OFAE_BookListTableViewCell

        cell.customizeCellWithDetails(imageURLString: "https://images.pexels.com/photos/67636/rose-blue-flower-rose-blooms-67636.jpeg?cs=srgb&dl=beauty-bloom-blue-67636.jpg&fm=jpg", bookTitle: "Sample Book \(indexPath.row + 1)", bookDetails: "Sample Book \(indexPath.row + 1)", percentage: "50")

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        pdfView?.url = URL(string: "http://www.pdf995.com/samples/pdf.pdf")
        pdfView?.navigationItem.title = "Book Title"
        pdfView?.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.dismissPresentedPDF))
        NotificationCenter.default.addObserver(self, selector: #selector(self.PDFStatusNotification(notification:)), name: NSNotification.Name(rawValue: "PDFStatus"), object: nil)
        let nav = UINavigationController(rootViewController: pdfView!)
        OFAUtils.lockOrientation(.portrait)
        pdfView?.navigationController?.navigationBar.tintColor = UIColor.white
        pdfView?.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        pdfView?.navigationController?.navigationBar.barTintColor = OFAUtils.getColorFromHexString(barTintColor)
        self.present(nav, animated: true, completion: nil)

//        if #available(iOS 11.0, *) {
//            let pdfViewer = self.storyboard?.instantiateViewController(withIdentifier: "PDFDocumentVC") as! OFAPDFDocumentViewController
//            pdfViewer.pdfTitle = "Book Title"
//            pdfViewer.pdfURLString = "https://www.sample-videos.com/pdf/Sample-pdf-5mb.pdf"
//            pdfViewer.lectureID = ""
//            pdfViewer.percentage = "1"
//            pdfViewer.isE_Book = true
//            self.navigationItem.title = ""
//            self.navigationController?.pushViewController(pdfViewer, animated: true)
//        } else {
//            // Fallback on earlier versions
//            OFAUtils.showToastWithTitle("You need to update ur phone to ios 11 to view Books")
//        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    override func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        OFAUtils.showLoadingViewWithTitle(nil)
    }
    
    override func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        OFAUtils.removeLoadingView(nil)
    }
    
    @objc func dismissPresentedPDF(){
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func PDFStatusNotification(notification:Notification){
        let dicPDFStatus = notification.userInfo! as NSDictionary
        OFAUtils.showAlertViewControllerWithinViewControllerWithTitle(viewController: self.pdfView!, alertTitle: nil, message: "\(dicPDFStatus["status"]!)", cancelButtonTitle: "OK")
    }
}
