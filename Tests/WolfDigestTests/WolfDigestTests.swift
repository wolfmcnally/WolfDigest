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
                digester.combine(x, y)
            }
        }
        
        XCTAssertEqual(A(x: 10, y: 20).digest†, "a06e2cce51db85f4234cd957eec06633237329cec8563db5eab43683d5a48db9")
    }
    
    func testDigestFloat() {
        struct A: Digestable {
            let x: Float
            let y: Double
            
            func digest(into digester: inout Digester) {
                digester.combine(x, y)
            }
        }
        
        XCTAssertEqual(A(x: .pi, y: .greatestFiniteMagnitude).digest†, "74dcc569f30737d48f7973875b7d4083bf1496d5243e2b5f20c049df9effe4cc")
    }

    func testDigestDecimal() {
        struct A: Digestable {
            let x: Decimal
            let y: Decimal
            
            func digest(into digester: inout Digester) {
                digester.combine(x, y)
            }
        }
        
        XCTAssertEqual(A(x: 10.1, y: 20.2).digest†, "a0c2a5784f1da9bed77771acf6f23946f7d8f0c961314376d355fba85c6e5dc4")
    }
    
    func testDigestString() {
        struct A: Digestable {
            let x: String
            let y: String
            
            func digest(into digester: inout Digester) {
                digester.combine(x, y)
            }
        }
        
        XCTAssertEqual(A(x: "dog", y: "cat").digest†, "1ac880f97cd8bd06e6dd7d319f774c7ebb908e349d7c6a10545e464a815ab1d2")
    }
    
    func testDigestData() {
        struct A: Digestable {
            let x: Data
            let y: Data
            
            func digest(into digester: inout Digester) {
                digester.combine(x, y)
            }
        }
        
        XCTAssertEqual(A(x: Data([0, 1, 2]), y: Data([3, 4, 5])).digest†, "17e88db187afd62c16e5debf3e6527cd006bc012bc90b51a810cd80c2d511f43")
    }
    
    func testDigestDate() {
        struct A: Digestable {
            let x: Date
            let y: Date
            
            func digest(into digester: inout Digester) {
                digester.combine(x, y)
            }
        }
        
        XCTAssertEqual(A(x: Date(timeIntervalSince1970: 0), y: Date(timeIntervalSinceReferenceDate: 0)).digest†, "94772adea66a7304cd7e3f368eb2a5c9338cefa4d27bc33bf8da78e9160856e0")
    }
}
