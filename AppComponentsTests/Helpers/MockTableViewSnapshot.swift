/*
	TableView mockada para tirar snapshot da cell.
	Material de referência https://osinski.dev/posts/snapshot-testing-self-sizing-table-view-cells/
*/

import UIKit

final class MockTableView: UITableView {
	override var intrinsicContentSize: CGSize {
		/// Cada vez que intrinsicContentSize é acessado, temos que dispara layoutIfNeeded(), caso contrário a tableView não vai  redimensionar corretamente
		layoutIfNeeded()
		/// Usamos contentSize.height como altura da tableView
		return CGSize(width: UIView.noIntrinsicMetric, height: contentSize.height)
	}
}

final class MockTableViewSnapshot<Cell: UITableViewCell>: UIView, UITableViewDataSource, UITableViewDelegate {
	
	private let cellForRow: ((Cell) -> ())?
	private let willDisplayCell: ((Cell) -> ())?
	private let cellIndentifier: String
	
	private lazy var tableView: MockTableView = {
		let view = MockTableView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.separatorStyle = .none /// para não mostrar o separador no snapshot
		view.dataSource = self
		view.delegate = self
		view.register(Cell.self, forCellReuseIdentifier: self.cellIndentifier)
		return view
	}()
	
	init(cellIndentifier: String, cellForRow: ((Cell) -> ())? = nil, willDisplayCell: ((Cell) -> ())? = nil) {
		self.cellForRow = cellForRow
		self.willDisplayCell = willDisplayCell
		self.cellIndentifier = cellIndentifier
		super.init(frame: .zero)
		setupUI()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIndentifier) as! Cell
		cellForRow?(cell)
		return cell
	}
	
	func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
		let cell = cell as! Cell
		willDisplayCell?(cell)
	}
	
}

extension MockTableViewSnapshot: SetupView {
	func addSubviews() {
		addSubview(tableView)
	}
	
	func addContraints() {
		NSLayoutConstraint.activate([
			tableView.topAnchor.constraint(equalTo: topAnchor),
			tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
			tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
			tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
			
			/// Container não pode ter um valor zero para altura, caso contrário a tableView não vai redimensionar após a cell configurar sua própria altura
			heightAnchor.constraint(greaterThanOrEqualToConstant: 1),
			widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width)
		])
	}
	
	func addConfiguration() {
		translatesAutoresizingMaskIntoConstraints = false
	}
}
