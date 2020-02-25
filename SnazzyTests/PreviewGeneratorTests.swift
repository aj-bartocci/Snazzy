//
//  PreviewGeneratorTests.swift
//  SnazzyTests
//
//  Created by AJ Bartocci on 2/24/20.
//  Copyright © 2020 AJ Bartocci. All rights reserved.
//

import XCTest
@testable import Snazzy

class PreviewGeneratorTests: XCTestCase {
    
    var theme: MockTheme!
    var sut: PreviewGenerator<MockTheme>!

    override func setUp() {
        theme = MockTheme()
        sut = PreviewGenerator(theme: theme)
    }

    override func tearDown() {
        sut = nil
        theme = nil
    }

    func testGenerateComponentStyles() {
        let compStyles = sut.generateComponentStyles(theme)
        XCTAssertEqual(compStyles.count, 2)
    }

    func testGenerateTypeStyles() {
        let typeStyles = sut.generateTypeStyles(theme)
        XCTAssertEqual(typeStyles.count, 2)
    }
    
    func testGenerateColors() {
        let colors = sut.generateColors(theme)
        XCTAssertEqual(colors.count, 2)
    }
    
    func testGenerateFonts() {
        let fonts = sut.generateFonts(theme)
        XCTAssertEqual(fonts.count, 2)
    }
}
