//
//  FavouriteView.swift
//  FinalSubmission
//
//  Created by addin on 02/04/21.
//

import SwiftUI
import SIECore
import Game

struct FavouriteView: View {
  
  @ObservedObject var presenter: GetListPresenter<
    Any,
    GameModel,
    Interactor<
      Any,
      [GameModel],
      GetFavouriteGameRepository<
        GetFavouriteGameLocaleDataSource,
        FavGameTransformer>>>
  
  var body: some View {
    ZStack {
      if presenter.isLoading {
        loadingIndicator
      } else if presenter.isError {
        errorIndicator
      } else if presenter.list.isEmpty {
        emptyIndicator
      } else {
        content
      }
    }
    .onAppear {
      presenter.getList(request: nil)
    }
  }
}

extension FavouriteView {
  
  var loadingIndicator: some View {
    VStack {
      Text("Loading...")
      if #available(iOS 14.0, *) {
        ProgressView()
          .progressViewStyle(CircularProgressViewStyle())
      } else {
        // Fallback on earlier versions
      }
    }
  }
  
  var errorIndicator: some View {
    VStack {
      Text(presenter.errorMessage)
    }
  }
  
  var emptyIndicator: some View {
    VStack {
      Text("Empty Favourite")
    }
  }
  
  var content: some View {
    ScrollView {
      if #available(iOS 14.0, *) {
        LazyVStack {
          ForEach(presenter.list) { game in
            linkBuilder(for: game) {
              GameRow(game: game)
            }
          }
        }
      } else {
        // Fallback on earlier versions
      }
    }
  }
  
  func linkBuilder<Content: View>(
    for game: GameModel,
    @ViewBuilder content: () -> Content
  ) -> some View {
    NavigationLink(
      destination: FavouriteRouter().makeDetailView(for: game)
    ) { content() }
  }
  
}
