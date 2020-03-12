//
//  CricketersViewModel.swift
//  Cricketers
//
//  Created by Adaikalraj on 11/03/20.
//  Copyright © 2020 Test. All rights reserved.
//

import UIKit
import CoreData

// MARK:- Protocol delegate for CricketersListViewController.

protocol CricketersViewModelDelegate: class {
    func didFinishLoading()
}


// MARK:- Protocol delegate for CricketersListViewController.

protocol ProfileViewModelDelegate: class {
    func didFinishLoading()
}


class CricketersViewModel: NSObject {
    
    weak var delegate: CricketersViewModelDelegate?
    weak var profileDelegate: ProfileViewModelDelegate?
    var cricketData = [NSManagedObject]()
    var noResultView = UIView()
    
    override init() {
    }
    
    // MARK:- Fetching data from coreData.
    
    func loadData(type: Int){
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Cricketers")
        request.returnsObjectsAsFaults = false
        
        do {
            cricketData = try context.fetch(request) as! [NSManagedObject]
            if type == 1{
                delegate?.didFinishLoading()
            }
            else if type == 2{
                profileDelegate?.didFinishLoading()
            }
            
        }
        catch {
            print("Error while fetching data: \(error)")
            if type == 1{
                delegate?.didFinishLoading()
            }
            else if type == 2{
                profileDelegate?.didFinishLoading()
            }
        }
    }
    
}


// MARK:- TableView Datasource

extension CricketersViewModel: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if cricketData.count > 0{
            tableView.backgroundView = nil
            return cricketData.count
        }
        else{
            tableView.backgroundView = noResultView
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CricketersTableViewCell") as! CricketersTableViewCell
        let data = cricketData[indexPath.row]
        cell.selectionStyle = .none
        cell.nameLabel.text = data.value(forKey: "name") as? String
        cell.descriptionLabel.text = data.value(forKey: "detail") as? String
        let imageUrlString = data.value(forKey: "image") as! String
        let imageUrl = URL(string: imageUrlString)!
        let imageData = try! Data(contentsOf: imageUrl)
        cell.profileImageView.image = UIImage(data: imageData)
        return cell
    }
    
}


// MARK:- CollectionView DataSource

extension CricketersViewModel: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if cricketData.count > 0{
            collectionView.backgroundView = nil
            return cricketData.count
        }
        else{
            collectionView.backgroundView = noResultView
            return 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CricketersProfileCollectionViewCell", for: indexPath) as! CricketersProfileCollectionViewCell
        let data = cricketData[indexPath.item]
        let imageUrlString = data.value(forKey: "image") as! String
        let imageUrl = URL(string: imageUrlString)!
        let imageData = try! Data(contentsOf: imageUrl)
        cell.cricketersImageView.image = UIImage(data: imageData)
        return cell
    }
    
}


// MARK:- Custom collectionview layout delegate

extension CricketersViewModel: CollectionLayoutDelegate {
    
    func collectionView(_ collectionView: UICollectionView, sizeOfPhotoAtIndexPath indexPath: IndexPath) -> CGSize {
        let data = cricketData[indexPath.item]
        let imageUrlString = data.value(forKey: "image") as! String
        let imageUrl = URL(string: imageUrlString)!
        let imageData = try! Data(contentsOf: imageUrl)
        let image = UIImage(data: imageData)
        return image!.size
    }
}
