//
//  ViewController.swift
//  Photorama
//
//  Created by user203264 on 11/28/21.
//

import UIKit

class PhotosViewController: UITableViewController {
    
//    @IBOutlet private var imageView: UIImageView!
//    @IBOutlet var collectionView: UITableView!
    var store: PhotoStore!
    let photoDataSource = PhotoDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Photo Viewer"
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 65
        
        tableView.dataSource = photoDataSource
        tableView.delegate = self
        
//        store.fetchInterestingPhotos()
        store.fetchInterestingPhotos {
            (photosResult) in
            switch photosResult {
            case let .success(photos):
                print("Successfully found \(photos.count) photos.")
                self.photoDataSource.photos = photos
                print(self.photoDataSource.photos.count)
//                if let firstPhoto = photos.first {
//                    self.updateImageView(for: firstPhoto)
//                }
            case let .failure(error):
                print("Error fetching interesting photos: \(error)")
                self.photoDataSource.photos.removeAll()
            }
            
//            for index in 0...self.photoDataSource.photos.count{
//                let indexPath = IndexPath(row: index, section: 0)
//                self.tableView.insertRows(at: [indexPath], with: .automatic)
            //        self.tableView.reloadSections(IndexSet(integer: 0), with: UITableView.RowAnimation.left)
//                    }
            
        }
//        for index in 1...self.photoDataSource.photos.count{
//            let indexPath = IndexPath(row: index, section: 0)
//        tableView.insertRows(at: [indexPath], with: .automatic)
        tableView.reloadSections(IndexSet(integer: 0), with: UITableView.RowAnimation.left)
//        }
    }
    
//    required init?(coder aDecoder: NSCoder){
//        super.init(coder: aDecoder)
//
//        navigationItem.leftBarButtonItem = editButtonItem
//    }
//
    
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return photoDataSource.photos.count
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

//    func collectionView(_ collectionView: UITableView, willDisplay cell: UITableViewCell, forItemAt indexPath: IndexPath){
//        let photo = photoDataSource.photos[indexPath.row]
//        
//        // Download image data
//        store.fetchImage(for: photo) { (result) -> Void in
//            
//            // index path for photo might have changed
//            // so find the most recent index path
//            guard let photoIndex = self.photoDataSource.photos.firstIndex(of: photo), case let .success(image) = result else{
//                return
//            }
//            let photoIndexPath = IndexPath(item: photoIndex, section: 0)
//            
//            // when request finishes, find current cell for this photo
//            if let cell = self.collectionView.cellForRow(at: photoIndexPath) as? PhotoCollectionViewCell{
////                cell.update(displaying: image)
//            }
//        
//        }
//    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forItemAt indexPath: IndexPath){
//        let photo = photoDataSource.photos[indexPath.row]
                
        // set the text on the cell with the description of the item
        // that is at the nth idex of items, where n = row this cell
        // will appear in on the table view
        let item = photoDataSource.photos[indexPath.row]
        
        // configure the cell with the Item
        let dateFormatter = DateFormatter()

        dateFormatter.dateStyle = DateFormatter.Style.medium
//            dateFormatter.timeStyle = DateFormatter.Style.short

        let strDate = dateFormatter.string(from: item.dateTaken)
     
        
        // when request finishes, find current cell for this photo
        if let cell = tableView.cellForRow(at: indexPath) as? PhotoCollectionViewCell{
            cell.update(displaying: item)
            cell.imageTitle.text=item.title
            cell.imageDate.text = strDate
                   }
        
        
        
        
    }
    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
//        
////        // create instance of UITableViewCell with default appearance
////        tableView.register(tableView.self, forCellReuseIdentifier: "Cell")
//        // get a new or recycled cell
//        let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoCollectionViewCell", for: indexPath) as! PhotoCollectionViewCell
//        
//        // set the text on the cell with the description of the item
//        // that is at the nth idex of items, where n = row this cell
//        // will appear in on the table view
//        let item = photoDataSource.photos[indexPath.row]
//        
//        // configure the cell with the Item
//        let dateFormatter = DateFormatter()
//
//        dateFormatter.dateStyle = DateFormatter.Style.medium
////            dateFormatter.timeStyle = DateFormatter.Style.short
//
//        let strDate = dateFormatter.string(from: item.dateTaken)
//        
//        cell.imageTitle.text=item.title
//        cell.imageDate.text = strDate
////        cell.valueLabel.text = "\(item.valueInDollars)"
////        if (item.valueInDollars >= 5){
////            cell.valueLabel.textColor = UIColor.green
////        } else{
////            cell.valueLabel.textColor = UIColor.red
////        }
//        
//        return cell
//    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        // if the triggered segue is the "showItem" segue
        switch segue.identifier{
        case "showPhoto":
            // Figure out which row was just tapped
            if let row = tableView.indexPathForSelectedRow?.row{
                // Get the item associated with this row and pass it along
                let item = photoDataSource.photos[row]
                let photoInfoViewController = segue.destination as! PhotoInfoViewController
                photoInfoViewController.photoStore = store
                photoInfoViewController.photo = item
                
            }
        default:
            preconditionFailure("Unexpected segue Identifier")
        }
    }
    
    @IBAction func addNewItem(_ sender: UIBarButtonItem){
       // make a new index path for the 0 section, last row

       // insert this new row into the table
//         Create a new item and add it to the store
//        let newItem = itemStore.createItem()
        
        var photos = photoDataSource.photos

        tableView.beginUpdates()
        for (photo_index, photo) in photos.enumerated(){
        // figure out where that item is in the array
        
//            tableView.beginUpdates()
            if let index = photos.firstIndex(of: photo){
            let indexPath = IndexPath(row: index, section: 0)

            // insert this new row into the table
            tableView.insertRows(at: [indexPath], with: .automatic)
            
            }
        }
        tableView.endUpdates()
    }

}

