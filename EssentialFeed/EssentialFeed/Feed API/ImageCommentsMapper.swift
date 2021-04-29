//
//  ImageCommentsMapper.swift
//  EssentialFeed
//
//  Created by Ricardo Herrera Petit on 4/28/21.
//  Copyright © 2021 Essential Developer. All rights reserved.
//

import Foundation

//
//  Copyright © 2019 Essential Developer. All rights reserved.
//

import Foundation

final class ImageCommentsMapper {
	private struct Root: Decodable {
		let items: [RemoteFeedItem]
	}
	
	static func map(_ data: Data, from response: HTTPURLResponse) throws -> [RemoteFeedItem] {
		guard response.isOK, let root = try? JSONDecoder().decode(Root.self, from: data) else {
			throw RemoteImageCommentsLoader.Error.invalidData
		}
		
		return root.items
	}
}
