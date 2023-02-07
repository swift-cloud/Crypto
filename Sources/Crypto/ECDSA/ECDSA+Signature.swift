//
//  File.swift
//  
//
//  Created by Rafael Stark on 2/15/21.
//

import Foundation

extension ECDSA {
    public class Signature {

        public var r: CS.BigInt
        public var s: CS.BigInt

        public init(_ r: CS.BigInt, _ s: CS.BigInt) {
            self.r = r
            self.s = s
        }

        public func toDer() -> Data {
            let hexadecimal = self.toString()
            let encodedSequence = BinaryAscii.dataFromHex(hexadecimal)
            return encodedSequence
        }

        public static func fromDer(_ data: Data) throws -> Signature {
            return .init(
                CS.BigInt(CS.BigUInt(data[0..<32])),
                CS.BigInt(CS.BigUInt(data[32..<64]))
            )
        }

        public func toBase64() -> String {
            return BinaryAscii.base64FromData(self.toDer())
        }

        public static func fromBase64(_ string: String) throws -> Signature {
            let der = BinaryAscii.dataFromBase64(string)
            return try fromDer(der)
        }

        public func toString() -> String {
            return Der.encodeConstructed(
                Der.encodeInteger(self.r),
                Der.encodeInteger(self.s)
            )
        }
    }
}
