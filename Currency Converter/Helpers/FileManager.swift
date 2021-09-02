//
//  FileManager.swift
//  Currency Converter
//
//  Created by Yogesh Bharate on 02/09/21.
//

import Foundation
import UIKit

final class FileHandler {
  // MARK: - Properties
  static let shared = FileHandler()
  
  // Initialization
  private init() {
    debugPrint(AppConstants.fileManagerInit)
  }
  
  func writeFile(_ fileName: String, _ data: Data) {
    if let pathWithFileName = getPathWithFileName(fileName) {
      do {
        try data.write(to: pathWithFileName, options: .atomic)
        debugPrint("\(pathWithFileName) saved successfully.")
      } catch {
        debugPrint("Unable to save file - \(error.localizedDescription)")
      }
    }
  }
  
  func readFile(_ fileName: String) -> Data? {
    if let pathWithFileName = getPathWithFileName(fileName) {
      do {
        let data = try Data(contentsOf: pathWithFileName)
        debugPrint("\(pathWithFileName) read successfully.")
        return data
      } catch {
        debugPrint("Unable to read file - \(error.localizedDescription)")
      }
    }
    return nil
  }
  
  private func getDocumentDirectory() -> URL? {
    return FileManager.default.urls(for: .documentDirectory, in: .allDomainsMask).first
  }
  
  private func getPathWithFileName(_ fileName: String) -> URL? {
    if let documentDirectory = getDocumentDirectory() {
      return documentDirectory.appendingPathComponent(fileName+AppConstants.txtExtension)
    }
    return nil
  }
  
  func getFileModificationTime(_ fileName: String) -> Date? {
    if let pathWithFileName = getPathWithFileName(fileName) {
      do {
        let attr = try FileManager.default.attributesOfItem(atPath: pathWithFileName.path)
        return attr[FileAttributeKey.modificationDate] as? Date
      } catch {
        debugPrint("Unable to fetch file modification details - \(error.localizedDescription)")
      }
    }
    
    return nil
  }
}
