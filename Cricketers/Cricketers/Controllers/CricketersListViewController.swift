//
//  CricketersListViewController.swift
//  Cricketers
//
//  Created by Adaikalraj on 10/03/20.
//  Copyright © 2020 Test. All rights reserved.
//

import UIKit
import CoreData

class CricketersListViewController: UIViewController,UITableViewDelegate {
    
    @IBOutlet weak var cricketTableView: UITableView!
    @IBOutlet var noResultView: UIView!
    
    var activityIndicator = UIActivityIndicatorView()
    var viewModel = CricketersViewModel()
    var saveInCoreData = SaveInCoreData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator.color = .yellow
        activityIndicator.center = self.view.center
        activityIndicator.style = .large
        self.view.addSubview(activityIndicator)
        
        cricketTableView.delegate = self
        cricketTableView.dataSource = viewModel
        cricketTableView.separatorStyle = .none
        cricketTableView.rowHeight = UITableView.automaticDimension
        cricketTableView.estimatedRowHeight = 150
        
        viewModel.delegate = self
        viewModel.noResultView = noResultView
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        activityIndicator.startAnimating()
        loadData()
    }
    
    
    // MARK:- API call
    
    func loadData(){
        
        let url = "https://api.myjson.com/bins/t533e"
        APIHandler.getResponse(url: url, method: "get", json: nil, completionHandler: { (error,responseJSON,urlResponse) in
            
            if responseJSON != nil{
                let json = responseJSON!
                let cricketersArray = json["players"] as! [[String:Any]]
                
                for cricketer in cricketersArray {
                    let item = CricketersModel.init(id: cricketer["id"] as! Int, name: cricketer["name"] as! String, description: cricketer["description"] as! String, image: cricketer["imageUrl"] as! String)
                    DispatchQueue.main.async {
                        self.saveInCoreData.saveData(item: item)
                    }
                }
            }
            DispatchQueue.main.async {
                self.viewModel.loadData(type: 1)
                self.activityIndicator.stopAnimating()
            }
        })
    }

    
    // MARK:- Tableview Delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let nextViewController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(identifier: "CricketersProfileViewController") as! CricketersProfileViewController
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
}


//MARK:- protocol delegate

extension CricketersListViewController: CricketersViewModelDelegate {
    func didFinishLoading() {
        cricketTableView.reloadData()
    }
}

