//
//  GalleryTableViewCell.swift
//  za-feed-excercise
//
//  Created by gcshcm on 24/03/2022.
//

import UIKit

class GalleryTableViewCell: UITableViewCell {

    @IBOutlet weak var likeImage: UIView!
    @IBOutlet weak var unsplashImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var likesLabel: UILabel!
    
    var username: String = ""
    var imageUrl: String = ""
    var likes: String = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        likeImage.tintColor = .myBlue
        unsplashImageView.layer.cornerRadius = 10

//        userNameLabel.text = "Nhan Huu Ta"
//        likesLabel.text = "1234"
//        unsplashImageView.load(url: URL(string: "https://images.unsplash.com/photo-1648022991331-717b6e2323ad?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwzMTI3MTB8MHwxfGFsbHwyfHx8fHx8Mnx8MTY0ODEzNDU2OQ&ixlib=rb-1.2.1&q=80&w=1080")!)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateCell(){
        userNameLabel.text = username
        likesLabel.text = likes
        unsplashImageView.load(url: URL(string: imageUrl)!)
    }
}
