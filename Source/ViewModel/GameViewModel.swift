import Foundation

struct GameViewModel {
	var game: Game = Game()
	
	var playerTurn = Player.playerOne
	
	var board: [[Piece]] {
		return game.board
	}
	
	var flatBoard: [Piece] {
		return game.board.flatMap { $0 }
	}
	
	static var reset: GameViewModel {
		return GameViewModel(game: .init(), playerTurn: .playerOne)
	}
	
	mutating func update(with coords: Coordinates) -> GameViewModel {
		let board = game.updateBoard(using: coords, playerTurn: playerTurn)
		return GameViewModel(game: .init(board: board), playerTurn: self.playerTurn)
	}
	
	func swapTurn(current: Player) -> GameViewModel {
		return GameViewModel(game: self.game, playerTurn: current.switchPlayer)
	}
}

// MARK: - Process move
extension GameViewModel {
	
	@discardableResult
	mutating func process(move playerPiece: Piece, coordinates: Coordinates) -> Result {
		
		guard checkLegalMove(coordinates: coordinates) else {
			return .moveIlleagal
		}
		
		let updatedModel = update(with: coordinates)
		
		if updatedModel.checkWin(for: playerPiece, coordinates: coordinates) {
			return .gameWin(updatedModel)
		}
		
		if checkDraw(game: game) {
			return .gameDraw(updatedModel)
		}
		
		return .move(updatedModel.swapTurn(current: playerTurn))
	}
	
	func checkLegalMove(coordinates: Coordinates) -> Bool {
		return self.game[coordinates] == .empty
	}
	
	func checkWin(for playerPiece: Piece, coordinates: Coordinates) -> Bool {
		return checkHorizontalWin(for: playerPiece)
			|| checkVerticalWin(for: playerPiece)
			|| checkDiagonalWin(for: playerPiece)
	}
}

// MARK: - Result Checks
extension GameViewModel {
	
	func checkHorizontalWin(for playerPiece: Piece) -> Bool {
		for row in game.board {
			if row.elements(areAll: playerPiece) { return true }
		}
		return false
	}
	
	func checkVerticalWin(for playerPiece: Piece) -> Bool {
		for i in 0..<game.board.count {
			var match = true
			for row in game.board {
				if row[i] == playerPiece { continue }
				else { match = false; break }
			}
			if match { return true }
		}
		return false
	}
	
	func checkDiagonalWin(for playerPiece: Piece) -> Bool {
		if playerPiece == game.board[0][0] && playerPiece == game.board[1][1] && playerPiece == game.board[2][2] ||
		   playerPiece == game.board[2][0] && playerPiece == game.board[1][1] && playerPiece == game.board[0][2] {
		   return true
		}
		return false
	}
	
	func checkDraw(game: Game) -> Bool {
		for row in game.board {
			if row.contains(.empty) { return false }
		}
		return true
	}
}
