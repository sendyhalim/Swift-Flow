//
//  TypeHelperTests.swift
//  SwiftFlow
//
//  Created by Benjamin Encz on 12/20/15.
//  Copyright © 2015 Benjamin Encz. All rights reserved.
//

import Foundation
import Quick
import Nimble
@testable import SwiftFlow

struct AppState1: StateType {}
struct AppState2: StateType {}

// swiftlint:disable function_body_length
class TypeHelper: QuickSpec {

    override func spec() {

        describe("f_withSpecificTypes") {

            it("calls methods if the source type can be casted into the function signature type") {
                var called = false
                let reducerFunction: (AppState1?, Action) -> AppState1 = { state, action in
                    called = true

                    return state ?? AppState1()
                }

                withSpecificTypes(AppState1(), action: StandardAction(""),
                    function: reducerFunction)

                expect(called).to(beTrue())
            }

            it("calls the method if the source type is nil") {
                var called = false
                let reducerFunction: (AppState1?, Action) -> AppState1 = { state, action in
                    called = true

                    return state ?? AppState1()
                }

                withSpecificTypes(nil, action: StandardAction(""),
                    function: reducerFunction)

                expect(called).to(beTrue())
            }

            it ("doesn't call if source type can't be casted to function signature type") {
                var called = false
                let reducerFunction: (AppState1?, Action) -> AppState1 = { state, action in
                    called = true

                    return state ?? AppState1()
                }

                withSpecificTypes(AppState2(), action: StandardAction(""),
                    function: reducerFunction)

                expect(called).to(beFalse())
            }

        }

    }

}
// swiftlint:enable function_body_length
