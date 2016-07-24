//
//  SwiftHoedownTests.swift
//  SwiftHoedownTests
//
//  Created by Niels de Hoog on 22/10/15.
//  Copyright © 2015 Invisible Pixel. All rights reserved.
//

import XCTest
@testable import Hoedown

class HoedownTests: XCTestCase {
    
    func testHeader1() {
        let markdown = "# Header 1"
        let html = Hoedown.renderHTMLForMarkdown(markdown)
        XCTAssertEqual(html, "<h1>Header 1</h1>\n")
    }
    
    func testCurlyQuotes() {
        let markdown = "“This is a quote”\nFollowed by some text"
        let html = Hoedown.renderHTMLForMarkdown(markdown, flags: .None, extensions: .None)
        XCTAssertEqual(html, "<p>“This is a quote”\nFollowed by some text</p>\n")
    }
}
