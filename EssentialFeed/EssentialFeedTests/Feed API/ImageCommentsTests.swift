//
//  ImageCommentsTests.swift
//  EssentialFeedTests
//
//  Created by Ricardo Herrera Petit on 4/6/21.
//  Copyright © 2021 Essential Developer. All rights reserved.
//

import XCTest
import EssentialFeed

class ImageCommentsRemoteLoader {
	private let client : HTTPClient
	
	init(client: HTTPClient) {
		self.client = client
	}
	
	func loadImageComments(from url: URL , completion: (Any) -> Void ) {
		client.get(from: url) { _ in }
	}
}

class ImageCommentsRemoteLoaderTests: XCTestCase {
	func test_init_doesNotRequestAnyURL() {
		let client = HTTPClientSpy()
		let _ = ImageCommentsRemoteLoader(client: client)
		XCTAssertTrue(client.requestedURLs.isEmpty)
	}
	
	func test_loadImageComments_requestsDataFromURL() {
		let url = anyURL()
		let client = HTTPClientSpy()
		let sut = ImageCommentsRemoteLoader(client: client)
		
		sut.loadImageComments(from: url) { _ in }
		
		XCTAssertEqual(client.requestedURLs, [url])
	}
}
