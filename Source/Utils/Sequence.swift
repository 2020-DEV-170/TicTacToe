import Foundation

/// Returns a Boolean value indicating whether every element of a sequence
/// is the same.
///
/// - Parameter element: The element that you want to check.
/// - Returns: `true` if the sequence only contains the element passed in.
extension Sequence where Element: Equatable {
	func elements(areAll element: Element) -> Bool {
		return allSatisfy { e in
			element == e
		}
	}
}
