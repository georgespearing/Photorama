//
//  PhotoDataSource.swift
//  Photorama
//
//  Created by user203264 on 11/28/21.
//

import UIKit

class PhotoDataSource: NSObject, UITableViewDataSource{
    
    var photos = [Photo]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return photos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
//        // create instance of UITableViewCell with default appearance
//        tableView.register(tableView.self, forCellReuseIdentifier: "Cell")
        // get a new or recycled cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoCollectionViewCell", for: indexPath) as! PhotoCollectionViewCell
        
        // set the text on the cell with the description of the item
        // that is at the nth idex of items, where n = row this cell
        // will appear in on the table view
        let item = photos[indexPath.row]
        
        // configure the cell with the Item
        let dateFormatter = DateFormatter()

        dateFormatter.dateStyle = DateFormatter.Style.medium
//            dateFormatter.timeStyle = DateFormatter.Style.short

        let strDate = dateFormatter.string(from: item.dateTaken)
        
        cell.imageTitle.text=item.title
        cell.imageDate.text = strDate
//        cell.valueLabel.text = "\(item.valueInDollars)"
//        if (item.valueInDollars >= 5){
//            cell.valueLabel.textColor = UIColor.green
//        } else{
//            cell.valueLabel.textColor = UIColor.red
//        }
        
        return cell
    }
}
