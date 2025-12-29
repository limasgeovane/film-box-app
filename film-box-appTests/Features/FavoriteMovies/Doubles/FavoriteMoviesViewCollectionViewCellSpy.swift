import UIKit
@testable import film_box_app

final class FavoriteMoviesViewCollectionViewCellSpy: UICollectionViewCell, FavoriteMoviesViewCollectionViewCellLogic {
    private(set) var configureCellCount = 0
    private(set) var configureCellParameter: FavoriteMoviesDisplayModel?
    func configureCell(displayModel: FavoriteMoviesDisplayModel) {
        configureCellCount += 1
        configureCellParameter = displayModel
    }
}
