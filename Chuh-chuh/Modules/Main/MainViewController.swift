//
//  MainViewController.swift
//  Chuh-chuh
//
//  Created by Volodymyr Hryhoriev on 11/18/17.
//  Copyright © 2017 Nobles Team. All rights reserved.
//

import UIKit

class MainViewController: ViewController {
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let from = StationModel(id: 2204001, title: "Харків")
        let to = StationModel(id: 2200200, title: "Вінниця")
        let model = SearchModel(from: from, to: to, date: "08.12.2017", time: "00:00")
        
        let provider = TrainProvider()
        provider.fetchTrains(with: model)
    }
    
}
