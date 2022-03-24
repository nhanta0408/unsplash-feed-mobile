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
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(onRightBarButtonClick))
        
        galleryTableView.dataSource = self
        galleryTableView.allowsSelection = false

    }
    @objc func onRightBarButtonClick(){
        //navigationController?.popToRootViewController(animated: true)
        
        postModels = imageRepository.getListImage();
        galleryTableView.reloadData()
    }
    

}
extension GalleryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postModels?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        galleryTableView.register(UINib.init(nibName: "GalleryTableViewCell", bundle: nil), forCellReuseIdentifier: "GalleryTableViewCell")
        let cell = galleryTableView.dequeueReusableCell(withIdentifier: "GalleryTableViewCell", for: indexPath) as! GalleryTableViewCell
        cell.username = postModels?[indexPath.row].user.username ?? ""
        return cell
    }
    
    
}
