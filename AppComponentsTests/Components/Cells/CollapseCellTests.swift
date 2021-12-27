import XCTest
import SnapshotTesting
import AppComponents

class CollapseCellTests: XCTestCase {
	
	override class func setUp() {
		isRecording = false
	}
	
	func test_collapse_cell_is_loading() {
		let container = MockTableViewSnapshot<CollapseCell>(cellIndentifier: CollapseCell.identifier, cellForRow: { cell in
			cell.render(.build(makeCollapseCellDTO()))
		}, willDisplayCell:  { cell in
			cell.render(.loading(true, color: .gray, backgroundColor: .white))
		})
		assertSnapshot(matching: container, as: .image)
    }
	
	func test_collapse_cell_is_build() {
		let container = MockTableViewSnapshot<CollapseCell>(cellIndentifier: CollapseCell.identifier, cellForRow: { cell in
			cell.render(.build(makeCollapseCellDTO()))
		})
		assertSnapshot(matching: container, as: .image)
	}
	
	func test_collapse_cell_is_collapse() {
		let container = MockTableViewSnapshot<CollapseCell>(cellIndentifier: CollapseCell.identifier, cellForRow: { cell in
			cell.render(.build(makeCollapseCellDTO()))
			cell.render(.collapse)
		})
		assertSnapshot(matching: container, as: .image)
	}
}

