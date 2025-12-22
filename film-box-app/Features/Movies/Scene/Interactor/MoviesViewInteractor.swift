protocol MoviesInteractorLogic {
    func favoriteMovie(movie: MovieDisplayModel)
    func unfavoriteMovie(movieId: Int)
}

final class MoviesInteractor: MoviesInteractorLogic {
    private let favoriteMoviesRepository: FavoriteMoviesRepositoryLogic
    
    init(favoriteMoviesRepository: FavoriteMoviesRepositoryLogic) {
        self.favoriteMoviesRepository = favoriteMoviesRepository
    }
    
    func favoriteMovie(movie: MovieDisplayModel) {
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
        favoriteMoviesRepository.unfavorite(movieId: movieId)
    }
}
