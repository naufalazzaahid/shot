public protocol DIComponent {}

public class DIComponentError: Error {
  public let message: String
  
  public init(_ message: String) {
    self.message = message
  }
}
