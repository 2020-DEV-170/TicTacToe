import Foundation

enum Player: String {
	case playerOne = "❌"
	case playerTwo = "⭕️"
	
	var switchPlayer: Player {
		switch self {
		case .playerOne: return .playerTwo
		case .playerTwo: return .playerOne
		}
	}
	
	var piece: Piece {
		switch self {
		case .playerOne: return .x
		case .playerTwo: return .o
		}
	}
}
