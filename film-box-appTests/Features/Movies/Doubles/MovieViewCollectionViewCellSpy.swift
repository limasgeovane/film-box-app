import UIKit
@testable import film_box_app

final class MovieViewCollectionViewCellSpy: UICollectionViewCell, MovieViewCollectionViewCellLogic {
    private(set) var configureCellCount = 0
    private(set) var configureCellParameter: MovieDisplayModel?
    func configureCell(displayModel: MovieDisplayModel) {
        configureCellCount += 1
        configureCellParameter = displayModel
    }
}
