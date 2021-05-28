//
//  ImageCommentCellController.swift
//  EssentialFeediOS
//
//  Created by Ricardo Herrera Petit on 5/27/21.
//  Copyright © 2021 Essential Developer. All rights reserved.
//

import UIKit
import EssentialFeed

public class ImageCommentCellController: CellController {
	private let model: ImageCommentViewModel

	public init(model: ImageCommentViewModel) {
		self.model = model
	}
	
	public func view(in tableView: UITableView) -> UITableViewCell {
		let cell: ImageCommentCell = tableView.dequeueReusableCell()
		cell.messageLabel.text = model.message
		cell.dateLabel.text = model.date
		cell.usernameLabel.text = model.username
		return cell
	}
	
	public func preload() {
	
	}
	
	public func cancelLoad() {
	
	}
	
	
}
