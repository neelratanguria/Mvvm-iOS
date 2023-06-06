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
                            Image(systemName: moves[i]?.indicator ?? "")
                                        .resizable()
                                        .frame(
                                            width: 40,
                                            height: 40
                                        )
                                        .foregroundColor(.gray)
                        }
                        .onTapGesture {
                            if isSquaredOccupied(in: moves, forIndex: i) { return }
                            moves[i] = Move(player: .Human, boardIndex: i)

                            if(isDone(in: moves)) {return}
                            let computerPos = determineComputureMovePosition(in: moves)
                            moves[computerPos] = Move(player: .Computer, boardIndex: computerPos)
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
    
    func isSquaredOccupied(in moves: [Move?], forIndex index: Int) -> Bool {
        return moves.contains(where: { $0?.boardIndex == index})
    }
    
    func isDone(in moves: [Move?]) -> Bool {
        return !moves.contains(where: { $0 == nil })
    }
    
    func determineComputureMovePosition(in moves: [Move?]) -> Int {
        var movePosition = Int.random(in: 0..<9)
        
        while (isSquaredOccupied(in: moves, forIndex: movePosition)) {
            movePosition = Int.random(in: 0..<9)
        }
        return movePosition
    }
}

enum Player {
    case Human, Computer
}

struct Move {
    let player: Player
    let boardIndex: Int
    
    var indicator: String {
        return player == .Human ? "xmark" : "circle"
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
