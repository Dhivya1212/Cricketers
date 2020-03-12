//
//  CricketersProfileViewController.swift
//  Cricketers
//
//  Created by Adaikalraj on 10/03/20.
//  Copyright © 2020 Test. All rights reserved.
//

import UIKit

class CricketersProfileViewController: UIViewController {

    @IBOutlet weak var profileCollectionView: UICollectionView!
    @IBOutlet var noResultView: UIView!
    
    var viewModel = CricketersViewModel()
    var profileData = [ProfileModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        profileCollectionView.dataSource = viewModel
        
        viewModel.profileDelegate = self
        viewModel.noResultView = noResultView
        
        if let layout = profileCollectionView.collectionViewLayout as? CollectionLayout {
            layout.delegate = viewModel
        }
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.loadData(type: 2)
    }

}


// MARK:- Protocol delegate.

extension CricketersProfileViewController: ProfileViewModelDelegate{
    func didFinishLoading() {
        profileCollectionView.reloadData()
    }
    
    
}


