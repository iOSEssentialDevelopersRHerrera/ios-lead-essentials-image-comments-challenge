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
	init(client: HTTPClient) {
		
	}
}

class ImageCommentsRemoteLoaderTests: XCTestCase {
	func test_init_doesNotRequestAnyURL() {
		let client = HTTPClientSpy()
		let _ = ImageCommentsRemoteLoader(client: client)
		XCTAssertTrue(client.requestedURLs.isEmpty)
	}
}
