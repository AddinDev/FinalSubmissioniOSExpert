//
//  HomeRouter.swift
//  FinalSubmission
//
//  Created by addin on 02/04/21.
//

import SwiftUI
import Game
import SIECore

class HomeRouter {
  
  func makeDetailView(for game: GameModel) -> some View {
    
    let detailUseCase: Interactor<
      String,
      DetailModel,
      GetDetailRepository<
        GetDetailRemoteDataSource,
        DetailTransformer>
    > = Injection.init().provideDetail()
    
    let addFavUseCase: Interactor<
      GameModel,
      Bool,
      AddFavouriteGameRepository<
        AddFavouriteGameLocaleDataSource,
        AddFavGameTransformer>
    > = Injection.init().provideAddFavourite()
    
    let removeFavUseCase: Interactor<
      GameModel,
      Bool,
      RemoveFavouriteGameRepository<
        AddFavouriteGameLocaleDataSource,
        AddFavGameTransformer>
    > = Injection.init().provideRemoveFavourite()
    
    let presenter = GetDetailPresenter(
      fav: false,
      detailUseCase: detailUseCase,
      favouriteUseCase: addFavUseCase,
      removeFavouriteUseCase: removeFavUseCase)
    
    return DetailView(presenter: presenter, game: game)
    
  }
  
}
