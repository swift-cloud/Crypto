//
//  File.swift
//  
//
//  Created by Rafael Stark on 2/15/21.
//

import Foundation


public class ECDSA {
    
    public static func sign(message: String, privateKey: PrivateKey, variant: SHA2.Variant = .sha256) -> Signature {
        let hashMessage = Digest.sha2(message.bytes, variant: variant)
        let numberMessage = BinaryAscii.intFromHex(BinaryAscii.hexFromData(.init(hashMessage)))
        let curve = privateKey.curve
        let randNum = RandomInteger.between(min: CS.BigInt(1), max: curve.N)
        let randomSignPoint = Math.multiply(curve.G, randNum, curve.N, curve.A, curve.P)
        let r = randomSignPoint.x.modulus(curve.N)
        let s = ((numberMessage + r * privateKey.secret) * (Math.inv(randNum, curve.N))).modulus(curve.N)
        return Signature(r, s)
    }
    
    public static func verify(message: String, signature: Signature, publicKey: PublicKey, variant: SHA2.Variant = .sha256) -> Bool {
        let hashMessage = Digest.sha2(message.bytes, variant: variant)
        guard let numberMessage = CS.BigInt(hashMessage.toHexString(), radix: 16) else {
            return false
        }
        let curve = publicKey.curve
        let r = signature.r
        let s = signature.s
        
        if (r < 1 || r >= curve.N) {
            return false
        }
        if (s < 1 || s >= curve.N) {
            return false
        }
        
        let inv = Math.inv(s, curve.N)
        let u1 = Math.multiply(curve.G, (numberMessage * inv).modulus(curve.N), curve.N, curve.A, curve.P)
        let u2 = Math.multiply(publicKey.point, (r * inv).modulus(curve.N), curve.N, curve.A, curve.P)
        let v = Math.add(u1, u2, curve.A, curve.P)
        if (v.isAtInfinity()) {
            return false
        }
        return v.x.modulus(curve.N) == r
    }
}
