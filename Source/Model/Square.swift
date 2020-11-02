import Foundation

enum Square: Int {
	
	// Top row
	case topLeft
	case topMiddle
	case topRight
	
	// Middle row
	case middleLeft
	case middle
	case middleRight
	
	// Bottom
	case bottomLeft
	case bottomMiddle
	case bottomRight
	
	// Square coordinates
	var coordinates: Coordinates {
		switch self {
		case .topLeft:		return .init(row: 0, column: 0)
		case .middleLeft:	return .init(row: 1, column: 0)
		case .bottomLeft:	return .init(row: 2, column: 0)
		case .topMiddle:	return .init(row: 0, column: 1)
		case .middle:		return .init(row: 1, column: 1)
		case .bottomMiddle: return .init(row: 2, column: 1)
		case .topRight:		return .init(row: 0, column: 2)
		case .middleRight:	return .init(row: 1, column: 2)
		case .bottomRight:	return .init(row: 2, column: 2)
		}
	}
}
