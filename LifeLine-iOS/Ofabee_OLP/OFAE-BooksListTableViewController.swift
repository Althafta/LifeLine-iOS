//
//  OFAE-BooksListTableViewController.swift
//  Life_Line
//
//  Created by Syam PJ on 25/09/18.
//  Copyright © 2018 Administrator. All rights reserved.
//

import UIKit

class OFAE_BooksListTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.backgroundColor = OFAUtils.getColorFromHexString(ofabeeCellBackground)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = "My Books"
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
        if #available(iOS 11.0, *) {
            let pdfViewer = self.storyboard?.instantiateViewController(withIdentifier: "PDFDocumentVC") as! OFAPDFDocumentViewController
            pdfViewer.pdfTitle = "Book Title"
            pdfViewer.pdfURLString = "https://www.sample-videos.com/pdf/Sample-pdf-5mb.pdf"
            pdfViewer.lectureID = ""
            pdfViewer.percentage = "1"
            pdfViewer.isE_Book = true
            self.navigationItem.title = ""
            self.navigationController?.pushViewController(pdfViewer, animated: true)
        } else {
            // Fallback on earlier versions
            OFAUtils.showToastWithTitle("You need to update ur phone to ios 11 to view Books")
        }
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
}
