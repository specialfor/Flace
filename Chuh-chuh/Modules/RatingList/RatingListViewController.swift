//
//  RatingListViewController.swift
//  Chuh-chuh
//
//  Created by Volodymyr Hryhoriev on 11/19/17.
//  Copyright © 2017 Nobles Team. All rights reserved.
//

import UIKit

class RatingListViewController: ViewController {
    
    // MARK: Views
    lazy var tableView: UITableView = {
        let tView = UITableView()
        
        self.view.addSubview(tView)
        tView.snp.makeConstraints({ (make) in
            make.edges.equalToSuperview()
        })
        
        return tView
    }()
    
    // MARK: View lifecycle
    override func initialize() {
        navigationItem.title = "Rating List"
        
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupDatasource()
        tableView.reloadData()
    }
    
    // MARK: Configure
    var models: [RatingListCellModel] = []
    
    private func configureTableView() {
        tableView.register(RatingListCell.self, forCellReuseIdentifier: RatingListCell.cellId)
        
        tableView.separatorStyle = .none
        tableView.tableFooterView = nil
        tableView.rowHeight = RatingListCell.height
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func setupDatasource() {
        models = []
        let places = StorageService.default.places
        for i in 0..<places.count {
            let model = RatingListCellModel(index: i + 1, place: places[i])
            models.append(model)
        }
        models.sort { (model1, model2) -> Bool in
            return model1.place.rating >= model2.place.rating
        }
    }
    
}

// MARK: UITableViewDataSource
extension RatingListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: RatingListCell.cellId, for: indexPath) as! ConfigurableCell
        
        cell.setup(with: models[indexPath.row])
        
        return cell as! UITableViewCell
    }
    
}

// MARK: UITablewViewDelegate
extension RatingListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        SplashRouter.shared.showPlaceDetails(models[indexPath.row].place)
    }
    
}
