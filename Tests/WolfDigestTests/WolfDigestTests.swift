import XCTest
import WolfDigest
import WolfBase

final class WolfDigestTests: XCTestCase {
    func testDigestNil() {
        struct A: Digestable {
            func digest(into digester: inout Digester) {
            }
        }
        
        XCTAssertNil(A().digest)
        XCTAssertEqual(A().digest†, "nil")
    }
    
    func testDigestInt() {
        struct A: Digestable {
            let x: Int
            let y: Int
            
            func digest(into digester: inout Digester) {
                digester.combine(x)
                digester.combine(y)
            }
        }
        
        XCTAssertEqual(A(x: 10, y: 20).digest†, "a06e2cce51db85f4234cd957eec06633237329cec8563db5eab43683d5a48db9")
    }
}
