//
//  NewPokemonView.swift
//  Pokedex
//
//  Created by Amir Hussain on 08/02/2023.
//

import SwiftUI
import UIKit

struct NewPokemonView: View {
   
    enum SaveImageError: Error {
        case SomethingWentWrong
    }
    
    @State private var name: String = ""
    @State private var description: String = ""
    @State private var selectedImage: UIImage? = nil
    
    @State private var showingImagePicker = false
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    
    @State private var selectedType = "BUG"
    @State private var pokemonTypes: [String] = PokemonType.types
    
    @Binding var isPresented: Bool
    var onAddNewPokemon: ((PokemonModel)->Void)
    
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    
                    HStack {
                        Button(action: {
                            self.isPresented = false
                        }) {
                            Text("Cancel")
                        }
                        Spacer()
                        Text("Add Pokemon")
                        Spacer()
                        Button(action: {
                            self.handleAddNewPokemon()
                        }) {
                            Text("Add")
                        }
                    }
                    
                    Section {
                        TextField("Name", text: $name)
                        Picker(selection: $selectedType, label: Text("Select Type")) {
                            ForEach(pokemonTypes, id: \.self) {
                                Text($0)
                            }
                        }
                    }
                    
                    Section {
                        TextField("Description",
                                  text: $description,
                                  axis: .vertical)
                            .lineLimit(4...10)
                    }
                    
                    Section {
                        if let selectedImage {
                            Image(uiImage: selectedImage)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 100, height: 100)
                        } else {
                            Text("No image selected")
                        }
                        
                        Button(action: {
                            showingImagePicker = true
                        }) {
                            Text("Select Image")
                        }
                    }
                }
            }
        }
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker(sourceType: self.sourceType,
                        selectedImage: self.$selectedImage)
        }
    }
    
    private func handleAddNewPokemon() {
        do {
            let imageName = try saveImageInDocumentsDirectory()
            let newPokemonModel = PokemonModel(name: name,
                                               description: description,
                                               imageName: imageName,
                                               type: selectedType)
            onAddNewPokemon(newPokemonModel)
            self.isPresented = false
        }catch {
            print("Error adding pokemon: \(error)")
        }
    }
    
    private func saveImageInDocumentsDirectory() throws -> String {
        
        let fileName = "\(UUID().uuidString).jpg"
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        if let data = selectedImage?.jpegData(compressionQuality: 0.4) {
            do {
                try data.write(to: fileURL)
                return fileName
            } catch {
                print("Error saving image: \(error)")
            }
        }
        throw SaveImageError.SomethingWentWrong
    }
}


struct NewPokemonView_Preview: PreviewProvider {
    static var previews: some View {
        NewPokemonView(isPresented: .constant(false),
                       onAddNewPokemon: { _ in })
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    
    typealias UIViewControllerType = UIImagePickerController
    let sourceType: UIImagePickerController.SourceType
    @Binding var selectedImage: UIImage?
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = sourceType
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage{
                parent.selectedImage = uiImage
            }
            picker.dismiss(animated: true, completion: nil)
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true, completion: nil)
        }
    }
}
