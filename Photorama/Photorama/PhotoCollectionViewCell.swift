//
//  PhotoCollectionViewCell.swift
//  Photorama
//
//  Created by user203264 on 11/28/21.
//

import UIKit

class PhotoCollectionViewCell: UITableViewCell {
    
    @IBOutlet var imageTitle: UILabel!
    @IBOutlet var imageDate: UILabel!
//    @IBOutlet var imageView: UIImageView!
    
    func update(displaying image: Photo?){
           if let imageToDisplay = image{
//               spinner.stopAnimating()
               imageTitle.text = imageToDisplay.title
           } else{
//               spinner.startAnimating()
               imageTitle.text = "Not Found"
           }
       }

}
