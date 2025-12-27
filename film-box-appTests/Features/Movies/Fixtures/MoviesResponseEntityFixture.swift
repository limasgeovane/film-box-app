@testable import film_box_app

extension MoviesResponseEntity {
    static func fixture(
        page: Int = 99,
        results: [MovieEntity] = [MovieEntity.fixture()],
        totalPages: Int = 10,
        totalResults: Int = 100
    ) -> Self {
        .init(
            page: page,
            results: results,
            totalPages: totalPages,
            totalResults: totalResults
        )
    }
}
