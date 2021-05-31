//
//  CellController.swift
//  EssentialFeediOS
//
//  Created by Ricardo Herrera Petit on 5/30/21.
//  Copyright © 2021 Essential Developer. All rights reserved.
//

import UIKit

public struct CellController  {
	let dataSource: UITableViewDataSource
	let delegate: UITableViewDelegate?
	let datasourcePrefecthing: UITableViewDataSourcePrefetching?
	
	public init(_ dataSource: UITableViewDataSource & UITableViewDelegate & UITableViewDataSourcePrefetching) {
		self.dataSource = dataSource
		self.delegate = dataSource
		self.datasourcePrefecthing = dataSource
	}
	
	public init(_ dataSource: UITableViewDataSource) {
		self.dataSource = dataSource
		self.delegate = nil
		self.datasourcePrefecthing = nil
	}
}
