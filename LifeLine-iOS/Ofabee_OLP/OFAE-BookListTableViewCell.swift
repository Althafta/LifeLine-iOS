//
//  OFAE-BookListTableViewCell.swift
//  Life_Line
//
//  Created by Syam PJ on 25/09/18.
//  Copyright © 2018 Administrator. All rights reserved.
//

import UIKit

class OFAE_BookListTableViewCell: UITableViewCell {

    @IBOutlet weak var viewInner: UIView!
    @IBOutlet weak var imageViewBookCover: UIImageView!
    @IBOutlet weak var buttonBookTitle: UIButton!
    @IBOutlet weak var labelBookDetails: UILabel!
    @IBOutlet weak var labelPercentage: UILabel!
    @IBOutlet weak var buttonProgress: MHProgressButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func customizeCellWithDetails(imageURLString:String,bookTitle:String,bookDetails:String,percentage:String){
        self.buttonBookTitle.setTitle(bookTitle, for: .normal)
        self.labelBookDetails.text = bookDetails
        
        guard let n = NumberFormatter().number(from: percentage) else { return }
        self.buttonProgress.linearLoadingWith(progress: CGFloat(truncating: n))
        
        self.buttonProgress.layer.cornerRadius = self.buttonProgress.frame.height/2
        self.labelPercentage.text = "\(percentage) %"
        self.imageViewBookCover.sd_setImage(with: URL(string: imageURLString), placeholderImage: #imageLiteral(resourceName: "Default image"), options: .progressiveDownload)
        self.viewInner.dropShadow()
    }
}
