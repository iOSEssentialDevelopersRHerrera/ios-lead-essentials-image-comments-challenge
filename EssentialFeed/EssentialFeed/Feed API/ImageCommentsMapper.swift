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
		guard isOK(response: response), let root = try? JSONDecoder().decode(Root.self, from: data) else {
			throw RemoteImageCommentsLoader.Error.invalidData
		}
		
		return root.items
	}
	
	private static func isOK (response: HTTPURLResponse) -> Bool {
		return 200 <= response.statusCode && 299 >= response.statusCode
	}
}
