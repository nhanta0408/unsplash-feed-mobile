//
//  GalleryViewController.swift
//  za-feed-excercise
//
//  Created by NhanHuuTa on 24/03/2022.
//

import UIKit

class GalleryViewController: UIViewController {

    
    @IBOutlet weak var galleryTableView: UITableView!
    var postModels: [PostModel]?
    let imageRepository = ImageRepository()
    let galleryViewModel: GalleryViewModelProtocol = GalleryViewModel()
    var isLoading = false

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(onRightBarButtonClick))
        galleryTableView.dataSource = self
        galleryTableView.delegate = self
        galleryTableView.allowsSelection = false
        
        //Only reload in case loadMore. Like/Dislike is only update specific cell.
        //Reason: when reload, the cell has to fetch Image by url. It can use cache to store the current image to avoid fetch everytime reload
        galleryViewModel.newCountOfPosts.bind{ (_) in
            DispatchQueue.main.async {
                self.galleryTableView.reloadData()
                self.isLoading = false //Completion
            }
        }


    }
    @objc func onRightBarButtonClick(){
        navigationController?.popToRootViewController(animated: true)
    }
    

}
extension GalleryViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section==0){
            return galleryViewModel.newCountOfPosts.value
        }
        else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.section == 0) {
            galleryTableView.register(UINib.init(nibName: "GalleryTableViewCell", bundle: nil), forCellReuseIdentifier: "GalleryTableViewCell")
            let cell = galleryTableView.dequeueReusableCell(withIdentifier: "GalleryTableViewCell", for: indexPath) as! GalleryTableViewCell

            //cell.post = galleryViewModel.newPosts.value[indexPath.row]
            cell.post = galleryViewModel.uptodatePosts[indexPath.row]
            cell.indexNumber = indexPath.row + 1

            // Don't use the "binding method" to avoid reloading all table. It is need to just update one cell
            cell.likeClikedClosure = { id, isLiked in
                self.galleryViewModel.handleLikeDislikeClick(imageId: id, isLiked: isLiked){ post in
                    cell.post = post
                    cell.updateCell()
                }
                
            }
            cell.updateCell()
            return cell
        }
        else {
            if(galleryViewModel.newCountOfPosts.value < Constant.maximumPosts){
                galleryTableView.register(UINib.init(nibName: "LoadingCell", bundle: nil), forCellReuseIdentifier: "LoadingCell")
                let cell = galleryTableView.dequeueReusableCell(withIdentifier: "LoadingCell", for: indexPath) as! LoadingCell
                cell.loadingIndicator.startAnimating();
                return cell
            }
            else {
                galleryTableView.register(UINib.init(nibName: "BlankCell", bundle: nil), forCellReuseIdentifier: "BlankCell")
                let cell = galleryTableView.dequeueReusableCell(withIdentifier: "BlankCell", for: indexPath) as! BlankCell
                return cell
            }
        }
       
    }
    
}

extension GalleryViewController: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
               let contentHeight = scrollView.contentSize.height
        if (offsetY > contentHeight - scrollView.frame.height) && !isLoading {
                   isLoading = true
                   galleryViewModel.loadMoreData{
                   }
               }
    }
}
