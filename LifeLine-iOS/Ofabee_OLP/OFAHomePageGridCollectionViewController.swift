//
//  OFAHomePageGridCollectionViewController.swift
//  Life_Line
//
//  Created by Administrator on 9/11/18.
//  Copyright © 2018 Administrator. All rights reserved.
//

import UIKit

class OFAHomePageGridCollectionViewController: UICollectionViewController {

    var arrayHomeTitles = ["E-LEARN","E-BOOKS","STORE","EVENTS","MEDITATE","LIFELINE TV","PODCASTS"]
    var arrayIndices = [0,1,2,3,4,5,6]
    let userId = UserDefaults.standard.value(forKey: USER_ID) as? String
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = "Lifeline"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
            self.setNavigationBarItem(isSidemenuEnabled: false)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arrayHomeTitles.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCell", for: indexPath) as! OFAHomePageCollectionViewCell
        cell.customizeCellWithDetails(iconName: "AppLogo_vertical", heading: self.arrayHomeTitles[indexPath.row])
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        if self.arrayIndices.contains(indexPath.row){
            switch indexPath.row{
            case 0:
                if userId == nil {
                    let browseCourse = self.storyboard?.instantiateViewController(withIdentifier: "BrowseCourseTVC") as!OFABrowseCourseTableViewController
                    self.navigationItem.title = ""
                    UIApplication.shared.statusBarStyle = .lightContent
                    self.navigationController?.pushViewController(browseCourse, animated: true)
                }else{
                    delegate.initializeMyCourse()
                }
            case 1:
                if userId == nil {
                    delegate.initializePreLoginPage()
                }else{
                    let browseCourse = self.storyboard?.instantiateViewController(withIdentifier: "E-BookTVC") as! OFAE_BooksListTableViewController
                    self.navigationItem.title = ""
                    self.navigationController?.pushViewController(browseCourse, animated: true)
                }
            case 2:
                let storeWebView = self.storyboard?.instantiateViewController(withIdentifier: "WebViewController") as! OFAWebViewViewController
                storeWebView.isFromHome = true
                storeWebView.contentURL = "http://lifelinemcs.org/store/?v=c86ee0d9d7ed"
                storeWebView.pageHeading = "Store"
                self.navigationItem.title = ""
                self.navigationController?.pushViewController(storeWebView, animated: true)
            case 3:
                let eventsWebView = self.storyboard?.instantiateViewController(withIdentifier: "WebViewEventsController") as! OFAWebViewUpcomingEventsViewController
                eventsWebView.isFromHome = true
                self.navigationItem.title = ""
                self.navigationController?.pushViewController(eventsWebView, animated: true)
            case 4:
                if userId == nil {
                    delegate.initializePreLoginPage()
                }else{
                    let meditationPage = self.storyboard?.instantiateViewController(withIdentifier: "MeditationTVC") as! OFAMeditationTableViewController
                    self.navigationItem.title = ""
                    self.navigationController?.pushViewController(meditationPage, animated: true)
                }
            case 5:
                let youtubeWebView = self.storyboard?.instantiateViewController(withIdentifier: "WebViewController") as! OFAWebViewViewController
                youtubeWebView.isFromHome = true
                youtubeWebView.contentURL = "https://www.youtube.com/user/drppvijay/videos"
                youtubeWebView.pageHeading = "Lifeline TV"
                self.navigationItem.title = ""
                self.navigationController?.pushViewController(youtubeWebView, animated: true)
            default:
                if userId == nil {
                    delegate.initializePreLoginPage()
                }else{
                    OFAUtils.showToastWithTitle("Under construction")
                }
            }
        }
    }
    
    @objc func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.sectionInset = UIEdgeInsets(top: 6, left: 4, bottom: 6, right: 4)
        layout.minimumInteritemSpacing = 04
        layout.minimumLineSpacing = 04
        layout.invalidateLayout()
        return CGSize(width: ((self.view.frame.width/2) - 6), height: ((self.view.frame.width / 2) - 6))
    }
}
