//
//  PhotoInfoViewController.swift
//  Photorama
//
//  Created by user203264 on 11/28/21.
//

import UIKit

class PhotoInfoViewController: UIViewController{
    
    // MARK: - Initialize
    
    @IBOutlet var nameField: UILabel!
    @IBOutlet var valueField: UILabel!
    @IBOutlet var descriptionField: UILabel!
    @IBOutlet var imageView: UIImageView!
      
    var photo: Photo! {
        didSet{
            navigationItem.title = photo.title
            navigationItem.leftBarButtonItem?.title = "back"
            
        }
    }
    
//    var imageStore: ImageStore!
    
    var photoStore: PhotoStore!
    
    
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)
        
        nameField.text = photo.title
//
//        // get the item key
//        let key = photo.photoID

        // if three is an associated image with the item, display it on the image view
        photoStore.fetchImage (for: photo){ (imageResult) -> Void in
                switch imageResult{
                case let .success(image):
                    self.imageView.image = image
                case let .failure(error):
                    print("Error downloading image: \(error)")
                }
//            imageView.image = imageToDisplay

    }
    }
    
    override func viewWillDisappear(_ animated: Bool){
        super.viewWillDisappear(animated)
        
        // clear first responder
        view.endEditing(true)
        
        
    }
    
    // MARK: - Formatting
    
    
    
}
    


