//
//  ContentView.swift
//  Mvvm-iOS
//
//  Created by PRANTAE-WS-07  on 04/06/23.
//

import SwiftUI

struct ContentView: View {
    
    let columns : [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    @State var moves: [Move?] = Array(repeating: nil, count: 9)
    @State var isHumanTurn = true
    
    var body: some View {
        
        GeometryReader { geometry in
            VStack{
                Spacer()
                LazyVGrid(columns: columns){
                    ForEach(0..<9) { i in
                        ZStack {
                            Circle()
                                .frame(
                                    width: geometry.size.width/3 - 15,
                                    height: geometry.size.width/3
                                )
                            
                            if(moves[i]==nil) {
                                
                            } else{
                                if(moves[i]?.player == .Human){
                                    Image(systemName: "xmark")
                                        .resizable()
                                        .frame(
                                            width: 40,
                                            height: 40
                                        )
                                        .foregroundColor(.gray)
                                } else {
                                    Image(systemName: "circle")
                                        .resizable()
                                        .frame(
                                            width: 40,
                                            height: 40
                                        )
                                        .foregroundColor(.gray)
                                }
                                
                            }
                        }
                        .onTapGesture {
                            moves[i] = Move(player: isHumanTurn ? .Human : .Computer, boardIndex: i)
                            isHumanTurn.toggle()
                            
                        }
                    }
                }
                Spacer()
                Button(action: {
                    moves = Array(repeating: nil, count: 9)
                }, label: {
                    Text("Reset")
                        .frame(
                            width: 280,
                            height: 50
                        )
                        .background(.yellow)
                        .font(.system(size: 20, weight: .bold, design: .default))
                        .cornerRadius(10)
                })
                Spacer()
            }
            
        }
    }
}

enum Player {
    case Human, Computer
}

struct Move {
    let player: Player
    let boardIndex: Int
    
    var indicator: String {
        return player == .Human ? "xmar" : "circle"
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
