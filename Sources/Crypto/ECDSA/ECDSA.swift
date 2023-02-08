//
//  ECDSA.swift
//  
//
//  Created by Rafael Stark on 2/15/21.
//

import Foundation

public struct ECDSA {}

extension ECDSA.PublicKey {

    public func verify(message: String, signature: ECDSA.Signature) -> Bool {
        let input = Data(message.bytes.sha2(curve.sha2))
        let m = BigInteger(sign: .plus, magnitude: .init(input))
        let r = signature.r
        let s = signature.s
        if (r < 1 || r >= curve.N) {
            return false
        }
        if (s < 1 || s >= curve.N) {
            return false
        }
        let inv = ECDSA.Math.inv(s, curve.N)
        let u1 = ECDSA.Math.multiply(curve.G, (m * inv).modulus(curve.N), curve.N, curve.A, curve.P)
        let u2 = ECDSA.Math.multiply(point, (r * inv).modulus(curve.N), curve.N, curve.A, curve.P)
        let v = ECDSA.Math.add(u1, u2, curve.A, curve.P)
        if (v.isAtInfinity) {
            return false
        }
        return v.x.modulus(curve.N) == r
    }
}
