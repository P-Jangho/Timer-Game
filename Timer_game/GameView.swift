//
//  GameView.swift
//  Timer_game
//
//  Created by PJH on 2022/06/02.
//

import SwiftUI

struct GameView: View {
    
    //@State private var animationAmount: [Double] = [
    //    0.0,
    //    0.0,
    //    0.0,
    //    0.0
    //    ]
    //animation 변수, 회전각도는 double로 값을 줘야 함
    //배열[]로 하면 하나씩 회전시키고 틀릴 때는 회전x
    //@State private var animationAmount1 : Double = 0.0
    //@State private var animationAmount2 : Double = 0.0
    //@State private var animationAmount3 : Double = 0.0
    //하나씩돌리고싶을때 -> rotation3DEffect 안의 변수명을 맞춰줌
    
    @State private var animationAmount: Double = 0.0

    @Environment(\.presentationMode) var presentation
    //Alert버튼눌렀을 때, 뒤로가기 변수
    
    @AppStorage("highScore") var highScore = 0
    @AppStorage("timerValue") var timerValue = 5
    @State private var timerHandler: Timer? //? -> optional nil(값이없음)이 올 수도 있음
    @State private var count = 0
    
    @State private var randomNum : [Int] = [
        Int.random(in: 1...99),
        Int.random(in: 1...99),
        Int.random(in: 1...99),
        Int.random(in: 1...99)
        ]
    @State private var answerIndexSelector: Int = Int.random(in: 0...3)
    
    @State private var firstNum : Int = Int.random(in: 1...9)
    @State private var secondNum : Int = Int.random(in: 1...11)
    
    @State private var correctcount = 0
    @State private var showAlert: Bool = false

    var body: some View {
        ZStack {
            Image("1")
                .resizable()
                .opacity(0.15)
                .aspectRatio(contentMode: .fill)
            VStack(spacing: 10) {
                Text("\(timerValue - count)")
                    .fontWeight(.heavy)
                    .font(.system(size: 70))
                Spacer()
                    .frame(height: UIScreen.main.bounds.size.height / 40)
                Text("正解数 \(correctcount)")
                Text("\(firstNum) X \(secondNum)")
                    .font(.system(size: 60))
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .padding()
                    .padding()
                       Spacer()
                           .frame(height:   UIScreen.main.bounds.size.height / 10)
                HStack (spacing : UIScreen.main.bounds.size.width / 30) {
                    Button(action: {
                        
                        checkAnswer(index: 0)
 
                    }) {
                        Text("\(randomNum[0])")
                            .fontWeight(.black)
                            .frame(width: UIScreen.main.bounds.size.width / 10, height: UIScreen.main.bounds.size.width / 40)
                            .font(.system(size: 20))
                            .padding()
                            .foregroundColor(.black)
                            .overlay(RoundedRectangle(cornerRadius: 30).stroke(Color.black, lineWidth: 2)) //버튼테두리
                            .rotation3DEffect(.degrees(animationAmount //[0]
                                                      ), axis: (x: 0.0, y: 1.0, z: 0.0)) //버튼 3d액션
                    }
                    Button(action: {
                        
                        checkAnswer(index: 1)

                    }) {
                        Text("\(randomNum[1])")
                            .fontWeight(.black)
                            .frame(width: UIScreen.main.bounds.size.width / 10, height: UIScreen.main.bounds.size.width / 40)
                            .font(.system(size: 20))
                            .padding()
                            .foregroundColor(.black)
                            .overlay(RoundedRectangle(cornerRadius: 30).stroke(Color.black, lineWidth: 2))
                            .rotation3DEffect(.degrees(animationAmount //[1]
                                                      ), axis: (x: 0.0, y: 1.0, z: 0.0)) //버튼 3d액션
                    }
                    Button(action: {
                        
                        checkAnswer(index: 2)

                    }) {
                        Text("\(randomNum[2])")
                            .fontWeight(.black)
                            .frame(width: UIScreen.main.bounds.size.width / 10, height: UIScreen.main.bounds.size.width / 40)
                            .font(.system(size: 20))
                            .padding()
                            .foregroundColor(.black)
                            .overlay(RoundedRectangle(cornerRadius: 30).stroke(Color.black, lineWidth: 2))
                            .rotation3DEffect(.degrees(animationAmount //[2]
                                                      ), axis: (x: 0.0, y: 1.0, z: 0.0)) //버튼 3d액션
                    }
                    Button(action: {
                        
                        checkAnswer(index: 3)
                      
                    }) {
                        Text("\(randomNum[3])")
                            .fontWeight(.black)
                            .frame(width: UIScreen.main.bounds.size.width / 10, height: UIScreen.main.bounds.size.width / 40)
                            .font(.system(size: 20))
                            .padding()
                            .foregroundColor(.black)
                            .overlay(RoundedRectangle(cornerRadius: 30).stroke(Color.black, lineWidth: 2))
                            .rotation3DEffect(.degrees(animationAmount //[3]
                                                      ), axis: (x: 0.0, y: 1.0, z: 0.0)) //버튼 3d액션
                    }
                } //HStack
            } //VStack
        } //ZStack
        .navigationBarHidden(true)
        .onAppear{
            randomAppear()
        }
        .alert(isPresented: $showAlert) {
               Alert(title: Text("終了"),
                     message: Text("正解数　\(correctcount)"),
                     dismissButton: .default(Text("OK"), action: {
                   if correctcount > highScore {
                       highScore = correctcount
                   }
                   self.presentation.wrappedValue.dismiss()
               }))
            }
    } //body
    
