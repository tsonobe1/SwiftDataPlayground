import SwiftUI

struct ThreadLinesView: View {
    var body: some View {
        VStack(spacing: 20) {
            ForEach(0..<5) { i in
                HStack {
                    ThreadLine()
                    Text("Comment \(i)")
                }
            }
        }
    }
}

struct ThreadLine: View {
    var body: some View {
        Path { path in
            path.move(to: CGPoint(x: 5, y: 0))
            path.addLine(to: CGPoint(x: 5, y: 40))
        }
        .stroke(Color.gray, lineWidth: 2)
    }
}

struct ThreadLinesView_Previews: PreviewProvider {
    static var previews: some View {
        ThreadLinesView()
    }
}
