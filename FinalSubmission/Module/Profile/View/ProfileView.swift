//
//  ProfileView.swift
//  FinalSubmission
//
//  Created by addin on 02/04/21.
//

import SwiftUI

struct ProfileView: View {
  
  private let name: String = "Addin Satria Panambang"
  
  var body: some View {
    ZStack {
      Color.blue.opacity(0.3)
      VStack {
        image
        desc
      }
    }
  }
  
}

extension ProfileView {
  
  var image: some View {
    Image("potoudin")
      .resizable()
      .scaledToFit()
      .frame(width: 200, height: 200)
      .cornerRadius(200)
      .shadow(radius: 10)
      .padding()
  }
  
  var desc: some View {
    Text(name)
      .font(.title)
      .foregroundColor(Color("BW"))
  }
  
}
