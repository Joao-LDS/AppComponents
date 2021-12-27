import UIKit
import UIView_Shimmer

public protocol CollapseCellDelegate: AnyObject {
	func collapseCellButtonTapped(_ component: CollapseCell)
}

public class CollapseCell: UITableViewCell, ComponentType, ShimmeringViewProtocol {
	
	public static let identifier = "CollapseCell"
	public weak var delegate: CollapseCellDelegate?
	private var collapse = true {
		didSet {
			descriptionLabel.numberOfLines = collapse ? 3 : 0
		}
	}

	lazy var titleLabel: UILabel = {
		let view = UILabel()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.textColor = .black
		view.text = "Title"
		return view
	}()
	
	lazy var descriptionLabel: UILabel = {
		let view = UILabel()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.numberOfLines = 3
		view.textAlignment = .justified
		view.text = "Kahdohadoas dasndasndasidoijasdiasd as dsa d asdonasd."
		view.textColor = .black
		return view
	}()
	
	lazy var collapseButton: UIButton = {
		let view = UIButton(type: .system)
		view.translatesAutoresizingMaskIntoConstraints = false
		view.addTarget(self, action: #selector(collapseButtonTapped(_:)), for: .touchUpInside)
		view.setTitle("See More", for: .normal)
		view.setTitleColor(.blue, for: .normal)
		return view
	}()
	
	public var shimmeringAnimatedItems: [UIView] {
		[titleLabel, descriptionLabel, collapseButton]
	}
	
	public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setupUI()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	@objc func collapseButtonTapped(_ sender: Any) {
		self.delegate?.collapseCellButtonTapped(self)
	}
	
	public func render(_ type: RenderType) {
		switch type {
		case .build(let dto):
			titleLabel.text = dto.title
			descriptionLabel.text = dto.description
			collapseButton.setTitle(dto.buttonTitle, for: .normal)
		case .loading(let isLoading, let color, let backgroundColor):
			_ = isLoading ?
				setTemplateWithSubviews(isLoading, color: color, animate: isLoading, viewBackgroundColor: backgroundColor) :
				setTemplateWithSubviews(isLoading)
		case .collapse:
			collapse.toggle()
		}
	}
}

extension CollapseCell {
	public enum RenderType {
		case build(DTO)
		case loading(Bool, color: UIColor, backgroundColor: UIColor)
		case collapse
	}
}

extension CollapseCell {
	public struct DTO {
		var title: String
		var description: String
		var buttonTitle: String
		
		public init(title: String, description: String, buttonTitle: String) {
			self.title = title
			self.description = description
			self.buttonTitle = buttonTitle
		}
	}
}

extension CollapseCell: SetupView {
	func addSubviews() {
		contentView.addSubview(titleLabel)
		contentView.addSubview(descriptionLabel)
		contentView.addSubview(collapseButton)
	}
	
	func addContraints() {
		NSLayoutConstraint.activate([
			titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
			titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
			descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
			descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
			descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
			collapseButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16),
			collapseButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
			collapseButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
		])
	}
	
	func addConfiguration() {
		backgroundColor = .white
		translatesAutoresizingMaskIntoConstraints = false
	}
}
