//
//  TrainTarget.swift
//  Chuh-chuh
//
//  Created by Volodymyr Hryhoriev on 11/18/17.
//  Copyright © 2017 Nobles Team. All rights reserved.
//

import Moya

enum TrainTarget {
    case filter(title: String)
    case fecthTrains(model: SearchModel)
}

extension TrainTarget: TargetType {
    var baseURL: URL {
        return URL(string: "https://booking.uz.gov.ua/purchase")!
    }
    
    var path: String {
        switch self {
        case .filter:
            return "/station"
        case .fecthTrains:
            return "/search"
        }
    }
    
    var method: Method {
        switch self {
        case .filter:
            return .get
        case .fecthTrains:
            return .post
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .filter(let title):
            return .requestParameters(parameters: ["term" : title], encoding: URLEncoding.queryString)
        case .fecthTrains(let model):
            return .requestParameters(parameters: model.dictionary, encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
//        return ["Content-type": "application/json"]
        return nil
    }
    
}

