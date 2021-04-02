//
//  HomeView.swift
//  FinalSubmission
//
//  Created by addin on 02/04/21.
//

import SwiftUI
import SIECore
import Game

struct HomeView: View {
  
  @ObservedObject var presenter: GetListPresenter<
    Any,
    GameModel,
    Interactor<
      Any,
      [GameModel],
      GetGameRepository<
        GetGameLocaleDataSource,
        GetGameRemoteDataSource,
        GameTransformer>>>
  
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
      if presenter.list.count == 0 {
        presenter.getList(request: nil)
      }
    }
  }
  
}

extension HomeView {
  
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
      Text("Empty Game")
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
      destination: HomeRouter().makeDetailView(for: game)
    ) { content() }
  }
  
}
