//
//  UITableViewCellTests.swift
//  Rex
//
//  Created by David Rodrigues on 19/04/16.
//  Copyright © 2016 Neil Pankey. All rights reserved.
//

import XCTest
import ReactiveCocoa
import Result

class UITableViewCellTests: XCTestCase {
    
    func testPrepareForReuseSignal() {

        let titleProperty = MutableProperty("John")

        let cell = UITableViewCell()

        guard let label = cell.textLabel else {
            fatalError()
        }

        label.rex_text <~
            titleProperty
                .producer
                .takeUntil(cell.rex_prepareForReuseSignal)

        XCTAssertEqual(label.text, "John")

        titleProperty <~ SignalProducer(value: "Frank")

        XCTAssertEqual(label.text, "Frank")

        cell.prepareForReuse()

        titleProperty <~ SignalProducer(value: "Will")

        XCTAssertEqual(label.text, "Frank")
    }
    
}
