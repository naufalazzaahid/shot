@propertyWrapper public struct Inject<Value> {
  public var wrappedValue: Value
  public init(wrappedValue: Value) {
    self.wrappedValue = wrappedValue
  }
}

@propertyWrapper public struct AssistedInject<Value> {
  public var wrappedValue: Value
  public init(wrappedValue: Value) {
    self.wrappedValue = wrappedValue
  }
}
