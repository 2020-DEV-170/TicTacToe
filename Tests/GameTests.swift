import XCTest
@testable import TicTacToe

class GameTests: XCTestCase {
    
    func testSubscriptWithCoordinates() {
        let model = mockModelFullBoard()
        XCTAssert(model.game[.init(row: 0, column: 0)] == .x)
    }
}

