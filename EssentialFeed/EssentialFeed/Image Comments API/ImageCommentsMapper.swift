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
		private let items: [Item]
		
		private struct Item: Decodable {
			let id: UUID
			let message: String
			let created_at: Date
			let author: Author
		}
		
		private struct Author: Decodable {
			let username: String
		}
		
		var comments: [ImageComment] {
			items.map { ImageComment(id: $0.id, message: $0.message, createdAt: $0.created_at, username: $0.author.username)}
		}
	}
	
	static func map(_ data: Data, from response: HTTPURLResponse) throws -> [ImageComment] {
		let decoder = JSONDecoder()
		decoder.dateDecodingStrategy = .iso8601
		guard isOK(response: response), let root = try? decoder.decode(Root.self, from: data) else {
			throw RemoteImageCommentsLoader.Error.invalidData
		}
		
		return root.comments
	}
	
	private static func isOK (response: HTTPURLResponse) -> Bool {
		return 200 <= response.statusCode && 299 >= response.statusCode
	}
	
}