    private func checkAnswer(index: Int) {
        if firstNum * secondNum == randomNum[index] {
            withAnimation {self.animationAmount //[index]
                += 360}
            correctcount += 1
            self.count = 0
            refreshData()
        } else {
            stopTimer()
            showAlert = true
        }
        
    }

    private func refreshData() {
        self.firstNum = Int.random(in: 1...9)
        self.secondNum = Int.random(in: 1...11)
        self.answerIndexSelector = Int.random(in: 0...3)
        
        randomNum = [
            Int.random(in: 1...99),
            Int.random(in: 1...99),
            Int.random(in: 1...99),
            Int.random(in: 1...99)
            ]
        
        randomAppear()
    }
    
    private func randomAppear() {
        randomNum.insert(firstNum * secondNum, at: answerIndexSelector)
        randomNum.removeLast()
        
        if randomNum[0] == randomNum[1] {
            randomNum[0] = Int.random(in: 1...99)
       } else if randomNum[0] == randomNum[2] {
           randomNum[0] = Int.random(in: 1...99)
        } else if randomNum[0] == randomNum[3] {
            randomNum[0] = Int.random(in: 1...99)
        } else if randomNum[1] == randomNum[2] {
            randomNum[1] = Int.random(in: 1...99)
        } else if randomNum[1] == randomNum[3] {
            randomNum[1] = Int.random(in: 1...99)
        } else if randomNum[2] == randomNum[3] {
            randomNum[2] = Int.random(in: 1...99)
        } else {}
        
        startTimer()
        
    } //randomAppear
    
    private func startTimer() {
        if let unwrapedTimerHandler = timerHandler {
            if unwrapedTimerHandler.isValid == true {
                return
            }
        } //nil인지 아닌지를 확인하는 절차(timerHandler에 ?를 줬기때문)
        
        if timerValue - count <= 0 {
            count = 0
        }
        
        timerHandler = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            countDownTimer()
            //1초에 1초가 지나도록 설정
            
        }
    }
    
    private func countDownTimer() {
        count += 1
        if timerValue - count <= 0 {
            timerHandler?.invalidate() // 정지
            showAlert = true
        }
    }
    
    private func stopTimer() {
        if let unwrapedTimerHandler = timerHandler {
            
            if unwrapedTimerHandler.isValid == true {
                
                unwrapedTimerHandler.invalidate()
            }
        }
        
    }
}
    
    

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
