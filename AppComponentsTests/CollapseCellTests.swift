import XCTest
import SnapshotTesting
@testable import AppComponents

class CollapseCellTests: XCTestCase {
	func test_collapse_cell_is_loading() {
		let cell = CollapseCell()
		cell.render(.loading(true, color: .gray, backgroundColor: .white))
		assertSnapshot(matching: cell, as: .image, record: true)
    }
	
	func test_collapse_cell_is_building() {
		let cell = CollapseCell()
		let dto = makeCollapseCellDTO()
		cell.render(.build(dto))
		assertSnapshot(matching: cell, as: .image, record: true)
	}
	
	func test_collapse_cell_is_collapse() {
		let cell = CollapseCell()
		cell.render(.collapse)
		assertSnapshot(matching: cell, as: .image, record: true)
	}
}

func makeCollapseCellDTO() -> CollapseCell.DTO {
	return CollapseCell.DTO(title: "Exemplo de Titulo",
							description: "kahdohadoas dasndasndasidoijasdiasd as dsa d asdonasd dsdfjdsfsdo isdujfoidsuf osdufoiusdoi udsoifu dsoi fo dsufiusdf sfydisyfiusdf iusdfu sdfi ysiufysdiuyfiusdy",
							buttonTitle: "Ver mais")
}
