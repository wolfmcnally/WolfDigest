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

public struct Digest {
    private let data: Data
    
    public init(_ data: Data) {
        precondition(data.count == 32)
        self.data = data
    }
}

extension Digest: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(data)
    }
    
    public static func == (lhs: Digest, rhs: Digest) -> Bool {
        lhs.data == rhs.data
    }
}

extension Digest {
    func lexicographicallyPrecedes(_ other: Digest) -> Bool {
        data.lexicographicallyPrecedes(other.data)
    }
}

extension Digest: Sequence {
    public func makeIterator() -> some IteratorProtocol {
        data.makeIterator()
    }
}

extension Digest: CustomStringConvertible {
    public var description: String {
        data.hex
    }
}

extension Digest: Serializable {
    public var serialized: Data {
        data
    }
}
