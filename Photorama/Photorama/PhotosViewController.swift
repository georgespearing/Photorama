//
//  ViewController.swift
//  Photorama
//
//  Created by user203264 on 11/28/21.
//

import UIKit

class PhotosViewController: UIViewController {
    
//    @IBOutlet private var imageView: UIImageView!
    @IBOutlet var collectionView: UICollectionView!
    var store: PhotoStore!
    let photoDataSource = PhotoDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = photoDataSource
        
//        store.fetchInterestingPhotos()
        store.fetchInterestingPhotos {
            (photosResult) in
            switch photosResult {
            case let .success(photos):
                print("Successfully found \(photos.count) photos.")
                self.photoDataSource.photos = photos
//                if let firstPhoto = photos.first {
//                    self.updateImageView(for: firstPhoto)
//                }
            case let .failure(error):
                print("Error fetching interesting photos: \(error)")
                self.photoDataSource.photos.removeAll()
            }
            self.collectionView.reloadSections(IndexSet(integer: 0))
        }
    }
    
//    func updateImageView(for photo: Photo){
//        store.fetchImage(for: photo){
//            (imageResult) in
//            switch imageResult{
//            case let .success(image):
//                self.imageView.image = image
//            case let .failure(error):
//                print("Error downloading image: \(error)")
//            }
//        }
//    }


}

