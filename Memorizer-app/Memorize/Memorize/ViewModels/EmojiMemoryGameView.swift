import SwiftUI
import Foundation
import AlertToast

struct EmojiMemoryGameView: View {
    
    @State private var showToast = false
    var motivationalMessages = [
        "Você é incrível!",
        "Continue assim!",
        "Você está arrasando!",
        "Não desista, você consegue!",
    ]
    
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        VStack {
            Grid(viewModel.cards) { card in
                CardView(card: card).onTapGesture {
                    viewModel.selectCard(card, onMatch: {
                        showToast.toggle()
                    })
                }
                .padding(5)
            }
            .padding()
            .foregroundColor(Color.orange)
            
            if showToast {
                MotivationalMessageView(message: motivationalMessages.randomElement() ?? "Incrível!")
                    .transition(.move(edge: .bottom))
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            showToast = false
                        }
                    }
            }
        }
    }
}

struct MotivationalMessageView: View {
    var message: String
    
    var body: some View {
        VStack {
            Text(message)
                .padding()
                .foregroundColor(Color.white)
                .background(Color.black)
                .cornerRadius(10)
        }
        .padding(.horizontal)
        .padding(.bottom, 20)
        .frame(maxWidth: .infinity, alignment: .bottom)
        .background(Color.clear)
    }
}

struct CardView: View {
    var card: MemoryGame<String>.Card
    
    var body: some View{
        GeometryReader { geometry in
            self.body(for: geometry.size)
          }
        }
        
        func body(for size: CGSize) -> some View {
            ZStack {
                if card.isFaceUp {
                    RoundedRectangle(cornerRadius: corneRadius).fill(Color.white)
                    RoundedRectangle(cornerRadius: corneRadius).stroke(lineWidth: edgeLineWidth)
                    Text(card.content)
                } else {
                    if !card.isMatched {
                        RoundedRectangle(cornerRadius: corneRadius).fill()
                    }
                }
            }
             .font(Font.system(size: fontSize(for: size)))
         }
            
    
    // Mark: - Drawing Constants
    
    let corneRadius: CGFloat = 10.0
    let edgeLineWidth: CGFloat = 3
    func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * 0.75
    }
}
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            EmojiMemoryGameView(viewModel: EmojiMemoryGame())
        }
    }
