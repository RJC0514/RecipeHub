//
//  RecognizerController.swift
//  RecipeMaker
//
//  Created by Ryan Cosentino on 10/22/21.
//

import UIKit
import AVFoundation
import Vision

class RecognizerController: NSObject, ObservableObject, AVCaptureVideoDataOutputSampleBufferDelegate {

	var add: (String)->Void = { s in
		print("hi")
	}

	// Camera
	@Published var alert = false
	var session = AVCaptureSession()
	var preview: AVCaptureVideoPreviewLayer!

	private let output = AVCaptureVideoDataOutput()
	private let outputQueue = DispatchQueue(
		label: "VideoDataOutput",
		qos: .userInitiated,
		autoreleaseFrequency: .workItem
	)

	// Vision
	private var requests = [VNRequest]()

	func setup() {

		switch AVCaptureDevice.authorizationStatus(for: .video) {
		case .authorized:
			setupVideo()
			DispatchQueue.global(qos: .userInteractive).async {
				self.setupVision()
			}
			return
		case .notDetermined:
			AVCaptureDevice.requestAccess(for: .video) { _ in
				self.setup()
			}
		// includes .denied
		default:
			DispatchQueue.main.async {
				self.alert.toggle()
			}
			return
		}
	}

	func setupVideo() {
		session.beginConfiguration()
		session.sessionPreset = .vga640x480 // .cif352x288?

		guard
			let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back),
			let input = try? AVCaptureDeviceInput(device: device),
			session.canAddInput(input)
		else {
			print("Error adding video device input to the session")
			return
		}
		session.addInput(input)

		guard
			session.canAddOutput(output)
		else {
			print("Error adding video device output to the session")
			return
		}
		output.alwaysDiscardsLateVideoFrames = true
		output.videoSettings = [kCVPixelBufferPixelFormatTypeKey as String: Int(kCVPixelFormatType_420YpCbCr8BiPlanarFullRange)]
		output.setSampleBufferDelegate(self, queue: outputQueue)
		session.addOutput(output)

		// idk what this does
		output.connection(with: .video)?.isEnabled = true

		session.commitConfiguration()
		session.startRunning()
	}

	func setupVision() {
		guard
			let modelURL = Bundle.main.url(forResource: "MyModel", withExtension: "mlmodelc"),
			let visionModel = try? VNCoreMLModel(for: MLModel(contentsOf: modelURL))
		else {
			print("Error loading model")
			return
		}

		let request = VNCoreMLRequest(model: visionModel) {
			(request, error) in

			DispatchQueue.main.async {
				if let results = request.results {
					for r in results where r is VNRecognizedObjectObservation {
						let observation = r as! VNRecognizedObjectObservation

						// Select only the label with the highest confidence.
						self.add(observation.labels[0].identifier)

//						let topObservation = observation.labels[0]
//						let obs = "\(topObservation.identifier) \(topObservation.confidence)"
//						print(obs)
					}
				}
			}
		}
		self.requests = [request]
	}

	func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {

		guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer)
		else { return }

		do {
			try VNImageRequestHandler(
				cvPixelBuffer: pixelBuffer,
				orientation: .right
			).perform(self.requests)
		} catch {
			print(error)
		}
	}

	func done() {
		session.stopRunning()
	}
}
