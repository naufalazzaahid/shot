@propertyWrapper struct Inject<Value> {
  var wrappedValue: Value
  init(wrappedValue: Value) {
    self.wrappedValue = wrappedValue
  }
}

@propertyWrapper struct AssistedInject<Value> {
  var wrappedValue: Value
  init(wrappedValue: Value) {
    self.wrappedValue = wrappedValue
  }
}
