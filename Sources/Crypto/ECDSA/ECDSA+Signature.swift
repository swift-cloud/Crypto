//
//  ECDSA+Signature.swift
//  
//
//  Created by Rafael Stark on 2/15/21.
//

import Foundation

extension ECDSA {
    public struct Signature {

        public let r: BigInteger

        public let s: BigInteger

        public init(r: BigInteger, s: BigInteger) {
            self.r = r
            self.s = s
        }

        public init(data: Data) {
            let mid = data.count / 2
            self.r = .init(BigUInteger(data.prefix(mid)))
            self.s = .init(BigUInteger(data.suffix(mid)))
        }
    }
}
