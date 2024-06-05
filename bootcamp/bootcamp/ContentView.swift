import SwiftUI

enum TopicView: Int, Identifiable, CaseIterable {
    case customBinding = 1
    case otherTopic = 2
    
    var id: Int { rawValue }
    
    var title: String {
        switch self {
        case .customBinding: return "Custom Binding"
        default: return "Not available"
        }
    }
    
    var Description: String {
        switch self {
        case .customBinding: return "Creating a custom Binding"
        default: return "Not available"
        }
    }
    
    @ViewBuilder
    var view: some View {
        switch self {
        case .customBinding: CustomBinding()
        default: Text("Other")
        }
    }
}
struct ContentView: View {
    var body: some View {
        NavigationView {
            List(TopicView.allCases) { topic in
                NavigationLink(destination: topic.view){
                    VStack(alignment: .leading) {
                        Text(topic.title)
                            .fontWeight(.regular)
                        Text(topic.Description)
                            .font(.footnote)
                    }
                }
            }
        }
        .navigationTitle("Topics")
    }
}

#Preview {
    ContentView()
}
