//
//  YonderTripsTests.swift
//  YonderTripsTests
//
//  Created by 임윤휘 on 5/22/25.
//

import XCTest
@testable import YonderTrips

final class YonderTripsTests: XCTestCase {

    override func setUpWithError() throws {
        
    }

    override func tearDownWithError() throws {
        
    }

    func testExample() throws {
        
    }

    func testPerformanceExample() throws {
        
        measure {
            
        }
    }
    
    // test email
    func testEmailValidation() {
        let email = "abc@xyz.com"
        let userValidationUseCase = UserValidationUseCase()
        
        XCTAssertNoThrow(try userValidationUseCase.validateUserInfo(.email(email)))
    }
    
    func testEmailValidationThrow() {
        let email = "invalid-email"
        let userValidationUseCase = UserValidationUseCase()
        
        XCTAssertThrowsError(try userValidationUseCase.validateUserInfo(.email(email))) { error in
            XCTAssertEqual(error as? UserValidationError, UserValidationError.invalidEmail)
        }
    }
    
    // test password
    func testPasswordValidation() {
        let password = "YonderTrips1234@@"
        let userValidationUseCase = UserValidationUseCase()
        
        XCTAssertNoThrow(try userValidationUseCase.validateUserInfo(.password(password)))
    }
    
    func testPasswordValidationThrow() {
        let password = "invalid-password"
        let userValidationUseCase = UserValidationUseCase()
        
        XCTAssertThrowsError(try userValidationUseCase.validateUserInfo(.password(password))) { error in
            XCTAssertEqual(error as? UserValidationError, UserValidationError.invalidPassword)
        }
    }
    
    // test nickname
    func testNicknameValidation() {
        let nickname = "욘더트립스"
        let userValidationUseCase = UserValidationUseCase()
        
        XCTAssertNoThrow(try userValidationUseCase.validateUserInfo(.nick(nickname)))
    }
    
    func testNicknameValidationThrow() {
        let nickname = "invalid-nickname"
        let userValidationUseCase = UserValidationUseCase()
        
        XCTAssertThrowsError(try userValidationUseCase.validateUserInfo(.nick(nickname))) { error in
            XCTAssertEqual(error as? UserValidationError, UserValidationError.invalidNick)
        }
    }
}
