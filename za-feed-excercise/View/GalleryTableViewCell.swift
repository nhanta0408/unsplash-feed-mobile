//
//  GalleryTableViewCell.swift
//  za-feed-excercise
//
//  Created by gcshcm on 24/03/2022.
//

import UIKit

typealias  LikeClickParameter = (String, Bool) -> Void
class GalleryTableViewCell: UITableViewCell {

    @IBOutlet weak var likeImage: UIView!
    @IBOutlet weak var unsplashImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var likesLabel: UILabel!
    
    var post: Post!
    var likeClikedClosure: LikeClickParameter!
    override func awakeFromNib() {
        super.awakeFromNib()
        likeImage.tintColor = .myBlue
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.likeClicked(_:)))
        likeImage.addGestureRecognizer(tap)
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
        userNameLabel.text = post.username
        likesLabel.text = String(post.likes)
        unsplashImageView.load(url: URL(string: post.url)!)
        likeImage.tintColor = post.likedByUser ? UIColor.myBlue : UIColor.gray
    }

    @objc func likeClicked(_ sender: UITapGestureRecognizer? = nil) {
        likeClikedClosure(post.id, post.likedByUser)
    }
}
