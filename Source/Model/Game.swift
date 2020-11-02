import Foundation

struct Game {

	var board: [[Piece]] = [
		[.empty, .empty, .empty],
		[.empty, .empty, .empty],
		[.empty, .empty, .empty]
	]
	
	subscript(coordinates: Coordinates) -> Piece {
		get {
			return board[coordinates.row][coordinates.column]
		}
	}
	
	mutating func updateBoard(using coordinates: Coordinates, playerTurn: Player) -> [[Piece]] {
		board[coordinates.row][coordinates.column] = playerTurn.piece
		return board
	}
}
