protocol SearchMoviesPresenter: AnyObject {
    func showLoading()
    func showError(message: String)
    func showContent()
}


protocol SearchMoviesPresenter {
    func responseSearchMovies(movies: [Movie])
    func responseLoading()
    func responseError()
}
