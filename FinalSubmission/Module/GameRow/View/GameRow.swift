//
//  GameRow.swift
//  FinalSubmission
//
//  Created by addin on 02/04/21.
//

import SwiftUI
import Game
import SDWebImageSwiftUI

public struct GameRow: View {
  
  var game: GameModel
  
  public var body: some View {
    
    HStack {
      image
      content
      spacer
    }
    
  }
  
}

extension GameRow {
  
  var image: some View {
    WebImage(url: URL(string: game.image))
      .resizable()
      .indicator(.activity)
      .transition(.fade)
      .scaledToFill()
      .frame(width: 75, height: 75)
      .cornerRadius(10)
      .padding()
  }
  
  var content: some View {
    VStack(alignment: .leading) {
      Text(game.title)
        .foregroundColor(Color("BW"))
        .padding(.trailing, 5)
      HStack {
        Image(systemName: "star.fill")
          .foregroundColor(.yellow)
          .padding(0)
        Text(game.rating)
          .foregroundColor(Color("BW"))
      }
    }
  }
  
  var spacer: some View {
    Spacer()
  }
  
}
