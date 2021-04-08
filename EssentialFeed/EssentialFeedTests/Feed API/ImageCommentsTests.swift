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
	typealias Result = Swift.Result<Any, Error>
	private let client : HTTPClient
	
	init(client: HTTPClient) {
		self.client = client
	}
	
	enum Error: Swift.Error {
			case connectivity
	}
	
	func loadImageComments(from url: URL , completion: @escaping (Any) -> Void ) {
		client.get(from: url,completion: completion)
	}
}

class ImageCommentsRemoteLoaderTests: XCTestCase {
	func test_init_doesNotRequestAnyURL() {
		let (_ , client) = makeSUT()
		
		XCTAssertTrue(client.requestedURLs.isEmpty)
	}
	
	func test_loadImageComments_requestsDataFromURL() {
		let url = anyURL()
		
		let (sut, client) = makeSUT()
		
		sut.loadImageComments(from: url) { _ in }
		
		XCTAssertEqual(client.requestedURLs, [url])
	}
	
	func test_loadImageCommentsTwice_requestsDataFromURLTwice() {
		let url = anyURL()
		
		let (sut, client) = makeSUT()
		
		sut.loadImageComments(from: url) { _ in }
		sut.loadImageComments(from: url) { _ in }
		
		XCTAssertEqual(client.requestedURLs, [url, url])
	}
	
	func test_loadImageComments_deliversErrorOnClientError() {
		let (sut, client) = makeSUT()
		
		expect(sut: sut, toCompleteWith: .failure(.connectivity)) {
			client.complete(with: anyNSError())
		}
	}
	
	//MARK: - Helpers
	
	func makeSUT(file: StaticString = #file, line: UInt = #line) -> (sut: ImageCommentsRemoteLoader, client: HTTPClientSpy) {
		let client = HTTPClientSpy()
		let sut = ImageCommentsRemoteLoader(client: client)
		trackForMemoryLeaks(sut, file: file, line: line)
		trackForMemoryLeaks(client, file: file, line: line)
		return (sut, client)
	}
	
	private func expect(sut: ImageCommentsRemoteLoader, toCompleteWith expectedResult: ImageCommentsRemoteLoader.Result, when  action: () -> Void  ) {
		
		let exp = expectation(description: "Wait for load comments completion")
		
		sut.loadImageComments(from: anyURL()) { _ in
			exp.fulfill()
		}
		
		action()
		
		wait(for: [exp], timeout: 1.0)
	}
}
