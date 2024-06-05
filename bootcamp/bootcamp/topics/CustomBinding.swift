import SwiftUI

struct CustomBinding: View {
    @State var title: String = "Start"
    @State private var errorTitle: String? = nil
    
    var body: some View {
        VStack {
            Text(title)
            ChildViewBindingSwiftUI(title: $title)
            ChildViewWithoutBinding(title: title) { newTitle in
                title = newTitle
            }
            ChildViewGenericBinding(title: Binding(get: {
                title
            }, set: { newValue in
                title = newValue
            }))
            
            
            Button("Show error") {
                errorTitle = "Error description"
            }
        }
        //with extension Binding
        .alert(errorTitle ?? "Error", isPresented: Binding(value: $errorTitle)) {
            Button("Ok") {}
        }
        //without extension Binding
        .alert(errorTitle ?? "Error",
               isPresented: Binding(
                get: { errorTitle != nil },
                set: { newValue in
                    errorTitle = nil
                })) {
            Button("Ok 2") {}
        }
    }
}

//get and set value using Binding property wrapper SwiftUI
struct ChildViewBindingSwiftUI: View {
    @Binding var title: String
    var body: some View {
        Text(title)
            .onAppear {
//                title = "New title"
            }
    }
}
//Set and Get without Binding SwiftUI
struct ChildViewWithoutBinding: View {
    let title: String
    let setTitle: (String) -> Void
    var body: some View {
        Text(title)
            .onAppear {
//                setTitle("New title 2")
            }
    }
}

//Set and get using generig Binding (no swiftUI)
struct ChildViewGenericBinding: View {
    let title: Binding<String>
    var body: some View {
        Text(title.wrappedValue)
            .onAppear {
                title.wrappedValue = "New title 3"
            }
    }
}


extension Binding where Value == Bool {
    init(value: Binding<String?>) {
        self.init {
            value.wrappedValue != nil
        } set: { newValue in
            if !newValue {
                value.wrappedValue = nil
            }
        }

    }
}

#Preview {
    CustomBinding()
}
