//
//  CellController.swift
//  EssentialFeediOS
//
//  Created by Ricardo Herrera Petit on 5/30/21.
//  Copyright © 2021 Essential Developer. All rights reserved.
//

import UIKit

public struct CellController  {
	let id: AnyHashable
	let dataSource: UITableViewDataSource
	let delegate: UITableViewDelegate?
	let datasourcePrefecthing: UITableViewDataSourcePrefetching?
	
	public init(id: AnyHashable, _ dataSource: UITableViewDataSource & UITableViewDelegate & UITableViewDataSourcePrefetching) {
		self.id = id
		self.dataSource = dataSource
		self.delegate = dataSource
		self.datasourcePrefecthing = dataSource
	}
	
	public init(id:AnyHashable,  _ dataSource: UITableViewDataSource) {
		self.id = id
		self.dataSource = dataSource
		self.delegate = nil
		self.datasourcePrefecthing = nil
	}
}

extension CellController: Equatable {
	public static func == (lhs: CellController, rhs: CellController) -> Bool {
		lhs.id == rhs.id
	}
}
extension CellController: Hashable {
	public func hash(into hasher: inout Hasher) {
		hasher.combine(id)
	}
}
