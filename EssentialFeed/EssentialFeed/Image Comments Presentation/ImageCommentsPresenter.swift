//
//  ImageCommentsPresenter.swift
//  EssentialFeed
//
//  Created by Ricardo Herrera Petit on 5/25/21.
//  Copyright © 2021 Essential Developer. All rights reserved.
//

import Foundation

//
//  Copyright © 2019 Essential Developer. All rights reserved.
//

import Foundation

public final class ImageCommentsPresenter {
	public static var title: String {
		return NSLocalizedString("IMAGE_COMMENTS_VIEW_TITLE",
			 tableName: "ImageComments",
			 bundle: Bundle(for: Self.self),
			 comment: "Title for the image comments view")
	}
}
