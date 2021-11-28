//
//  ViewController.swift
//  Photorama
//
//  Created by user203264 on 11/28/21.
//

import UIKit

class PhotosViewController: UIViewController, UICollectionViewDelegate {
    
//    @IBOutlet private var imageView: UIImageView!
    @IBOutlet var collectionView: UICollectionView!
    var store: PhotoStore!
    let photoDataSource = PhotoDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = photoDataSource
        collectionView.delegate = self
        
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

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath){
        let photo = photoDataSource.photos[indexPath.row]
        
        // Download image data
        store.fetchImage(for: photo) { (result) -> Void in
            
            // index path for photo might have changed
            // so find the most recent index path
            guard let photoIndex = self.photoDataSource.photos.firstIndex(of: photo), case let .success(image) = result else{
                return
            }
            let photoIndexPath = IndexPath(item: photoIndex, section: 0)
            
            // when request finishes, find current cell for this photo
            if let cell = self.collectionView.cellForItem(at: photoIndexPath) as? PhotoCollectionViewCell{
                cell.update(displaying: image)
            }
        
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        switch segue.identifier{
        case "showPhoto":
            if let selectedIndexPath = collectionView.indexPathsForSelectedItems?.first{
                
                let photo = photoDataSource.photos[selectedIndexPath.row]
                
                let destinationVC = segue.destination as! PhotoInfoViewController
                destinationVC.photo = photo
                destinationVC.store = store
            }
        default:
            preconditionFailure("Unexpected segue identifier.")
        }
    }

}

