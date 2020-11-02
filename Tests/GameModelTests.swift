import XCTest
@testable import TicTacToe

class GameModelTests: XCTestCase {
    func testResetBoard() {
        XCTAssert(GameViewModel.reset.game.board == mockGameEmptyBoard.board)
    }
    
    func testCanSwapTurn() {
        let model = mockModelEmptyBoard()
        let swappedPlayerModel = model.swapTurn(current: .playerOne)
        
        XCTAssert(swappedPlayerModel.playerTurn == .playerTwo)
    }
}

// MARK: - Test logic for horizontal win
extension GameModelTests {
    func testWinForFirstRow() {

        // Tets player one win
        let winningX = mockBoard(using: mockModelEmptyBoard(),
                                 playerMove: .x,
                                 coords: mockFirstRowWin)
        
        XCTAssert(winningX.checkHorizontalWin(for: .x))
        
        // Tets player two win
        let winningO = mockBoard(using: mockModelEmptyBoard(for: .playerTwo),
                                 playerMove: .o,
                                 coords: mockFirstRowWin)
        
        XCTAssert(winningO.checkHorizontalWin(for: .o))
    }
    
    func testWinForSecondRow() {
    
        // Tets player one win
        let winningX = mockBoard(using: mockModelEmptyBoard(),
                                 playerMove: .x,
                                 coords: mockSecondRowWin)
        
        XCTAssert(winningX.checkHorizontalWin(for: .x))
        
        // Tets player two win
        let winningO = mockBoard(using: mockModelEmptyBoard(for: .playerTwo),
                                 playerMove: .o,
                                 coords: mockSecondRowWin)
        
        XCTAssert(winningO.checkHorizontalWin(for: .o))
	}
	
	func testWinForThirdRow() {
        
        // Tets player one win
        let winningX = mockBoard(using: mockModelEmptyBoard(),
                                 playerMove: .x,
                                 coords: mockThirdRowWin)
        
        XCTAssert(winningX.checkHorizontalWin(for: .x))
        
        // Tets player two win
        let winningO = mockBoard(using: mockModelEmptyBoard(for: .playerTwo),
                                 playerMove: .o,
                                 coords: mockThirdRowWin)
        
        XCTAssert(winningO.checkHorizontalWin(for: .o))
	}
}

// MARK: - Test logic for vertical win
extension GameModelTests {
    func testWinForFirstColumn() {

        // Tets player one win
        let winningX = mockBoard(using: mockModelEmptyBoard(),
                                 playerMove: .x,
                                 coords: mockFirstColumnWin)
        
        XCTAssert(winningX.checkVerticalWin(for: .x))
        
        // Tets player two win
        let winningO = mockBoard(using: mockModelEmptyBoard(for: .playerTwo),
                                 playerMove: .o,
                                 coords: mockFirstColumnWin)
        
        XCTAssert(winningO.checkVerticalWin(for: .o))
    }
    
    func testWinForSecondColumn() {

        // Tets player one win
        let winningX = mockBoard(using: mockModelEmptyBoard(),
                                 playerMove: .x,
                                 coords: mockSecondColumnWin)
        
        XCTAssert(winningX.checkVerticalWin(for: .x))
        
        // Tets player two win
        let winningO = mockBoard(using: mockModelEmptyBoard(for: .playerTwo),
                                 playerMove: .o,
                                 coords: mockSecondColumnWin)
        
        XCTAssert(winningO.checkVerticalWin(for: .o))
    }
    
    func testWinForThirdColumn() {

        // Tets player one win
        let winningX = mockBoard(using: mockModelEmptyBoard(),
                                 playerMove: .x,
                                 coords: mockThirdColumnWin)
        
        XCTAssert(winningX.checkVerticalWin(for: .x))
        
        // Tets player two win
        let winningO = mockBoard(using: mockModelEmptyBoard(for: .playerTwo),
                                 playerMove: .o,
                                 coords: mockThirdColumnWin)
        
        XCTAssert(winningO.checkVerticalWin(for: .o))
    }
}

// MARK: - Test logic for diagonal win
extension GameModelTests {
	func testWinForDiagonalTopLeftToBottomRight() {
		testDiagonalWin(coords: mockTopLeftToBottomRightWin)
	}
	
	func testWinForDiagonalBottomLeftToTopRight() {
		testDiagonalWin(coords: mockBottomLeftToTopRightWin)
	}
	
	private func testDiagonalWin(coords: [Coordinates]) {
		
		// Tets player one win
		let winningX = mockBoard(using: mockModelEmptyBoard(),
								 playerMove: .x,
								 coords: coords)
		
		XCTAssert(winningX.checkDiagonalWin(for: .x))
		
		// Tets player two win
		let winningO = mockBoard(using: mockModelEmptyBoard(for: .playerTwo),
								 playerMove: .o,
								 coords: coords)
		
		XCTAssert(winningO.checkDiagonalWin(for: .o))
	}
}


// MARK: - Tests processing of a move
extension GameModelTests {
	func testProcessMakeMove() {
		var model = mockModelEmptyBoard()
		switch model.process(move: .x, coordinates: mockCoord) {
		case .move(_): XCTAssert(true)
		default: XCTFail()
		}
	}
	
	func testProcessMakeIllegalMove() {
		var model = mockModelEmptyBoard()
		model.process(move: .x, coordinates: mockCoord)
		switch model.process(move: .x, coordinates: mockCoord) {
		case .moveIlleagal: XCTAssert(true)
		default: XCTFail()
		}
	}
	
	func testProcessMoveReturnsWin() {
		var model = mockModelOneSpaceLeft()
		switch model.process(move: .x, coordinates: mockCoord) {
		case .gameWin(_): XCTAssert(true)
		default: XCTFail()
		}
	}
	
	func testProcessMoveReturnsDraw() {
		var model = mockModelOneSpaceLeft(for: .playerTwo)
		switch model.process(move: .o, coordinates: mockCoord) {
		case .gameDraw(_): XCTAssert(true)
		default: XCTFail()
		}
	}
}

