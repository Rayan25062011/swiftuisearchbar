import SwiftUI

struct ContentView: View {
    let cars = ["Subaru WRX", "Tesla Model 3", "Porsche 911", "Renault Zoe", "DeLorean"]
    @State private var searchTerm : String = ""


    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $searchTerm)
                List {
                    ForEach(self.cars, id: \.self) { car in
                        Text(car)
                    }
                }.navigationBarTitle(Text("Cars"))
            }
        }
    }
}

struct SearchBar: UIViewRepresentable {

    @Binding var text: String

    class Coordinator: NSObject, UISearchBarDelegate {

        @Binding var text: String

        init(text: Binding<String>) {
            _text = text
        }

        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            text = searchText
        }
    }

    func makeCoordinator() -> SearchBar.Coordinator {
        return Coordinator(text: $text)
    }

    func makeUIView(context: UIViewRepresentableContext<SearchBar>) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
        searchBar.searchBarStyle = .minimal
        return searchBar
    }

    func updateUIView(_ uiView: UISearchBar, context: UIViewRepresentableContext<SearchBar>) {
        uiView.text = text
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
