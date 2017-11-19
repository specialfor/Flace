//
//  ConfigurableCell.swift
//  Nynja
//
//  Created by Volodymyr Hryhoriev on 10/23/17.
//  Copyright © 2017 TecSynt Solutions. All rights reserved.
//

protocol ConfigurableCell: class {
    
    static var cellId: String { get }
    
    func setup(with model: CellModel)
    
}
