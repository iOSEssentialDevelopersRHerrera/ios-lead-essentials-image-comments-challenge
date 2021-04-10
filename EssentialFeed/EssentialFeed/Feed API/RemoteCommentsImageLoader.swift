//
//  RemoteCommentsImageLoader.swift
//  EssentialFeed
//
//  Created by Ricardo Herrera Petit on 4/9/21.
//  Copyright © 2021 Essential Developer. All rights reserved.
//

import Foundation

public class RemoteImageCommentsLoader {
	public typealias Result = Swift.Result<Any, Error>
	private let client : HTTPClient
	
	public init(client: HTTPClient) {
		self.client = client
	}
	
	public enum Error: Swift.Error {
		case connectivity
		case invalidData
	}
	
	public func loadImageComments(from url: URL , completion: @escaping (Result) -> Void ) {
		client.get(from: url) { [weak self] result in
			guard self != nil else { return }
			completion(result
						.mapError { _ in Error.connectivity }
						.flatMap{ _ in .failure(Error.invalidData)})
		}
	}
}
