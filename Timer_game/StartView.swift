//
//  StartView.swift
//  Timer_game
//
//  Created by PJH on 2022/06/02.
//

import SwiftUI

struct StartView: View {
    @AppStorage("timerValue") var timerValue = 5
    @AppStorage("highScore") var highScore = 0
    
    var body: some View {
        NavigationView {
            ZStack {
                Image("GAME START")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .padding(.top, 250)
                    .opacity(0.5)
                VStack {
                    Text("high score \(highScore)")
                        .font(.system(size: 30))
                        .fontWeight(.medium)
                        .offset(x: 0, y: -140)
                    
                    //offset -> 원하는 위치에
                    //position도 쓸 수 있음
                    //offset 뒷배경 같이 이동 못함
                    //position 뒷배경(영역) 같이 이동 가능
                    
                    Button(action: {
                        highScore = 0
                    }) {
                        Text("reset")
                            .font(.largeTitle)
                            .fontWeight(.medium)
                            .foregroundColor(Color.orange)
                    }
                    .offset(x: 0, y: -120)
                    //offset은 뒷배경과 같이 이동을 못하므로 버튼자체를 이동시켜야 함(괄호 밖에 걸어야 함)
                    Spacer()
                        .frame(height: UIScreen.main.bounds.size.height / 150)
                    NavigationLink(destination: GameView()) {
                        Image("game")
                            
                    }
                    .offset(x: 0, y: -30)
                    Picker(LocalizedStringKey("String"), selection: $timerValue) {
                        Text("5")
                            .tag(5)
                        Text("8")
                            .tag(8)
                        Text("10")
                            .tag(10)
                    }
                    .pickerStyle(.inline)
                } //VStack
            } //ZStack
        } //NavigationView
    }
    
    func refreshData() {
        
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}
