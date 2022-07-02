public protocol DIComponent {}

class DIComponentError: Error {
  let message: String
  
  init(_ message: String) {
    self.message = message
  }
}
