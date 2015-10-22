//
//  SwiftHoedownTests.swift
//  SwiftHoedownTests
//
//  Created by Niels de Hoog on 22/10/15.
//  Copyright © 2015 Invisible Pixel. All rights reserved.
//

import XCTest
@testable import SwiftHoedown

class SwiftHoedownTests: XCTestCase {
    
    func testHeader1() {
        let markdown = "# Header 1"
        let html = Hoedown.renderHTMLForMarkdown(markdown)!
        XCTAssertEqual(html, "<h1>Header 1</h1>\n")
    }
}
