//
//  LoadingCell.swift
//  za-feed-excercise
//
//  Created by NhanHuuTa on 25/03/2022.
//

import UIKit

class LoadingCell: UITableViewCell {

    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
