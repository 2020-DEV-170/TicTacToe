import UIKit

class GameViewController: UIViewController {

	// Game View Model
	private lazy var model = GameViewModel()
	
	// Game UI
	private lazy var gameView: GameView = {
		let view = GameView()
		view.elements = model.board
		view.delegate = self
		return view
	}()

	// Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()
		view = gameView
	}
}

// MARK: - Actions
extension GameViewController: GameViewDelegate {
	@objc func squarePressed(square: UIButton) {
		guard let square = Square(rawValue: square.tag) else {
			fatalError("Square not found")
		}
		
		let result = model.process(move: model.playerTurn.piece, coordinates: square.coordinates)
		
		switch result {
		case .moveIlleagal: showAlertView(title: "Illegal Move", message: "Square not empty")
		case .move(let model): update(using: model)
		case .gameDraw(let model): handleEndGame(with: model, message: "It's a draw")
		case .gameWin(let model): handleEndGame(with: model, message: "\(model.playerTurn.rawValue) Wins")
		}
	}
}

// MARK: - End game methods
extension GameViewController {
	private func handleEndGame(with model: GameViewModel, message: String) {
		showAlertView(title: "Game Over", message: message)
		reset()
	}
	
	private func reset() {
		update(using: GameViewModel.reset)
	}
	
	private func update(using model: GameViewModel) {
		self.model = model
		gameView.update(model)
	}
}

// MARK: - AlertView
extension GameViewController {
	private func showAlertView(title: String, message: String) {
		let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
		alert.addAction(.init(title: "Ok", style: .default, handler: nil))
		present(alert, animated: true, completion: nil)
	}
}
