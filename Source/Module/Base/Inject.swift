@propertyWrapper public struct Inject<Value> {
  var wrappedValue: Value
  public init(wrappedValue: Value) {
    self.wrappedValue = wrappedValue
  }
}

@propertyWrapper public struct AssistedInject<Value> {
  var wrappedValue: Value
  public init(wrappedValue: Value) {
    self.wrappedValue = wrappedValue
  }
}
