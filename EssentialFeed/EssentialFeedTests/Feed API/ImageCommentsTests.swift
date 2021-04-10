//
//  ImageCommentsTests.swift
//  EssentialFeedTests
//
//  Created by Ricardo Herrera Petit on 4/6/21.
//  Copyright © 2021 Essential Developer. All rights reserved.
//

import XCTest
import EssentialFeed

class RemoteImageCommentsLoader {
	typealias Result = Swift.Result<Any, Error>
	private let client : HTTPClient
	
	init(client: HTTPClient) {
		self.client = client
	}
	
	enum Error: Swift.Error {
		case connectivity
		case invalidData
	}
	
	func loadImageComments(from url: URL , completion: @escaping (Result) -> Void ) {
		client.get(from: url) { [weak self] result in
			guard self != nil else { return }
			completion(result
						.mapError { _ in Error.connectivity }
						.flatMap{ _ in .failure(Error.invalidData)})
		}
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
		
		expect(sut, toCompleteWith: .failure(.connectivity)) {
			client.complete(with: anyNSError())
		}
	}
	
	func test_loadImageComments_deliversErrorOnNon200HTTPResponse() {
		let (sut, client) = makeSUT()
		
		let samples = [199, 201, 300, 400, 500]
		
		samples.enumerated().forEach { index, code in
			expect(sut, toCompleteWith: .failure(.invalidData), when: {
				client.complete(withStatusCode: code, data: anyData(), at: index)
			})
		}
	}
	
	func test_loadImageComments_doesNotDeliverResultAfterSUTInstanceHasBeenDeallocated() {
		let client = HTTPClientSpy()
		var sut: RemoteImageCommentsLoader? = RemoteImageCommentsLoader(client: client)
		
		var capturedResults = [RemoteImageCommentsLoader.Result]()
		_ = sut?.loadImageComments(from: anyURL()) { capturedResults.append($0) }
		
		sut = nil
		client.complete(withStatusCode: 200, data: anyData())
		
		XCTAssertTrue(capturedResults.isEmpty)
	}
	
	func test_load_deliversErrorOn200HTTPResponseWithInvalidJSON() {
		let (sut, client) = makeSUT()
		
		expect(sut, toCompleteWith: .failure(.invalidData), when: {
			let invalidJSON = Data("invalid json".utf8)
			client.complete(withStatusCode: 200, data: invalidJSON)
		})
	}
	
	//MARK: - Helpers
	
	func makeSUT(file: StaticString = #file, line: UInt = #line) -> (sut: RemoteImageCommentsLoader, client: HTTPClientSpy) {
		let client = HTTPClientSpy()
		let sut = RemoteImageCommentsLoader(client: client)
		trackForMemoryLeaks(sut, file: file, line: line)
		trackForMemoryLeaks(client, file: file, line: line)
		return (sut, client)
	}
	
	private func expect(_ sut: RemoteImageCommentsLoader, toCompleteWith expectedResult: RemoteImageCommentsLoader.Result, when action: () -> Void, file: StaticString = #file, line: UInt = #line) {
			let exp = expectation(description: "Wait for load comments completion")
			
			sut.loadImageComments(from: anyURL()) { receivedResult in
				switch (receivedResult, expectedResult) {
				case let (.failure(receivedError), .failure(expectedError)):
					XCTAssertEqual(receivedError, expectedError, file: file, line: line)
					
				default:
					XCTFail("Expected result \(expectedResult), got \(receivedResult) instead", file: file, line: line)
				}
				
				exp.fulfill()
			}
			
			action()
			
			wait(for: [exp], timeout: 1.0)
		}
}
