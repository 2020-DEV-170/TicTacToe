import Foundation
@testable import TicTacToe

// Mock board for test win
func mockBoard(using model: GameViewModel, playerMove: Piece, coords: [Coordinates]) -> GameViewModel {
	var mutModel = model
	mutModel.process(move: playerMove, coordinates: coords[0])
	mutModel.process(move: playerMove, coordinates: coords[1])
	mutModel.process(move: playerMove, coordinates: coords[2])
	return mutModel
}

// Mocks for horizontal win
var mockFirstRowWin: [Coordinates] {
	return [.init(row: 0, column: 0),
			.init(row: 0, column: 1),
			.init(row: 0, column: 2)]
}

var mockSecondRowWin: [Coordinates] {
	return [.init(row: 1, column: 0),
			.init(row: 1, column: 1),
			.init(row: 1, column: 2)]
}

var mockThirdRowWin: [Coordinates] {
	return [.init(row: 2, column: 0),
			.init(row: 2, column: 1),
			.init(row: 2, column: 2)]
}

// Mocks for vertical win
var mockFirstColumnWin: [Coordinates] {
	return [.init(row: 0, column: 0),
			.init(row: 1, column: 0),
			.init(row: 2, column: 0)]
}

var mockSecondColumnWin: [Coordinates] {
	return [.init(row: 0, column: 1),
			.init(row: 1, column: 1),
			.init(row: 2, column: 1)]
}

var mockThirdColumnWin: [Coordinates] {
	return [.init(row: 0, column: 2),
			.init(row: 1, column: 2),
			.init(row: 2, column: 2)]
}

// Mocks for diagonal win
var mockTopLeftToBottomRightWin: [Coordinates] {
	return [.init(row: 0, column: 0),
			.init(row: 1, column: 1),
			.init(row: 2, column: 2)]
}

var mockBottomLeftToTopRightWin: [Coordinates] {
	return [.init(row: 2, column: 0),
			.init(row: 1, column: 1),
			.init(row: 0, column: 2)]
}

// Mocks for board state
let mockGameEmptyBoard = Game.init(board: [
	[.empty, .empty, .empty],
	[.empty, .empty, .empty],
	[.empty, .empty, .empty]
	])

let mockGameFullBoard = Game.init(board: [
	[.x, .o, .x],
	[.o, .o, .x],
	[.x, .x, .o]
	])

let mockGameOneSpaceLeft = Game.init(board: [
	[.x, .o, .x],
	[.o, .o, .x],
	[.x, .x, .empty]
	])

let mockCoord = Coordinates(row: 2, column: 2)

func mockModelEmptyBoard(for player: Player = .playerOne) -> GameViewModel {
	return GameViewModel(game: mockGameEmptyBoard, playerTurn: player)
}

func mockModelFullBoard(for player: Player = .playerOne) -> GameViewModel {
	return GameViewModel(game: mockGameFullBoard, playerTurn: player)
}

func mockModelOneSpaceLeft(for player: Player = .playerOne) -> GameViewModel {
	return GameViewModel(game: mockGameOneSpaceLeft, playerTurn: player)
}
