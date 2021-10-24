//
//  RecognizerView.swift
//  RecipeMaker
//
//  Created by Ryan Cosentino on 10/22/21.
//

import SwiftUI
import AVFoundation

struct RecognizerView: View {

	@Environment(\.dismiss) var dismiss

	@StateObject var camera = RecognizerController()
	@State var tempAdded = [String]()

	init(_ addIngredient: @escaping (String)->Void, _ hasIngredient: @escaping (String)->Bool) {
		self.addIngredient = addIngredient
		self.hasIngredient = hasIngredient
	}

	var addIngredient: (String)->Void
	var hasIngredient: (String)->Bool
	func addTempIngredient(_ ing: String) {
		if !self.hasIngredient(ing) && !self.tempAdded.contains(ing) {
			self.tempAdded.append(ing)
		}
	}

	var body: some View {
		ZStack {
			#if targetEnvironment(simulator)
				Color.black.ignoresSafeArea(.all)
			#else
				CameraPreview(camera: camera)
			#endif
			VStack {
				HStack {
					Spacer()
					Button(action: { dismiss() }) {
						CameraText("Done")
							.padding(.trailing, 10)
					}
				}
				Spacer()
				VStack {
					ForEach(tempAdded, id: \.self) { i in
						CameraText("× \(i)")
							.font(.title3)
						.onAppear {
							DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
								if let index = tempAdded.firstIndex(of: i) {
									tempAdded.remove(at: index)
									addIngredient(i)
								}
							}
						}
						.onTapGesture {
							tempAdded.remove(at: tempAdded.firstIndex(of: i)!)
						}
					}
				}
			}
			.padding(.vertical)
		}
		.alert("Error Accessing Camera", isPresented: $camera.alert) {
			Button("OK") { dismiss() }
		}
		#if !targetEnvironment(simulator)
		.onAppear {
			camera.setup()
			camera.add = addTempIngredient(_:)
		}
		.onDisappear {
			camera.done()
			for i in tempAdded {
				addIngredient(i)
			}
			tempAdded = []
		}
		#endif
	}
}

struct CameraPreview: UIViewRepresentable {

	@ObservedObject var camera: RecognizerController

	func makeUIView(context: Context) -> UIView {
		camera.preview = AVCaptureVideoPreviewLayer(session: camera.session)
		camera.preview.frame = UIScreen.main.bounds
		camera.preview.videoGravity = .resizeAspectFill

		let view = UIView(frame: camera.preview.frame)
		view.layer.addSublayer(camera.preview)
		return view
	}

	func updateUIView(_ uiView: UIView, context: Context) {
		// empty
	}
}

struct CameraText: View {

	var text: String

	init(_ text: String) {
		self.text = text
	}

	var body: some View {
		Text(text)
			.foregroundColor(.black)
			.fontWeight(.semibold)
			.padding(.vertical, 10)
			.padding(.horizontal, 18)
			.background(.white)
			.clipShape(Capsule())
	}
}

//struct CameraView_Previews: PreviewProvider {
//	static var previews: some View {
//		RecognizerView()
//	}
//}
