import UIKit
import AppComponents

class ExempleViewController: UIViewController {
	
	var isLoading: Bool = true {
		didSet {
			tableView.reloadData()
		}
	}

	@IBOutlet weak var tableView: UITableView! {
		didSet {
			tableView.delegate = self
			tableView.dataSource = self
			tableView.register(CollapseCell.self, forCellReuseIdentifier: CollapseCell.identifier)
			tableView.estimatedRowHeight = 100.0
			tableView.rowHeight = UITableView.automaticDimension
		}
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
			self.isLoading = false
		}
	}

}

extension ExempleViewController: UITableViewDataSource, UITableViewDelegate {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		if indexPath.row == 0 {
			guard let cell = tableView.dequeueReusableCell(withIdentifier: CollapseCell.identifier) as? CollapseCell  else {
				return UITableViewCell()
			}
			let dto = CollapseCell.DTO(title: DataDTO.title.text, description: DataDTO.description.text, buttonTitle: DataDTO.buttonTitle.text)
			cell.render(.build(dto))
			cell.delegate = self
			return cell
		} else {
			return UITableViewCell()
		}
	}
	
	func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
		let cell = cell as? CollapseCell
		cell?.render(.loading(isLoading, color: .gray, backgroundColor: cell?.superview?.backgroundColor ?? .white))
	}
}

extension ExempleViewController: CollapseCellDelegate {
	func collapseCellButtonTapped(_ component: CollapseCell) {
		component.render(.collapse)
		tableView.reloadData()
	}
}

enum DataDTO {
	case title
	case description
	case buttonTitle
	
	var text: String {
		switch self {
		case .title:
			return "Exemplo de Titulo"
		case .description:
			return "kahdohadoas dasndasndasidoijasdiasd as dsa d asdonasd dsdfjdsfsdo isdujfoidsuf osdufoiusdoi udsoifu dsoi fo dsufiusdf sfydisyfiusdf iusdfu sdfi ysiufysdiuyfiusdy"
		case .buttonTitle:
			return "Ver mais"
		}
	}
}
