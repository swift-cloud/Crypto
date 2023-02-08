//
//  ECDSATests.swift
//  
//
//  Created by Andrew Barba on 2/7/23.
//

import Foundation
import XCTest
@testable import Crypto

private let pem =
    """
    -----BEGIN PUBLIC KEY-----
    MFkwEwYHKoZIzj0CAQYIKoZIzj0DAQcDQgAECKo5A1ebyFcnmVV8SE5On+8G81JyBjSvcrx4VLetWCjuDAmppTo3xM/zz763COTCgHfp/6lPdCyYjjqc+GM7sw==
    -----END PUBLIC KEY-----
    """

private let token =
    """
    eyJ0eXAiOiJKV1QiLCJhbGciOiJFUzI1NiJ9.eyJleHAiOjE2NzUzNjU0MjgsImlzcyI6ImZhc3RseSJ9.QL2Pm1JnXV/vAYK7ijeD4U1CBjOTLihNMDZ+qfvjkKOTUiK1jyxGEwjZfeApijRaOtQT8fVkdPnKjF+tBiUzkA==
    """

final class ECDSATests: XCTestCase {

    func testVerify() throws {
        let parts = token.components(separatedBy: ".")
        let message = parts.prefix(2).joined(separator: ".")
        let pk = ECDSA.PublicKey(pem: pem, curve: .secp256r1)
        let sig = ECDSA.Signature(data: .init(base64Encoded: parts[2])!)
        let verified = pk.verify(message: message, signature: sig)
        XCTAssertTrue(verified)
    }
}
