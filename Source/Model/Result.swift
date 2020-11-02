import Foundation

enum Result {
	case moveIlleagal
	case move(GameViewModel)
	case gameDraw(GameViewModel)
	case gameWin(GameViewModel)
}
