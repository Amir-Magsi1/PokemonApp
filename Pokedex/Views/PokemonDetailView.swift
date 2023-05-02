//
//  PokemonDetailView.swift
//  Pokedex
//
//  Created by Amir Hussain on 08/02/2023.
//

import SwiftUI


/// Shows the details of a pokemon.
struct PokemonDetailView: View {
    
    var pockemonModel: PokemonModel
    
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            VStack {
                HStack {
                    Button(action: {
                        dismissSheet()
                    }) {
                        Image(systemName: "arrow.left")
                            .foregroundColor(Color.appColor2)
                            .font(.title)
                    }
                    Spacer()
                }
                .padding(16)
                .padding(.bottom, 6)
                .padding(.top)
                
                VStack(alignment: .leading) {
                    HStack {
                        Text(pockemonModel.name)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(Color.appColor)
                        
                        Spacer()
                    }
                    
                    Text(pockemonModel.type)
                        .font(.callout)
                        .padding()
                        .lineLimit(1)
                        .background(.white)
                        .frame(height: 24)
                        .cornerRadius(12)
                        .overlay(Capsule().stroke(Color.appColor3, lineWidth: 1))
                        .padding(.top, -14)
                }
                .padding(.leading, 16)
                .padding(.top, -10)
                
               
                VStack {
                    if let imageName = pockemonModel.imageName,
                       let image = FileManagerHelper.loadImageFromDocuments(name: imageName){
                        Image(uiImage: image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 200, height: 200)
                            .padding(.top, 24)
                    }else {
                        Image("1")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 200, height: 200)
                            .padding(.top, 24)
                    }
                }
                .frame(maxWidth: .infinity,
                       maxHeight : 250)
                .padding(.bottom, -40)
                
                VStack(alignment: .leading) {
                    Text("Description")
                        .foregroundColor(.appColor2)
                        .font(.title2)
                        .fontWeight(.bold)
                    Text(pockemonModel.description)
                        .font(.title3)
                        .padding(.top, 4)
                        .foregroundColor(Color.white)
                }
                .frame(maxWidth: .infinity,
                       maxHeight: .infinity,
                       alignment: .topLeading)
                .padding([.leading, .trailing, .top])
                .background(Color.appColor)
                .cornerRadius(20,corners: [.topLeft,.topRight])
            }
            .frame(maxWidth: .infinity,
                   maxHeight: .infinity,
               alignment: .top)
            .ignoresSafeArea()
        }
    }
    
    func dismissSheet() {
        UIApplication.shared.windows.first?.rootViewController?.dismiss(animated: true, completion: nil)
    }
}

struct PokemonDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonDetailView(pockemonModel: .mockModel)
    }
}


/// View extension to round corners.
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
