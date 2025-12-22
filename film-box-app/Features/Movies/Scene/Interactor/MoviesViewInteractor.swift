protocol MoviesInteractorLogic {
    func favoriteMovie(movieId: Int)
    func unfavoriteMovie(movieId: Int)
}

final class MoviesInteractor: MoviesInteractorLogic {
    private var movies: [MovieDisplayModel]
    private let favoriteMoviesRepository: FavoriteMoviesRepositoryLogic
    
    init(
        movies: [MovieDisplayModel],
        favoriteMoviesRepository: FavoriteMoviesRepositoryLogic
    ) {
        self.movies = movies
        self.favoriteMoviesRepository = favoriteMoviesRepository
    }
    
    func favoriteMovie(movieId: Int) {
        guard let movie = movies.first(where: { $0.id == movieId }) else { return }
        let favoriteMovie = FavoriteMoviesDisplayModel(
            id: movie.id,
            title: movie.title,
            posterImageName: movie.posterImageName ?? "",
            ratingText: movie.ratingText,
            overview: movie.overview
        )
        favoriteMoviesRepository.favorite(favoriteMovie: favoriteMovie)
    }
    
    func unfavoriteMovie(movieId: Int) {
        guard let movie = movies.first(where: { $0.id == movieId }) else { return }
        let favoriteMovie = FavoriteMoviesDisplayModel(
            id: movie.id,
            title: movie.title,
            posterImageName: movie.posterImageName ?? "",
            ratingText: movie.ratingText,
            overview: movie.overview
        )
        favoriteMoviesRepository.unfavorite(favoriteMovie: favoriteMovie)
    }
}
