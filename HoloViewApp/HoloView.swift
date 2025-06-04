import SwiftUI
import AVFoundation

struct DraggableText: Identifiable {
    let id = UUID()
    var text: String
    var position: CGPoint
}

struct HoloView: View {
    @State private var selectedMode: Mode = .live
    @State private var messages: [DraggableText] = [
        DraggableText(text: "Hello world", position: .init(x: 100, y: 200)),
        DraggableText(text: "Another post", position: .init(x: 150, y: 300))
    ]

    var body: some View {
        ZStack {
            modeView
            ForEach($messages) { $message in
                VStack(spacing: 4) {
                    Text(message.text)
                    HStack(spacing: 16) {
                        Image(systemName: "xmark.circle")
                        Image(systemName: "camera")
                        Image(systemName: "bubble.left.and.bubble.right")
                        Image(systemName: "mic.fill")
                    }
                    .font(.caption)
                }
                .padding()
                .background(Color.white.opacity(0.6))
                .cornerRadius(8)
                .position(message.position)
                .onTapGesture {
                    withAnimation(.easeOut) {
                        messages.removeAll { $0.id == message.id }
                    }
                }
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            message.position = value.location
                        }
                )
            }
            .animation(.spring(), value: messages)
            VStack {
                Spacer()
                Picker("Mode", selection: $selectedMode) {
                    Text("Live").tag(Mode.live)
                    Text("VR").tag(Mode.vr)
                    Text("AR").tag(Mode.ar)
                    Text("Find").tag(Mode.find)
                    Text("Threads").tag(Mode.threads)
                    Text("TikTok").tag(Mode.tiktok)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
            }
        }
        .ignoresSafeArea()
    }

    @ViewBuilder
    private var modeView: some View {
        switch selectedMode {
        case .live:
            Color.black.overlay(
                Text("Live View Placeholder")
                    .foregroundColor(.white)
            )
        case .vr:
            Color.blue.overlay(
                Text("VR Scene Placeholder")
                    .foregroundColor(.white)
            )
        case .ar:
            Color.green.overlay(
                Text("AR Overlay Placeholder")
                    .foregroundColor(.white)
            )
        case .find:
            FindMeView()
        case .threads:
            ThreadsView()
        case .tiktok:
            TikTokView()
        }
    }

    enum Mode {
        case live, vr, ar, find, threads, tiktok
    }
}

#Preview {
    HoloView()
}