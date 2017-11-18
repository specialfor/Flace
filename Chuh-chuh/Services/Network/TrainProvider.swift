//
//  TrainProvider.swift
//  Chuh-chuh
//
//  Created by Volodymyr Hryhoriev on 11/18/17.
//  Copyright © 2017 Nobles Team. All rights reserved.
//

import Moya

class TrainProvider {
    
    let provider = MoyaProvider<TrainTarget>()
    
    func fetchTrains(with model: SearchModel) {
        provider.request(.fecthTrains(model: model)) { (result) in
            switch result {
            case .success(let response):
                let data = response.data
                let string = String.init(data: data, encoding: .utf8)
                print(string)
                break
            case .failure(let error):
                break
            }
        }
    }
    
}
