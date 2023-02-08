//
//  ECDSA+Curve.swift
//  
//
//  Created by Rafael Stark on 2/14/21.
//

import Foundation

extension ECDSA {
    public struct Curve {

        public let sha2: SHA2.Variant

        public let length: Int

        public let A: BigInteger

        public let B: BigInteger

        public let P: BigInteger

        public let N: BigInteger

        public let G: Point

        public init(
            sha2: SHA2.Variant,
            length: Int,
            A: BigInteger,
            B: BigInteger,
            P: BigInteger,
            N: BigInteger,
            Gx: BigInteger,
            Gy: BigInteger
        ) {
            self.sha2 = sha2
            self.length = length
            self.A = A
            self.B = B
            self.P = P
            self.N = N
            self.G = Point(Gx, Gy)
        }

        /**
         Verify if the point `p` is on the curve
         - Parameter p: Point p = Point(x, y)
         - Returns: boolean
         */
        public func contains(p: Point) -> Bool {
            if (p.x < 0 || p.x >= self.P) {
                return false
            }
            if (p.y < 0 || p.y >= self.P) {
                return false
            }
            if ((p.y.power(2) - (p.x.power(3) + self.A * p.x + self.B)) % self.P != 0) {
                return false
            }
            return true
        }
    }
}

extension ECDSA.Curve {

    public static let secp256k1 = ECDSA.Curve(
        sha2: .sha256,
        length: 32,
        A: BigInteger("0000000000000000000000000000000000000000000000000000000000000000", radix: 16)!,
        B: BigInteger("0000000000000000000000000000000000000000000000000000000000000007", radix: 16)!,
        P: BigInteger("fffffffffffffffffffffffffffffffffffffffffffffffffffffffefffffc2f", radix: 16)!,
        N: BigInteger("fffffffffffffffffffffffffffffffebaaedce6af48a03bbfd25e8cd0364141", radix: 16)!,
        Gx: BigInteger("79be667ef9dcbbac55a06295ce870b07029bfcdb2dce28d959f2815b16f81798", radix: 16)!,
        Gy: BigInteger("483ada7726a3c4655da4fbfc0e1108a8fd17b448a68554199c47d08ffb10d4b8", radix: 16)!
    )

    public static let secp256r1 = ECDSA.Curve(
        sha2: .sha256,
        length: 32,
        A: BigInteger("ffffffff00000001000000000000000000000000fffffffffffffffffffffffc", radix: 16)!,
        B: BigInteger("5ac635d8aa3a93e7b3ebbd55769886bc651d06b0cc53b0f63bce3c3e27d2604b", radix: 16)!,
        P: BigInteger("ffffffff00000001000000000000000000000000ffffffffffffffffffffffff", radix: 16)!,
        N: BigInteger("ffffffff00000000ffffffffffffffffbce6faada7179e84f3b9cac2fc632551", radix: 16)!,
        Gx: BigInteger("6b17d1f2e12c4247f8bce6e563a440f277037d812deb33a0f4a13945d898c296", radix: 16)!,
        Gy: BigInteger("4fe342e2fe1a7f9b8ee7eb4a7c0f9e162bce33576b315ececbb6406837bf51f5", radix: 16)!
    )
}
