//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

import Foundation
import WolfBase

public struct Digester {
    private var buf = Data()
    
    public mutating func combine(bytes: UnsafeRawBufferPointer) {
        buf.append(contentsOf: bytes)
    }

    public mutating func combine<H>(_ value: H) where H : Digestable {
        value.digest(into: &self)
    }
    
    public mutating func combine<H>(_ value: Optional<H>) where H : Digestable {
        if let value = value {
            combine(value)
        }
    }
    
    public mutating func combine(data: Data?) {
        if let data = data {
            data.withUnsafeBytes {
                combine(bytes: $0)
            }
        }
    }
    
    public mutating func combine<S>(_ seq: S) where S: Sequence, S.Element: Digestable {
        seq.forEach { combine($0) }
    }
    
    public mutating func combine<E>(_ set: Set<E>) where E : Digestable {
        combine(Array(set).sorted(by: { $0.digest!.lexicographicallyPrecedes($1.digest!) }))
    }
    
    public mutating func combine<S>(_ value: S) where S : Serializable {
        combine(data: value.serialized)
    }
    
    mutating func combine(_ array: [Any]) {
        array.forEach { combine(data: ($0 as! Serializable).serialized) }
    }
    
    public mutating func combine(_ items: Serializable...) {
        combine(items)
    }

    func finalize() -> Digest? {
        guard !buf.isEmpty else {
            return nil
        }
        return Digest(buf.sha256Digest)
    }
}
