import UIKit

protocol GameViewDelegate: class {
	func squarePressed(square: UIButton)
}

// MARK: -
class GameView: UIView {

	// Public
	public weak var delegate: GameViewDelegate?
	public var elements: [[Piece]]? {
		didSet {
			setupView()
		}
	}
	
	// Private
	private lazy var container = UIStackView()
	private lazy var instructionsLabel: UILabel = {
		let label = UILabel()
		label.numberOfLines = 0
		label.textColor = .darkGray
		label.textAlignment = .center
		label.font = .systemFont(ofSize: 32, weight: .light)
		return label
	}()
	
	private lazy var buttons: [UIButton] = []
	
	// Init
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupView()
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		setupView()
	}
}

// MARK: - Game State Controls
extension GameView {
	
	/// Reset
	public func reset() {
		update(GameViewModel.reset)
	}
	
	/// Update
	public func update(_ model: GameViewModel) {
		// Instructions
		instructionsLabel.text = model.playerTurn.piece.rawValue
		
		for (index, button) in buttons.enumerated() {
			let value = model.flatBoard[index]
			button.setTitle(value.rawValue, for: .normal)
		}
	}
}

// MARK: - UI
extension GameView {
	private func setupView() {
		backgroundColor = .white
		
		// Instructions
		instructionsLabel.text = Player.playerOne.piece.rawValue
		
		// Grid
		container.spacing = 10
		container.axis = .vertical
		
		// Clear grid
		buttons.removeAll()
		container.removeAllArrangedSubviews()
		
		// Generate grid
		if let map = elements {
			
			var index = 0
			
			// Generate rows
			map.forEach { row in
				
				// Create row
				let rowStack = UIStackView()
				rowStack.spacing = 10
				rowStack.axis = .horizontal
				rowStack.alignment = .fill
				rowStack.distribution = .fillEqually
				
				// Create column
				row.forEach { square in
					let button = UIButton()
					button.tag = index
					button.layer.cornerRadius = 6
					button.anchor(width: 80, height: 80)
					button.backgroundColor = .systemGray5
					button.addTarget(self, action: #selector(squarePressed), for: .touchUpInside)
					
					//
					buttons.append(button)
					
					// Add item to row
					rowStack.addArrangedSubview(button)
					index += 1
				}
				
				// Add row
				container.addArrangedSubview(rowStack)
			}
		}
		
		addSubview(container)
		addSubview(instructionsLabel)
		setupLayout()
	}
	
	private func setupLayout() {
		container.anchor(centerX: centerXAnchor, centerY: centerYAnchor, paddingCenterY: 30)
		instructionsLabel.anchor(bottom: container.topAnchor, paddingBottom: 20,
								 left: container.leftAnchor,
								 right: container.rightAnchor)
	}
}

// MARK: - Actions
extension GameView {
	@objc func squarePressed(sender: UIButton) {
		if let delegate = delegate {
			delegate.squarePressed(square: sender)
		}
	}
}
