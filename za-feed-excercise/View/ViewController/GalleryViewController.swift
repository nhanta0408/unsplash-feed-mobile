//
//  GalleryViewController.swift
//  za-feed-excercise
//
//  Created by gcshcm on 24/03/2022.
//

import UIKit

class GalleryViewController: UIViewController {

    
    @IBOutlet weak var galleryTableView: UITableView!
    var postModels: [PostModel]?
    let imageRepository = ImageRepository()
    let galleryViewModel: GalleryViewModelProtocol = GalleryViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(onRightBarButtonClick))
        galleryTableView.dataSource = self
        galleryTableView.allowsSelection = false
        
        galleryViewModel.posts.bind{ (_) in
            DispatchQueue.main.async {
                self.galleryTableView.reloadData()
            }
        }


    }
    @objc func onRightBarButtonClick(){
        //navigationController?.popToRootViewController(animated: true)
        galleryViewModel.getListPhoto()
    }
    

}
extension GalleryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return galleryViewModel.posts.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        galleryTableView.register(UINib.init(nibName: "GalleryTableViewCell", bundle: nil), forCellReuseIdentifier: "GalleryTableViewCell")
        let cell = galleryTableView.dequeueReusableCell(withIdentifier: "GalleryTableViewCell", for: indexPath) as! GalleryTableViewCell

        cell.post = galleryViewModel.posts.value[indexPath.row]

        // Don't use the "binding method" to avoid reloading all table. It is need to just update one cell
        cell.likeClikedClosure = { id, isLiked in
            self.galleryViewModel.handleLikeDislikeClick(imageId: id, isLiked: isLiked, currentPost: cell.post){ post in
                cell.post = post
                cell.updateCell()
            }
            
        }
        cell.updateCell()
        return cell
    }
    
    
}
