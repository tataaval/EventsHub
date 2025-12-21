import SwiftUI

struct DropDownView: View {
    @Binding var selectedOption: String
    @Binding var isExpanded: Bool
    let options: [String]
    let onSelect: (String) -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Select Department")
                .font(.system(size: 14))
                .foregroundStyle(.black)
            Button(action: {
                isExpanded.toggle()
            }) {
                HStack {
                    Text(selectedOption)
                        .font(.system(size: 14))
                        .foregroundColor(selectedOption == "Select Department" ? .gray : .black)
                    Spacer()
                    Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                        .foregroundColor(.gray)
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 6)
                        .stroke(Color.gray, lineWidth: 1)
                )
            }
            
            if isExpanded {
                VStack(alignment: .leading, spacing: 0) {
                    ForEach(options, id: \.self) { option in
                        Button(action: {
                            onSelect(option)
                        }) {
                            Text(option)
                                .font(.system(size: 14))
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .foregroundStyle(.black)
                        }
                    }
                }
                .overlay(
                    RoundedRectangle(cornerRadius: 6)
                        .stroke(Color.gray, lineWidth: 1)
                )
            }
        }
    }
}
