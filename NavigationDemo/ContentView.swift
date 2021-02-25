//
//  ContentView.swift
//  NavigationDemo
//
//  Created by Stepan Vardanyan (private) on 25.02.21.
//

import SwiftUI

struct ContentView: View {

    @State private var page: Int = 0

    var body: some View {
        NavigationView {
            Screen(text: "Go Next Page", color: .purple, page: $page)
        }
    }
}

struct Screen: View {
    var text: String
    var color: Color

    @State private var pushed: Bool = false

    @Binding var page: Int

    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        GeometryReader { reader in
            ScrollView {
                ZStack {
                    color

                    VStack(spacing: 16) {

                        Text("Current page \(page)")

                        HStack() {
                            Button(action: {
                                page -= 1
                                pushed = false
                                self.presentationMode.wrappedValue.dismiss()
                            }, label: {
                                Image(systemName: "chevron.left.circle.fill")
                                    .font(.largeTitle)
                                    .foregroundColor(page > 0 ? .white : .gray)
                            })
                            .disabled(page <= 0)

                            Spacer()

                            Button(action: {
                                page += 1
                                pushed = true
                            }, label: {
                                Image(systemName: "chevron.right.circle.fill")
                                    .font(.largeTitle)
                                    .foregroundColor(.white)
                            })
                        }
                        .padding(.horizontal)

                        NavigationLink(
                            destination: Screen(text: text, color: .random, page: $page),
                            isActive: $pushed,
                            label: {})
                    }
                }
                .frame(width: reader.size.width, height: reader.size.height)
            }
        }
        .navigationBarHidden(true)
        .edgesIgnoringSafeArea(.all)
    }
}

extension Color {
    static var random: Color {
        return Color(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1)
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
