//
//  RatingListViewController.swift
//  Chuh-chuh
//
//  Created by Volodymyr Hryhoriev on 11/19/17.
//  Copyright © 2017 Nobles Team. All rights reserved.
//

import UIKit
import CoreLocation
import MultiSelectSegmentedControl

enum Filter: Int {
    case byRating
    case byDistance
    
    var filterClosure: (RatingListCellModel, RatingListCellModel) -> Bool {
        switch self {
        case .byRating:
            return { model1, model2 in
                return model1.place.rating >= model2.place.rating
            }
        case .byDistance:
            return { model1, model2 in
                if let distance1 = model1.distance, let distance2 = model2.distance {
                    return distance1 <= distance2
                }
                
                return true
            }
        }
        
    }
}

class RatingListViewController: ViewController {
    
    var filter: Filter!
    var tags: Set<Tag> = []
    
    // MARK: Views
    lazy var tableView: UITableView = {
        let tView = UITableView()
        
        self.view.addSubview(tView)
        tView.snp.makeConstraints({ (make) in
            make.top.left.right.equalToSuperview()
        })
        
        return tView
    }()
    
    lazy var segmentControl: UISegmentedControl = {
        let sControl = UISegmentedControl(items: ["Rating", "Distance"])
        
        self.view.addSubview(sControl)
        sControl.snp.makeConstraints({ (make) in
            make.top.equalTo(tableView.snp.bottom).offset(16.0)
            make.centerX.equalToSuperview()
        })
        
        return sControl
    }()
    
    lazy var tagsSegment: MultiSelectSegmentedControl = {
        let sControl = MultiSelectSegmentedControl(items: Tag.titles)
        
        let inset = 16.0
        
        self.view.addSubview(sControl)
        sControl.snp.makeConstraints({ (make) in
            make.top.equalTo(segmentControl.snp.bottom).offset(inset)
            make.left.equalTo(inset)
            make.right.bottom.equalTo(-inset)
        })
        
        return sControl
    }()
    
    // MARK: View lifecycle
    override func initialize() {
        navigationItem.title = "Rating List"
        configureTableView()
        
        segmentControl.addTarget(self, action: #selector(filterChanged), for: .valueChanged)
        segmentControl.selectedSegmentIndex = 0
        filter = Filter(rawValue: segmentControl.selectedSegmentIndex)
        
        tagsSegment.isHidden = false
        tagsSegment.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        reloadTable()
    }
    
    // MARK: Configure
    var models: [RatingListCellModel] = []
    
    private func configureTableView() {
        tableView.register(RatingListCell.self, forCellReuseIdentifier: RatingListCell.cellId)
        
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.tableFooterView = nil
        tableView.rowHeight = RatingListCell.height
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func reloadTable() {
        setupDatasource()
        tableView.reloadData()
    }
    
    private func setupDatasource() {
        models = []
        let places = StorageService.default.places
        for i in 0..<places.count {
            let model = RatingListCellModel(index: i + 1, place: places[i])
            models.append(model)
        }
        
        if !tags.isEmpty {
            models = models.filter { (model) -> Bool in
                let set = Set<Tag>(model.place.tags)
                return set.intersection(tags) == tags
            }
        }
        
        models.sort(by: filter.filterClosure)
    }
 
    // MARK: Action
    @objc private func filterChanged() {
        filter = Filter(rawValue: segmentControl.selectedSegmentIndex)
        reloadTable()
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

// MARK: MultiSelectSegmentedControlDelegate
extension RatingListViewController: MultiSelectSegmentedControlDelegate {
    
    func multiSelect(_ multiSelectSegmentedControl: MultiSelectSegmentedControl, didChangeValue value: Bool, at index: UInt) {
        
        let arr = multiSelectSegmentedControl.selectedSegmentIndexes.map { Tag(rawValue: $0)! }
        tags = Set<Tag>(arr)
        reloadTable()
    }
    
}
